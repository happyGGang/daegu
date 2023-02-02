package kr.co.whalesoft.app.cms.limitedIp;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LimitedIp extends PagingUtils {

	private int limitedIp_idx; //접근불가능IDX
	private String limited_ip; //접근불가능IP
	private String use_yn; //사용여부
	private String remark; //설명
	private Date add_date; //등록일
	private String add_id; //등록ID
	private Date modify_date;
	private String modify_id;
	
	public int getLimitedIp_idx() {
		return limitedIp_idx;
	}
	public void setLimitedIp_idx(int limitedIp_idx) {
		this.limitedIp_idx = limitedIp_idx;
	}
	public String getLimited_ip() {
		return limited_ip;
	}
	public void setLimited_ip(String limited_ip) {
		this.limited_ip = limited_ip;
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
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
}