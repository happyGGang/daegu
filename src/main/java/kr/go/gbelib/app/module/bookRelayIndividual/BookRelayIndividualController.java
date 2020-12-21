package kr.go.gbelib.app.module.bookRelayIndividual;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "reader_contest", "다독자 공모를 선택하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookRelayIndividual.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "이름");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "user_affiliation", 50, "소속명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레리 계획");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookRelayIndividual.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
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
