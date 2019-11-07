package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ApiLog extends PagingUtils {

	private int log_idx;
	private String api_mode;
	private String code;
	private String msg;
	private String params;
	private String user_ip;
	private String log_date;
	public ApiLog(String api_mode, String code, String msg, String params, String user_ip) {
		this.api_mode = api_mode;
		this.code = code;
		this.msg = msg;
		this.params = params;
		this.user_ip = user_ip;
	}
	public int getLog_idx() {
		return log_idx;
	}
	public String getApi_mode() {
		return api_mode;
	}
	public String getCode() {
		return code;
	}
	public String getMsg() {
		return msg;
	}
	public String getParams() {
		return params;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public String getLog_date() {
		return log_date;
	}
	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}
	public void setApi_mode(String api_mode) {
		this.api_mode = api_mode;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public void setParams(String params) {
		this.params = params;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	
}
