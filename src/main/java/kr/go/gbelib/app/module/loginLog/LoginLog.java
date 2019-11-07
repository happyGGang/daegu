package kr.go.gbelib.app.module.loginLog;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class LoginLog extends PagingUtils {

	private long idx;
	private String login_type;
	private String member_id;
	private String homepage_id;
	private String login_date;
	private String user_agent;
	private String ip;
	private String homepage_name;
	private String browser;
	private String os;
	private String category;
	private String search_sdt;
	private String search_edt;
	
	public LoginLog() { }
	
	public LoginLog(Member member, HttpServletRequest request, Homepage homepage) {
		if(member == null) return;
		
		this.homepage_id = member.getHomepage_id();
		this.member_id = member.getMember_id();
		this.login_type = member.getLoginType();
		this.ip = request.getRemoteAddr();
		this.user_agent = request.getHeader("user-agent");
		this.homepage_id = homepage.getHomepage_id();
	}

	public LoginLog(Member member, HttpServletRequest request, String login_type) {
		if(member == null) return;
		
		this.homepage_id = member.getHomepage_id();
		this.member_id = member.getMember_id();
		this.login_type = member.getLoginType();
		this.ip = request.getRemoteAddr();
		this.user_agent = request.getHeader("user-agent");
		this.login_type = login_type;
	}
	
	public long getIdx() {
		return idx;
	}
	public void setIdx(long idx) {
		this.idx = idx;
	}
	public String getLogin_type() {
		return login_type;
	}
	public void setLogin_type(String login_type) {
		this.login_type = login_type;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getLogin_date() {
		return login_date;
	}
	public void setLogin_date(String login_date) {
		this.login_date = login_date;
	}
	public String getUser_agent() {
		return user_agent;
	}
	public void setUser_agent(String user_agent) {
		this.user_agent = user_agent;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}
	public String getOs() {
		return os;
	}
	public void setOs(String os) {
		this.os = os;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSearch_sdt() {
		return search_sdt;
	}
	public void setSearch_sdt(String search_sdt) {
		this.search_sdt = search_sdt;
	}
	public String getSearch_edt() {
		return search_edt;
	}
	public void setSearch_edt(String search_edt) {
		this.search_edt = search_edt;
	}
	
}
