package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;

import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class UntactLockerSettingService extends BaseService {
	
	@Autowired
	private UntactLockerSettingDao dao;

	@Autowired
	private TermsService termsService;

	public List<UntactLockerSetting> getUntactLockerSettingList(String homepage_id) {
		return dao.getUntactLockerSettingList(homepage_id);
	}
	
	public int modifyUntactLockerSetting(UntactLockerSetting untactLockerSetting) {
		return dao.modifyUntactLockerSetting(untactLockerSetting);
	}

	public int modifyUntactLockerSettingALL(UntactLockerSetting untactLockerSetting) {
		return dao.modifyUntactLockerSettingALL(untactLockerSetting);
	}
	
	public int getUntactLockerSettingCount(String homepage_id) {
		return dao.getUntactLockerSettingCount(homepage_id);
	}

	public UntactBookSetting getUntactBookSettingOne(String homepage_id) {
		return dao.getUntactBookSettingOne(homepage_id);
	}

	@Transactional
	public int mergeUntactBookSetting(UntactBookSetting untactBookSetting) {
		if(dao.mergeUntactBookSetting(untactBookSetting) > 0) {
			int maxLocker = dao.getMaxUntactLocker(untactBookSetting.getHomepage_id());

			if(untactBookSetting.getTotal_count() > maxLocker) {
				for (int i=maxLocker + 1; i<=untactBookSetting.getTotal_count(); i++) {
					UntactLockerSetting untactLockerSetting = new UntactLockerSetting();
					untactLockerSetting.setHomepage_id(untactBookSetting.getHomepage_id());
					untactLockerSetting.setLocker_number(i);
					untactLockerSetting.setLocker_type("사용안함");

					dao.insertUntactLocker(untactLockerSetting);
				}
			} else if(untactBookSetting.getTotal_count() < maxLocker) {
				UntactLockerSetting untactLockerSetting = new UntactLockerSetting();
				untactLockerSetting.setHomepage_id(untactBookSetting.getHomepage_id());
				untactLockerSetting.setLocker_number(untactBookSetting.getTotal_count());

				dao.deleteUntactLocker(untactLockerSetting);
			}
		}

		return 1;
	}

	public int reservationTimeCount(String homepage_id) {
		return dao.reservationTimeCount(homepage_id);
	}
	
	public int reservationMaxCount(String homepage_id) {
		return dao.reservationMaxCount(homepage_id);
	}

	public String getLoanTime(String homepage_id) {
		return dao.getLoanTime(homepage_id);
	}
	
	public List<UntactLockerSetting> showLockerState(String homepage_id) {
		return dao.showLockerState(homepage_id);
	}

	public String getLockerUseType(String homepage_id) {
		return dao.getLockerUseType(homepage_id);
	}

	public int getLockerMaxCount(String homepage_id) {
		return dao.getLockerMaxCount(homepage_id);
	}

	public String getLockerUseYN(String homepage_id) {
		return dao.getLockerUseYN(homepage_id);
	}

	/**
	 * 비대면대출 이용약관 불러오기
	 * */
	public List<Terms> getUntactBookSettingTerms(String homepage_id) {
		Terms terms = new Terms();
		terms.setHomepage_id(homepage_id);

		List<Terms> termList = termsService.getTermsList(terms);
		List<Terms> untactTermList = new ArrayList<Terms>();

		for(Terms item : termList) {
			if(item.getTerms_type().equals("110")) {
				untactTermList.add(item);
			}
		}

		return untactTermList;
	}
	
	@Transactional
	public int createUntactBookRound(UntactBookSetting untactBookSetting) {
		int result = 0;
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date start = sdf.parse(untactBookSetting.getRound_start_date());
			Date end = sdf.parse(untactBookSetting.getRound_end_date());
			
			long date = end.getTime() - start.getTime();
			
			long days = date / (24*60*60*1000);
			days = Math.abs(days);
			
			int roundDay = (int) Math.round((long)days / untactBookSetting.getReservation_repeated_day());
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(start);
			
			Calendar calendar2 = Calendar.getInstance();
			calendar2.setTime(start);
			
			UntactBookRound untactBookRound = new UntactBookRound();
			untactBookRound.setHomepage_id(untactBookSetting.getHomepage_id());
			untactBookRound.setRound_start_time(untactBookSetting.getStart_hour() + ":" + untactBookSetting.getStart_minute());
			untactBookRound.setRound_end_time(untactBookSetting.getStart_hour() + ":" + untactBookSetting.getStart_minute());
			for (int i = 0; i <= roundDay; i++) {
				if(i == 0) {
					untactBookRound.setRound_idx(DateFormatUtils.format(start.getTime(), "yyyyMMdd"));
					
					calendar2.add(Calendar.DATE, untactBookSetting.getReservation_repeated_day());
					DateFormatUtils.format(calendar2.getTime(), "yyyyMMdd");
					//처음 시작 시간을 2022-01-11 반복일 2라고 설정시 처음은 2022-01-11 2022-01-13
					untactBookRound.setRound_start_date(untactBookSetting.getRound_start_date());
					untactBookRound.setRound_end_date(DateFormatUtils.format(calendar2.getTime(), "yyyy-MM-dd"));
				} else {
					calendar.add(Calendar.DATE, untactBookSetting.getReservation_repeated_day());
					
					untactBookRound.setRound_idx(DateFormatUtils.format(calendar.getTime(), "yyyyMMdd"));
					
					calendar2.add(Calendar.DATE, untactBookSetting.getReservation_repeated_day());
					DateFormatUtils.format(calendar2.getTime(), "yyyyMMdd");
					
					untactBookRound.setRound_start_date(DateFormatUtils.format(calendar.getTime(), "yyyy-MM-dd"));
					untactBookRound.setRound_end_date(DateFormatUtils.format(calendar2.getTime(), "yyyy-MM-dd"));
				}
				result += dao.createUntactBookRound(untactBookRound);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	public int deleteUntactBookRound(UntactBookRound untactBookRound) {
		return dao.deleteUntactBookRound(untactBookRound);
	}

	public String getUntactBookRoundOne(UntactBookRound untactBookRound) {
		return dao.getUntactBookRoundOne(untactBookRound);
	}

	public UntactBookRound getUntactBookRoundAll(UntactBookRound untactBookRound) {
		return dao.getUntactBookRoundAll(untactBookRound);
	}

	public String getReturnDate(UntactBookRound untactBookRound) {
		return dao.getReturnDate(untactBookRound);
	}

	public String getRepeatedOne(String homepage_id) {
		return dao.getRepeatedOne(homepage_id);
	}

	public String getUntactBookRound(UntactBookRound untactBookRound) {
		return dao.getUntactBookRound(untactBookRound);
	}

	public String getUntactBookRoundBefore(UntactBookRound untactBookRound) {
		return dao.getUntactBookRoundBefore(untactBookRound);
	}

	public int checkUntactBookRoundCount(UntactBookRound untactBookRound) {
		return dao.checkUntactBookRoundCount(untactBookRound);
	}

	public List<UntactLockerSetting> showLockerStateBefore(UntactBookReservation untactBookReservation) {
		return dao.showLockerStateBefore(untactBookReservation);
	}
}