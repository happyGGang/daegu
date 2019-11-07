package kr.co.whalesoft.app.cms.module.calendarManage;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.common.api.LibSearchAPI;

@Service
public class CalendarManageService extends BaseService {
	
	@Autowired
	private CalendarManageDao dao;
	
	public List<CalendarManage> getCalendar(CalendarManage calendarManage) {
		return dao.getCalendar(calendarManage);
	}
	
	public List<CalendarManage> getCalendarManage(CalendarManage calendarManage) {
		return dao.getCalendarManage(calendarManage);
	}
	
	public CalendarManage getCalendarManageOne(CalendarManage calendarManage) {
		CalendarManage one = dao.getCalendarManageOne(calendarManage);
		if (StringUtils.isNotEmpty(one.getWeekday())) {
			Collections.addAll(one.getWeekdayArr(), one.getWeekday().split(","));
		}
		return one;
	}
	
	public CalendarManage getCalendarManageOne2(CalendarManage calendarManage) {
		return dao.getCalendarManageOne2(calendarManage);
	}
	
	public List<CalendarManage> getClosedDate(CalendarManage calendarManage) {
		return dao.getClosedDate(calendarManage);
	}
	
	public List<CalendarManage> getCalendarStatus(CalendarStatus calendarStatus) {
		return dao.getCalendarStatus(calendarStatus);
	}
	
	public List<CalendarManage> getCalendarMonthStatus(CalendarStatus calendarStatus) {
		return dao.getCalendarMonthStatus(calendarStatus);
	}
	
	public List<CalendarManage> getCalendarYearStatus(CalendarStatus calendarStatus) {
		return dao.getCalendarYearStatus(calendarStatus);
	}
	
	public CalendarManage getClosedDate2(CalendarManage calendarManage) {
		return dao.getClosedDate2(calendarManage);
	}
	
	public CalendarManage getClosedDate3(CalendarManage calendarManage) {
		return dao.getClosedDate3(calendarManage);
	}
	
	public List<CalendarManage> getCalendarManageDetail(CalendarManage calendarManage) {
		calendarManage.setDate_type("2");
		return dao.getCalendarManageDetail(calendarManage);
	}
	
	public int closedDateCheck(CalendarManage calendarManage) {
		return dao.closedDateCheck(calendarManage);
	}
	
	public int addCalendarManage(CalendarManage calendarManage) {
		return dao.addCalendarManage(calendarManage);
	}
	
	@Transactional
	public int modifyCalendarManage(CalendarManage calendarManage) throws Exception {
		
		int originGroupIdx = calendarManage.getGroup_idx();
		
		calendarManage.setIndividual_yn2(calendarManage.getIndividual_yn());
		if (StringUtils.equals(calendarManage.getIndividual_yn(), "E")) {
			calendarManage.setIndividual_yn("N");	
		}
		
		if (StringUtils.equals(calendarManage.getIndividual_yn(), "Y")) {
			//개별 수정은 수정만 하고
			if (calendarManage.getWeekdayArr() == null || StringUtils.equals(calendarManage.getWeekdayArr().get(0), "0")) {
				calendarManage.setWeekday("1,2,3,4,5,6,7");
			} else {
				calendarManage.setWeekday(StringUtils.join(calendarManage.getWeekdayArr(), ","));
			}
			return dao.modifyCalendarManage(calendarManage);
		} else {
			//전체수정은 지우고 다시 쓴다. 이미 개별수정된 일정은 독립적인 일정으로 변경된다. 반복일정에 포함되지 않는다.
			//지우고
			deleteCalendarManageGroup(calendarManage);
			
			//다시 쓴다
			String startDate = calendarManage.getStart_date();
			String endDate = calendarManage.getEnd_date();
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date startDay = dateFormat.parse(startDate);
			Date endDay = dateFormat.parse(endDate);
			
			Calendar start = Calendar.getInstance();
			Calendar end = Calendar.getInstance();
			
			start.setTime(startDay);
			end.setTime(endDay);
			
			if (calendarManage.getWeekdayArr() == null || StringUtils.equals(calendarManage.getWeekdayArr().get(0), "0")) {
				calendarManage.setWeekday("1,2,3,4,5,6,7");
			} else {
				calendarManage.setWeekday(StringUtils.join(calendarManage.getWeekdayArr(), ","));
			}
			
			String[] weekday = calendarManage.getWeekday().split(",");
			
			int nextIdx = dao.getNextCmIdx(calendarManage);
			calendarManage.setGroup_idx(nextIdx);
			calendarManage.setGroup_idx_tmp(originGroupIdx);
			
			while( start.compareTo( end ) !=1 ){
				for(int i = 0; i < weekday.length; i++) {
					int day = getDateDay(start, "yyyy-MM-dd");
					
					if(Integer.parseInt(weekday[i]) == day) {
						
						calendarManage.setStart_date(dateFormat.format(start.getTime()));
						calendarManage.setEnd_date(dateFormat.format(start.getTime()));
						
						int checkCount = dao.getCalendarManageCheckCount(calendarManage);
						if (checkCount == 0) {
							addCalendarManage(calendarManage);
						}
					}
				}
				start.add(Calendar.DATE, 1);
			}
			return 1;
		}
		
	}
	
	public int deleteCalendarManage(CalendarManage calendarManage) {
		return dao.deleteCalendarManage(calendarManage);
	}

	public int addCalendarManageFromILUS(CalendarManage calendarManage, Homepage homepage) {
		int resultRow = 0;
		String[] libCodes = homepage.getHomepage_codeList();
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, Integer.parseInt(calendarManage.getPlan_year()));
		cal.set(Calendar.MONTH, Integer.parseInt(calendarManage.getPlan_month())-1);
		String vSdate = calendarManage.getPlan_date().replace("-", "") + "01";
		String vEdate = calendarManage.getPlan_date().replace("-", "") + cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		Map<String, Object> holiDays = LibSearchAPI.getHolidays(libCodes[0], vSdate, vEdate);
		@SuppressWarnings("unchecked")
		List<Map<String, Object>> list = (List<Map<String, Object>>) holiDays.get("dsHoliday");
		for (Map<String, Object> map : list) {
			String start_date = String.valueOf(map.get("HOLIDY_DATE"));
			start_date = getDashDate(start_date);
			if (StringUtils.isNotEmpty(start_date)) {
				calendarManage.setStart_date(start_date);
				calendarManage.setEnd_date(start_date);
				calendarManage.setStart_time("");
				calendarManage.setEnd_time("");
				
				calendarManage.setTitle(String.valueOf(map.get("HOLIDY_NAME")));
				calendarManage.setContents(String.valueOf(map.get("REMARK")));
				
				calendarManage.setDate_type("1");//휴관
				addCalendarManage(calendarManage);
				resultRow++;
			}
		}
		
		return resultRow;
	}

	private String getDashDate(String start_date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		try {
			start_date = sdf2.format(sdf.parse(start_date));
		} catch (ParseException e) {
			if (start_date.length() == 8) {
				start_date = start_date.substring(0,4) + "-" + start_date.substring(4, 6) + "-" + start_date.substring(6); 
			} else {
				return null;
			}
		}
		return start_date;
	}

	public List<CalendarManage> getCalendarListType(CalendarManage calendarManage) {
		return dao.getCalendarListType(calendarManage);
	}

	public int getNextCmIdx(CalendarManage calendarManage) {
		return dao.getNextCmIdx(calendarManage);
	}

	public List<Code> getDefaultWeekDay() {
		List<Code> list = new ArrayList<Code>();
		String[] idArr = "0,2,3,4,5,6,7,1".split(",");
		String[] nameArr = "전체,월,화,수,목,금,토,일".split(",");
		
		for ( int i = 0; i < nameArr.length; i++ ) {
			Code code = new Code();
			code.setCode_id(idArr[i]);
			code.setCode_name(nameArr[i]);
			list.add(code);	
		}
		
		return list;
	}

	public int deleteCalendarManageGroup(CalendarManage calendarManage) {
		return dao.deleteCalendarManageGroup(calendarManage);
	}
	
	private int getDateDay(Calendar date, String dateType) throws Exception {
	    String day = "" ;
	     
	    int dayNum = date.get(Calendar.DAY_OF_WEEK) ;
	     
	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;
	    }
	    return dayNum ;
	}
	
	public boolean isTodayClosed(String homepage_id) {
		return dao.isTodayClosed(homepage_id) > 0 ? true : false;
	}
	
}
