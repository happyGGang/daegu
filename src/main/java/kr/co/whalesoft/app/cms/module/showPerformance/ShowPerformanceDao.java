package kr.co.whalesoft.app.cms.module.showPerformance;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApply;

public interface ShowPerformanceDao {
	public List<Calendar> getCalendar(ShowPerformance showPerformance);
	
	public List<ShowPerformance> getShowPerformance(ShowPerformance showPerformance);
	
	public ShowPerformance getShowPerformanceOne(ShowPerformance showPerformance);
	
	public ShowPerformance getTimeShowPerformanceOne(ShowPerformance showPerformance);

	public int getShowPerformanceDateCheck(ShowApply apply);
	
	public int addShowPerformance(ShowPerformance showPerformance);
	
	public int addTimeShowPerformance(ShowPerformance showPerformance);
	
	public int modifyShowPerformance(ShowPerformance showPerformance);
	
	public int deleteShowPerformance(ShowPerformance showPerformance);
	
	public int countShowPerformance(ShowPerformance showPerformance);
	
	public int countClosedShowPerformance(ShowPerformance showPerformance);
	
	public List<CalendarStatus> getShowPerformanceStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getShowPerformanceMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getShowPerformanceYearStatus(CalendarStatus calendarStatus);

	String getCodeName(ShowPerformance showPerformance);


}
