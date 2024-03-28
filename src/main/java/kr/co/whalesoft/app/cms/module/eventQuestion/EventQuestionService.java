package kr.co.whalesoft.app.cms.module.eventQuestion;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventQuestionService extends BaseService {
	
	@Autowired
	private EventQuestionDao eventQuestionDao;
	
	public List<EventQuestion> getEventQuestionList(EventQuestion eventQuestion) {
		return eventQuestionDao.getEventQuestionList(eventQuestion);
	}
	
	public int getEventQuestionListCount(EventQuestion eventQuestion) {
		return eventQuestionDao.getEventQuestionListCount(eventQuestion);
	}
	
	public EventQuestion getEventQuestionOne(EventQuestion eventQuestion) {
		return eventQuestionDao.getEventQuestionOne(eventQuestion);
	}
	
	public int addEventQuestion(EventQuestion eventQuestion) {
		return eventQuestionDao.addEventQuestion(eventQuestion);
	}
	
	public int modifyEventQuestion(EventQuestion eventQuestion) {
		return eventQuestionDao.modifyEventQuestion(eventQuestion);
	}
	
	public int deleteEventQuestion(EventQuestion eventQuestion) {
		return eventQuestionDao.deleteEventQuestion(eventQuestion);
	}
}