package kr.go.gbelib.app.cms.module.marathon;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Marathon extends PagingUtils{
	
	private String homepage_id; //홈페이지ID
	private int contest_idx; //대회번호
	private String contest_name; //대회이름
	private String application_start_day; //접수시작일자
	private String application_end_day; //접수종료일자
	private String contest_start_day; //대회시작일자
	private String contest_end_day; //대회종료일자
	private char use_yn; //사용여부
	private Date add_date; //등록일자
	private String add_id; //등록인
	private Date modify_date; //수정일자
	private Date modify_id; //수정인
	private String del_yn = "N"; //삭제 여부

	public Marathon() {}

	public Marathon(String homepage_id, int contest_idx) {
		this.homepage_id = homepage_id;
		this.contest_idx = contest_idx;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getContest_idx() {
		return contest_idx;
	}
	public void setContest_idx(int contest_idx) {
		this.contest_idx = contest_idx;
	}
	public String getContest_name() {
		return contest_name;
	}
	public void setContest_name(String contest_name) {
		this.contest_name = contest_name;
	}
	public String getApplication_start_day() {
		return application_start_day;
	}
	public void setApplication_start_day(String application_start_day) {
		this.application_start_day = application_start_day;
	}
	public String getApplication_end_day() {
		return application_end_day;
	}
	public void setApplication_end_day(String application_end_day) {
		this.application_end_day = application_end_day;
	}
	public String getContest_start_day() {
		return contest_start_day;
	}
	public void setContest_start_day(String contest_start_day) {
		this.contest_start_day = contest_start_day;
	}
	public String getContest_end_day() {
		return contest_end_day;
	}
	public void setContest_end_day(String contest_end_day) {
		this.contest_end_day = contest_end_day;
	}
	public char getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(char use_yn) {
		this.use_yn = use_yn;
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
	public Date getModify_id() {
		return modify_id;
	}
	public void setModify_id(Date modify_id) {
		this.modify_id = modify_id;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
}
