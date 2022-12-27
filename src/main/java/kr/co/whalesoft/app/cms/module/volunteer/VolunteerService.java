package kr.co.whalesoft.app.cms.module.volunteer;

import java.util.Calendar;
import java.util.List;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.volunteer.apply.VolunteerApply;
import kr.co.whalesoft.app.cms.module.volunteer.apply.VolunteerApplyService;
import kr.co.whalesoft.framework.base.BaseService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VolunteerService extends BaseService {
	
	@Autowired
	private VolunteerDao Dao;
	
	@Autowired
	private VolunteerApplyService applyService;
	
	public List<Calendar> getCalendar(Volunteer volunteer) {
		return Dao.getCalendar(volunteer);
	}
	
	public List<Volunteer> getVolunteer(Volunteer volunteer) {
		List<Volunteer> list = Dao.getVolunteer(volunteer);
		for (Volunteer volunteer1 : list) {
			if (StringUtils.isEmpty(volunteer1.getCode_name())) {
				volunteer1.setCode_name(Dao.getCodeName(volunteer1));
			}
		}
		return list;
	}
	
	public List<CalendarStatus> getVolunteerStatus(CalendarStatus calendarStatus) {
		return Dao.getVolunteerStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getVolunteerMonthStatus(CalendarStatus calendarStatus) {
		return Dao.getVolunteerMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getVolunteerYearStatus(CalendarStatus calendarStatus) {
		return Dao.getVolunteerYearStatus(calendarStatus);
	}
	
	public Volunteer getVolunteerOne(Volunteer volunteer) {
		return Dao.getVolunteerOne(volunteer);
	}

	public Volunteer getTimeVolunteerOne(Volunteer volunteer) {
		return Dao.getTimeVolunteerOne(volunteer);
	}
	
	public int getVolunteerDateCheck(VolunteerApply apply) {
		return Dao.getVolunteerDateCheck(apply);
	}
	
	public int addVolunteer(Volunteer volunteer) {
		return Dao.addVolunteer(volunteer);
	}
	public int addTimeVolunteer(Volunteer volunteer) {
		return Dao.addTimeVolunteer(volunteer);
	}
	
	public int modifyCalendarManage(Volunteer volunteer) {
		return Dao.modifyVolunteer(volunteer);
	}
	
	public int deleteVolunteer(Volunteer volunteer) {
		return Dao.deleteVolunteer(volunteer);
	}
	
	public int countVolunteer(Volunteer volunteer) {
		return Dao.countVolunteer(volunteer);
	}
	
	public int countClosedVolunteer(Volunteer volunteer) {
		return Dao.countClosedVolunteer(volunteer);
	}

	@Transactional
	public void deleteVolunteerBatch(Volunteer volunteer) {
		for (int i : volunteer.getVolunteer_idx_arr()) {
			Volunteer oneVolunteer = new Volunteer();
			oneVolunteer.setHomepage_id(volunteer.getHomepage_id());
			oneVolunteer.setVolunteer_idx(i);
			
			VolunteerApply oneApply = new VolunteerApply();
			oneApply.setHomepage_id(volunteer.getHomepage_id());
			oneApply.setVolunteer_idx(i);
			
			Dao.deleteVolunteer(oneVolunteer);
			applyService.deleteApplyAll(oneApply);
		}
	}
}
