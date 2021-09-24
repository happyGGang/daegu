package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class UntactBookReservation extends PagingUtils {
	
	private String homepage_id;  //홈페이지ID
	private int locker_number;  //사물함번호
	private int request_number;  //신청번호
	private String member_id;  //신청자ID
	private String member_name;  //신청자명
	private String request_date;  //신청일
	private int locker_password;  //사물함비밀번호
	private String reservation_step;  //대출단계
	private String reg_no;  //대출번호
	private String book_regno;  //제어번호
	private String book_isbn;  //ISBN
	private String book_name;  //도서명
	private String loan_date;  //대출일
	private String reservation_yn;  //대출취소여부
	private String cancel_reason;  //대출취소사유
	
	public UntactBookReservation() {}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getLocker_number() {
		return locker_number;
	}
	public void setLocker_number(int locker_number) {
		this.locker_number = locker_number;
	}
	public int getRequest_number() {
		return request_number;
	}
	public void setRequest_number(int request_number) {
		this.request_number = request_number;
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
	public String getRequest_date() {
		return request_date;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public int getLocker_password() {
		return locker_password;
	}
	public void setLocker_password(int locker_password) {
		this.locker_password = locker_password;
	}
	public String getReservation_step() {
		return reservation_step;
	}
	public void setReservation_step(String reservation_step) {
		this.reservation_step = reservation_step;
	}
	public String getReg_no() {
		return reg_no;
	}
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}
	public String getBook_regno() {
		return book_regno;
	}
	public void setBook_regno(String book_regno) {
		this.book_regno = book_regno;
	}
	public String getBook_isbn() {
		return book_isbn;
	}
	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getLoan_date() {
		return loan_date;
	}
	public void setLoan_date(String loan_date) {
		this.loan_date = loan_date;
	}
	public String getReservation_yn() {
		return reservation_yn;
	}
	public void setReservation_yn(String reservation_yn) {
		this.reservation_yn = reservation_yn;
	}
	public String getCancel_reason() {
		return cancel_reason;
	}
	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}
	
	
}
