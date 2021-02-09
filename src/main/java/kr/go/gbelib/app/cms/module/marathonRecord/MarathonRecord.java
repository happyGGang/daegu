package kr.go.gbelib.app.cms.module.marathonRecord;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MarathonRecord extends PagingUtils{
	private String homepage_id; //홈페이지 ID
	private int contest_idx; //대회번호
	private int contest_type_idx; //대회종목번호
	private int applicant_idx; //신청자 번호
	private int record_idx; //일지 번호
	private int[] record_idx_arr; //일지 번호 배열(등록, 수정용)
	private String member_id; //회원 ID
	private String member_name; //회원명
	private String book_name; //도서명
	private int read_page_count; //읽은 쪽수
	private String book_resources; //대출/구입처
	private String book_get_date; //대출/구입 날짜
	private String book_type; //분류번호
	private String book_author; //저자
	private String publisher; //출판사
	private String call_no; //청구기호
	private String reg_no; //등록번호
	private String book_journals; //독서감상문
	private Date record_date; //일지등록일자
	private Date modify_date; //수정일자
	private String modify_id; //수정인
	private int read_page_count_beforeChange; //읽은 쪽수(수정할 때 사용자 누적 쪽수 변경용)
	private int[] read_page_count_arr; //읽은 쪽수 배열 (삭제할 때 사용자 누적 쪽수 변경용)
	private String loan_choice = "N"; //대출 내역 선택 여부
	
	private int contest_type_idx_modify;
	private int applicant_idx_modify;
	
	public MarathonRecord() {}
	
	public MarathonRecord(String homepage_id, int contest_idx, int contest_type_idx, int applicant_idx) {
		this.homepage_id = homepage_id;
		this.contest_idx = contest_idx;
		this.contest_type_idx = contest_type_idx;
		this.applicant_idx = applicant_idx;
	}

	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getContest_idx() {
		return contest_idx;
	}
	public void setContest_idx(int contest_idx) {
		this.contest_idx = contest_idx;
	}
	public int getContest_type_idx() {
		return contest_type_idx;
	}
	public void setContest_type_idx(int contest_type_idx) {
		this.contest_type_idx = contest_type_idx;
	}
	public int getApplicant_idx() {
		return applicant_idx;
	}
	public void setApplicant_idx(int applicant_idx) {
		this.applicant_idx = applicant_idx;
	}
	public int getRecord_idx() {
		return record_idx;
	}
	public void setRecord_idx(int record_idx) {
		this.record_idx = record_idx;
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
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public int getRead_page_count() {
		return read_page_count;
	}
	public void setRead_page_count(int read_page_count) {
		this.read_page_count = read_page_count;
	}
	public String getBook_resources() {
		return book_resources;
	}
	public void setBook_resources(String book_resources) {
		this.book_resources = book_resources;
	}
	public String getBook_get_date() {
		return book_get_date;
	}
	public void setBook_get_date(String book_get_date) {
		this.book_get_date = book_get_date;
	}
	public String getBook_type() {
		return book_type;
	}
	public void setBook_type(String book_type) {
		this.book_type = book_type;
	}
	public String getBook_author() {
		return book_author;
	}
	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getCall_no() {
		return call_no;
	}
	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}
	public String getReg_no() {
		return reg_no;
	}
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}
	public String getBook_journals() {
		return book_journals;
	}
	public void setBook_journals(String book_journals) {
		this.book_journals = book_journals;
	}
	public Date getRecord_date() {
		return record_date;
	}
	public void setRecord_date(Date record_date) {
		this.record_date = record_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public int[] getRecord_idx_arr() {
		return record_idx_arr;
	}
	public void setRecord_idx_arr(int[] record_idx_arr) {
		this.record_idx_arr = record_idx_arr;
	}
	public int getRead_page_count_beforeChange() {
		return read_page_count_beforeChange;
	}
	public void setRead_page_count_beforeChange(int read_page_count_beforeChange) {
		this.read_page_count_beforeChange = read_page_count_beforeChange;
	}
	public int[] getRead_page_count_arr() {
		return read_page_count_arr;
	}
	public void setRead_page_count_arr(int[] read_page_count_arr) {
		this.read_page_count_arr = read_page_count_arr;
	}
	public String getLoan_choice() {
		return loan_choice;
	}
	public void setLoan_choice(String loan_choice) {
		this.loan_choice = loan_choice;
	}
	public int getContest_type_idx_modify() {
		return contest_type_idx_modify;
	}
	public void setContest_type_idx_modify(int contest_type_idx_modify) {
		this.contest_type_idx_modify = contest_type_idx_modify;
	}
	public int getApplicant_idx_modify() {
		return applicant_idx_modify;
	}
	public void setApplicant_idx_modify(int applicant_idx_modify) {
		this.applicant_idx_modify = applicant_idx_modify;
	}
}
