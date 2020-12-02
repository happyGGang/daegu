package kr.go.gbelib.app.cms.module.readerContest;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
@RequestMapping(value = {"/cms/module/readerContest"})
public class ReaderContestController extends BaseController {

	private final String basePath = "/cms/module/readerContest/";
	
	@Autowired
	private ReaderContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, ReaderContest readerContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		readerContest.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.readerContestCount(readerContest), readerContest);
		
		model.addAttribute("readerContest", readerContest);
		model.addAttribute("readerContestList", service.readerContestList(readerContest));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, ReaderContest readerContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		readerContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("readerContest", readerContest);
		model.addAttribute("getReaderContest", service.getReaderContest(readerContest));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, ReaderContest readerContest, HttpServletRequest request) throws Exception {
		checkAuth("C", model, request);
		readerContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("readerContest", readerContest);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ReaderContest readerContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(readerContest.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "participation_field", "참가분야를 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_date", "생년월일을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(본인) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(본인) 번호가 올바르지 않습니다.");
    		if (readerContest.getProtector_phone() != null && readerContest.getProtector_phone() != "") {
    			ValidationUtils.rejectPhone(result, "protector_phone", "휴대폰(보호자) 번호가 올바르지 않습니다.");
    		}
    		if (readerContest.getUser_email() != null && readerContest.getUser_email() != "") {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "이름");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
		}
		
		if (!result.hasErrors()) {
			readerContest.setAdd_id(getSessionMemberId(request));
			service.addReaderContest(readerContest);
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
	public @ResponseBody JsonResponse delete(ReaderContest readerContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		readerContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (readerContest.getEditMode().equals("DELETE")) {
				service.deleteReaderContest(readerContest);
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
	public @ResponseBody JsonResponse statusChange(ReaderContest readerContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		readerContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeReaderContest(readerContest);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ReaderContestSearchView excel(Model model, ReaderContest readerContest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("readerContest", readerContest);
		model.addAttribute("readerContestResult", service.getExcelList(readerContest));
		
		return new ReaderContestSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, ReaderContest readerContest, HttpServletRequest request, HttpServletResponse response) {
		List<ReaderContest> readerContestList = service.getExcelList(readerContest);
		
		new ReaderContestXlsToCsv(readerContestList, "다독자 공모 참가 신청 리스트.csv", request, response);
	}
	
}
