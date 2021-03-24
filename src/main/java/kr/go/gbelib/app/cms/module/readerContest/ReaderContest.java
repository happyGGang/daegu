package kr.go.gbelib.app.cms.module.readerContest;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ReaderContest extends PagingUtils {
	
	private String homepage_id;	//홈페이지ID
	private int reader_idx;	//다독자IDX
	private String participation_field;	//참가분야
	private String participation_type; // 참가타입
	private String user_name;	//신청자 이름
	private String user_date;	//신청자 생년월일
	private String user_phone;	//신청자 휴대폰
	private String protector_phone;	//보호자 휴대폰
	private String user_email;	//신청자 이메일
	private String postcode;	//우편번호
	private String address_base;	//기본주소
	private String address_detailed;	//상세주소
	private String approval_status = "0";	//승인상태
	private String delete_yn = "N";	//삭제여부
	private String add_id;	//등록ID
	private Date add_date;	//등록일
	private String modify_id;	//수정ID
	private Date modify_date;	//수정일
	private String delete_id;	//삭제ID

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getReader_idx() {
		return reader_idx;
	}

	public void setReader_idx(int reader_idx) {
		this.reader_idx = reader_idx;
	}

	public String getParticipation_field() {
		return participation_field;
	}

	public void setParticipation_field(String participation_field) {
		this.participation_field = participation_field;
	}
	
	public String getParticipation_type() {
		return participation_type;
	}
	
	public void setParticipation_type(String participation_type) {
		this.participation_type = participation_type;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_date() {
		return user_date;
	}

	public void setUser_date(String user_date) {
		this.user_date = user_date;
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

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getDelete_id() {
		return delete_id;
	}

	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}

}
