package kr.go.gbelib.app.cms.module.expReservation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApply;
import kr.go.gbelib.app.cms.module.expReservation.expReservationApply.ExpReservationApplyService;

@Service
public class ExpReservationService extends BaseService{
	
	@Autowired
	private ExpReservationDao dao;
	
	@Autowired
	private ExpReservationApplyService expReservationApplyService;

	public List<Calendar> getCalendar(ExpReservation expReservation) {
		return dao.getCalendar(expReservation);
	}

	public List<ExpReservation> getExpReservationList(ExpReservation expReservation) {
		return dao.getExpReservationList(expReservation);
	}

	public ExpReservation getExpReservationOne(ExpReservation expReservation) {
		return dao.getExpReservationOne(expReservation);
	}

	public int addExpReservation(ExpReservation expReservation) {
		int result = 0;
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date from = sdf.parse(expReservation.getFrom_date());
			Date to = sdf.parse(expReservation.getTo_date());
			
			int[] weeks = expReservation.getWeeks();
			
			long date = to.getTime() - from.getTime();
			if(date < 0L) {
				return 0;
			}
			long days = date / (24*60*60*1000);
			days = Math.abs(days);
			
			Calendar c = Calendar.getInstance();
			c.setTime(from);
			
			for(int i = 0; i < days; i++) {
				for(int j = 0; j < weeks.length; j++) {
					if(c.get(Calendar.DAY_OF_WEEK) == weeks[j]) {
						expReservation.setReservation_date(sdf.format(c.getTime()).replace("-", ""));
						result += dao.addExpReservation(expReservation);
					}
				}
				c.add(Calendar.DATE, 1);
			}
			
			if(days == 0) {
				expReservation.setReservation_date(sdf.format(c.getTime()).replace("-", ""));
				result += dao.addExpReservation(expReservation);
			}
		}catch(ParseException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int modifyExpReservation(ExpReservation expReservation) {
		return dao.modifyExpReservation(expReservation);
	}

	@Transactional
	public int deleteExpReservation(ExpReservation expReservation) {
		int result = 0;
		ExpReservationApply apply = new ExpReservationApply();
		apply.setProgram_list_idx(expReservation.getProgram_list_idx());
		if (apply.getProgram_list_idx() == expReservation.getProgram_list_idx()) {
			result = expReservationApplyService.deleteExpProgram(apply) + dao.deleteExpReservation(expReservation);
		}
		return result;
	}

}
