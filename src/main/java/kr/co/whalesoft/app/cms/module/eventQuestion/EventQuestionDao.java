package kr.co.whalesoft.app.cms.module.eventQuestion;

import java.util.List;

public interface EventQuestionDao {

	public List<EventQuestion> getEventQuestionList(EventQuestion eventQuestion);
	
	public int getEventQuestionListCount(EventQuestion eventQuestion);
	
	public EventQuestion getEventQuestionOne(EventQuestion eventQuestion);
	
	public int addEventQuestion(EventQuestion eventQuestion);
	
	public int modifyEventQuestion(EventQuestion eventQuestion);
	
	public int deleteEventQuestion(EventQuestion eventQuestion);
}