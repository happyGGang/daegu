package kr.go.gbelib.app.cms.module.bringInLog;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BringInLog extends PagingUtils {

	private int log_idx;
	private String manage_code;
	private String member_id;
	private String member_name;
	private String birthday;
	private String cell_phone;
	private String ip;
	private String log_date;

	public int getLog_idx() {
		return log_idx;
	}

	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getCell_phone() {
		return cell_phone;
	}

	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getLog_date() {
		return log_date;
	}

	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	
}
