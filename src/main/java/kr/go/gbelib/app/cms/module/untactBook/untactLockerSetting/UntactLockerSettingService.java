package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UntactLockerSettingService extends BaseService {
	
	@Autowired
	private UntactLockerSettingDao dao;

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

}