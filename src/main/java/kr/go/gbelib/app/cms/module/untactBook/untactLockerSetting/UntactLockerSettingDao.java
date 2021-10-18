package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import java.util.List;

public interface UntactLockerSettingDao {

	public List<UntactLockerSetting> getUntactLockerSettingList(String homepage_id);

	public int getMaxUntactLocker(String homepage_id);

	public int deleteUntactLocker(UntactLockerSetting untactLockerSetting);

	public int insertUntactLocker(UntactLockerSetting untactLockerSetting);

	public int modifyUntactLockerSetting(UntactLockerSetting untactLockerSetting);

	public int modifyUntactLockerSettingALL(UntactLockerSetting untactLockerSetting);

	public int getUntactLockerSettingCount(String homepage_id);

	public UntactBookSetting getUntactBookSettingOne(String homepage_id);

	public int mergeUntactBookSetting(UntactBookSetting untactBookSetting);

	public int reservationTimeCount(String homepage_id);

	public int reservationMaxCount(String homepage_id);

	public String getLoanTime(String homepage_id);

	public List<UntactLockerSetting> showLockerState(String homepage_id);

	public String getLockerUseType(String homepage_id);

	public int getLockerMaxCount(String homepage_id);

	public String getLockerUseYN(String homepage_id);

}
