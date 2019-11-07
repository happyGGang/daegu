package kr.go.gbelib.app.cms.module.api;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class SSO extends PagingUtils {
	
	private String flag;
	private String ssoId;
	private String ssoNo;
	private String goPage;
	public String getFlag() {
		return flag;
	}
	public String getSsoId() {
		return ssoId;
	}
	public String getSsoNo() {
		return ssoNo;
	}
	public String getGoPage() {
		return goPage;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public void setSsoId(String ssoId) {
		this.ssoId = ssoId;
	}
	public void setSsoNo(String ssoNo) {
		this.ssoNo = ssoNo;
	}
	public void setGoPage(String goPage) {
		this.goPage = goPage;
	}
	
}
