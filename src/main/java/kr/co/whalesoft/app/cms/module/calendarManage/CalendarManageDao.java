package kr.co.whalesoft.app.cms.module.calendarManage;

import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;

public interface CalendarManageDao {
	public List<CalendarManage> getCalendar(CalendarManage calendarManage );
	
	public List<CalendarManage> getCalendarManage(CalendarManage calendarManage);
	
	public CalendarManage getCalendarManageOne(CalendarManage calendarManage);
	
	public List<CalendarManage> getClosedDate(CalendarManage calendarManage);
	
	public List<CalendarManage> getCalendarStatus(CalendarStatus calendarStatus);
	
	public List<CalendarManage> getCalendarMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarManage> getCalendarYearStatus(CalendarStatus calendarStatus);
	
	public int closedDateCheck(CalendarManage calendarManage);
	
	public int addCalendarManage(CalendarManage calendarManage);
	
	public int modifyCalendarManage(CalendarManage calendarManage);
	
	public int deleteCalendarManage(CalendarManage calendarManage);

	public CalendarManage getClosedDate2(CalendarManage calendarManage);
	
	public CalendarManage getClosedDate3(CalendarManage calendarManage);
	
	public CalendarManage getClosedDate4(CalendarManage calendarManage);
	
	public List<CalendarManage> getCalendarManageDetail(CalendarManage calendarManage);

	public List<CalendarManage> getCalendarListType(CalendarManage calendarManage);

	public int getNextCmIdx(CalendarManage calendarManage);

	public CalendarManage getCalendarManageOne2(CalendarManage calendarManage);

	public int deleteCalendarManageGroup(CalendarManage calendarManage);

	public int getCalendarManageCheckCount(CalendarManage calendarManage);
	
	public int isTodayClosed(String homepage_id);

	List<String> getEventSeogu(CalendarManage calendarManage);

	List<String> getMovieSeogu(CalendarManage calendarManage);

	List<String> getCloseSeogu(CalendarManage calendarManage);
}
