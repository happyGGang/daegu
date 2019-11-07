package kr.co.whalesoft.app.cms.module.survey.statistics;

import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.answer.Answer;
import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.app.cms.module.survey.questDetail.QuestDetail;
import kr.co.whalesoft.app.cms.module.survey.questMatrix.QuestMatrix;


public interface StatisticsDao {
	public List<Statistics> getStatistics(QuestMatrix questMatrix);

	public List<QuestDetail> getQuestDetailStatistics(Quest questBean);
	
	public List<QuestMatrix> getQuestMatrix(Quest questBean);
	
	public List<Statistics> getQuestMatrixStatistics(QuestMatrix questMatrix);

	public List<Answer> getDescriptionList(Quest quest);

	public List<QuestDetail> getQuestDetailDescriptionStatistics(Quest questBean);
	
	public int updateChosenYn(Answer answer);
	
	public List<Statistics> getAnswersPerUser(Answer answer);
	
	public int getSelectedUsersCnt(Answer answer);

}
