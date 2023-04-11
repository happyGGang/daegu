package kr.go.gbelib.app.module.bookRelayIndividual;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bookRelayIndividual.BookRelayIndividual;
import kr.go.gbelib.app.cms.module.bookRelayIndividual.BookRelayIndividualService;

@Controller(value = "userBookRelayIndividual")
@RequestMapping(value = {"/{homepagePath}/module/bookRelayIndividual"})
public class BookRelayIndividualController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bookRelayIndividual/";

	@Autowired
	private BookRelayIndividualService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);
		
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		bookRelayIndividual.setAdd_id(getSessionMemberId(request));
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayIndividual bookRelayIndividual, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayIndividual.getEditMode().equals("ADD")) {
    		ValidationUtils.rejectIfEmpty(result, "user_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "대상별을 선택하세요.");
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "성명");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookRelayIndividual.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if(service.checkDupRequest(bookRelayIndividual)) {
				res.setValid(false);
				res.setMessage("독서릴레이는 중복신청이 불가능합니다. 관리자에게 문의해주세요.");
				
				return res;
			}
			
			if (bookRelayIndividual.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					bookRelayIndividual.setAdd_id("ANONYMOUS");
				} else {
					bookRelayIndividual.setAdd_id(getSessionMemberId(request));
				}
				service.addBookRelayIndividual(bookRelayIndividual);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
