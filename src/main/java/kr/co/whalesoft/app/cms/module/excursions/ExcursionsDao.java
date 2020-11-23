package kr.co.whalesoft.app.cms.module.excursions;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;

public interface ExcursionsDao {
	public List<Calendar> getCalendar(Excursions excursions);
	
	public List<Excursions> getExcursions(Excursions excursions);
	
	public Excursions getExcursionsOne(Excursions excursions);
	
	public int getExcursionsuDateCheck(Apply apply);
	
	public int addExcursions(Excursions excursions);
	
	public int modifyExcursions(Excursions excursions);
	
	public int deleteExcursions(Excursions excursions);
	
	public int countExcursions(Excursions excursions);
	
	public int countClosedExcursions(Excursions excursions);
	
	public List<CalendarStatus> getExcursionsStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getExcursionsMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getExcursionsYearStatus(CalendarStatus calendarStatus);

	String getCodeName(Excursions excursion);
}
