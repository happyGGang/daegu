package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

public class UntactBookSetting {

	private String homepage_id;  		//홈페이지ID
	private String locker_use_yn;  		//사물함 사용여부
	private String locker_type;  		//가로, 세로 사물함 종류선택 
	private int row_count;  			//가로_갯수
	private int total_count; 			//총_갯수
	private String round_start_date;	//회차시작일
	private String round_end_date;	//회차종료일
	private int reservation_repeated_day;	//회차반복일
	private String reservation_repeated_time;	//예약기준시간
	private String locker_use_type;		//사물함 타입
	private String terms;

	private String start_hour;
	private String start_minute;
	
	private String round_idx;  		//회차_idx
	
	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public String getLocker_use_yn() {
		return locker_use_yn;
	}
	
	public void setLocker_use_yn(String locker_use_yn) {
		this.locker_use_yn = locker_use_yn;
	}
	
	public int getRow_count() {
		return row_count;
	}
	
	public void setRow_count(int row_count) {
		this.row_count = row_count;
	}
	
	public int getTotal_count() {
		return total_count;
	}
	
	public void setTotal_count(int total_count) {
		this.total_count = total_count;
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
	
	public int getReservation_repeated_day() {
		return reservation_repeated_day;
	}
	
	public void setReservation_repeated_day(int reservation_repeated_day) {
		this.reservation_repeated_day = reservation_repeated_day;
	}
	
	public String getReservation_repeated_time() {
		return reservation_repeated_time;
	}
	
	public void setReservation_repeated_time(String reservation_repeated_time) {
		this.reservation_repeated_time = reservation_repeated_time;
	}
	
	public String getLocker_use_type() {
		return locker_use_type;
	}
	
	public void setLocker_use_type(String locker_use_type) {
		this.locker_use_type = locker_use_type;
	}
	
	public String getTerms() {
		return terms;
	}
	
	public void setTerms(String terms) {
		this.terms = terms;
	}

	public String getStart_hour() {
		return start_hour;
	}

	public void setStart_hour(String start_hour) {
		this.start_hour = start_hour;
	}

	public String getStart_minute() {
		return start_minute;
	}

	public void setStart_minute(String start_minute) {
		this.start_minute = start_minute;
	}

	public String getRound_idx() {
		return round_idx;
	}

	public void setRound_idx(String round_idx) {
		this.round_idx = round_idx;
	}

	public String getLocker_type() {
		return locker_type;
	}

	public void setLocker_type(String locker_type) {
		this.locker_type = locker_type;
	}
	
}