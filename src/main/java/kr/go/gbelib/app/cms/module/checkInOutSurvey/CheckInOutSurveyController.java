package kr.go.gbelib.app.cms.module.checkInOutSurvey;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.checkInOut.CheckInOut;
import kr.go.gbelib.app.cms.module.checkInOut.CheckInOutService;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestion;
import kr.go.gbelib.app.cms.module.checkInOutSurveyQuestion.CheckInOutSurveyQuestionService;
import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReq;
import kr.go.gbelib.app.cms.module.checkInOutSurveyReq.CheckInOutSurveyReqService;
import kr.go.gbelib.app.cms.module.teach.Teach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping(value = {"/cms/module/checkInOutSurvey"})
public class CheckInOutSurveyController extends BaseController {

	private final String basePath = "/cms/module/checkInOutSurvey/";

	@Autowired
	private CheckInOutService checkInOutService;

	@Autowired
	private CheckInOutSurveyService service;
	
	@Autowired
	private CheckInOutSurveyQuestionService checkInOutSurveyQuestionService;
	
	@Autowired
	private CheckInOutSurveyReqService checkInOutSurveyReqService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CheckInOutSurvey checkInOutSurvey, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		checkInOutSurvey.setHomepage_id(getAsideHomepageId(request));

		int count = service.getQuizListCount(checkInOutSurvey);
		service.setPaging(model, count, checkInOutSurvey);
		model.addAttribute("checkInOutSurvey", checkInOutSurvey);
		model.addAttribute("checkInOutSurveyListCount", count);
		model.addAttribute("checkInOutSurveyList", service.getQuizList(checkInOutSurvey));
		model.addAttribute("checkInOutSurveyTypeList", codeService.getCode(checkInOutSurvey.getHomepage_id(), "H0003"));
		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, CheckInOutSurvey checkInOutSurvey, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if (homepage == null) {
			Homepage homepageOne = homepageService.getHomepageOne(new Homepage(checkInOutSurvey.getHomepage_id()));
			model.addAttribute("homepage", homepageOne);
		}
		if(checkInOutSurvey.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("checkInOutSurvey", service.copyObjectPaging(checkInOutSurvey, service.getQuizOne(checkInOutSurvey)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("checkInOutSurvey", checkInOutSurvey);
		}

		model.addAttribute("checkInOutSurveyTypeList", codeService.getCode(checkInOutSurvey.getHomepage_id(), "H0003"));
		return basePath + "edit_ajax";
	}

	@RequestMapping (value = {"/noticeEdit.*"})
	public String edit(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		checkInOut.setHomepage_id(getAsideHomepageId(request));

		int notice_count = checkInOutService.checkNoticeCount(checkInOut);

		if(notice_count > 0) {
			checkAuth("U", model, request);
			checkInOut = checkInOutService.getCheckInOutNotice(checkInOut);
			checkInOut.setEditMode("MODIFY");

			model.addAttribute("checkInOut", checkInOut);
		} else {
			checkAuth("C", model, request);
			checkInOut.setEditMode("ADD");
			model.addAttribute("checkInOut", checkInOut);
		}

		return basePath + "noticeEdit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, CheckInOutSurvey checkInOutSurvey, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = checkInOutSurvey.getEditMode();

		if ( !checkInOutSurvey.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "checkinout_survey_start_date", "설문조사 시작날짜를 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "checkinout_survey_end_date", "설문조사 종료날짜를 지정하세요.");
		}

		if (editMode.equals("ADD") || editMode.equals("MODIFY")) {
			if (service.checkSurveyExists(checkInOutSurvey)) {
				res.setValid(false);
				res.setMessage("설문조사 기간이 중복됩니다.");

				return res;
			}
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				checkInOutSurvey.setAdd_id(getSessionMemberId(request));
				service.addQuiz(checkInOutSurvey);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				checkInOutSurvey.setModify_id(getSessionMemberId(request));
				service.modifyQuiz(checkInOutSurvey);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteQuiz(checkInOutSurvey);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/noticeSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse noticeSave(Model model, CheckInOut checkInOut, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = checkInOut.getEditMode();

		if ( !checkInOut.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "checkinout_notice_name", "공지 제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "checkinout_notice_start_date", "공지 시작날짜를 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "checkinout_notice_end_date", "공지 종료날짜를 지정하세요.");
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				int notice_count = checkInOutService.checkNoticeCount(checkInOut);

				if (notice_count > 0) {
					res.setValid(false);
					res.setMessage("이미 공지중인 게시글이 있습니다. 공지 사용여부를 바꾸시고 다시 시도해주세요.");
				} else {
					checkInOut.setAdd_id(getSessionMemberId(request));
					checkInOutService.addCheckInOutNotice(checkInOut);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}

			} else if(editMode.equals("MODIFY")) {
				checkInOut.setModify_id(getSessionMemberId(request));
				checkInOutService.modifyCheckInOutNotice(checkInOut);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				checkInOutService.deleteCheckInOutNotice(checkInOut);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/deleteFile.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteFile(CheckInOutSurveyQuestion checkInOutSurveyQuestion, BindingResult result, HttpServletRequest request) throws ParseException {
		JsonResponse res = new JsonResponse(request);

		checkInOutSurveyQuestionService.deleteFile(checkInOutSurveyQuestion);
		res.setValid(true);
		res.setMessage("파일을 삭제 했습니다.");

		return res;
	}
	
	@RequestMapping(value = {"/editQuestion.*"})
	public String edit(Model model, CheckInOutSurveyQuestion checkInOutSurveyQuestion) {
		CheckInOutSurvey checkInOutSurvey = new CheckInOutSurvey();
		checkInOutSurvey.setHomepage_id(checkInOutSurveyQuestion.getHomepage_id());
		checkInOutSurvey.setCheckinout_survey_idx(checkInOutSurveyQuestion.getCheckinout_survey_idx());
		checkInOutSurvey = service.getQuizOne(checkInOutSurvey);
		
		model.addAttribute("checkInOutSurvey", checkInOutSurvey);
		model.addAttribute("checkInOutSurveyQuestion", checkInOutSurveyQuestion);
		model.addAttribute("checkInOutSurveyQuestionList", checkInOutSurveyQuestionService.getQuizQuestionList(checkInOutSurveyQuestion));
		return basePath + "editQuestion_ajax";
	}
	
	@RequestMapping(value = {"/saveQuestion.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveQuestion(Model model, CheckInOutSurveyQuestion checkInOutSurveyQuestion, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		CheckInOutSurvey checkInOutSurvey = new CheckInOutSurvey();
		checkInOutSurvey.setHomepage_id(checkInOutSurveyQuestion.getHomepage_id());
		checkInOutSurvey.setCheckinout_survey_idx(checkInOutSurveyQuestion.getCheckinout_survey_idx());
		checkInOutSurvey = service.getQuizOne(checkInOutSurvey);

		String editMode = checkInOutSurveyQuestion.getEditMode();
		
		if ( !checkInOutSurveyQuestion.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "checkinout_survey_question_title", "설문조사 제목을 입력하세요.");
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				checkInOutSurveyQuestionService.addQuizQuestion(checkInOutSurveyQuestion);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				checkInOutSurveyQuestionService.modifyQuizQuestion(checkInOutSurveyQuestion);
				res.setValid(true);
				//res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				checkInOutSurveyQuestionService.deleteQuizQuestion(checkInOutSurveyQuestion);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/reqList.*"})
	public String reqList(Model model, CheckInOutSurveyReq checkInOutSurveyReq, HttpServletRequest request) {

		int count = checkInOutSurveyReqService.getQuizReqListCount(checkInOutSurveyReq);

		checkInOutSurveyReqService.setPaging(model, count, checkInOutSurveyReq);
		
		List<CheckInOutSurveyReq> checkInOutSurveyReqList = checkInOutSurveyReqService.getQuizReqList(checkInOutSurveyReq);
		List<CheckInOutSurveyQuestion> checkInOutSurveyQuestionList = checkInOutSurveyQuestionService.getQuizQuestionList(new CheckInOutSurveyQuestion(checkInOutSurveyReq.getHomepage_id(), checkInOutSurveyReq.getCheckinout_survey_idx()));
		
		model.addAttribute("checkInOutSurvey", service.getQuizOne(new CheckInOutSurvey(checkInOutSurveyReq.getHomepage_id(), checkInOutSurveyReq.getCheckinout_survey_idx())));
		model.addAttribute("checkInOutSurveyQuestionList", checkInOutSurveyQuestionList);
		model.addAttribute("checkInOutSurveyReq", checkInOutSurveyReq);
		model.addAttribute("checkInOutSurveyReqCount", count);
		model.addAttribute("checkInOutSurveyReqList", checkInOutSurveyReqList);
		
		return basePath + "reqList_ajax";
	}
	
}