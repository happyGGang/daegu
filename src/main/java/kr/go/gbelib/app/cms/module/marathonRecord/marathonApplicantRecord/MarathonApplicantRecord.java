package kr.go.gbelib.app.cms.module.marathonRecord.marathonApplicantRecord;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MarathonApplicantRecord extends PagingUtils{
	private int applicant_idx; //신청자 번호
	private String member_id; //신청자 아이디
	private String member_name; //신청자명
	private String school_name; //학교명
	private String school_class; //학년 , 반
	private String school_class_one; //학년
	private String school_class_two; //반
	private String contest_type; //대회종목
	private int page_count; //쪽수
	private int read_page_count; //읽은쪽수
	private int read_page_count_total; //누적쪽수
	private Date finish_date; //달성일
	
	private String book_name; //도서명
	private String book_author; //저자
	private String book_type; //분류 번호
	private String publisher; //출판사
	private Date record_date; //일지 작성일
	private String book_resources; //대출/구입처
	private String book_journals; //독서감상문
	
	public int getApplicant_idx() {
		return applicant_idx;
	}
	public void setApplicant_idx(int applicant_idx) {
		this.applicant_idx = applicant_idx;
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
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getSchool_class_one() {
		return school_class_one;
	}
	public void setSchool_class_one(String school_class_one) {
		this.school_class_one = school_class_one;
	}
	public String getSchool_class_two() {
		return school_class_two;
	}
	public void setSchool_class_two(String school_class_two) {
		this.school_class_two = school_class_two;
	}
	public String getContest_type() {
		return contest_type;
	}
	public void setContest_type(String contest_type) {
		this.contest_type = contest_type;
	}
	public int getPage_count() {
		return page_count;
	}
	public void setPage_count(int page_count) {
		this.page_count = page_count;
	}
	public int getRead_page_count() {
		return read_page_count;
	}
	public void setRead_page_count(int read_page_count) {
		this.read_page_count = read_page_count;
	}
	public int getRead_page_count_total() {
		return read_page_count_total;
	}
	public void setRead_page_count_total(int read_page_count_total) {
		this.read_page_count_total = read_page_count_total;
	}
	public Date getFinish_date() {
		return finish_date;
	}
	public void setFinish_date(Date finish_date) {
		this.finish_date = finish_date;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
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
	public Date getRecord_date() {
		return record_date;
	}
	public void setRecord_date(Date record_date) {
		this.record_date = record_date;
	}
	public String getBook_resources() {
		return book_resources;
	}
	public void setBook_resources(String book_resources) {
		this.book_resources = book_resources;
	}
	public String getSchool_class() {
		return school_class;
	}
	public void setSchool_class(String school_class) {
		this.school_class = school_class;
	}
	public String getBook_type() {
		return book_type;
	}
	public void setBook_type(String book_type) {
		this.book_type = book_type;
	}
	public String getBook_journals() {
		return book_journals;
	}
	public void setBook_journals(String book_journals) {
		this.book_journals = book_journals;
	}
}
