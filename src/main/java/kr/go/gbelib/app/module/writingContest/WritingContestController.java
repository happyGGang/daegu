package kr.go.gbelib.app.module.writingContest;

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
import kr.go.gbelib.app.cms.module.writingContest.WritingContest;
import kr.go.gbelib.app.cms.module.writingContest.WritingContestService;

@Controller(value = "userWritingContest")
@RequestMapping(value = {"/{homepagePath}/module/writingContest"})
public class WritingContestController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/writingContest/";

	@Autowired
	private WritingContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, WritingContest writingContest, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("writingContest", writingContest);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, WritingContest writingContest, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		writingContest.setAdd_id(getSessionMemberId(request));
		model.addAttribute("writingContest", writingContest);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(WritingContest writingContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(writingContest.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "participation_field", "참가분야를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "writing_type", "참가분야-종류를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "user_name", "성명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(본인) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(본인) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(writingContest.getProtector_phone())) {
    			ValidationUtils.rejectPhone(result, "protector_phone", "휴대폰(보호자) 번호가 올바르지 않습니다.");
    		}
    		if (StringUtils.isNotEmpty(writingContest.getUser_email())) {
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
		writingContest.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (writingContest.getEditMode().equals("ADD")) {
				
				if (!member.isLogin() && member.isAnonymous()) {
					writingContest.setAdd_id("ANONYMOUS");
				} else {
					writingContest.setAdd_id(getSessionMemberId(request));
				}
				service.addWritingContest(writingContest);
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
