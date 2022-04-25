package kr.co.whalesoft.app.cms.module.showPerformance;

import java.util.Calendar;
import java.util.List;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApply;
import kr.co.whalesoft.framework.base.BaseService;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ShowPerformanceService extends BaseService {
	
	@Autowired
	private ShowPerformanceDao Dao;
	
	@Autowired
	private kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApplyService applyService;
	
	public List<Calendar> getCalendar(ShowPerformance showPerformance) {
		return Dao.getCalendar(showPerformance);
	}
	
	public List<ShowPerformance> getShowPerformance(ShowPerformance showPerformance) {
		List<ShowPerformance> list = Dao.getShowPerformance(showPerformance);
		for (ShowPerformance ShowPerformance1 : list) {
			if (StringUtils.isEmpty(ShowPerformance1.getCode_name())) {
				ShowPerformance1.setCode_name(Dao.getCodeName(ShowPerformance1));
			}
		}
		return list;
	}
	
	public List<CalendarStatus> getShowPerformanceStatus(CalendarStatus calendarStatus) {
		return Dao.getShowPerformanceStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getShowPerformanceMonthStatus(CalendarStatus calendarStatus) {
		return Dao.getShowPerformanceMonthStatus(calendarStatus);
	}
	
	public List<CalendarStatus> getShowPerformanceYearStatus(CalendarStatus calendarStatus) {
		return Dao.getShowPerformanceYearStatus(calendarStatus);
	}
	
	public ShowPerformance getShowPerformanceOne(ShowPerformance showPerformance) {
		return Dao.getShowPerformanceOne(showPerformance);
	}

	public ShowPerformance getTimeShowPerformanceOne(ShowPerformance showPerformance) {
		return Dao.getTimeShowPerformanceOne(showPerformance);
	}
	
	public int getShowPerformanceDateCheck(ShowApply apply) {
		return Dao.getShowPerformanceDateCheck(apply);
	}
	
	public int addShowPerformance(ShowPerformance showPerformance) {
		return Dao.addShowPerformance(showPerformance);
	}
	
	public int modifyCalendarManage(ShowPerformance showPerformance) {
		return Dao.modifyShowPerformance(showPerformance);
	}
	
	public int deleteShowPerformance(ShowPerformance showPerformance) {
		return Dao.deleteShowPerformance(showPerformance);
	}
	
	public int countShowPerformance(ShowPerformance showPerformance) {
		return Dao.countShowPerformance(showPerformance);
	}
	
	public int countClosedShowPerformance(ShowPerformance showPerformance) {
		return Dao.countClosedShowPerformance(showPerformance);
	}

	@Transactional
	public void deleteShowPerformanceBatch(ShowPerformance showPerformance) {
		for (int i : showPerformance.getShowPerformance_idx_arr()) {
			ShowPerformance oneShowPerformance = new ShowPerformance();
			oneShowPerformance.setHomepage_id(showPerformance.getHomepage_id());
			oneShowPerformance.setShowPerformance_idx(i);
			
			ShowApply oneApply = new ShowApply();
			oneApply.setHomepage_id(showPerformance.getHomepage_id());
			oneApply.setShowPerformance_idx(i);
			
			Dao.deleteShowPerformance(oneShowPerformance);
			applyService.deleteApplyAll(oneApply);
		}
	}
}
