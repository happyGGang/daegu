package kr.go.gbelib.app.module.bookRelayClub;

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
import kr.go.gbelib.app.cms.module.bookRelayClub.BookRelayClub;
import kr.go.gbelib.app.cms.module.bookRelayClub.BookRelayClubService;

@Controller(value = "userBookRelayClub")
@RequestMapping(value = {"/{homepagePath}/module/bookRelayClub"})
public class BookRelayClubController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bookRelayClub/";

	@Autowired
	private BookRelayClubService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayClub", bookRelayClub);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookRelayClub", bookRelayClub);
		
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		bookRelayClub.setAdd_id(getSessionMemberId(request));
		model.addAttribute("bookRelayClub", bookRelayClub);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayClub bookRelayClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayClub.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "club_name", "동아리명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "leader_name", "대표자명 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_plan", "릴레이 계획을 입력하세요.");
    		
    		for (int i = 0; i < bookRelayClub.getRelayList().size(); i++) {
    			ValidationUtils.rejectIfEmpty(result, "relayList[" + i + "].relay_name", "릴레이 명단의 " + (i + 1) + "번째 이름을 입력하세요.");
    			ValidationUtils.rejectIfEmpty(result, "relayList[" + i + "].relay_phone", "릴레이 명단의 " + (i + 1) + "번째 연락처를 입력하세요.");
			}
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookRelayClub.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "club_name", 100, "동아리명");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "leader_name", 20, "대표자명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레이 계획");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookRelayClub.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (bookRelayClub.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					bookRelayClub.setAdd_id("ANONYMOUS");
				} else {
					bookRelayClub.setAdd_id(getSessionMemberId(request));
				}
				service.addBookRelayClub(bookRelayClub);
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
