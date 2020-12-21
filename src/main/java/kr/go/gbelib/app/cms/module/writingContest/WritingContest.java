package kr.go.gbelib.app.cms.module.writingContest;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class WritingContest extends PagingUtils {
	
	private int writing_idx;  //백일장IDX
	private String participation_field;  //참가분야
	private String writing_type;  //종류
	private String user_name;  //성명
	private String school_name;  //학교명
	private String school_year;  //학년
	private String user_phone;  //휴대폰(본인)
	private String protector_phone;  //휴대폰(보호자)
	private String user_email;  //이메일
	private String postcode;  //우편번호
	private String address_base;  //기본주소
	private String address_detailed;  //상세주소
	private String approval_status = "0";  //신청상태
	private String delete_yn = "N";  //삭제여부
	private String add_id;  //등록ID
	private Date add_date;  //등록일
	private String delete_id;  //삭제ID

	public int getWriting_idx() {
		return writing_idx;
	}

	public void setWriting_idx(int writing_idx) {
		this.writing_idx = writing_idx;
	}

	public String getParticipation_field() {
		return participation_field;
	}

	public void setParticipation_field(String participation_field) {
		this.participation_field = participation_field;
	}

	public String getWriting_type() {
		return writing_type;
	}

	public void setWriting_type(String writing_type) {
		this.writing_type = writing_type;
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
