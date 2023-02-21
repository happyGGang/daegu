package kr.go.gbelib.app.cms.module.facility;

import java.util.List;
import java.util.Map;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;

public interface FacilityDao  {

	public List<Facility> getCalendar(Facility facility);
	
	public List<Facility> getFacilityList(Facility facility);
	
	public List<Facility> getFacilityListByExcel(Facility facility);
	
	public List<Facility> getFacilityListAll(Facility facility);
	
	public int getFacilityListCount(Facility facility);
	
	public Facility getFacilityOne(Facility facility);
	
	public int addFacility(Map<String, List<Facility>> param);

	public int modifyFacility(Facility facility);
	
	public int deleteFacility(Facility facility);
	public List<Integer> getFacilityLastIDX(Facility facility);

	public List<CalendarStatus> getFacilityStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getFacilityMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getFacilityYearStatus(CalendarStatus calendarStatus);

	public List<Facility> getFacilityListByUser(Facility facility);
}