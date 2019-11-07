package kr.co.whalesoft.app.cms.module.support;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;

public interface SupportDao {
	
	public List<Calendar> getCalendar(Support support);
	
	public List<CalendarStatus> getSupportStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getSupportMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getSupportYearStatus(CalendarStatus calendarStatus);
	
	public List<Support> getSupport(Support support);
	
	public List<Support> getUserSupport(Support support);
	
	public Support getSupportOne(Support support);
	
	public int addSupport(Support support);
	
	public int modifySupport(Support support);
	
	public int modifySupportResult(Support support);
	
	public int deleteSupport(Support support);

}
