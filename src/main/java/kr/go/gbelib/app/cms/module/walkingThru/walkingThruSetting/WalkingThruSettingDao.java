package kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting;

import java.util.List;

public interface WalkingThruSettingDao {

	List<WalkingThruSetting> getWalkingThruSettingList(WalkingThruSetting walkingThruSetting);

	WalkingThruSetting getWalkingThruSettingOne(String homepage_id);

	int modifyWalkingThruSetting(WalkingThruSetting walkingThruSetting);

	int checkReserveTime(WalkingThruSetting walkingThruSetting);

}
