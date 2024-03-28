package kr.co.whalesoft.app.cms.module.event;

import kr.co.whalesoft.app.cms.module.eventReq.EventReq;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventService extends BaseService {

	@Autowired
	private EventDao dao;

	public List<Event> getEventListAll(Event event) {
		return dao.getEventListAll(event);
	}

	public List<Event> getEventList(Event event) {
		return dao.getEventList(event);
	}

	public int getEventListCount(Event event) {
		return dao.getEventListCount(event);
	}

	@WorkingLogger(comment="독서퀴즈 응모자 관리 1건 조회", type="P")
	public Event getEventOne(Event event) {
		return dao.getEventOne(event);
	}

	public int addEvent(Event event) {
		return dao.addEvent(event);
	}

	public int modifyEvent(Event event) {
		return dao.modifyEvent(event);
	}

	public int deleteEvent(Event event) {
		return dao.deleteEvent(event);
	}

	public Event getEventUser(Event event) {
		return dao.getEventUser(event);
	}

	public int getAreadyEventOne(Event event) {
		return dao.getAreadyEventOne(event);
	}

	public int getEventCntOfValidDate(EventReq eventReq) {
		return dao.getEventCntOfValidDate(eventReq);
	}

	public int increaseSelectCnt(Event event) {
		return dao.increaseSelectCnt(event);
	}

	public int increaseReSelectCnt(Event event) {
		return dao.increaseReSelectCnt(event);
	}
	
}