package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

public class UntactBookSetting {

	private String homepage_id;  		//홈페이지ID
	private String locker_use_yn;  		//사물함 사용여부
	private String locker_type;  		//가로, 세로 사물함 종류선택 
	private int row_count;  			//가로_갯수
	private int total_count; 			//총_갯수
	private int reservation_repeated_day;	//회차반복일
	private String reservation_repeated_time;	//회차반복시간
	private String reservation_time;	//예약가능시간
	private String loan_time;  //대출가능시간
	private String locker_use_type;		//사물함 타입
	private String terms;
	private String night_loan_yn;

	private String round_idx;  		//회차_idx
	
	private String reserve_start_hour;
	private String reserve_start_minute;
	private String reserve_end_hour;
	private String reserve_end_minute;

	private String loan_end_hour;
	private String loan_end_minute;

	private String repeated_start_hour;
	private String repeated_start_minute;
	
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
	public String getLocker_type() {
		return locker_type;
	}
	public void setLocker_type(String locker_type) {
		this.locker_type = locker_type;
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
	public int getReservation_repeated_day() {
		return reservation_repeated_day;
	}
	public void setReservation_repeated_day(int reservation_repeated_day) {
		this.reservation_repeated_day = reservation_repeated_day;
	}
	public String getReservation_time() {
		return reservation_time;
	}
	public void setReservation_time(String reservation_time) {
		this.reservation_time = reservation_time;
	}
	public String getLoan_time() {
		return loan_time;
	}
	public void setLoan_time(String loan_time) {
		this.loan_time = loan_time;
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
	public String getNight_loan_yn() {
		return night_loan_yn;
	}
	public void setNight_loan_yn(String night_loan_yn) {
		this.night_loan_yn = night_loan_yn;
	}
	public String getRound_idx() {
		return round_idx;
	}
	public void setRound_idx(String round_idx) {
		this.round_idx = round_idx;
	}
	public String getReserve_start_hour() {
		return reserve_start_hour;
	}
	public void setReserve_start_hour(String reserve_start_hour) {
		this.reserve_start_hour = reserve_start_hour;
	}
	public String getReserve_start_minute() {
		return reserve_start_minute;
	}
	public void setReserve_start_minute(String reserve_start_minute) {
		this.reserve_start_minute = reserve_start_minute;
	}
	public String getReserve_end_hour() {
		return reserve_end_hour;
	}
	public void setReserve_end_hour(String reserve_end_hour) {
		this.reserve_end_hour = reserve_end_hour;
	}
	public String getReserve_end_minute() {
		return reserve_end_minute;
	}
	public void setReserve_end_minute(String reserve_end_minute) {
		this.reserve_end_minute = reserve_end_minute;
	}
	public String getLoan_end_hour() {
		return loan_end_hour;
	}
	public void setLoan_end_hour(String loan_end_hour) {
		this.loan_end_hour = loan_end_hour;
	}
	public String getLoan_end_minute() {
		return loan_end_minute;
	}
	public void setLoan_end_minute(String loan_end_minute) {
		this.loan_end_minute = loan_end_minute;
	}
	public String getReservation_repeated_time() {
		return reservation_repeated_time;
	}
	public void setReservation_repeated_time(String reservation_repeated_time) {
		this.reservation_repeated_time = reservation_repeated_time;
	}
	public String getRepeated_start_hour() {
		return repeated_start_hour;
	}
	public void setRepeated_start_hour(String repeated_start_hour) {
		this.repeated_start_hour = repeated_start_hour;
	}
	public String getRepeated_start_minute() {
		return repeated_start_minute;
	}
	public void setRepeated_start_minute(String repeated_start_minute) {
		this.repeated_start_minute = repeated_start_minute;
	}
}