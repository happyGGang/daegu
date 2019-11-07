package kr.co.whalesoft.app.cms.module.survey.statistics;

import java.io.ByteArrayInputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.SurveyService;
import kr.co.whalesoft.app.cms.module.survey.answer.Answer;
import kr.co.whalesoft.app.cms.module.survey.answer.AnswerSearchView;
import kr.co.whalesoft.app.cms.module.survey.answer.AnswerService;
import kr.co.whalesoft.app.cms.module.survey.answer.AnswerXlsToCsv;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.quest.QuestService;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/survey/surveyStatistics"})
public class StatisticsController extends BaseController {

	@Autowired
	private StatisticsService service;

	@Autowired
	private SurveyService surveyService;

	@Autowired
	private QuestService questService;

	@Autowired
	private AnswerService answerService;

	private final String basePath = "/cms/module/survey/cms/statistics/";

	@RequestMapping(value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		Survey surveyBean = surveyService.getSurveyOne(survey);

		model.addAttribute("answer_count", surveyService.getAnswerUserCount(surveyBean));

		if (surveyBean.getAnswer_count() > 0) {
			model.addAttribute("statistics", service.getQuest(quest));
			surveyBean.setSurvey_content(StringUtils.defaultString(surveyBean.getSurvey_content()).replace("\r\n", "<br />"));
			model.addAttribute("survey", surveyBean);
		} else {
			service.alertMessagePopup("응답자가 없습니다.", request, response);
			return null;
		}
		return basePath + "index";
	}
	@RequestMapping(value = { "/questEdit.*" }, method = RequestMethod.GET)
	public String questEdit(Model model, Quest quest,QuestDetail questDetail,QuestMatrix questMatrix, HttpServletRequest request, HttpServletResponse response)throws Exception{
		quest.setHomepage_id(getAsideHomepageId(request));
		questMatrix.setHomepage_id(getAsideHomepageId(request));
		if (quest.getQuest_type().equals("MATRIX")) {
			model.addAttribute("questMatrixList", service.getQuestOne(quest));
		}
			model.addAttribute("questDetailList",service.getQuestOne(quest));
		return basePath + "questEdit_ajax";
	}
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public AnswerSearchView excelDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		model.addAttribute("quest", quest);
//		model.addAttribute("answerResult", answerService.getSurveyAnswerUser(quest));

		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		Survey surveyBean = surveyService.getSurveyOne(survey);

		List<Quest> questList = service.getQuest(quest);

		if (surveyBean.getAnswer_count() > 0) {
			model.addAttribute("statistics", questList);

			for(int i=0; i<questList.size(); i++) {
				if(questList.get(i).getQuest_type().equals("DESCRIPTION")) {
					quest.setQuest_idx(questList.get(i).getQuest_idx());
					questList.get(i).setDesc_list(service.getDescriptionList(quest));
				}
			}

//			model.addAttribute("description", service.getDescriptionList(quest));
			surveyBean.setSurvey_content(StringUtils.defaultString(surveyBean.getSurvey_content()).replace("\r\n", "<br />"));
			model.addAttribute("survey", surveyBean);
		} else {
			service.alertMessagePopup("응답자가 없습니다.", request, response);
			return null;
		}

		List<Answer> answerList = service.getSurveyAnswerUser2(survey.getSurvey_idx());
		model.addAttribute("answerList", answerList);

		return new AnswerSearchView();
	}
	
	@RequestMapping(value = {"/imgDownload.*"}, method = RequestMethod.POST)
	public void imgDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String imgData = quest.getImgData();
		
		imgData = imgData.replaceAll("data:image/png;base64,", "");
		
        byte[] file = Base64.decodeBase64(imgData);
        ByteArrayInputStream is = new ByteArrayInputStream(file);
        
        response.setContentType("image/png");
        response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(quest.getQuest_content()+".png", request.getHeader("user-agent")));
        
        IOUtils.copy(is, response.getOutputStream());
        response.flushBuffer();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		Survey surveyBean = surveyService.getSurveyOne(survey);

		List<Quest> questList = service.getQuest(quest);
		List<Answer> answerList = service.getSurveyAnswerUser2(survey.getSurvey_idx());

		if (surveyBean.getAnswer_count() > 0) {
			model.addAttribute("statistics", questList);

			for(int i=0; i<questList.size(); i++) {
				if(questList.get(i).getQuest_type().equals("DESCRIPTION")) {
					quest.setQuest_idx(questList.get(i).getQuest_idx());
					questList.get(i).setDesc_list(service.getDescriptionList(quest));
				}
			}

			if (!StringUtils.isEmpty(surveyBean.getSurvey_content())) {
				surveyBean.setSurvey_content(surveyBean.getSurvey_content().replace("\r\n", "<br />"));
			}
			model.addAttribute("survey", surveyBean);

			new AnswerXlsToCsv(questList, answerList, surveyBean, request, response);

		} else {
			service.alertMessagePopup("응답자가 없습니다.", request, response);
		}
	}

	@RequestMapping(value = { "/detailView.*" }, method = RequestMethod.GET)
	public String detailView(Model model, Quest quest, HttpServletRequest request) {
		Survey survey = new Survey();
		survey.setHomepage_id(quest.getHomepage_id());
		survey.setSurvey_idx(quest.getSurvey_idx());
		Survey surveyBean = surveyService.getSurveyOne(survey);
		if (!StringUtils.isEmpty(surveyBean.getSurvey_content())) {
			surveyBean.setSurvey_content(surveyBean.getSurvey_content().replace("\r\n", "<br />"));
		}
		model.addAttribute("survey", surveyBean);
		model.addAttribute("description", service.getDescriptionList(quest));
		model.addAttribute("quest", questService.getQuestOne(quest));
		return basePath + "detailView";
	}

	@RequestMapping(value = { "/answerUser.*" }, method = RequestMethod.GET)
	public String answerUser(Model model, Quest quest, HttpServletRequest request) {
		Survey survey = new Survey();
		survey.setHomepage_id(quest.getHomepage_id());
		survey.setSurvey_idx(quest.getSurvey_idx());
		Survey surveyBean = surveyService.getSurveyOne(survey);
		surveyBean.setSurvey_content(StringUtils.defaultString(surveyBean.getSurvey_content()).replace("\r\n", "<br />"));
		model.addAttribute("survey", surveyBean);
		model.addAttribute("answerUser", answerService.getSurveyAnswerUser(quest));
		return basePath + "answerUser_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Survey survey,QuestDetail questDetail, Quest quest, QuestMatrix questMatrix, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			if(survey.getEditMode().equals("answerModify")) {
				res.setValid(true);

				res.setData(questDetail.getAnswer_count());

			} else if(questDetail.getEditMode().equals("questModify")) {
				res.setValid(true);

				int count = 0;

				if(quest.getQuest_type().equals("ONE") || quest.getQuest_type().equals("MULTI")) {

					List<QuestDetail> list = quest.getQuest_detail_list();


					for (int i = 0; i < list.size(); i++) {
						QuestDetail one = list.get(i);

						count += (int)one.getCnt();

						one.setQuest_idx(questDetail.getQuest_idx());
						list.set(i, one);
					}

					quest.setAnswer_count(count);
					quest.setQuest_detail_list(list);

					res.setData(quest);
				} else if (quest.getQuest_type().equals("MATRIX")) {
					List<QuestMatrix> quest_matrix_list = quest.getQuest_matrix_list();
					List<QuestDetail> quest_detail_list = quest.getQuest_detail_list();

					for (int j = 0; j < quest_detail_list.size(); j++) {
						QuestDetail one2 = quest_detail_list.get(j);

						one2.setQuest_idx(quest.getQuest_idx());

						quest_detail_list.set(j,one2);
					}

					int prev_cnt = 0;
					for (int i = 0; i < quest_matrix_list.size(); i++) {
						QuestMatrix one = quest_matrix_list.get(i);


						int rowCount= 0;

						for (int j= 0; j < one.getStatisticsList().get(i).getCntList().size(); j++) {
							rowCount += one.getStatisticsList().get(i).getCntList().get(j).getCnt();
						};

						if(i > 0 && prev_cnt != rowCount ) {
							res.setValid(false);
							res.setMessage("각 세부질문의 전체 인원수가 서로 다릅니다.");
							return res;
						}
						prev_cnt = rowCount;

						count += rowCount;

						one.setRowCount(rowCount);
						one.setQuest_idx(quest.getQuest_idx());
						quest_matrix_list.set(i, one);


					}

					quest.setAnswer_count(count);
					quest.setQuest_detail_list(quest_detail_list);
					quest.setQuest_matrix_list(quest_matrix_list);

					res.setData(quest);
				}

			}

		}
		return res;
	};

	@RequestMapping(value = { "/shuffleAnswers.*" }, method = RequestMethod.GET)
	public String shuffleAnswers(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Answer answer = new Answer();
		answer.setHomepage_id(quest.getHomepage_id());
		answer.setSurvey_idx(quest.getSurvey_idx());
		if(service.getSelectedUsersCnt(answer) > 0) {
			service.alertMessage("이미 당첨자 등록이 된 상태입니다. 당첨자는 변경할 수 없습니다.", request, response);
		}

		Survey survey = new Survey();
		survey.setHomepage_id(quest.getHomepage_id());
		survey.setSurvey_idx(quest.getSurvey_idx());
		Survey surveyBean = surveyService.getSurveyOne(survey);
		surveyBean.setSurvey_content(StringUtils.defaultString(surveyBean.getSurvey_content()).replace("\r\n", "<br />"));
		surveyService.add_select_cnt(surveyBean);

		model.addAttribute("survey", surveyBean);
		model.addAttribute("answerUser", answerService.getShuffledAnswers(quest));
		return basePath + "shuffleAnswers_ajax";
	}

	@RequestMapping(value = {"/surveySave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse surveySave(Answer answer, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		Member member = (Member) getSessionMemberInfo(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(answer.getEditMode().equals("SELECT")) {
				if(service.getSelectedUsersCnt(answer) > 0) {
					res.setValid(false);
					res.setUrl("/cms/module/survey/index.do");
					res.setMessage("이미 당첨자 등록이 된 상태입니다. 당첨자는 변경할 수 없습니다.");
				} else {
					service.updateChosenYn(answer);
					res.setValid(true);
					res.setUrl("/cms/module/survey/index.do");
					res.setMessage("당첨자 등록이 완료됐습니다.\n결과 분석 엑셀 다운로드를 이용하셔서 이용자 목록을 받으시기 바랍니다.");
				}
			} else {
				res.setValid(false);
				res.setMessage("잘못된 접근입니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

}
