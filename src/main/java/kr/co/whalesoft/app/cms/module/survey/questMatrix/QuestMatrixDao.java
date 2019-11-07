package kr.co.whalesoft.app.cms.module.survey.questMatrix;

import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.quest.Quest;

public interface QuestMatrixDao {
	
	public List<QuestMatrix> getQuestMatrix(Quest quest);
	
	public int addQuestMatrix(QuestMatrix questMatrix);
	
	public int deleteQuestMatrix(Quest quest);
	
}
