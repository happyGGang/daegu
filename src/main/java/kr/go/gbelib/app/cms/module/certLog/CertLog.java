package kr.go.gbelib.app.cms.module.certLog;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class CertLog extends PagingUtils {

	private int log_idx;
	private String cert_mode;
	private String cert_type;
	private String name;
	private String birthday;
	private String cell_phone;
	private String ci;
	private String msg;
	private String ip;
	private String log_date;
	public CertLog() { }
	public CertLog(String cert_mode, String cert_type, String name, String birthday, String cell_phone, String ci,
			String msg, String ip) {
		super();
		this.cert_mode = cert_mode;
		this.cert_type = cert_type;
		this.name = name;
		this.birthday = birthday;
		this.cell_phone = cell_phone;
		this.ci = ci;
		this.msg = msg;
		this.ip = ip;
	}
	public int getLog_idx() {
		return log_idx;
	}
	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}
	public String getCert_mode() {
		return cert_mode;
	}
	public void setCert_mode(String cert_mode) {
		this.cert_mode = cert_mode;
	}
	public String getCert_type() {
		return cert_type;
	}
	public void setCert_type(String cert_type) {
		this.cert_type = cert_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
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
