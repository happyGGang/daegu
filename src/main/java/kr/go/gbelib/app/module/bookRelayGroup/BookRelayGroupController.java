package kr.go.gbelib.app.module.bookRelayGroup;

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
import kr.go.gbelib.app.cms.module.bookRelayGroup.BookRelayGroup;
import kr.go.gbelib.app.cms.module.bookRelayGroup.BookRelayGroupService;

@Controller(value = "userBookRelayGroup")
@RequestMapping(value = {"/{homepagePath}/module/bookRelayGroup"})
public class BookRelayGroupController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bookRelayGroup/";

	@Autowired
	private BookRelayGroupService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayGroup", bookRelayGroup);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayGroup", bookRelayGroup);
		
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		bookRelayGroup.setAdd_id(getSessionMemberId(request));
		model.addAttribute("bookRelayGroup", bookRelayGroup);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayGroup bookRelayGroup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayGroup.getEditMode().equals("ADD")) {
    		ValidationUtils.rejectIfEmpty(result, "group_name", "기관명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "manager_name", "담당자명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_plan", "릴레이 계획을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_personnel", "릴레이 예상인원을 입력하세요.");
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		
    		ValidationUtils.rejectIfStringLength(result, "group_name", 100, "기관명");
    		ValidationUtils.rejectIfStringLength(result, "manager_name", 20, "담당자명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레이 계획");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookRelayGroup.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (bookRelayGroup.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					bookRelayGroup.setAdd_id("ANONYMOUS");
				} else {
					bookRelayGroup.setAdd_id(getSessionMemberId(request));
				}
				service.addBookRelayGroup(bookRelayGroup);
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
