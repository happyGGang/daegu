package kr.go.gbelib.app.cms.module.writingContest;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/writingContest"})
public class WritingContestController extends BaseController {

	private final String basePath = "/cms/module/writingContest/";
	
	@Autowired
	private WritingContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, WritingContest writingContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		writingContest.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.writingContestCount(writingContest), writingContest);
		
		model.addAttribute("writingContest", writingContest);
		model.addAttribute("writingContestList", service.writingContestList(writingContest));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, WritingContest writingContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		writingContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("writingContest", writingContest);
		model.addAttribute("getWritingContest", service.getWritingContest(writingContest));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, WritingContest writingContest, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		writingContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("writingContest", writingContest);
		
		return basePath + "edit_ajax";
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
    		ValidationUtils.rejectIfStringLength(result, "address_base", 500, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 500, "상세주소");
		}
		
		if (!result.hasErrors()) {
			writingContest.setAdd_id(getSessionMemberId(request));
			service.addWritingContest(writingContest);
			res.setValid(true);
			res.setMessage("저장되었습니다.");
			res.setUrl("index.do");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	

	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(WritingContest writingContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		writingContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (writingContest.getEditMode().equals("DELETE")) {
				service.deleteWritingContest(writingContest);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}	
		
	
	@RequestMapping (value = {"/statusChange.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusChange(WritingContest writingContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		writingContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeWritingContest(writingContest);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WritingContestSearchView excel(Model model, WritingContest writingContest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("writingContest", writingContest);
		model.addAttribute("writingContestResult", service.getExcelList(writingContest));
		
		return new WritingContestSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, WritingContest writingContest, HttpServletRequest request, HttpServletResponse response) {
		List<WritingContest> writingContestList = service.getExcelList(writingContest);
		
		new WritingContestXlsToCsv(writingContestList, "백일장 참가 신청 리스트.csv", request, response);
	}
	
}
