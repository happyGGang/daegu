package kr.co.whalesoft.app.cms.module.eventReq;

import java.util.List;

public interface EventReqDao {

	public List<EventReq> getEventReqList(EventReq eventReq);
	
	public List<EventReq> getEventReqListAll(EventReq eventReq);
	
	public List<EventReq> getShuffledeventReqList(EventReq eventReq);

	public List<EventReq> getReShuffledeventReqList(EventReq eventReq);
	
	public int getEventReqListCount(EventReq eventReq);
	
	public int getEventReqWinnerListCount(EventReq eventReq);
	
	public int modifyChosenYn(EventReq eventReq);

	public EventReq getEventReqOne(EventReq eventReq);
	
	public int addeventReq(EventReq eventReq);
	
	public int modifyWinner(EventReq eventReq);

	public int checkReqByMemberId(EventReq eventReq);
	
	public int deletePersonalData(EventReq eventReq);

	public List<EventReq> getReEventReqListAll(EventReq eventReq);
}