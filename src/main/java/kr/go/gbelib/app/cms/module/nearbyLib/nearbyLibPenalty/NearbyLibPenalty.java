package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibPenalty;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class NearbyLibPenalty extends PagingUtils {
	
	//페널티세팅
	private int penalty_setting_idx;     //페널티세팅IDX
	private int penalty_standard_count;  //페널티횟수기준
	private int penalty_period;          //페널티기간
	private String use_yn; 		         //페널티사용유무
	
	//페널티 회원정보
	private String manage_code;          //홈페이지관리코드
	private int penalty_idx;             //페널티IDX
	private int[] penalty_idx_arr;       //페널티IDX_ARR
	private int penalty_count; 		     //예약위반횟수
	private String penalty_member_id;    //페널티위반아이디
	private String penalty_reason;       //페널티사유
	private String penalty_delete_yn;    //페널티초기화유무
	private String penalty_date;         //페널티위반시간
	
	//공통
	private String homepage_id;          //홈페이지ID
	private String penalty_add_id;       //페널티등록ID
	private String penalty_add_ip;       //페널티등록IP
	private String penalty_add_date;     //페널티등록시간
	private String penalty_modify_id;    //페널티수정ID
	private String penalty_modify_ip;    //페널티수정IP
	private String penalty_modify_date;  //페널티수정시간
	
	//검색용변수
	private String search_start_date;    //검색시작일
	private String search_end_date;      //검색종료일
	private String homepage_name; 		 //도서관명
	
	public int getPenalty_setting_idx() {
		return penalty_setting_idx;
	}
	public void setPenalty_setting_idx(int penalty_setting_idx) {
		this.penalty_setting_idx = penalty_setting_idx;
	}
	public int getPenalty_standard_count() {
		return penalty_standard_count;
	}
	public void setPenalty_standard_count(int penalty_standard_count) {
		this.penalty_standard_count = penalty_standard_count;
	}
	public int getPenalty_period() {
		return penalty_period;
	}
	public void setPenalty_period(int penalty_period) {
		this.penalty_period = penalty_period;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getPenalty_idx() {
		return penalty_idx;
	}
	public void setPenalty_idx(int penalty_idx) {
		this.penalty_idx = penalty_idx;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getManage_code() {
		return manage_code;
	}
	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public int getPenalty_count() {
		return penalty_count;
	}
	public void setPenalty_count(int penalty_count) {
		this.penalty_count = penalty_count;
	}
	public String getPenalty_member_id() {
		return penalty_member_id;
	}
	public void setPenalty_member_id(String penalty_member_id) {
		this.penalty_member_id = penalty_member_id;
	}
	public String getPenalty_reason() {
		return penalty_reason;
	}
	public void setPenalty_reason(String penalty_reason) {
		this.penalty_reason = penalty_reason;
	}
	public String getPenalty_delete_yn() {
		return penalty_delete_yn;
	}
	public void setPenalty_delete_yn(String penalty_delete_yn) {
		this.penalty_delete_yn = penalty_delete_yn;
	}
	public String getPenalty_add_id() {
		return penalty_add_id;
	}
	public void setPenalty_add_id(String penalty_add_id) {
		this.penalty_add_id = penalty_add_id;
	}
	public String getPenalty_add_ip() {
		return penalty_add_ip;
	}
	public void setPenalty_add_ip(String penalty_add_ip) {
		this.penalty_add_ip = penalty_add_ip;
	}
	public String getPenalty_add_date() {
		return penalty_add_date;
	}
	public void setPenalty_add_date(String penalty_add_date) {
		this.penalty_add_date = penalty_add_date;
	}
	public String getPenalty_modify_id() {
		return penalty_modify_id;
	}
	public void setPenalty_modify_id(String penalty_modify_id) {
		this.penalty_modify_id = penalty_modify_id;
	}
	public String getPenalty_modify_ip() {
		return penalty_modify_ip;
	}
	public void setPenalty_modify_ip(String penalty_modify_ip) {
		this.penalty_modify_ip = penalty_modify_ip;
	}
	public String getPenalty_modify_date() {
		return penalty_modify_date;
	}
	public void setPenalty_modify_date(String penalty_modify_date) {
		this.penalty_modify_date = penalty_modify_date;
	}
	public String getPenalty_date() {
		return penalty_date;
	}
	public void setPenalty_date(String penalty_date) {
		this.penalty_date = penalty_date;
	}
	public int[] getPenalty_idx_arr() {
		return penalty_idx_arr;
	}
	public void setPenalty_idx_arr(int[] penalty_idx_arr) {
		this.penalty_idx_arr = penalty_idx_arr;
	}
	public String getSearch_start_date() {
		return search_start_date;
	}
	public void setSearch_start_date(String search_start_date) {
		this.search_start_date = search_start_date;
	}
	public String getSearch_end_date() {
		return search_end_date;
	}
	public void setSearch_end_date(String search_end_date) {
		this.search_end_date = search_end_date;
	}
}
