package kr.go.gbelib.app.cms.module.readingNotes;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ReadingNotes extends PagingUtils {
	private String homepage_id; //홈페이지 ID
	private int reading_notes_idx; //독서노트 순번
	private int[] reading_notes_idx_arr; //독서노트 순번 배열
	private String member_id; //회원 ID
	private String[] member_id_arr; //회원 ID 배열
	private String member_name; //회원명
	private String user_no; //대출번호
	private String book_name; //책 제목
	private String book_type; //책 종류 (대출 도서, 대출 외 도서)
	private String publisher; //출판사
	private String author; //저자
	private String isbn; //ISBN
	private String contents; //내용
	private String approve_status = "C"; //승인 상태  N : 반려, Y : 승인, C : 확인중 
	private String approve_status_search; //승인 상태 검색용
	private String approve_status_modify; //승인 상태 다중 수정용
	private String approve_status_replace; //승인 상태 단일 수정용
	private String[] approve_status_arr; //승인 상태 배열
	private String cancel_reason; //반려 사유
	private String cancel_reason_replace; //반려 사유 단일 수정용
	private String[] cancel_reason_arr; //반려 사유 배열
	private String read_success_date; //완독일
	private Date add_date; //등록일
	private Date modify_date; //수정일
	
	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public int getReading_notes_idx() {
		return reading_notes_idx;
	}
	
	public void setReading_notes_idx(int reading_notes_idx) {
		this.reading_notes_idx = reading_notes_idx;
	}
	
	public int[] getReading_notes_idx_arr() {
		return reading_notes_idx_arr;
	}
	
	public void setReading_notes_idx_arr(int[] reading_notes_idx_arr) {
		this.reading_notes_idx_arr = reading_notes_idx_arr;
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

	public String getUser_no() {
		return user_no;
	}
	
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getBook_name() {
		return book_name;
	}
	
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	
	public String getBook_type() {
		return book_type;
	}
	
	public void setBook_type(String book_type) {
		this.book_type = book_type;
	}
	
	public String getPublisher() {
		return publisher;
	}
	
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	
	public String getAuthor() {
		return author;
	}
	
	public void setAuthor(String author) {
		this.author = author;
	}
	
	public String getIsbn() {
		return isbn;
	}
	
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	
	public String getContents() {
		return contents;
	}
	
	public void setContents(String contents) {
		this.contents = contents;
	}
	
	public String getApprove_status() {
		return approve_status;
	}
	
	public void setApprove_status(String approve_status) {
		this.approve_status = approve_status;
	}
	
	public String getCancel_reason() {
		return cancel_reason;
	}
	
	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}

	public String getRead_success_date() {
		return read_success_date;
	}
	
	public void setRead_success_date(String read_success_date) {
		this.read_success_date = read_success_date;
	}

	public Date getAdd_date() {
		return add_date;
	}
	
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	
	public Date getModify_date() {
		return modify_date;
	}
	
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	
	public String[] getMember_id_arr() {
		return member_id_arr;
	}
	
	public void setMember_id_arr(String[] member_id_arr) {
		this.member_id_arr = member_id_arr;
	}
	
	public String[] getCancel_reason_arr() {
		return cancel_reason_arr;
	}
	
	public void setCancel_reason_arr(String[] cancel_reason_arr) {
		this.cancel_reason_arr = cancel_reason_arr;
	}
	
	public String getApprove_status_search() {
		return approve_status_search;
	}
	
	public void setApprove_status_search(String approve_status_search) {
		this.approve_status_search = approve_status_search;
	}
	
	public String getApprove_status_modify() {
		return approve_status_modify;
	}
	
	public void setApprove_status_modify(String approve_status_modify) {
		this.approve_status_modify = approve_status_modify;
	}
	
	public String getApprove_status_replace() {
		return approve_status_replace;
	}
	
	public void setApprove_status_replace(String approve_status_replace) {
		this.approve_status_replace = approve_status_replace;
	}
	
	public String getCancel_reason_replace() {
		return cancel_reason_replace;
	}
	
	public void setCancel_reason_replace(String cancel_reason_replace) {
		this.cancel_reason_replace = cancel_reason_replace;
	}
	
	public String[] getApprove_status_arr() {
		return approve_status_arr;
	}
	
	public void setApprove_status_arr(String[] approve_status_arr) {
		this.approve_status_arr = approve_status_arr;
	}
	
}
