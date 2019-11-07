package kr.co.whalesoft.app.cms.module.survey.questDetail;

import java.util.List;

import kr.co.whalesoft.app.cms.module.survey.quest.Quest;

public interface QuestDetailDao {
	
	public List<QuestDetail> getQuestDetail(Quest quest);

	public int addQuestDetail(QuestDetail questDetail);

	public int deleteQuestDetail(Quest quest);
	
}