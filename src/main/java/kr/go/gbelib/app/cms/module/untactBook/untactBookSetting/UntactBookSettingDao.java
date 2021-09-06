package kr.go.gbelib.app.cms.module.untactBook.untactBookSetting;

public interface UntactBookSettingDao {

	public UntactBookSetting getUntactBookSettingOne(String homepage_id);
	
	public int mergeUntactBookSetting(UntactBookSetting untactBookSetting);
	
}
