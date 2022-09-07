package kr.go.gbelib.app.cms.module.bookReportClub;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookReportClub extends PagingUtils {
	
	private int book_club_idx;  //독서동아리IDX
	private String participation_field;  //참가분야
	private String club_name;  //동아리명
	private String rep_name;  //대표자명
	private String user_phone;  //휴대폰(제1 연락처)
	private String user_phone2;  //휴대폰(제2 연락처)
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
	private String org_file_name3;  //원본파일명3
	private String server_file_name3;  //서버파일명3
	private String file_extension3;  //파일확장자3
	private long file_size3;  //파일크기3
	private String approval_status = "0";  //신청상태
	private String delete_yn = "N";  //삭제여부
	private String add_id;  //등록ID
	private Date add_date;  //등록일
	private String delete_id;  //삭제ID
	
	public BookReportClub() {}
	
	public BookReportClub(String homepage_id, int book_club_idx) {
		setHomepage_id(homepage_id);
		this.book_club_idx = book_club_idx;
	}

	public int getBook_club_idx() {
		return book_club_idx;
	}

	public void setBook_club_idx(int book_club_idx) {
		this.book_club_idx = book_club_idx;
	}

	public String getParticipation_field() {
		return participation_field;
	}

	public void setParticipation_field(String participation_field) {
		this.participation_field = participation_field;
	}

	public String getClub_name() {
		return club_name;
	}

	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}

	public String getRep_name() {
		return rep_name;
	}

	public void setRep_name(String rep_name) {
		this.rep_name = rep_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_phone2() {
		return user_phone2;
	}

	public void setUser_phone2(String user_phone2) {
		this.user_phone2 = user_phone2;
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

	public String getOrg_file_name3() {
		return org_file_name3;
	}

	public void setOrg_file_name3(String org_file_name3) {
		this.org_file_name3 = org_file_name3;
	}

	public String getServer_file_name3() {
		return server_file_name3;
	}

	public void setServer_file_name3(String server_file_name3) {
		this.server_file_name3 = server_file_name3;
	}

	public String getFile_extension3() {
		return file_extension3;
	}

	public void setFile_extension3(String file_extension3) {
		this.file_extension3 = file_extension3;
	}

	public long getFile_size3() {
		return file_size3;
	}

	public void setFile_size3(long file_size3) {
		this.file_size3 = file_size3;
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
