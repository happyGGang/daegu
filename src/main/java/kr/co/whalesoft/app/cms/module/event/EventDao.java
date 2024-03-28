package kr.co.whalesoft.app.cms.module.event;


import kr.co.whalesoft.app.cms.module.eventReq.EventReq;

import java.util.List;

public interface EventDao {

	public List<Event> getEventList(Event event);
	
	public List<Event> getEventListAll(Event event);
	
	public int getEventListCount(Event event);
	
	public Event getEventOne(Event event);
	
	public int addEvent(Event event);
	
	public int modifyEvent(Event event);
	
	public int deleteEvent(Event event);
	
	public Event getEventUser(Event event);

	public int getAreadyEventOne(Event event);
	
	public int getEventCntOfValidDate(EventReq eventReq);
	
	public int increaseSelectCnt(Event event);

	public int increaseReSelectCnt(Event event);
	
}