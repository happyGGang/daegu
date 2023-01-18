package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage;

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
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibStatus.NearbyLibStatus;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.PrivateLibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Service
public class NearbyLibManageService extends BaseService {

	@Autowired
	private NearbyLibManageDao dao;
	
	public List<NearbyLibManage> getCalendar(NearbyLibManage nearbyLibManage) {
		return dao.getCalendar(nearbyLibManage);
	}

	public List<NearbyLibManage> getNearbyLibManage(NearbyLibManage nearbyLibManage) {
		return dao.getNearbyLibManage(nearbyLibManage);
	}

	public NearbyLibManage getNearbyLibManageOne(NearbyLibManage nearbyLibManage) {
		NearbyLibManage one = dao.getNearbyLibManageOne(nearbyLibManage);
		if (StringUtils.isNotEmpty(one.getWeekday())) {
			Collections.addAll(one.getWeekdayArr(), one.getWeekday().split(","));
		}
		return one;
	}

	public NearbyLibManage getNearbyLibManageOne2(NearbyLibManage nearbyLibManage) {
		return dao.getNearbyLibManageOne2(nearbyLibManage);
	}

	public List<NearbyLibManage> getClosedDate(NearbyLibManage nearbyLibManage) {
		return dao.getClosedDate(nearbyLibManage);
	}

	public List<NearbyLibManage> getNearbyLibStatus(NearbyLibStatus nearbyLibStatus) {
		return dao.getNearbyLibStatus(nearbyLibStatus);
	}

	public List<NearbyLibManage> getCalendarMonthStatus(NearbyLibStatus nearbyLibStatus) {
		return dao.getCalendarMonthStatus(nearbyLibStatus);
	}

	public List<NearbyLibManage> getCalendarYearStatus(NearbyLibStatus nearbyLibStatus) {
		return dao.getCalendarYearStatus(nearbyLibStatus);
	}

	public NearbyLibManage getClosedDate2(NearbyLibManage nearbyLibManage) {
		NearbyLibManage result = dao.getClosedDate2(nearbyLibManage);

		return result;
	}

	public NearbyLibManage getClosedDate3(NearbyLibManage nearbyLibManage) {
		return dao.getClosedDate3(nearbyLibManage);
	}

	public NearbyLibManage getClosedDate4(NearbyLibManage nearbyLibManage) {
		return dao.getClosedDate4(nearbyLibManage);
	}

	public List<NearbyLibManage> getClosedDate5(NearbyLibManage nearbyLibManage) {
		return dao.getClosedDate5(nearbyLibManage);
	}
	
	public List<NearbyLibManage> getNearbyLibManageDetail(NearbyLibManage nearbyLibManage) {
		return dao.getNearbyLibManageDetail(nearbyLibManage);
	}

	public int closedDateCheck(NearbyLibManage nearbyLibManage) {
		return dao.closedDateCheck(nearbyLibManage);
	}

	public int addNearbyLibManage(NearbyLibManage nearbyLibManage) {
		return dao.addNearbyLibManage(nearbyLibManage);
	}

	@Transactional
	public int modifyNearbyLibManage(NearbyLibManage nearbyLibManage) throws Exception {

		int originGroupIdx = nearbyLibManage.getGroup_idx();

		nearbyLibManage.setIndividual_yn2(nearbyLibManage.getIndividual_yn());
		if (StringUtils.equals(nearbyLibManage.getIndividual_yn(), "E")) {
			nearbyLibManage.setIndividual_yn("N");
		}

		if (StringUtils.equals(nearbyLibManage.getIndividual_yn(), "Y")) {
			//개별 수정은 수정만 하고
			if (nearbyLibManage.getWeekdayArr() == null || StringUtils.equals(nearbyLibManage.getWeekdayArr().get(0), "0")) {
				nearbyLibManage.setWeekday("1,2,3,4,5,6,7");
			} else {
				nearbyLibManage.setWeekday(StringUtils.join(nearbyLibManage.getWeekdayArr(), ","));
			}
			return dao.modifyNearbyLibManage(nearbyLibManage);
		} else {
			//전체수정은 지우고 다시 쓴다. 이미 개별수정된 일정은 독립적인 일정으로 변경된다. 반복일정에 포함되지 않는다.
			//지우고
			deleteNearbyLibManageGroup(nearbyLibManage);

			//다시 쓴다
			String startDate = nearbyLibManage.getStart_date();
			String endDate = nearbyLibManage.getEnd_date();

			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date startDay = dateFormat.parse(startDate);
			Date endDay = dateFormat.parse(endDate);

			Calendar start = Calendar.getInstance();
			Calendar end = Calendar.getInstance();

			start.setTime(startDay);
			end.setTime(endDay);

			if (nearbyLibManage.getWeekdayArr() == null || StringUtils.equals(nearbyLibManage.getWeekdayArr().get(0), "0")) {
				nearbyLibManage.setWeekday("1,2,3,4,5,6,7");
			} else {
				nearbyLibManage.setWeekday(StringUtils.join(nearbyLibManage.getWeekdayArr(), ","));
			}

			String[] weekday = nearbyLibManage.getWeekday().split(",");

			int nextIdx = dao.getNextCmIdx(nearbyLibManage);
			nearbyLibManage.setGroup_idx(nextIdx);
			nearbyLibManage.setGroup_idx_tmp(originGroupIdx);

			while( start.compareTo( end ) !=1 ){
				for(int i = 0; i < weekday.length; i++) {
					int day = getDateDay(start, "yyyy-MM-dd");

					if(Integer.parseInt(weekday[i]) == day) {

						nearbyLibManage.setStart_date(dateFormat.format(start.getTime()));
						nearbyLibManage.setEnd_date(dateFormat.format(start.getTime()));

						int checkCount = dao.getNearbyLibManageCheckCount(nearbyLibManage);
						if (checkCount == 0) {
							addNearbyLibManage(nearbyLibManage);
						}
					}
				}
				start.add(Calendar.DATE, 1);
			}
			return 1;
		}

	}

	public int deleteNearbyLibManage(NearbyLibManage nearbyLibManage) {
		return dao.deleteNearbyLibManage(nearbyLibManage);
	}

	public int addNearbyLibManageFromLas(NearbyLibManage nearbyLibManage, Homepage homepage) {
		int resultRow = 0;

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, Integer.parseInt(nearbyLibManage.getPlan_year()));
		cal.set(Calendar.MONTH, Integer.parseInt(nearbyLibManage.getPlan_month())-1);
		String plan_date = nearbyLibManage.getPlan_date();
		int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

		LibrarySearch librarySearch = new LibrarySearch();
		librarySearch.setManageCode(homepage.getManage_code());

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			for(int i = 1; i <= endDay; i++) {
				String search_day = "0";
				if(i < 10) {
					search_day += i;
				} else {
					search_day = String.valueOf(i);
				}
				librarySearch.setSearch_start_date(plan_date.replace("-", "") + search_day);
				Map<String, Object> holiDays = PrivateLibSearchAPI.getCheckHoliday(librarySearch);

				if(holiDays.get("RESULT_CODE").equals("1")) {
					nearbyLibManage.setStart_date(plan_date + "-" + search_day);
					nearbyLibManage.setEnd_date(plan_date + "-" + search_day);
					nearbyLibManage.setStart_time("");
					nearbyLibManage.setEnd_time("");

					nearbyLibManage.setTitle("휴관일");
					nearbyLibManage.setContents("자료시스템에서 가져온 휴관일 입니다.");

					nearbyLibManage.setDate_type("1");//휴관
					addNearbyLibManage(nearbyLibManage);
					resultRow++;
				}
			}
		} else {
			for(int i = 1; i <= endDay; i++) {
				String search_day = "0";
				if(i < 10) {
					search_day += i;
				} else {
					search_day = String.valueOf(i);
				}
				librarySearch.setSearch_start_date(plan_date.replace("-", "") + search_day);
				Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(librarySearch);

				if(holiDays.get("RESULT_CODE").equals("1")) {
					nearbyLibManage.setStart_date(plan_date + "-" + search_day);
					nearbyLibManage.setEnd_date(plan_date + "-" + search_day);
					nearbyLibManage.setStart_time("");
					nearbyLibManage.setEnd_time("");

					nearbyLibManage.setTitle("휴관일");
					nearbyLibManage.setContents("자료시스템에서 가져온 휴관일 입니다.");

					nearbyLibManage.setDate_type("1");//휴관
					addNearbyLibManage(nearbyLibManage);
					resultRow++;
				}
			}
		}
		
		return resultRow;
	}

	public int addNearbyLibManageFromLasYear(NearbyLibManage nearbyLibManage, Homepage homepage) {
		int resultRow = 0;

		String plan_date = nearbyLibManage.getPlan_date();

		LibrarySearch librarySearch = new LibrarySearch();
		librarySearch.setManageCode(homepage.getManage_code());

		String y = plan_date.split("-")[0];

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			for (int i = 1; i <= 12; i++) {
				String m = i < 10 ? "0" + i : "" + i;
				for (int j = 1; j <= 31; j++) {
					String d = j < 10 ? "0" + j : "" + j;
					librarySearch.setSearch_start_date(y+m+d);
					Map<String, Object> holiDays = PrivateLibSearchAPI.getCheckHoliday(librarySearch);
					if(holiDays.get("RESULT_CODE").equals("1")) {
						nearbyLibManage.setStart_date(y+ "-" +m+ "-" +d);
						nearbyLibManage.setEnd_date(y+ "-" +m+ "-" +d);
						nearbyLibManage.setStart_time("");
						nearbyLibManage.setEnd_time("");

						nearbyLibManage.setTitle("휴관일");
						nearbyLibManage.setContents("자료시스템에서 가져온 휴관일 입니다.");

						nearbyLibManage.setDate_type("1");//휴관
						addNearbyLibManage(nearbyLibManage);
						resultRow++;
					}
				}
			}
		} else {
			for (int i = 1; i <= 12; i++) {
				String m = i < 10 ? "0" + i : "" + i;
				for (int j = 1; j <= 31; j++) {
					String d = j < 10 ? "0" + j : "" + j;
					librarySearch.setSearch_start_date(y+m+d);
					Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(librarySearch);
					if(holiDays.get("RESULT_CODE").equals("1")) {
						nearbyLibManage.setStart_date(y+ "-" +m+ "-" +d);
						nearbyLibManage.setEnd_date(y+ "-" +m+ "-" +d);
						nearbyLibManage.setStart_time("");
						nearbyLibManage.setEnd_time("");

						nearbyLibManage.setTitle("휴관일");
						nearbyLibManage.setContents("자료시스템에서 가져온 휴관일 입니다.");

						nearbyLibManage.setDate_type("1");//휴관
						addNearbyLibManage(nearbyLibManage);
						resultRow++;
					}
				}
			}
		}
		
		return resultRow;
	}

	public List<NearbyLibManage> getCalendarListType(NearbyLibManage nearbyLibManage) {
		return dao.getCalendarListType(nearbyLibManage);
	}

	public int getNextCmIdx(NearbyLibManage nearbyLibManage) {
		return dao.getNextCmIdx(nearbyLibManage);
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

	public int deleteNearbyLibManageGroup(NearbyLibManage nearbyLibManage) {
		return dao.deleteNearbyLibManageGroup(nearbyLibManage);
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
