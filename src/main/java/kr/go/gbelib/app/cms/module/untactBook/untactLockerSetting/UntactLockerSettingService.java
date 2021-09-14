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

	public UntactBookSetting getUntactBookSettingOne(String homepage_id) {
		return dao.getUntactBookSettingOne(homepage_id);
	}

	@Transactional
	public int mergeUntactBookSetting(UntactBookSetting untactBookSetting) {
		if(dao.mergeUntactBookSetting(untactBookSetting) > 0) {
			int maxLocker = dao.getMaxUntactLocker();

			if(untactBookSetting.getTotal_count() > maxLocker) {
				for (int i=maxLocker + 1; i<=untactBookSetting.getTotal_count(); i++) {
					UntactLockerSetting untactLockerSetting = new UntactLockerSetting();
					untactLockerSetting.setHomepage_id(untactBookSetting.getHomepage_id());
					untactLockerSetting.setLocker_number(i);
					untactLockerSetting.setLocker_type("사용안함");

					dao.insertUntactLocker(untactLockerSetting);
				}
			} else if(untactBookSetting.getTotal_count() < maxLocker) {
				dao.deleteUntactLocker(untactBookSetting.getTotal_count());
			}
		}

		return 1;
	}

}