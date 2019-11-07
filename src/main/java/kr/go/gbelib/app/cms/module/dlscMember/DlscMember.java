package kr.go.gbelib.app.cms.module.dlscMember;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class DlscMember extends PagingUtils {

	private int dls_member_idx;  //DLS 인증 순번
	private String dls_id;  //DLS 아이디
	private String lib_id;  //도서관 아이디
	private String web_id;  //도서관 웹아이디
	private String user_name;  //성명
	private String user_ip;  //아이피
	private Date add_date;  //등록일
	
	public int getDls_member_idx() {
		return dls_member_idx;
	}
	
	public void setDls_member_idx(int dls_member_idx) {
		this.dls_member_idx = dls_member_idx;
	}
	
	public String getDls_id() {
		return dls_id;
	}
	
	public void setDls_id(String dls_id) {
		this.dls_id = dls_id;
	}
	
	public String getLib_id() {
		return lib_id;
	}
	
	public void setLib_id(String lib_id) {
		this.lib_id = lib_id;
	}
	
	public String getWeb_id() {
		return web_id;
	}
	
	public void setWeb_id(String web_id) {
		this.web_id = web_id;
	}
	
	public String getUser_name() {
		return user_name;
	}
	
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getUser_ip() {
		return user_ip;
	}
	
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	
	public Date getAdd_date() {
		return add_date;
	}
	
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	
}
