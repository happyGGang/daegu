package kr.co.whalesoft.app.cms.module.survey.questMatrix;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.module.survey.quest.Quest;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class QuestMatrixService extends BaseService {
	
	@Autowired
	private QuestMatrixDao dao;

	public List<QuestMatrix> getQuestMatrix(Quest quest) {
		return dao.getQuestMatrix(quest);
	}
	
	public int addQuestMatrix(QuestMatrix questMatrix) {
		return dao.addQuestMatrix(questMatrix);
	}
	
	public int deleteQuestMatrix(Quest quest) {
		return dao.deleteQuestMatrix(quest);
	}
}
