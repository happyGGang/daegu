package kr.co.whalesoft.app.cms.module.survey;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.answer.Answer;
import kr.co.whalesoft.app.cms.module.survey.answer.AnswerService;
import kr.co.whalesoft.app.cms.module.survey.answer.SampleSearchView;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.quest.QuestService;
import kr.co.whalesoft.app.cms.module.survey.statistics.StatisticsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value={"/cms/module/survey"})
public class SurveyController extends BaseController {

	private final String basePath = "/cms/module/survey/";

	@Autowired
	private SurveyService service;
	
	@Autowired
	private QuestService questService;
	
	@Autowired
	private AnswerService answerService;
		
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private StatisticsService statisticsService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(String url, Model model, Survey survey, HttpServletRequest request) throws AuthException {	
		Member member = (Member) getSessionMemberInfo(request);
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			survey.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		survey.setAdd_user_id(member.getMember_id());
		service.setPaging(model, service.getSurveyCount(survey), survey);
				
		model.addAttribute("surveyList", service.getSurvey(survey));
		model.addAttribute("survey", survey);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, Survey survey, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Member member = (Member) getSessionMemberInfo(request);
		survey.setAdd_user_id(member.getMember_id());
		Survey surveyBean = service.getSurveyOne(survey);
		if (surveyBean == null) {
			service.alertMessage("권한이 없습니다.", request, response);
			return null;
		}
		
		if(surveyBean.getSurvey_content() != null) {
			surveyBean.setSurvey_content(surveyBean.getSurvey_content().replace("\r\n", "<br />"));
		}
		surveyBean.setHomepage_id(survey.getHomepage_id());
		
		Answer answer = new Answer();
		answer.setHomepage_id(survey.getHomepage_id());
		answer.setSurvey_idx(survey.getSurvey_idx());
		model.addAttribute("selectedUsersCnt", statisticsService.getSelectedUsersCnt(answer));
		
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(survey.getHomepage_id())));
		model.addAttribute("survey", surveyBean);
		return basePath + "view_ajax";
	}
	
	@RequestMapping(value = {"/skinSample.*"}, method = RequestMethod.GET)
	public String skinSample(Model model, Survey survey, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(survey.getSkin_cd().equals("1")) {
			return basePath + "layout/skin1_ajax";
		} else {
			return basePath + "layout/skin2_ajax";
		}
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Survey survey, HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean reqStatus = false;
		
		if(survey.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			Survey survey_temp = new Survey();
			survey_temp.setSurvey_idx(survey.getSurvey_idx());
			survey_temp.setHomepage_id(survey.getHomepage_id());
			survey_temp = service.getSurveyOne(survey_temp);
			
			if (survey_temp.getAnswer_count() > 0) {
				service.alertMessageAjax("응답자가 있는 경우 설문기간만 수정하실 수 있습니다.", request, response);
				reqStatus = true;
			}
			
			Member member = (Member) getSessionMemberInfo(request);
			survey.setAdd_user_id(member.getMember_id());
			Survey surveyBean = service.getSurveyOne(survey);
			if (surveyBean == null) {
				service.alertMessage("권한이 없습니다.", request, response);
				return null;
			}
			surveyBean.setEditMode(survey.getEditMode());
			surveyBean.setHomepage_id(survey.getHomepage_id());
			model.addAttribute("survey", surveyBean);
			model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(survey.getHomepage_id())));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("survey", survey);
		}
		
		if(reqStatus) {
			return basePath + "editDate";
		} else {
			return basePath + "edit";
		}
		
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "survey_title", "설문조사 조사명을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "survey_content", "설문조사 내용을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "survey_start_date", "설문조사 기간을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "survey_end_date", "설문조사 기간을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "greetings", "인사말을 입력하세요.");

		Member member = (Member) getSessionMemberInfo(request);
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			if(survey.getEditMode().equals("MODIFY")) {
				survey.setModify_user_id(member.getMember_id());
				service.modifySurvey(survey);
				res.setValid(true);
				res.setUrl("/cms/module/survey/view.do");
				res.setData(survey.getUrlParam(survey));
				res.setMessage("수정 되었습니다.");
			} else if(survey.getEditMode().equals("PICK")) {
				res.setValid(true);
//				res.setUrl("/cms/module/survey/index.do");
				res.setMessage("등록 되었습니다.");
			} else {
				survey.setAdd_user_id(member.getMember_id());
				service.addSurvey(survey);
				res.setValid(true);
				res.setUrl("/cms/module/survey/index.do");
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/saveDate.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveDate(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "survey_start_date", "설문조사 기간을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "survey_end_date", "설문조사 기간을 선택하세요.");

		Member member = (Member) getSessionMemberInfo(request);
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			if(survey.getEditMode().equals("MODIFY")) {
				survey.setModify_user_id(member.getMember_id());
				service.modifySurveyDate(survey);
				res.setValid(true);
				res.setUrl("/cms/module/survey/view.do");
				res.setData(survey.getUrlParam(survey));
				res.setMessage("수정 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/changeOpen.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse changeOpen(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			service.modifySurveyOpenYN(survey);
			res.setValid(true);				
			res.setData(survey.getUrlParam(survey));
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/changePrivateOpen.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse changePrivateOpen(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
				service.modifySurveyPrivateYn(survey);
				res.setValid(true);				
				res.setData(survey.getUrlParam(survey));
				res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@Transactional
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			
			try {
				String homepage_id = request.getParameter("homepage_id");
				String[] ids = homepage_id.split(",");
				if (ids.length > 1) {
					homepage_id = ids[0];
					survey.setHomepage_id(homepage_id);
				}
			} catch ( Exception e ) {
			}
			
			service.deleteSurvey(survey);			
			service.deleteSurveyQuest(survey);
			service.deleteSurveyQuestDetail(survey);
			service.deleteSurveyQuestMatrix(survey);
			service.deleteSurveyAnswerDetail(survey);
			service.deleteSurveyAnswerUser(survey);
			service.deleteSurveyAnswerMatrix(survey);
			
			res.setValid(true);
			res.setUrl("/cms/module/survey/index.do");
			res.setData(survey.getUrlParam(survey));
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	@Transactional
	@RequestMapping(value = {"/copy.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse copy(Survey survey, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			Member member = (Member) getSessionMemberInfo(request);
			try {
				String homepage_id = request.getParameter("homepage_id");
				String[] ids = homepage_id.split(",");
				if (ids.length > 1) {
					homepage_id = ids[0];
					survey.setHomepage_id(homepage_id);
				}
			} catch ( Exception e ) {}
			
			survey.setAdd_user_id(member.getMember_id());
			
			service.copySurvey(survey);
			service.copySurveyQuest(survey);
			service.copySurveyQuestDetail(survey);
			service.copySurveyQuestMatrix(survey);
			
			res.setValid(true);
			res.setUrl("/cms/module/survey/index.do");
			res.setData(survey.getUrlParam(survey));
			res.setMessage("복사 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	
	

//	@RequestMapping(value = {"/offLineExcelDownload.*"}, method = RequestMethod.POST)
//	public SurveyOfflineView offLineExcelDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		
//		if (quest.getSurvey_idx() != 0) {
//			Survey survey = new Survey();
//			survey.setSurvey_idx(quest.getSurvey_idx());
//			survey.setHomepage_id(quest.getHomepage_id());
//			survey = service.getSurveyOne(survey);
//			if (survey != null) {
//				model.addAttribute("survey", survey);
//			} else {
//				service.alertMessage("잘못된 경로로 접근하셨습니다.", request, response);
//				return null;
//			}
//		}
//		model.addAttribute("questList", questService.getQuest(quest));
//
//		return new SurveyOfflineView();
//	}
//	
//	@RequestMapping(value = {"/offLineExcelDownload.*"}, method = RequestMethod.POST)
//	public void offLineExcelDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		Download down = new Download(request, response, "survey.xls");
//		service.writeExcelData(quest, down.getOutputStream(), request);
//		down.close();
//	}
	
	@RequestMapping (value = { "/offLineExcelDownload.*" }, method = RequestMethod.GET)
	public String index(Model model, Quest quest, HttpServletRequest request) {

		return basePath + "index";
	}
	
	@RequestMapping(value={"/uploadForm.*"}, method=RequestMethod.GET)
	public String uploadForm(Model model, Survey survey, HttpServletRequest request, HttpServletResponse response) throws Exception{
		checkAuth("U", model, request);
		
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(survey.getHomepage_id())));
		model.addAttribute("survey", survey);
		
		return basePath + "uploadForm_ajax";
	}
	
	@RequestMapping(value = {"/excelSampleDownload.*"}, method = RequestMethod.POST)
	public SampleSearchView excelSampleDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("quest", quest);
		model.addAttribute("questCnt", questService.getQuestCnt(quest));
		
		quest.setSearchMode("noComment");
		model.addAttribute("questForm", questService.getQuest(quest));
		
		return new SampleSearchView();
	}
	
	@RequestMapping(value = {"/excelUpload.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse excelUpload(Quest quest, BindingResult result, MultipartHttpServletRequest mRequset) throws Exception {
		JsonResponse res = new JsonResponse(mRequset);
		
		quest.setSearchMode("noComment");
		List<Quest> questForm = questService.getQuest(quest);
		
		MultipartFile file = mRequset.getFile("file");
		if(file != null) {
			String fileType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1).toUpperCase();
			if(fileType.equals("XLS")) {
				Object list = answerService.excelUpload(quest, mRequset.getFile("file"), questForm);
				if(list instanceof String) {
					res.setValid(false);
					res.setMessage((String)list);
					return res;
				}
				
				Survey survey = new Survey();
				survey.setHomepage_id(quest.getHomepage_id());
				survey.setSurvey_idx(quest.getSurvey_idx());
				survey = service.getSurveyOne(survey);
				
				for(Quest one : (List<Quest>)list) {
					if(survey.getName_yn().equals("Y")) {
						one.setAdd_user_name("익명");
					}
					
					String OFFLINE = String.format("OFFLINE%s", String.valueOf(System.currentTimeMillis()));
					one.setAdd_user_id(OFFLINE);
					one.setMember_key("OFFLINE");
					one.setAdd_user_ip("OFFLINE");
					
					answerService.addAnswerSurvey(one);
				}
				
				res.setValid(true);
				res.setMessage("오프라인 설문 등록되었습니다.");
				
				if(survey.getPopup_yn().equals("Y")) {
				} else {
					res.setData(quest.getMenu_idx());
				}
					
			} else {
				res.setValid(false);
				res.setMessage(".xls 확장자를 가진 파일만 등록할 수 있습니다. \n(Excel 97 - 2003 통합 문서)");
			}
		}

		return res;
	}
	
}