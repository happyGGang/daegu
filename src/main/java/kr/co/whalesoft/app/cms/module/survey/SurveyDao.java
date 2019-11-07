package kr.co.whalesoft.app.cms.module.survey;

import java.util.List;

public interface SurveyDao {
	
	public int getSurveyCount(Survey survey);
	
	public int getAnswerUserCount(Survey survey);

	public List<Survey> getSurvey(Survey survey);
	
	public int getUserSurveyCount(Survey survey);

	public List<Survey> getUserSurvey(Survey survey);
	
	public List<Survey> getSurveyAll(String homepage_id);
	
	public Survey getSurveyOne(Survey survey);
	
	public Survey getSurveyOne(int survey_idx);
	
	public int addSurvey(Survey survey);
	
	public int modifySurvey(Survey survey);
	
	public int modifySurveyDate(Survey survey);
	
	public int deleteSurvey(Survey survey);
	
	public int deleteSurveyQuest(Survey survey);
	
	public int deleteSurveyQuestDetail(Survey survey);
	
	public int deleteSurveyQuestMatrix(Survey survey);
	
	public int deleteSurveyAnswerDetail(Survey survey);
	
	public int deleteSurveyAnswerUser(Survey survey);
	
	public int deleteSurveyAnswerMatrix(Survey survey);
	
	public int copySurvey(Survey survey);
	
	public int copySurveyQuest(Survey survey);
	
	public int copySurveyQuestDetail(Survey survey);
	
	public int copySurveyQuestMatrix(Survey survey);
	
	public int modifySurveyOpenYN(Survey survey);
	
	public int modifySurveyPrivateYn(Survey survey);

	public Survey getSurveyOneByUser(Survey survey);
	
	public int add_select_cnt(Survey survey);
	
}