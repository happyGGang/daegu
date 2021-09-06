package kr.go.gbelib.app.cms.module.untactBook.untactBookSetting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class UntactBookSettingService extends BaseService {
	
	@Autowired
	private UntactBookSettingDao dao;

	public UntactBookSetting getUntactBookSettingOne(String homepage_id) {
		return dao.getUntactBookSettingOne(homepage_id);
	}
	
	public int mergeUntactBookSetting(UntactBookSetting untactBookSetting) {
		return dao.mergeUntactBookSetting(untactBookSetting);
	}
	
}
