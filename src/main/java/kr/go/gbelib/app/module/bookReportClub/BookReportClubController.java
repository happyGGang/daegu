package kr.go.gbelib.app.module.bookReportClub;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bookReportClub.BookReportClub;
import kr.go.gbelib.app.cms.module.bookReportClub.BookReportClubService;

@Controller(value = "userBookReportClub")
@RequestMapping(value = {"/{homepagePath}/module/bookReportClub"})
public class BookReportClubController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bookReportClub/";

	@Autowired
	private BookReportClubService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookReportClub.setHomepage_id(homepage.getHomepage_id());
		service.setPaging(model, service.bookReportClubCount(bookReportClub), bookReportClub);
		model.addAttribute("bookReportClubList", service.bookReportClubList(bookReportClub));
		model.addAttribute("bookReportClub", bookReportClub);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookReportClub", bookReportClub);
		
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		bookReportClub.setAdd_id(getSessionMemberId(request));
		model.addAttribute("bookReportClub", bookReportClub);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookReportClub.setHomepage_id(homepage.getHomepage_id());
		
		service.setPaging(model, service.bookReportClubCount(bookReportClub), bookReportClub);
		
		model.addAttribute("bookReportClub", bookReportClub);
		model.addAttribute("getBookReportClub", service.getBookReportClub(bookReportClub));
		
		return String.format(basePath, homepage.getFolder()) + "view";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookReportClub bookReportClub, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookReportClub.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "club_name", "동아리명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "rep_name", "대표자명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(제1 연락처) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(제1 연락처) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookReportClub.getUser_phone())) {
    			ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(제1 연락처) 번호가 올바르지 않습니다.");
    		}

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(제1 연락처) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookReportClub.getUser_phone2())) {
    			ValidationUtils.rejectPhone(result, "user_phone2", "휴대폰(제2 연락처) 번호가 올바르지 않습니다.");
    		}
    		if (StringUtils.isNotEmpty(bookReportClub.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "rep_name", 20, "대표자명");
    		ValidationUtils.rejectIfStringLength(result, "club_name", 50, "동아리명");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 500, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 500, "상세주소");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookReportClub.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (bookReportClub.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					bookReportClub.setAdd_id("ANONYMOUS");
				} else {
					bookReportClub.setAdd_id(getSessionMemberId(request));
				}
				service.addBookReportClub(bookReportClub, mpRequest);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
				res.setUrl("index.do?menu_idx=" + bookReportClub.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
