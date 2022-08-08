package kr.go.gbelib.app.cms.module.drone.deviceSetting;

import java.util.List;
import kr.go.gbelib.app.cms.module.elib.accessIp.ElibAccessIp;

public interface DeviceSettingDao {

    public List<DeviceSetting> getDeviceList(DeviceSetting deviceSetting);

    public int insertDevice(DeviceSetting deviceSetting);
}
