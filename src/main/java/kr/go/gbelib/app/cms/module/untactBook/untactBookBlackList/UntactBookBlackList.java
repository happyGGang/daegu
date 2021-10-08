package kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class UntactBookBlackList extends PagingUtils {

	private String homepage_id;  //홈페이지ID
	private String member_id;  //사용자ID
	private String member_name;  //사용자명
	private String penalty_reason;  //사유
	private String penalty_day;  //등록일
	private String penalty_register_ip;  //등록IP
	private String penalty_register_id;  //등록ID
	
	private String start_date;
	private String end_date;
	
	private String[] member_id_arr; //사용자ID_arr
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
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
	public String getPenalty_reason() {
		return penalty_reason;
	}
	public void setPenalty_reason(String penalty_reason) {
		this.penalty_reason = penalty_reason;
	}
	public String getPenalty_day() {
		return penalty_day;
	}
	public void setPenalty_day(String penalty_day) {
		this.penalty_day = penalty_day;
	}
	public String getPenalty_register_ip() {
		return penalty_register_ip;
	}
	public void setPenalty_register_ip(String penalty_register_ip) {
		this.penalty_register_ip = penalty_register_ip;
	}
	public String getPenalty_register_id() {
		return penalty_register_id;
	}
	public void setPenalty_register_id(String penalty_register_id) {
		this.penalty_register_id = penalty_register_id;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String[] getMember_id_arr() {
		return member_id_arr;
	}
	public void setMember_id_arr(String[] member_id_arr) {
		this.member_id_arr = member_id_arr;
	}
	
}