package kr.co.whalesoft.app.cms.module.consultings;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApply;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApplyService;
import kr.co.whalesoft.framework.base.BaseService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ConsultingsService extends BaseService {
	
	@Autowired
	private ConsultingsDao Dao;
	
	@Autowired
	private ConsultingApplyService applyService;
	
	public List<Calendar> getCalendar(Consultings consultings) {
		return Dao.getCalendar(consultings);
	}
	
	public List<Consultings> getConsultings(Consultings consultings) {
		List<Consultings> list = Dao.getConsultings(consultings);
		for (Consultings consulting : list) {
			if (StringUtils.isEmpty(consulting.getCode_name())) {
				consulting.setCode_name(Dao.getCodeName(consulting));
			}
		}
		return list;
	}
	
	public List<CalendarStatus> getConsultingsStatus(CalendarStatus calendarStatus) {
		return Dao.getConsultingsStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getConsultingsMonthStatus(CalendarStatus calendarStatus) {
		return Dao.getConsultingsMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getConsultingsYearStatus(CalendarStatus calendarStatus) {
		return Dao.getConsultingsYearStatus(calendarStatus);
	}
	
	public Consultings getConsultingsOne(Consultings consultings) {
		return Dao.getConsultingsOne(consultings);
	}
	
	public int getConsultingsuDateCheck(ConsultingApply apply) {
		return Dao.getConsultingsuDateCheck(apply);
	}
	
	public int addConsultings(Consultings consultings) {
		return Dao.addConsultings(consultings);
	}
	
	public int modifyCalendarManage(Consultings consultings) {
		return Dao.modifyConsultings(consultings);
	}
	
	public int deleteConsultings(Consultings consultings) {
		return Dao.deleteConsultings(consultings);
	}
	
	public int countConsultings(Consultings consultings) {
		return Dao.countConsultings(consultings);
	}
	
	public int countClosedConsultings(Consultings consultings) {
		return Dao.countClosedConsultings(consultings);
	}

	@Transactional
	public void deleteConsultingsBatch(Consultings consultings) {
		for (int i : consultings.getConsultings_idx_arr()) {
			Consultings oneConsultings = new Consultings();
			oneConsultings.setHomepage_id(consultings.getHomepage_id());
			oneConsultings.setConsultings_idx(i);
			
			ConsultingApply oneApply = new ConsultingApply();
			oneApply.setHomepage_id(consultings.getHomepage_id());
			oneApply.setConsultings_idx(i);
			
			Dao.deleteConsultings(oneConsultings);
			applyService.deleteApplyAll(oneApply);
		}
	}
}
