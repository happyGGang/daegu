package kr.go.gbelib.app.cms.module.donateBook;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class DonateBook extends PagingUtils {

	private int donate_idx;  //기증도서IDX
	private String name;  //기증자명
	private String phone;  //전화번호
	private String phone1;  //휴대폰
	private String phone2;  //휴대폰
	private String phone3;  //휴대폰
	private String cell_phone;  //폰번호
	private String cell_phone1;  //휴대폰
	private String cell_phone2;  //휴대폰
	private String cell_phone3;  //휴대폰
	private String donate_book;  //기증도서정보
	private int donate_count;  //기증권수
	private String donate_method;  //기증방법
	private String donate_yn = "Y";  //기증처리동의여부
	private String add_date; // 등록일
	private String donate_year; //기증년
	private String donate_month; //기증월
	private String masking_name;
	
	private String self_info_yn;
	
	public int getDonate_idx() {
		return donate_idx;
	}
	public void setDonate_idx(int donate_idx) {
		this.donate_idx = donate_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		String[] list = phone.split("-");
		this.phone1 = list[0];
		if ( list.length > 1 ) {
			this.phone2 = list[1];
		}
		if ( list.length > 2 ) {
			this.phone3 = list[2];
		}
		this.phone = phone;
	}
	public String getCell_phone() {
		return cell_phone;
	}
	public void setCell_phone(String cell_phone) {
		String[] list = cell_phone.split("-");
		this.cell_phone1 = list[0];
		if ( list.length > 1 ) {
			this.cell_phone2 = list[1];
		}
		if ( list.length > 2 ) {
			this.cell_phone3 = list[2];
		}
		this.cell_phone = cell_phone;
	}
	public String getDonate_book() {
		return donate_book;
	}
	public void setDonate_book(String donate_book) {
		this.donate_book = donate_book;
	}
	public String getDonate_method() {
		return donate_method;
	}
	public void setDonate_method(String donate_method) {
		this.donate_method = donate_method;
	}
	public String getDonate_yn() {
		return donate_yn;
	}
	public void setDonate_yn(String donate_yn) {
		this.donate_yn = donate_yn;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getCell_phone1() {
		return cell_phone1;
	}
	public void setCell_phone1(String cell_phone1) {
		this.cell_phone1 = cell_phone1;
	}
	public String getCell_phone2() {
		return cell_phone2;
	}
	public void setCell_phone2(String cell_phone2) {
		this.cell_phone2 = cell_phone2;
	}
	public String getCell_phone3() {
		return cell_phone3;
	}
	public void setCell_phone3(String cell_phone3) {
		this.cell_phone3 = cell_phone3;
	}
	public int getDonate_count() {
		return donate_count;
	}
	public void setDonate_count(int donate_count) {
		this.donate_count = donate_count;
	}
	public String getDonate_year() {
		return donate_year;
	}
	public void setDonate_year(String donate_year) {
		this.donate_year = donate_year;
	}
	public String getDonate_month() {
		return donate_month;
	}
	public void setDonate_month(String donate_month) {
		this.donate_month = donate_month;
	}
	public String getMasking_name() {
		return masking_name;
	}
	public void setMasking_name(String masking_name) {
		this.masking_name = masking_name;
	}
	public String getSelf_info_yn() {
		return self_info_yn;
	}
	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
	}
}