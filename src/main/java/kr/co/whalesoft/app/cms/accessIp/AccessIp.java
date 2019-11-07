package kr.co.whalesoft.app.cms.accessIp;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class AccessIp extends PagingUtils {

	private int access_idx; //접근가능IDX
	private String access_ip; //접근가능IP
	private String use_yn; //허용여부
	private String remark; //설명
	private Date add_date; //등록일
	private String add_id; //등록ID
	private Date mod_date;
	private String mod_id;
	
	public String getAccess_ip() {
		return access_ip;
	}
	public void setAccess_ip(String access_ip) {
		this.access_ip = access_ip;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public int getAccess_idx() {
		return access_idx;
	}
	public void setAccess_idx(int access_idx) {
		this.access_idx = access_idx;
	}
	@Override
	public String toString() {
		return "AccessIp [access_ip=" + access_ip + ", use_yn=" + use_yn
				+ ", remark=" + remark + ", add_date=" + add_date + ", add_id="
				+ add_id + ", mod_date=" + mod_date + ", mod_id=" + mod_id
				+ "]";
	}
	
	
}