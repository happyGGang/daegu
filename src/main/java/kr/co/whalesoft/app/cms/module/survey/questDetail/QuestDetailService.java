package kr.co.whalesoft.app.cms.module.survey.questDetail;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class QuestDetailService extends BaseService {

	@Autowired
	private QuestDetailDao dao;
	
	public List<QuestDetail> getQuestDetail(Quest quest) {
		return dao.getQuestDetail(quest);
	}
	
	public int addQuestDetail(QuestDetail questDetail) {
		return dao.addQuestDetail(questDetail);
	}
	
	public int deleteQuestDetail(Quest quest) {
		return dao.deleteQuestDetail(quest);
	}
}