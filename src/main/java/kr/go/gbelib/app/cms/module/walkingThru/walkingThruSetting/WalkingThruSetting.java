package kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class WalkingThruSetting extends PagingUtils {
	
	private String homepage_id;  //홈페이지ID
	private String password_yn;  //비밀번호사용여부
	private String reservation_time;  //예약가능시간
	private String loan_time;  //대출가능시간
	private String loan_time_choice;  //대출가능시간선택
	private String terms;  //사용이용약관
	
	private String reserve_start_hour;
	private String reserve_start_minute;
	private String reserve_end_hour;
	private String reserve_end_minute;

	private String loan_start_hour;
	private String loan_start_minute;
	private String loan_end_hour;
	private String loan_end_minute;
	
	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public String getPassword_yn() {
		return password_yn;
	}
	
	public void setPassword_yn(String password_yn) {
		this.password_yn = password_yn;
	}
	
	public String getReservation_time() {
		return reservation_time;
	}
	
	public void setReservation_time(String reservation_time) {
		this.reservation_time = reservation_time;
	}
	
	public String getLoan_time_choice() {
		return loan_time_choice;
	}
	
	public void setLoan_time_choice(String loan_time_choice) {
		this.loan_time_choice = loan_time_choice;
	}
	
	public String getTerms() {
		return terms;
	}
	
	public void setTerms(String terms) {
		this.terms = terms;
	}

	public String getLoan_time() {
		return loan_time;
	}

	public void setLoan_time(String loan_time) {
		this.loan_time = loan_time;
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

	public String getLoan_start_hour() {
		return loan_start_hour;
	}

	public void setLoan_start_hour(String loan_start_hour) {
		this.loan_start_hour = loan_start_hour;
	}

	public String getLoan_start_minute() {
		return loan_start_minute;
	}

	public void setLoan_start_minute(String loan_start_minute) {
		this.loan_start_minute = loan_start_minute;
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
	
}
