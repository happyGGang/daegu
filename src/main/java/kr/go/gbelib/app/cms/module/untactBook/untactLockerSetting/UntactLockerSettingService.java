package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class UntactLockerSettingService extends BaseService {
	
	@Autowired
	private UntactLockerSettingDao dao;

	public List<UntactLockerSetting> getUntactLockerSettingList(String homepage_id) {
		return dao.getUntactLockerSettingList(homepage_id);
	}
	
	@Transactional
	public int modifyUntactLockerSetting(UntactLockerSetting untactLockerSetting) {
		return dao.modifyUntactLockerSetting(untactLockerSetting);
	}
	
	@Transactional
	public int modifyUntactLockerSettingALL(UntactLockerSetting untactLockerSetting) {
		return dao.modifyUntactLockerSettingALL(untactLockerSetting);
	}
	
	public int getUntactLockerSettingCount(String homepage_id) {
		return dao.getUntactLockerSettingCount(homepage_id);
	}

}
