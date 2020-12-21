package kr.go.gbelib.app.module.bookReportContest;

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
import kr.go.gbelib.app.cms.module.bookReportContest.BookReportContest;
import kr.go.gbelib.app.cms.module.bookReportContest.BookReportContestService;

@Controller(value = "userBookReportContest")
@RequestMapping(value = {"/{homepagePath}/module/bookReportContest"})
public class BookReportContestController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/bookReportContest/";

	@Autowired
	private BookReportContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookReportContest bookReportContest, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("bookReportContest", bookReportContest);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookReportContest bookReportContest, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		bookReportContest.setAdd_id(getSessionMemberId(request));
		model.addAttribute("bookReportContest", bookReportContest);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookReportContest bookReportContest, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookReportContest.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "participation_field", "참가분야를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "user_name", "성명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(본인) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(본인) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookReportContest.getProtector_phone())) {
    			ValidationUtils.rejectPhone(result, "protector_phone", "휴대폰(보호자) 번호가 올바르지 않습니다.");
    		}
    		if (StringUtils.isNotEmpty(bookReportContest.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "성명");
    		ValidationUtils.rejectIfStringLength(result, "school_name", 50, "학교");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
		}
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		bookReportContest.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (bookReportContest.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					bookReportContest.setAdd_id("ANONYMOUS");
				} else {
					bookReportContest.setAdd_id(getSessionMemberId(request));
				}
				service.addBookReportContest(bookReportContest, mpRequest);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
				res.setUrl("index.do?menu_idx=" + bookReportContest.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
