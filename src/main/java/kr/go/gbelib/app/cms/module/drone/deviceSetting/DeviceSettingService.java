package kr.go.gbelib.app.cms.module.drone.deviceSetting;

import java.util.List;
import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeviceSettingService extends BaseService {

    @Autowired
    private DeviceSettingDao dao;

    public List<DeviceSetting> getDeviceList(DeviceSetting deviceSetting) {
        return dao.getDeviceList(deviceSetting);
    }

    public int insertDevice(DeviceSetting deviceSetting) {
        return dao.insertDevice(deviceSetting);
    }

    public int updateDeviceUseYn(DeviceSetting deviceSetting) {
        return dao.updateDeviceUseYn(deviceSetting);
    }

    public int getDeviceUsedCount(DeviceSetting deviceSetting) {
        return dao.getDeviceUsedCount(deviceSetting);
    }
}
