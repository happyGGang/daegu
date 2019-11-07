package kr.go.gbelib.app.cms.module.liboneManage;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LiboneManage extends PagingUtils{

	private int error_idx; 
	
	private String exception_message;
	private String server_ip;
	
	
	public String getException_message() {
		return exception_message;
	}
	public void setException_message(String exception_message) {
		this.exception_message = exception_message;
	}
	public String getServer_ip() {
		return server_ip;
	}
	public void setServer_ip(String server_ip) {
		this.server_ip = server_ip;
	}
	public int getError_idx() {
		return error_idx;
	}
	public void setError_idx(int error_idx) {
		this.error_idx = error_idx;
	}
}
