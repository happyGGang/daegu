package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.checkInOutSurvey.CheckInOutSurvey;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/checkInOutSurveyReq"})
public class CheckInOutSurveyReqController extends BaseController {

	private final String basePath = "/cms/module/checkInOutSurveyReq/";

	@Autowired
	private CheckInOutSurveyReqService checkInOutSurveyReqService;
	
	@Autowired
	private CheckInOutSurveyQuestionService checkInOutSurveyQuestionService;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	@Qualifier("checkInOutSurveyStorage")
	private FileStorage checkInOutSurveyStorage;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CheckInOutSurveyReq checkInOutSurveyReq, HttpServletRequest request) {
		checkInOutSurveyReq.setHomepage_id(getAsideHomepageId(request));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, CheckInOutSurvey checkInOutSurvey) {
		if(checkInOutSurvey.getEditMode().equals("MODIFY")) {

		} else {
			model.addAttribute("quiz", checkInOutSurvey);
		}
		
		model.addAttribute("quizTypeList", codeService.getCode(checkInOutSurvey.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, CheckInOutSurvey checkInOutSurvey, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = checkInOutSurvey.getEditMode();
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public CheckInOutSurveyReqSearchView excel(Model model, CheckInOutSurveyReq checkInOutSurveyReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		int count = checkInOutSurveyReqService.getQuizReqListCount(checkInOutSurveyReq);
		checkInOutSurveyReqService.setPaging(model, count, checkInOutSurveyReq);
		
		List<CheckInOutSurveyReq> quizQuestionResult = checkInOutSurveyReqService.getQuizReqListAll(checkInOutSurveyReq);
		List<CheckInOutSurveyQuestion> checkInOutSurveyQuestionsList = checkInOutSurveyQuestionService.getQuizQuestionList(new CheckInOutSurveyQuestion(checkInOutSurveyReq.getHomepage_id(), checkInOutSurveyReq.getCheckinout_survey_idx()));
		
		model.addAttribute("quizReq", checkInOutSurveyReq);
		model.addAttribute("quizQuestionResult", quizQuestionResult);
		model.addAttribute("quizQuestionList", checkInOutSurveyQuestionsList);
		return new CheckInOutSurveyReqSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, CheckInOutSurveyReq checkInOutSurveyReq, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<CheckInOutSurveyReq> quizQuestionResult = checkInOutSurveyReqService.getQuizReqListAll(checkInOutSurveyReq);
		List<CheckInOutSurveyQuestion> checkInOutSurveyQuestionsList = checkInOutSurveyQuestionService.getQuizQuestionList(new CheckInOutSurveyQuestion(checkInOutSurveyReq.getHomepage_id(), checkInOutSurveyReq.getCheckinout_survey_idx()));
		
		new CheckInOutSurveyReqXlsToCsv(checkInOutSurveyReq, quizQuestionResult, checkInOutSurveyQuestionsList, request, response);
	}
}