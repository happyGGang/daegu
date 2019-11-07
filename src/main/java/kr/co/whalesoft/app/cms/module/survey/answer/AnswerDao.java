package kr.co.whalesoft.app.cms.module.survey.answer;

import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.quest.Quest;

public interface AnswerDao {

	public int addSurveyAnswerUser(Quest quest);

	public int getNextAnswerIdx(Quest quest);

	public int addSurveyAnswerDetail(Quest quest);

	public void addSurveyAnswerMatrix(Quest quest);

	public List<Answer> getSurveyAnswerUser(Quest quest);

	public int getSurveyAnswerUserOne(Quest quest);

	public int getSurveyPeriod(Quest quest);

	public int getSurveyOpen(Quest quest);
	
	public List<Answer> getShuffledAnswers(Quest quest);
	
	public List<Answer> getSurveyAnswerUser2(int survey_idx);
	
}
