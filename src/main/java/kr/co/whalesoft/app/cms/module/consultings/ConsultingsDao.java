package kr.co.whalesoft.app.cms.module.consultings;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApply;

public interface ConsultingsDao {
	public List<Calendar> getCalendar(Consultings consultings);
	
	public List<Consultings> getConsultings(Consultings consultings);
	
	public Consultings getConsultingsOne(Consultings consultings);
	
	public int getConsultingsuDateCheck(ConsultingApply apply);
	
	public int addConsultings(Consultings consultings);
	
	public int modifyConsultings(Consultings consultings);
	
	public int deleteConsultings(Consultings consultings);
	
	public int countConsultings(Consultings consultings);
	
	public int countClosedConsultings(Consultings consultings);
	
	public List<CalendarStatus> getConsultingsStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getConsultingsMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getConsultingsYearStatus(CalendarStatus calendarStatus);

	String getCodeName(Consultings consultings);
}
