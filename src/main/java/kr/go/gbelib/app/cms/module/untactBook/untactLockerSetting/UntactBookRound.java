package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

public class UntactBookRound {

	private String round_idx;  		//회차_idx
	private String homepage_id;  		//홈페이지ID
	private String round_start_date;	//회차시작일
	private String round_end_date;	//회차종료일
	private String round_start_time;	//회차시작시간
	private String round_end_time;	//회차종료시간
	
	private String manage_code;
	
	public String getRound_idx() {
		return round_idx;
	}
	
	public void setRound_idx(String round_idx) {
		this.round_idx = round_idx;
	}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public String getRound_start_date() {
		return round_start_date;
	}

	public void setRound_start_date(String round_start_date) {
		this.round_start_date = round_start_date;
	}

	public String getRound_end_date() {
		return round_end_date;
	}

	public void setRound_end_date(String round_end_date) {
		this.round_end_date = round_end_date;
	}

	public String getRound_start_time() {
		return round_start_time;
	}

	public void setRound_start_time(String round_start_time) {
		this.round_start_time = round_start_time;
	}

	public String getRound_end_time() {
		return round_end_time;
	}

	public void setRound_end_time(String round_end_time) {
		this.round_end_time = round_end_time;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	
}