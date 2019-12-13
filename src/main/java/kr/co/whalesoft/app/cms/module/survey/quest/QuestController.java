package kr.co.whalesoft.app.cms.module.survey.quest;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.survey.Survey;
import kr.co.whalesoft.app.cms.module.survey.SurveyService;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetailService;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrixService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping(value={"/cms/survey/quest"})
public class QuestController extends BaseController {
	
	@Autowired
	private QuestService service;
	
	@Autowired
	private QuestMatrixService questMatrixService;
	
	@Autowired
	private QuestDetailService questDetailService;
	
	@Autowired
	private SurveyService surveyService;
	
	private final String basePath = "/cms/module/survey/cms/quest/";

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		survey = surveyService.getSurveyOne(survey);
		
		if (survey.getAnswer_count() > 0) {
			service.alertMessageDialog("응답자가 있는 경우 수정하실 수 없습니다.", request, response);
			return null;
		} else {
			model.addAttribute("questList", service.getQuest(quest));
			model.addAttribute("quest", quest);
			return basePath + "index_ajax";
		}
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, Quest quest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		survey = surveyService.getSurveyOne(survey);
		
		if (survey.getAnswer_count() > 0) {
			service.alertMessagePopup("응답자가 있는 경우 수정하실 수 없습니다.", request, response);
			return null;
		}
		
		if(quest.getEditMode().equals("modify")) {
			Quest questBean = service.getQuestOne(quest);
			questBean.setEditMode("modify");
			questBean.setHomepage_id(quest.getHomepage_id());
			quest.setQuest_type(questBean.getQuest_type());
			model.addAttribute("quest", questBean);
			
		} else {
			model.addAttribute("quest", quest);
		}
		model.addAttribute("questList", service.getQuest(quest));
		
		return basePath + quest.getQuest_type() + "/" + "edit_ajax";
	}
	
	@RequestMapping(value = {"/questDetail.*"}, method = RequestMethod.GET)
	public String questDetail(Model model, Quest quest, HttpServletRequest request) {
		
		if(quest.getEditMode().equals("modify")) {
			model.addAttribute("questDetailList", questDetailService.getQuestDetail(quest));
			model.addAttribute("quest", service.getQuestOne(quest));
		} else {
			List<QuestDetail> questDetailList = new ArrayList<QuestDetail>();
			
			for(int i=0; i < quest.getQuest_count(); i++) {
				QuestDetail questDetailBean = new QuestDetail();
				questDetailList.add(questDetailBean);
			}
			
			model.addAttribute("questDetailList", questDetailList);
		}
		model.addAttribute("questList", service.getQuestBranch(quest));
		return basePath + quest.getQuest_type() + "/" + "questDetail_ajax";
	}
	
	@RequestMapping(value = {"/questMatrix.*"}, method = RequestMethod.GET)
	public String questMatrix(Model model, Quest quest, HttpServletRequest request) {
		
		if(quest.getEditMode().equals("modify")) {
			model.addAttribute("questMatrixList", questMatrixService.getQuestMatrix(quest));
		} else {
			List<QuestMatrix> questMatrixList = new ArrayList<QuestMatrix>();
			
			for(int i=0; i < quest.getMatrix_count(); i++) {
				QuestMatrix questMatrixBean = new QuestMatrix();
				questMatrixList.add(questMatrixBean);
			}
			
			model.addAttribute("questMatrixList", questMatrixList);
		}
		
		return basePath + "MATRIX/questMatrix_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Quest quest, BindingResult result, HttpServletRequest request) {
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		Survey survey = new Survey();
		survey.setSurvey_idx(quest.getSurvey_idx());
		survey.setHomepage_id(quest.getHomepage_id());
		survey = surveyService.getSurveyOne(survey);
		
		if (survey.getAnswer_count() > 0) {
			result.reject("응답자가 있는 경우 수정하실 수 없습니다.");
		}
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			Member member = (Member) getSessionMemberInfo(request);
			if(quest.getEditMode().equals("modify")) {
				quest.setModify_id(member.getMember_id());
				quest.setAdd_id(member.getMember_id());
				service.modifyQuest(quest);
				res.setValid(true);
//				res.setTargetOpener(true);
//				res.setData(quest.getUrlParam(quest));
				res.setMessage("수정 되었습니다.");
			} else {
				quest.setAdd_id(member.getMember_id());
				service.addQuest(quest);
				res.setValid(true);
//				res.setTargetOpener(true);
//				res.setData(quest.getUrlParam(quest));
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/saveImage.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveImage(Quest quest, BindingResult result, MultipartHttpServletRequest mpRequest) {
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(mpRequest);
		if (mpRequest.getFile("imageFile") == null || mpRequest.getFile("imageFile").getSize() <= 0) {
			result.reject("첨부된 이미지가 없습니다.");
		}
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			Member member = (Member) getSessionMemberInfo(mpRequest);
			quest.setMultiFile(mpRequest.getFile("imageFile"));
			if(quest.getEditMode().equals("modify")) {
				quest.setModify_id(member.getMember_id());
				service.modifyQuest(quest);
				res.setValid(true);
//				res.setTargetOpener(true);
				res.setData(quest.getUrlParam(quest));
				res.setMessage("수정 되었습니다.");
			} else {
				quest.setAdd_id(member.getMember_id());
				service.addQuest(quest);
				res.setValid(true);
//				res.setTargetOpener(true);
				res.setData(quest.getUrlParam(quest));
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/modifyOrder.*"}, method = RequestMethod.GET)
	public String modifyOrder(Model model, Quest quest, HttpServletRequest request) {
		Member member = (Member) getSessionMemberInfo(request);
		quest.setModify_id(member.getMember_id());
		service.modifyQuestOrder(quest);
		
		model.addAttribute("questList", service.getQuest(quest));
		model.addAttribute("quest", quest);
		
		return basePath + "index_ajax";
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.GET)
	public String delete(Model model, Quest quest, HttpServletRequest request) {
		service.deleteQuest(quest);
		
		model.addAttribute("questList", service.getQuest(quest));
		model.addAttribute("quest", quest);
		
		return basePath + "index_ajax";
	}
	
}