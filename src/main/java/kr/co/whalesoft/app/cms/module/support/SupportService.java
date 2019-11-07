package kr.co.whalesoft.app.cms.module.support;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SupportService extends BaseService {
	
	@Autowired
	private SupportDao dao;
	
	public List<Calendar> getCalendar(Support support) {
		return dao.getCalendar(support);
	}
	
	public List<CalendarStatus> getSupportStatus(CalendarStatus calendarStatus) {
		return dao.getSupportStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getSupportMonthStatus(CalendarStatus calendarStatus) {
		return dao.getSupportMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getSupportYearStatus(CalendarStatus calendarStatus) {
		return dao.getSupportYearStatus(calendarStatus);
	}
	
	public List<Support> getSupport(Support support) {
		return dao.getSupport(support);
	}
	
	public List<Support> getUserSupport(Support support) {
		return dao.getUserSupport(support);
	}
	
	public Support getSupportOne(Support support) {
		return dao.getSupportOne(support);
	}
	
	public int addSupport(Support support) {
		return dao.addSupport(support);
	}
	
	public int modifySupport(Support support) {
		return dao.modifySupport(support);
	}
	
	public int modifySupportResult(Support support) {
		return dao.modifySupportResult(support);
	}
	
	public int deleteSupport(Support support) {
		return dao.deleteSupport(support);
	}

}
