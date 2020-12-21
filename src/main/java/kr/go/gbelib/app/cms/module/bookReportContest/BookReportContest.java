package kr.go.gbelib.app.cms.module.bookReportContest;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookReportContest extends PagingUtils {
	
	private int book_report_idx;  //독후감IDX
	private String participation_field;  //참가분야
	private String user_name;  //성명
	private String school_name;  //학교명
	private String school_year;  //학년
	private String user_phone;  //휴대폰(본인)
	private String protector_phone;  //휴대폰(보호자)
	private String user_email;  //이메일
	private String postcode;  //우편번호
	private String address_base;  //기본주소
	private String address_detailed;  //상세주소
	private String org_file_name;  //원본파일명
	private String server_file_name;  //서버파일명
	private String file_extension;  //파일확장자
	private long file_size;  //파일크기
	private String org_file_name2;  //원본파일명2
	private String server_file_name2;  //서버파일명2
	private String file_extension2;  //파일확장자2
	private long file_size2;  //파일크기2
	private String approval_status = "0";  //신청상태
	private String delete_yn = "N";  //삭제여부
	private String add_id;  //등록ID
	private Date add_date;  //등록일
	private String delete_id;  //삭제ID
	
	public BookReportContest() {}
	
	public BookReportContest(String homepage_id, int book_report_idx) {
		setHomepage_id(homepage_id);
		this.book_report_idx = book_report_idx;
	}

	public int getBook_report_idx() {
		return book_report_idx;
	}

	public void setBook_report_idx(int book_report_idx) {
		this.book_report_idx = book_report_idx;
	}

	public String getParticipation_field() {
		return participation_field;
	}

	public void setParticipation_field(String participation_field) {
		this.participation_field = participation_field;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getSchool_year() {
		return school_year;
	}

	public void setSchool_year(String school_year) {
		this.school_year = school_year;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getProtector_phone() {
		return protector_phone;
	}

	public void setProtector_phone(String protector_phone) {
		this.protector_phone = protector_phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress_base() {
		return address_base;
	}

	public void setAddress_base(String address_base) {
		this.address_base = address_base;
	}

	public String getAddress_detailed() {
		return address_detailed;
	}

	public void setAddress_detailed(String address_detailed) {
		this.address_detailed = address_detailed;
	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getOrg_file_name2() {
		return org_file_name2;
	}

	public void setOrg_file_name2(String org_file_name2) {
		this.org_file_name2 = org_file_name2;
	}

	public String getServer_file_name2() {
		return server_file_name2;
	}

	public void setServer_file_name2(String server_file_name2) {
		this.server_file_name2 = server_file_name2;
	}

	public String getFile_extension2() {
		return file_extension2;
	}

	public void setFile_extension2(String file_extension2) {
		this.file_extension2 = file_extension2;
	}

	public long getFile_size2() {
		return file_size2;
	}

	public void setFile_size2(long file_size2) {
		this.file_size2 = file_size2;
	}

	public String getApproval_status() {
		return approval_status;
	}

	public void setApproval_status(String approval_status) {
		this.approval_status = approval_status;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getDelete_id() {
		return delete_id;
	}

	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}

}
