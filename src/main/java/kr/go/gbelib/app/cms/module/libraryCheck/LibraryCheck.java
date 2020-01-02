package kr.go.gbelib.app.cms.module.libraryCheck;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LibraryCheck extends PagingUtils {

	private int library_check_idx; // 장서점검기IDX
	private int[] library_check_arr;
	private String library_check_name; // 등록자이름
	private int library_check_number = -1; // 장서점검기 번호
	private String content; // 내용
	private String loan_status; // 대출상태
	private String org_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기

	private int lender_count; // 대출자 수
	// private string loan_

	private MultipartFile mfile; // 파일

	private int library_check_loan_idx; // 장서점검기 대출IDX
	private int[] library_check_loan_arr;
	private String loan_start_date; // 대출시작기간
	private String loan_end_date; // 대출종료기간
	private String hope_date; // 방문희망일자
	private String school_name; // 학교명
	private String request_name; // 신청자명
	private String phone; // 연락처
	private String phone_1;
	private String phone_2;
	private String phone_3;
	private String school_tel; // 학교연락처
	private String school_tel_1;
	private String school_tel_2;
	private String school_tel_3;
	private String request_status; // 진행상태

	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	public int getLibrary_check_idx() {
		return library_check_idx;
	}

	public void setLibrary_check_idx(int library_check_idx) {
		this.library_check_idx = library_check_idx;
	}

	public int[] getLibrary_check_arr() {
		return library_check_arr;
	}

	public void setLibrary_check_arr(int[] library_check_arr) {
		this.library_check_arr = library_check_arr;
	}

	public String getLibrary_check_name() {
		return library_check_name;
	}

	public void setLibrary_check_name(String library_check_name) {
		this.library_check_name = library_check_name;
	}

	public int getLibrary_check_number() {
		return library_check_number;
	}

	public void setLibrary_check_number(int library_check_number) {
		this.library_check_number = library_check_number;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLoan_status() {
		return loan_status;
	}

	public void setLoan_status(String loan_status) {
		this.loan_status = loan_status;
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

	public int getLender_count() {
		return lender_count;
	}

	public void setLender_count(int lender_count) {
		this.lender_count = lender_count;
	}

	public MultipartFile getMfile() {
		return mfile;
	}

	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}

	public int getLibrary_check_loan_idx() {
		return library_check_loan_idx;
	}

	public void setLibrary_check_loan_idx(int library_check_loan_idx) {
		this.library_check_loan_idx = library_check_loan_idx;
	}

	public int[] getLibrary_check_loan_arr() {
		return library_check_loan_arr;
	}

	public void setLibrary_check_loan_arr(int[] library_check_loan_arr) {
		this.library_check_loan_arr = library_check_loan_arr;
	}

	public String getLoan_start_date() {
		return loan_start_date;
	}

	public void setLoan_start_date(String loan_start_date) {
		this.loan_start_date = loan_start_date;
	}

	public String getLoan_end_date() {
		return loan_end_date;
	}

	public void setLoan_end_date(String loan_end_date) {
		this.loan_end_date = loan_end_date;
	}

	public String getHope_date() {
		return hope_date;
	}

	public void setHope_date(String hope_date) {
		this.hope_date = hope_date;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getRequest_name() {
		return request_name;
	}

	public void setRequest_name(String request_name) {
		this.request_name = request_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone_1() {
		return phone_1;
	}

	public void setPhone_1(String phone_1) {
		this.phone_1 = phone_1;
	}

	public String getPhone_2() {
		return phone_2;
	}

	public void setPhone_2(String phone_2) {
		this.phone_2 = phone_2;
	}

	public String getPhone_3() {
		return phone_3;
	}

	public void setPhone_3(String phone_3) {
		this.phone_3 = phone_3;
	}

	public String getSchool_tel() {
		return school_tel;
	}

	public void setSchool_tel(String school_tel) {
		this.school_tel = school_tel;
	}

	public String getSchool_tel_1() {
		return school_tel_1;
	}

	public void setSchool_tel_1(String school_tel_1) {
		this.school_tel_1 = school_tel_1;
	}

	public String getSchool_tel_2() {
		return school_tel_2;
	}

	public void setSchool_tel_2(String school_tel_2) {
		this.school_tel_2 = school_tel_2;
	}

	public String getSchool_tel_3() {
		return school_tel_3;
	}

	public void setSchool_tel_3(String school_tel_3) {
		this.school_tel_3 = school_tel_3;
	}

	public String getRequest_status() {
		return request_status;
	}

	public void setRequest_status(String request_status) {
		this.request_status = request_status;
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

}
