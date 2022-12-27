package kr.co.whalesoft.app.cms.module.volunteer;

import java.util.Calendar;
import java.util.List;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.volunteer.Volunteer;
import kr.co.whalesoft.app.cms.module.volunteer.apply.VolunteerApply;

public interface VolunteerDao {
	public List<Calendar> getCalendar(Volunteer volunteer);
	
	public List<Volunteer> getVolunteer(Volunteer volunteer);
	
	public Volunteer getVolunteerOne(Volunteer volunteer);
	
	public Volunteer getTimeVolunteerOne(Volunteer volunteer);

	public int getVolunteerDateCheck(VolunteerApply apply);
	
	public int addVolunteer(Volunteer volunteer);
	
	public int addTimeVolunteer(Volunteer volunteer);
	
	public int modifyVolunteer(Volunteer volunteer);
	
	public int deleteVolunteer(Volunteer volunteer);
	
	public int countVolunteer(Volunteer volunteer);
	
	public int countClosedVolunteer(Volunteer volunteer);
	
	public List<CalendarStatus> getVolunteerStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getVolunteerMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getVolunteerYearStatus(CalendarStatus calendarStatus);

	String getCodeName(Volunteer volunteer);


}
