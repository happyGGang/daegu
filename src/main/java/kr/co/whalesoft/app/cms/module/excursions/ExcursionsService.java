package kr.co.whalesoft.app.cms.module.excursions;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.framework.base.BaseService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExcursionsService extends BaseService {
	
	@Autowired
	private ExcursionsDao Dao;
	
	public List<Calendar> getCalendar(Excursions excursions) {
		return Dao.getCalendar(excursions);
	}
	
	public List<Excursions> getExcursions(Excursions excursions) {
		List<Excursions> list = Dao.getExcursions(excursions);
		for (Excursions excursion : list) {
			if (StringUtils.isEmpty(excursion.getCode_name())) {
				excursion.setCode_name(Dao.getCodeName(excursion));
			}
		}
		return list;
	}
	
	public List<CalendarStatus> getExcursionsStatus(CalendarStatus calendarStatus) {
		return Dao.getExcursionsStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getExcursionsMonthStatus(CalendarStatus calendarStatus) {
		return Dao.getExcursionsMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getExcursionsYearStatus(CalendarStatus calendarStatus) {
		return Dao.getExcursionsYearStatus(calendarStatus);
	}
	
	public Excursions getExcursionsOne(Excursions excursions) {
		return Dao.getExcursionsOne(excursions);
	}
	
	public int getExcursionsuDateCheck(Apply apply) {
		return Dao.getExcursionsuDateCheck(apply);
	}
	
	public int addExcursions(Excursions excursions) {
		return Dao.addExcursions(excursions);
	}
	
	public int modifyCalendarManage(Excursions excursions) {
		return Dao.modifyExcursions(excursions);
	}
	
	public int deleteExcursions(Excursions excursions) {
		return Dao.deleteExcursions(excursions);
	}
	
	public int countExcursions(Excursions excursions) {
		return Dao.countExcursions(excursions);
	}
	
	public int countClosedExcursions(Excursions excursions) {
		return Dao.countClosedExcursions(excursions);
	}
}
