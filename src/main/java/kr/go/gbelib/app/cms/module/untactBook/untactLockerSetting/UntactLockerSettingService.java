package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Service
public class UntactLockerSettingService extends BaseService {
	
	protected final Logger logger = LoggerFactory.getLogger(getClass());
	
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
	
	public int createUntactBookRound(UntactBookSetting untactBookSetting) throws ParseException {
		int result = 0;
		Date start = new Date();
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(start);
		
		Calendar calendar2 = Calendar.getInstance();
		calendar2.setTime(start);
		
		UntactBookRound untactBookRound = new UntactBookRound();
		calendar2.add(Calendar.DATE, untactBookSetting.getReservation_repeated_day());
		DateFormatUtils.format(calendar2.getTime(), "yyyyMMdd");

		untactBookRound.setHomepage_id(untactBookSetting.getHomepage_id());
		untactBookRound.setRound_idx(DateFormatUtils.format(start.getTime(), "yyyyMMdd"));
		
		untactBookRound.setRound_start_time(untactBookSetting.getRepeated_start_hour() + ":" + untactBookSetting.getRepeated_start_minute()+":00");
		untactBookRound.setRound_end_time(untactBookSetting.getRepeated_start_hour() + ":" + untactBookSetting.getRepeated_start_minute()+":01");
		untactBookRound.setRound_start_date(DateFormatUtils.format(calendar.getTime(), "yyyy-MM-dd"));
		untactBookRound.setRound_end_date(DateFormatUtils.format(calendar2.getTime(), "yyyy-MM-dd"));
		
		result += dao.createUntactBookRound(untactBookRound);
		return result;
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
		
		List<UntactLockerSetting> list = dao.showLockerStateBefore(untactBookReservation);
		
		int temp = 0;
		
		for(Iterator<UntactLockerSetting> it=list.iterator(); it.hasNext();){
			UntactLockerSetting item = it.next();
			
            if(item.getLocker_number() == temp) it.remove();
            
            temp = item.getLocker_number();
        }
		
		return list;
	}
	
	public void mergeSetting() {
		
		List<UntactBookSetting> untactBookSettingList = dao.getHomepageList();
		// WAS2_HOMEPAGE2 컨테이너에서만 실행
		if(StringUtils.equals(System.getProperty("whalesoft.container"), "WAS2_HOMEPAGE2")) {
			try {
				if(untactBookSettingList != null) {
					for (UntactBookSetting untactBookSetting : untactBookSettingList) {
						int dateCheck = dao.dateCheck(untactBookSetting.getHomepage_id());
						
						if(dateCheck == 0) {
							int res= createUntactBookRound(untactBookSetting);
	
							if (res == 0) {
								logger.error("###### 비대면 도서대출 회차 생성 에러 ######");
							}
						}
					}
				}
			} catch (Exception e) {
				logger.error("###### 비대면 도서대출 세팅 에러 ######" + e);
			}
		}

	}

	public int checkSetting(UntactBookSetting untactBookSetting) {
		return dao.checkSetting(untactBookSetting);
	}

	public String getReservationTime(String homepage_id) {
		return dao.getReservationTime(homepage_id);
	}

	public String getUntactBookRoundToday(UntactBookRound untactBookRound) {
		return dao.getUntactBookRoundToday(untactBookRound);
	}

	public String getReturnDateToday(UntactBookRound untactBookRound) {
		return dao.getReturnDateToday(untactBookRound);
	}
}