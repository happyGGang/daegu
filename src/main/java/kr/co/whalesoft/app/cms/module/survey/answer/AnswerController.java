package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.SurveyService;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.quest.QuestService;
import kr.co.whalesoft.app.cms.module.survey.statistics.StatisticsService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/survey"})
public class AnswerController extends BaseController {

	@Autowired
	private SurveyService surveyService;

	@Autowired
	private QuestService questService;

	@Autowired
	private AnswerService service;

	@Autowired
	private StatisticsService statisticsService;

	private String basePath = null;
	private Homepage homepage = null;

	private void attributeInit(HttpServletRequest request, Model model) {
		homepage = (Homepage)request.getAttribute("homepage");

		String homepageFolder = "";

		if ( homepage != null ) {
			homepageFolder = "/homepage/" + homepage.getFolder();
		}

		basePath = homepageFolder + "/module/survey/";
	}

	@RequestMapping(value={"/index.*"}, method=RequestMethod.GET)
	public String index(Model model, Survey survey, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		attributeInit(request, model);
		checkAuth("R", model, request);
		survey.setHomepage_id(homepage.getHomepage_id());

		service.setPaging(model, surveyService.getUserSurveyCount(survey), survey);
		model.addAttribute("surveyList", surveyService.getUserSurvey(survey));
		model.addAttribute("survey", survey);

		return basePath + "index";
	}

	@RequestMapping(value={"/index2.*"}, method=RequestMethod.GET)
	public String index2(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		attributeInit(request, model);
		homepage = (Homepage)request.getAttribute("homepage");

		if (quest.getSurvey_idx() != 0) {
			Survey survey = new Survey();
			survey.setSurvey_idx(quest.getSurvey_idx());
			survey.setHomepage_id(quest.getHomepage_id());
			survey = surveyService.getSurveyOne(survey);
			model.addAttribute("survey", survey);
		}

		model.addAttribute("homepage", homepage.getContext_path());
		model.addAttribute("questList", questService.getQuest(quest));
		model.addAttribute("quest", quest);

		return basePath + getSkinCd(quest) + "/" + "index";
	}

	@RequestMapping(value={"/index.*"}, method=RequestMethod.POST)
	public String index(Model model, Quest quest, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		attributeInit(request, model);
		return basePath + getSkinCd(quest) + "/" + "index";
	}

	@RequestMapping(value = { "/statistics.*" }, method = RequestMethod.GET)
	public String statistics(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		attributeInit(request, model);

		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		Survey surveyBean = surveyService.getSurveyOne(survey);
		if (surveyBean.getAnswer_count() > 0) {
			model.addAttribute("statistics", statisticsService.getQuest(quest));
			surveyBean.setSurvey_content(surveyBean.getSurvey_content().replace("\r\n", "<br />"));
			model.addAttribute("survey", surveyBean);
		} else {
			service.alertMessagePopup("응답자가 없습니다.", request, response);
			return null;
		}
		return basePath + "statistics_ajax";
	}

	@RequestMapping(value = { "/detail.*" }, method = RequestMethod.GET)
	public String detail(Model model, Quest quest, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		attributeInit(request, model);
		Survey survey = new Survey();
		survey.setHomepage_id(quest.getHomepage_id());
		survey.setSurvey_idx(quest.getSurvey_idx());
		Survey surveyBean = surveyService.getSurveyOne(survey);
		if (!StringUtils.isEmpty(surveyBean.getSurvey_content())) {
			surveyBean.setSurvey_content(surveyBean.getSurvey_content().replace("\r\n", "<br />"));
		}
		model.addAttribute("survey", surveyBean);
		model.addAttribute("description", statisticsService.getDescriptionList(quest));
		model.addAttribute("quest", questService.getQuestOne(quest));
		return basePath + "detailView_ajax";
	}


	@RequestMapping(value={"/view.*"}, method=RequestMethod.GET)
	public String view(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		attributeInit(request, model);
		homepage = (Homepage)request.getAttribute("homepage");
		Member member = (Member) getSessionMemberInfo(request);
		if (quest.getSurvey_idx() != 0) {
			Survey survey = new Survey();
			survey.setSurvey_idx(quest.getSurvey_idx());
			if ( StringUtils.isEmpty(quest.getHomepage_id()) ) {
				quest.setHomepage_id(homepage.getHomepage_id());
			}
			survey.setHomepage_id(quest.getHomepage_id());
			survey = surveyService.getSurveyOne(survey);
			if (survey != null) {
				model.addAttribute("survey", survey);
			} else {
				service.alertMessage("잘못된 경로로 접근하셨습니다.", request, response);
				return null;
			}
		}
		model.addAttribute("questList", questService.getQuest(quest));
		model.addAttribute("quest", quest);
		if(quest.getPopup_yn().equals("Y")) {
			return basePath + getSkinCd(quest) + "/" + "view_ajax";
		} else {
			return basePath + getSkinCd(quest) + "/" + "view";
//			return basePath + getSkinCd(quest) + "/" + "view_popup_ajax";
		}
	}

	@RequestMapping(value={"/view2.*"}, method=RequestMethod.GET)
	public String view2(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		attributeInit(request, model);
		homepage = (Homepage)request.getAttribute("homepage");
		if (quest.getSurvey_idx() != 0) {
			Survey survey = new Survey();
			survey.setSurvey_idx(quest.getSurvey_idx());
			if ( StringUtils.isEmpty(quest.getHomepage_id()) ) {
				quest.setHomepage_id(homepage.getHomepage_id());
			}
			survey.setHomepage_id(quest.getHomepage_id());
			survey = surveyService.getSurveyOne(survey);
			if (survey != null) {
				model.addAttribute("survey", survey);
			} else {
				service.alertMessage("잘못된 경로로 접근하셨습니다.", request, response);
				return null;
			}
		}
		model.addAttribute("questList", questService.getQuest(quest));
		model.addAttribute("quest", quest);
		return basePath  + "skin1/" + "view2_ajax";
	}

	@RequestMapping(value={"/view3.*"}, method=RequestMethod.GET)
	public String view3(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		attributeInit(request, model);
		homepage = (Homepage)request.getAttribute("homepage");
		if (quest.getSurvey_idx() != 0) {
			Survey survey = new Survey();
			survey.setSurvey_idx(quest.getSurvey_idx());
			if ( StringUtils.isEmpty(quest.getHomepage_id()) ) {
				quest.setHomepage_id(homepage.getHomepage_id());
			}
			survey.setHomepage_id(quest.getHomepage_id());
			survey = surveyService.getSurveyOne(survey);
			if (survey != null) {
				model.addAttribute("survey", survey);
			} else {
				service.alertMessage("잘못된 경로로 접근하셨습니다.", request, response);
				return null;
			}
		}
		model.addAttribute("questList", questService.getQuest(quest));
		model.addAttribute("quest", quest);
		return basePath  + "skin1/" + "view3_ajax";
	}

	@RequestMapping(value={"/edit.*"}, method=RequestMethod.GET)
	public String edit(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		checkAuth("C", model, request);
		attributeInit(request, model);
		homepage = (Homepage)request.getAttribute("homepage");
		Member member = (Member) getSessionMemberInfo(request);

		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		if ( StringUtils.isEmpty(quest.getHomepage_id()) ) {
			quest.setHomepage_id(homepage.getHomepage_id());
		}
		survey.setHomepage_id(quest.getHomepage_id());
		survey = surveyService.getSurveyOneByUser(survey);

		if (survey != null) {
			if (StringUtils.equals(survey.getAnnyms_yn(), "N")) {
				if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
    				if (survey.getPopup_yn().equals("N")) {
    					quest.setBefore_url(String.format("%s/%s/module/survey/index.do?menu_idx=%s", homepage.getDomain(), homepage.getContext_path(), quest.getMenu_idx()));
    					service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), quest.getMenu_idx(), quest.getBefore_url()), request, response);
    					return null;
    				} else {
    					service.alertMessagePopup("로그인 후 이용가능합니다.", request, response);
    					return null;
    				}

				}
			}

			if (quest.getSurvey_idx() != 0) {
//				if (survey.getSurvey_open_yn().equals("N")) {
//					service.alertMessage("완료된 설문조사입니다.", request, response);
//					return null;
//
//				}
//				if (service.isDupleAnswer(quest, member)) {
//					if(quest.getPopup_yn().equals("N")) {
//						service.alertMessage("이미 설문조사에 참여하셨습니다.", request, response);
//					} else {
//						service.alertMessagePopup("이미 설문조사에 참여하셨습니다.", request, response);
//					}
//					return null;
//				}
				model.addAttribute("already", service.isDupleAnswer(quest, member));
				if(surveyService.isLimitedUser(survey, member)) {
					surveyService.alertMessage("접근이 제한된 사용자입니다.", request, response);
					return null;
				}
				model.addAttribute("survey", survey);
			} else {
				service.alertMessage("잘못된 경로로 접근하셨습니다.", request, response);
				return null;
			}
			model.addAttribute("questList", questService.getQuest(quest));
			model.addAttribute("quest", quest);

			if ( quest.getPopup_yn().equals("Y") ) {
				return basePath + getSkinCd(quest) + "/" + "edit_popup_ajax";
			}
			else {
				return basePath + getSkinCd(quest) + "/" + "edit";
			}
		}
		else {
			service.alertMessage("해당 설문 정보가 없습니다.", request, response);
			return null;
		}
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Quest quest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Member member = (Member) getSessionMemberInfo(request);
		quest.setHomepage_id(homepage.getHomepage_id());
		//유효성검사 시작
//		if (!service.isSurveyPeriod(quest)) {
//			result.reject("설문조사 참여기간이 아닙니다.");
//		} else if (!service.isSurveyOpen(quest)) {
//			result.reject("완료된 설문조사입니다.");
//		} else if (service.isDupleAnswer(quest, member)) {
//			result.reject("이미 설문조사에 참여하셨습니다.");
//		}
		validationSurvey(result, quest, member);
		//유효성검사 끝
		Survey survey = new Survey();
		survey.setHomepage_id(homepage.getHomepage_id());
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey = surveyService.getSurveyOne(survey);

		if (!result.hasErrors()) {
			StringBuilder sb = new StringBuilder();
			sb.append(quest.getHomepage_id() + "\n");
			sb.append(quest.getSurvey_idx() + "\n");
			sb.append(quest.getMatrix_count() + "\n");
			sb.append(quest.getPopup_yn() + "\n");
			ObjectMapper mapper = new ObjectMapper();
			mapper.setVisibilityChecker(mapper.getSerializationConfig().getDefaultVisibilityChecker()
	                .withFieldVisibility(JsonAutoDetect.Visibility.ANY)
	                .withGetterVisibility(JsonAutoDetect.Visibility.NONE)
	                .withSetterVisibility(JsonAutoDetect.Visibility.NONE)
	                .withCreatorVisibility(JsonAutoDetect.Visibility.NONE));
			try {
				sb.append(mapper.writeValueAsString(quest.getAnswer_list()));
			} catch(Exception e) {
				e.printStackTrace();
			}

			String addResult = WebFilterCheckUtils.webFilterCheck("설문응답자", "설문조사", sb.toString());
			if (addResult != null) {
				res.setValid(false);
				res.setUrl(addResult);
				res.setTargetOpener(true);
				return res;
			}

			res.setValid(true);

			if (member.isLogin()) {
				if(survey.getName_yn().equals("Y")) {
					quest.setAdd_user_name("익명");
				} else {
					quest.setAdd_user_name(member.getMember_name());
				}
				quest.setAdd_id(member.getMember_id());
				quest.setMember_key(member.getSeq_no());
				quest.setAdd_user_ip(request.getRemoteAddr());
			} else {
				//비로그인사용자
				if(survey.getName_yn().equals("Y")) {
					quest.setAdd_user_name("익명");
				} else {
					quest.setAdd_user_name("비로그인");
				}
//				ANNYMS1499222739642
				String anonymous = String.format("ANNYMS%s", String.valueOf(System.currentTimeMillis()));
				quest.setAdd_id(anonymous);
				quest.setMember_key(anonymous);
				quest.setAdd_user_ip(request.getRemoteAddr());
			}


			service.addAnswerSurvey(quest);
			res.setMessage(survey.getGreetings());
			if(survey.getPopup_yn().equals("Y")) {
			} else {
				res.setData(quest.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}

	private void validationSurvey(BindingResult result, Quest quest, Member member) {
		quest.setSearchMode("noComment");

		if(quest.getAnswer_list() == null) {
			result.reject("응답 문항이 없습니다.");
			return;
		}

		for (int i = 0; i < quest.getAnswer_list().size(); i++) {
			Answer answerOne = quest.getAnswer_list().get(i);
			String questType = answerOne.getQuest_type();
			String questRequied = answerOne.getRequired_yn();

			if(questType != null) {
				if (questType.equals("ONE")) {
					if (answerOne.getQuest_idx_list() == null || answerOne.getQuest_idx_list().size() != 1) {
						result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
					}
				} else if (questType.equals("MULTI")) {
					if (answerOne.getQuest_idx_list() == null || answerOne.getQuest_idx_list().size() < 1) {
						result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
					} else {
						boolean hasAnswer = false;
						for ( String multiAnswer : answerOne.getQuest_idx_list() ) {
							if (StringUtils.isNotEmpty(multiAnswer)) {
								hasAnswer = true;
								break;
							}
						}

						String shortAnswer = answerOne.getQuest_idx_list().get(answerOne.getQuest_idx_list().size()-1);

						if (StringUtils.equals(shortAnswer, "99")) {
							if (StringUtils.isEmpty(answerOne.getShort_answer())) {
								result.reject((i+1)+"번 문항의 기타란은 필수 입력입니다.");
							}
						}


						if (!hasAnswer && !result.hasErrors()) {
							result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
						}
					}
				} else if (questType.equals("MATRIX")) {
					quest.setQuest_idx(answerOne.getQuest_idx());
					int matrix_count = questService.getQuestMatrixCount(quest);
					if (answerOne.getQuest_idx_list() == null || (answerOne.getQuest_idx_list().size() != matrix_count)) {
						result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
					}
					if (!result.hasErrors()) {
						for (String matrix_answer : answerOne.getQuest_idx_list()) {
							if (matrix_answer == null) {
								result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
								break;
							}
						}
					}
				} else if (questType.equals("DESCRIPTION")) {
					if (questRequied.equals("Y")) {
						if (answerOne.getShort_answer() == null || answerOne.getShort_answer().trim().equals("")) {
							result.reject((i+1)+"번 문항에 답하지 않으셨습니다.");
						}
					}
				}
			}
		}
	}

	private String getSkinCd(Quest quest) {
		String skin = "skin1";

		if (quest.getSurvey_idx() != 0) {
			Survey survey = new Survey();
			survey.setSurvey_idx(quest.getSurvey_idx());
			survey.setHomepage_id(quest.getHomepage_id());
			survey = surveyService.getSurveyOne(survey);
			skin  = "skin" + survey.getSkin_cd();
		}

		return skin;
	}

}
