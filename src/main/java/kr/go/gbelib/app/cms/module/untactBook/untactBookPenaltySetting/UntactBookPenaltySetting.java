package kr.go.gbelib.app.cms.module.untactBook.untactBookPenaltySetting;

import kr.co.whalesoft.framework.utils.PagingUtils;


public class UntactBookPenaltySetting extends PagingUtils {

	private int penalty_idx;  //순번
	private String homepage_id;  //홈페이지ID
	private String start_date;  //시작기간
	private String end_date;  //종료기간
	private Integer penalty_count;  //페널티 횟수
	private Integer penalty_day;  //페널티 일수
	private String use_yn;  //사용여부
	private String save_date;  //수정일
	
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
	
	public Integer getPenalty_count() {
		return penalty_count;
	}
	
	public void setPenalty_count(Integer penalty_count) {
		this.penalty_count = penalty_count;
	}
	
	public Integer getPenalty_day() {
		return penalty_day;
	}
	
	public void setPenalty_day(Integer penalty_day) {
		this.penalty_day = penalty_day;
	}
	
	public String getUse_yn() {
		return use_yn;
	}
	
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	
	public String getSave_date() {
		return save_date;
	}
	
	public void setSave_date(String save_date) {
		this.save_date = save_date;
	}
	
	
}
