package kr.go.gbelib.app.cms.module.facility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class FacilityService extends BaseService {

	@Autowired
	private FacilityDao facilityDao;

	public List<Facility> getCalendar(Facility facility) {
		return facilityDao.getCalendar(facility);
	}

	public List<Facility> getFacilityListAll(Facility facility) {
		return facilityDao.getFacilityListAll(facility);
	}

	public List<Facility> getFacilityList(Facility facility) {
		return facilityDao.getFacilityList(facility);
	}

	public List<Facility> getFacilityListByExcel(Facility facility) {
		return facilityDao.getFacilityListByExcel(facility);
	}

	public List<Facility> getFacilityListByUser(Facility facility) {
		return facilityDao.getFacilityListByUser(facility);
	}

	public int getFacilityListCount(Facility facility) {
		return facilityDao.getFacilityListCount(facility);
	}

	public Facility getFacilityOne(Facility facility) {
		return facilityDao.getFacilityOne(facility);
	}

	public int addFacility(Facility facility) {
		SimpleDateFormat sf 	= new SimpleDateFormat("yyyy-MM-dd");
		List<Facility> addList 	= new ArrayList<Facility>();
		Date startDate 			= null;
		Date endDate 			= null;
		String useDay 			= facility.getUse_day();
		try {
			startDate 	= sf.parse(facility.getStart_date());
			endDate 	= sf.parse(facility.getEnd_date());
		} catch (ParseException e) {
		}
		Calendar cal = Calendar.getInstance() ;
		while ( !DateUtils.isSameDay(startDate, endDate) ) {
			Facility o = facility.clone();
			if ( endDate.before(startDate) ) { // 종료일이 시작일 보다 작다면 강제로 멈춘다 (안전장치)
				break;
			}

			cal.setTime(startDate);
			if ( StringUtils.isEmpty(useDay) || (StringUtils.isNotEmpty(useDay) && useDay.contains(String.valueOf(cal.get(Calendar.DAY_OF_WEEK)))) ) {
		    	o.setUse_date(sf.format(startDate));
				addList.add(o);
			}
			startDate = DateUtils.addDays(startDate, 1);
		}

		cal.setTime(endDate);
		if ( StringUtils.isEmpty(useDay) || (StringUtils.isNotEmpty(useDay) && useDay.contains(String.valueOf(cal.get(Calendar.DAY_OF_WEEK)))) ) {
			facility.setUse_date(sf.format(endDate));
			addList.add(facility);
	    }

		Map<String, List<Facility>> param = new HashMap<String, List<Facility>>();
		param.put("list", addList);
		if (addList.size() == 0) {
			return 0;
		} else {
			return facilityDao.addFacility(param);
		}
	}
	public List<Integer> getFacilityLastIDX(Facility facility) {
		return facilityDao.getFacilityLastIDX(facility);
	}

	public int modifyFacility(Facility facility) {
		return facilityDao.modifyFacility(facility);
	}

	public int deleteFacility(Facility facility) {
		return facilityDao.deleteFacility(facility);
	}

	public List<CalendarStatus> getFacilityStatus(CalendarStatus calendarStatus) {
		return facilityDao.getFacilityStatus(calendarStatus);
	}

	public List<CalendarStatus> getFacilityMonthStatus(CalendarStatus calendarStatus) {
		return facilityDao.getFacilityMonthStatus(calendarStatus);
	}

	public List<CalendarStatus> getFacilityYearStatus(CalendarStatus calendarStatus) {
		return facilityDao.getFacilityYearStatus(calendarStatus);
	}

	public Map<String, List<Facility>> convertToRepo(List<Facility> list) {
		Map<String, List<Facility>> repo = new HashMap<String, List<Facility>>();

		for ( Facility one : list ) {
			String key = one.getUse_date();
			List<Facility> facilityList = null;
			if ( repo.containsKey(key) ) {
				facilityList = repo.get(key);
			}
			else {
				facilityList = new ArrayList<Facility>();
			}

			facilityList.add(one);
			repo.put(key, facilityList);
		}

		return repo;
	}

}