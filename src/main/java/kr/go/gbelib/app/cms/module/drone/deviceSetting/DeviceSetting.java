package kr.go.gbelib.app.cms.module.drone.deviceSetting;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class DeviceSetting extends PagingUtils {
    private int device_idx;
    private String manage_code;
    private String device_code;
    private String pickup_place;
    private String use_yn = "Y";
    private Date add_date;
    private String add_id;

    public DeviceSetting() {}

    public DeviceSetting(String manage_code) {
        this.manage_code = manage_code;
    }

    public int getDevice_idx() {
        return device_idx;
    }

    public void setDevice_idx(int device_idx) {
        this.device_idx = device_idx;
    }

    public String getManage_code() {
        return manage_code;
    }

    public void setManage_code(String manage_code) {
        this.manage_code = manage_code;
    }

    public String getDevice_code() {
        return device_code;
    }

    public void setDevice_code(String device_code) {
        this.device_code = device_code;
    }

    public String getPickup_place() {
        return pickup_place;
    }

    public void setPickup_place(String pickup_place) {
        this.pickup_place = pickup_place;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }

    public String getAdd_id() {
        return add_id;
    }

    public void setAdd_id(String add_id) {
        this.add_id = add_id;
    }
}
