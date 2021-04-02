package kr.go.gbelib.app.cms.module.bookRelayIndividual;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookRelayIndividual extends PagingUtils {
	
	private String homepage_id;	//홈페이지ID
	private int individual_idx;	//개인IDX 
	private String user_name;	//신청자 이름
	private String user_phone;	//신청자 휴대폰
	private String user_email;	//신청자 이메일
	private String user_affiliation;	//소속명(학교 또는 직장명)
	private String postcode;	//우편번호
	private String address_base;	//기본주소
	private String address_detailed;	//상세주소
	private String book_area;	//도서 영역
	private int book_quantity;	//독서노트 신청수량
	private String reader_contest;	//다독자 공모
	private String relay_plan;	//릴레이 계획
	private int relay_personnel;	//릴레이 예상인원
	private String receive_lib; // 수령도서관
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

	public int getIndividual_idx() {
		return individual_idx;
	}

	public void setIndividual_idx(int individual_idx) {
		this.individual_idx = individual_idx;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_affiliation() {
		return user_affiliation;
	}

	public void setUser_affiliation(String user_affiliation) {
		this.user_affiliation = user_affiliation;
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

	public String getBook_area() {
		return book_area;
	}

	public void setBook_area(String book_area) {
		this.book_area = book_area;
	}

	public int getBook_quantity() {
		return book_quantity;
	}

	public void setBook_quantity(int book_quantity) {
		this.book_quantity = book_quantity;
	}

	public String getReader_contest() {
		return reader_contest;
	}

	public void setReader_contest(String reader_contest) {
		this.reader_contest = reader_contest;
	}

	public String getRelay_plan() {
		return relay_plan;
	}

	public void setRelay_plan(String relay_plan) {
		this.relay_plan = relay_plan;
	}

	public int getRelay_personnel() {
		return relay_personnel;
	}

	public void setRelay_personnel(int relay_personnel) {
		this.relay_personnel = relay_personnel;
	}
	
	public String getReceive_lib() {
		return receive_lib;
	}
	
	public void setReceive_lib(String receive_lib) {
		this.receive_lib = receive_lib;
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
