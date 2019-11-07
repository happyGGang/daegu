package kr.co.whalesoft.app.cms.module.survey.quest;

import java.util.List;

public interface QuestDao {
	
	public List<Quest> getQuest(Quest quest);
	
	public int getQuestCnt(Quest quest);
	
	public Quest getQuestOne(Quest quest);
	
	public int getQuestIdx();

	public int addQuest(Quest quest);
	
	public int modifyQuestOrder(Quest quest);
	
	public int getQuestOrderOne(Quest quest);
	
	public int modifyQuest(Quest quest);
	
	public int deleteQuest(Quest quest);

	public List<Quest> getQuestBranch(Quest quest);

	public int reOrderQuest(Quest tempQuest);
}