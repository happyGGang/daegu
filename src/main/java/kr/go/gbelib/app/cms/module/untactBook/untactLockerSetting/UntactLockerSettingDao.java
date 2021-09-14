package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import java.util.List;

public interface UntactLockerSettingDao {

	public List<UntactLockerSetting> getUntactLockerSettingList(String homepage_id);

	public int modifyUntactLockerSetting(UntactLockerSetting untactLockerSetting);

	public int modifyUntactLockerSettingALL(UntactLockerSetting untactLockerSetting);

}
