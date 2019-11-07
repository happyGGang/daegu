package kr.co.whalesoft.app.cms.module.survey.statistics;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.module.survey.answer.Answer;
import kr.co.whalesoft.app.cms.module.survey.answer.AnswerService;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.quest.QuestDao;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetailService;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrixService;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class StatisticsService extends BaseService {

	@Autowired
	private StatisticsDao dao;
	
	@Autowired
	private QuestDao questDao;
	
	@Autowired
	private QuestMatrixService questMatrixService;
	
	@Autowired
	private QuestDetailService questDetailService;
	
	@Autowired
	private AnswerService answerService;
	
	public List<Quest> getQuest(Quest quest) {
		
		List<Quest> questList = questDao.getQuest(quest);
		
		for(Quest questBean : questList) {
			if(questBean.getQuest_type().equals("MATRIX")) {
				questBean.setQuest_matrix_list(dao.getQuestMatrix(questBean));
				for (QuestMatrix questMatrix : questBean.getQuest_matrix_list()) {
					questMatrix.setStatisticsList(dao.getQuestMatrixStatistics(questMatrix));
				}
			}
			
			if (questBean.getQuest_type().equals("DESCRIPTION")) {
				questBean.setQuest_detail_list(dao.getQuestDetailDescriptionStatistics(questBean));
			} else {
				questBean.setQuest_detail_list(dao.getQuestDetailStatistics(questBean));
				if (StringUtils.equals(questBean.getQuest_detail_free_yn(), "Y")) {
					questBean.setAnswer_list(getDescriptionList(questBean));
				}
			}
			
			
		}
		
		return questList;
	}
	
	public Quest getQuestOne(Quest quest) {
		
			if(quest.getQuest_type().equals("MATRIX")) {
				quest.setQuest_matrix_list(dao.getQuestMatrix(quest));
				quest.setQuest_detail_list(dao.getQuestDetailStatistics(quest));
				
				for (QuestMatrix questMatrix : quest.getQuest_matrix_list()) {
					questMatrix.setStatisticsList(dao.getQuestMatrixStatistics(questMatrix));
				}
				
			}
			
			if (quest.getQuest_type().equals("DESCRIPTION")) {
				quest.setQuest_detail_list(dao.getQuestDetailDescriptionStatistics(quest));
			} else {
				quest.setQuest_detail_list(dao.getQuestDetailStatistics(quest));
				if (StringUtils.equals(quest.getQuest_detail_free_yn(), "Y")) {
					quest.setAnswer_list(getDescriptionList(quest));
				}
			}
			
			return quest;
		}

	
	public List<QuestMatrix> getQuestMatrix(Quest questBean){
		return dao.getQuestMatrix(questBean);
	}
	
	public List<Statistics> getQuestMatrixStatistics(QuestMatrix questMatrix){
		return dao.getQuestMatrixStatistics(questMatrix);
	}
	
	public List<QuestDetail> getQuestDetailStatistics(Quest questBean){
		return dao.getQuestDetailStatistics(questBean);
	}
	
	public List<Answer> getDescriptionList(Quest quest) {
		return dao.getDescriptionList(quest);
	}
	
	public int updateChosenYn(Answer answer) {
		return dao.updateChosenYn(answer);
	}
	
	public List<Answer> getSurveyAnswerUser2(int survey_idx) {
		List<Answer> surveyAnswerUser = answerService.getSurveyAnswerUser2(survey_idx);
		
		for (Answer answer : surveyAnswerUser) {
			answer.setSurvey_idx(survey_idx);
			answer.setStatisticsList(dao.getAnswersPerUser(answer));
		}

		return surveyAnswerUser;
	}
	
	public int getSelectedUsersCnt(Answer answer) {
		return dao.getSelectedUsersCnt(answer);
	}
	
}
