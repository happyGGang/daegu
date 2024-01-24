package kr.go.gbelib.app.cms.module.bookDelivery;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookDelivery extends PagingUtils {

	private int book_delivery_idx;  //IDX
	private int[] book_delivery_arr;
	private String request_date;  //발송요청일
	private String subject;  //주제
	private String book_package_name;  //책꾸러미명
	private String loan_date;  //대출기간
	private String loan_date1;  //대출기간
	private String loan_date2;  //대출기간
	private String school_name;  //학교명
	private String member_name;  //신청자
	private String phone;  //휴대폰
	private String address;  //주소
	private String return_plan_place;  //수령및반납장소
	private String school_phone;  //학교연락처
	private int book_count;  //권수
	private String return_plan_date;  //반송요청일
	private String status;  //상태
	
	public int getBook_delivery_idx() {
		return book_delivery_idx;
	}
	public void setBook_delivery_idx(int book_delivery_idx) {
		this.book_delivery_idx = book_delivery_idx;
	}
	public String getRequest_date() {
		return request_date;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getBook_package_name() {
		return book_package_name;
	}
	public void setBook_package_name(String book_package_name) {
		this.book_package_name = book_package_name;
	}
	public String getLoan_date() {
		return loan_date;
	}
	public void setLoan_date(String loan_date) {
		this.loan_date = loan_date;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getReturn_plan_place() {
		return return_plan_place;
	}
	public void setReturn_plan_place(String return_plan_place) {
		this.return_plan_place = return_plan_place;
	}
	public String getSchool_phone() {
		return school_phone;
	}
	public void setSchool_phone(String school_phone) {
		this.school_phone = school_phone;
	}
	public int getBook_count() {
		return book_count;
	}
	public void setBook_count(int book_count) {
		this.book_count = book_count;
	}
	public String getReturn_plan_date() {
		return return_plan_date;
	}
	public void setReturn_plan_date(String return_plan_date) {
		this.return_plan_date = return_plan_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int[] getBook_delivery_arr() {
		return book_delivery_arr;
	}
	public void setBook_delivery_arr(int[] book_delivery_arr) {
		this.book_delivery_arr = book_delivery_arr;
	}
	public String getLoan_date1() {
		return loan_date1;
	}
	public void setLoan_date1(String loan_date1) {
		this.loan_date1 = loan_date1;
	}
	public String getLoan_date2() {
		return loan_date2;
	}
	public void setLoan_date2(String loan_date2) {
		this.loan_date2 = loan_date2;
	}
	
}
