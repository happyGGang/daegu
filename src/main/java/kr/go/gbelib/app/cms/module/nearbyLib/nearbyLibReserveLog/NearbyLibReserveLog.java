package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveLog;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author ttkaz
 * 2022. 11. 25.
 *
 */
public class NearbyLibReserveLog extends PagingUtils{
	
	private String homepage_id; //홈페이지ID
	private int log_idx; //로그idx
	private int reserve_idx; //예약idx
	private int reserve_bundle_idx; //건당묶음예약지표
	private int device_idx; //장비idx
	private String device_name; //장비명
	private String pk; //KLAS예약key
	private String book_key; //KLAS책key
	private String reg_no; //도서등록번호
	private String book_isbn; //isbn
	private String book_name; //도서명
	private String lib_name; //소장돗관명
	private String member_id; //회원id
	private String member_name; //회원명
	private String user_key; //회원key
	private String applicant_cell_phone; //신청자 전화번호
	private String work_id; //업데이트id
	private String work_status; //업데이트 상태
	private String work_ip; //업데이트ip
	private String work_date; //업데이트날짜
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getLog_idx() {
		return log_idx;
	}
	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public int getReserve_bundle_idx() {
		return reserve_bundle_idx;
	}
	public void setReserve_bundle_idx(int reserve_bundle_idx) {
		this.reserve_bundle_idx = reserve_bundle_idx;
	}
	public int getDevice_idx() {
		return device_idx;
	}
	public void setDevice_idx(int device_idx) {
		this.device_idx = device_idx;
	}
	public String getDevice_name() {
		return device_name;
	}
	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	public String getPk() {
		return pk;
	}
	public void setPk(String pk) {
		this.pk = pk;
	}
	public String getBook_key() {
		return book_key;
	}
	public void setBook_key(String book_key) {
		this.book_key = book_key;
	}
	public String getReg_no() {
		return reg_no;
	}
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
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
	public String getLib_name() {
		return lib_name;
	}
	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
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
	public String getUser_key() {
		return user_key;
	}
	public void setUser_key(String user_key) {
		this.user_key = user_key;
	}
	public String getApplicant_cell_phone() {
		return applicant_cell_phone;
	}
	public void setApplicant_cell_phone(String applicant_cell_phone) {
		this.applicant_cell_phone = applicant_cell_phone;
	}
	public String getWork_id() {
		return work_id;
	}
	public void setWork_id(String work_id) {
		this.work_id = work_id;
	}
	public String getWork_status() {
		return work_status;
	}
	public void setWork_status(String work_status) {
		this.work_status = work_status;
	}
	public String getWork_ip() {
		return work_ip;
	}
	public void setWork_ip(String work_ip) {
		this.work_ip = work_ip;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	
}
