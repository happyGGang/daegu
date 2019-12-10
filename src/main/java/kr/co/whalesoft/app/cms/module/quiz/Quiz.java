package kr.co.whalesoft.app.cms.module.quiz;

import java.util.Calendar;
import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Quiz extends PagingUtils {

	private int quiz_idx; // 퀴즈IDX
	private String quiz_type; // 퀴즈타입
	private String quiz_name; // 퀴즈제목
	private int quiz_year = Calendar.getInstance().get(Calendar.YEAR); // 퀴즈연도
	private int quiz_month = Calendar.getInstance().get(Calendar.MONTH) + 1; // 퀴즈월
	private String book_name; // 책이름
	private String book_author; // 저자
	private String book_publisher; // 출판사
	private String call_no; // 청구기호
	private String book_desc; // 책설명
	private String quiz_start_date; // 퀴즈시작날짜
	private String quiz_end_date; // 퀴즈종료날짜
	private String book_image; // 책 이미지
	private String top_html; // 상단 HTML
	private String bottom_html; // 하단 HTML
	private String delete_yn; // 삭제여부
	private Date add_date; // 등록일
	private String add_id; // 등록ID
	private Date modify_date; // 수정일
	private String modify_id; // 수정ID
	private int quiz_req_count; // 퀴즈 신청수
	private String school_yn = "Y"; // 학교입력여부
	private String ban_yn = "Y"; // 반입력여부
	private String hak_yn = "Y"; // 학년입력여부
	private int select_cnt;

	public Quiz() {
	}

	public Quiz(String homepage_id, int quiz_idx) {
		setHomepage_id(homepage_id);
		this.quiz_idx = quiz_idx;
	}

	// 사용자 화면에서 사용하는 생성자
	public Quiz(String homepage_id, String quiz_type, int quiz_year, int quiz_month) {
		setHomepage_id(homepage_id);
		this.quiz_type = quiz_type;
		this.quiz_year = quiz_year;
		this.quiz_month = quiz_month;
	}

	public int getQuiz_idx() {
		return quiz_idx;
	}

	public void setQuiz_idx(int quiz_idx) {
		this.quiz_idx = quiz_idx;
	}

	public int getQuiz_year() {
		return quiz_year;
	}

	public void setQuiz_year(int quiz_year) {
		this.quiz_year = quiz_year;
	}

	public int getQuiz_month() {
		return quiz_month;
	}

	public void setQuiz_month(int quiz_month) {
		this.quiz_month = quiz_month;
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

	public String getBook_publisher() {
		return book_publisher;
	}

	public void setBook_publisher(String book_publisher) {
		this.book_publisher = book_publisher;
	}

	public String getQuiz_start_date() {
		return quiz_start_date;
	}

	public void setQuiz_start_date(String quiz_start_date) {
		this.quiz_start_date = quiz_start_date;
	}

	public String getQuiz_end_date() {
		return quiz_end_date;
	}

	public void setQuiz_end_date(String quiz_end_date) {
		this.quiz_end_date = quiz_end_date;
	}

	public String getBook_image() {
		return book_image;
	}

	public void setBook_image(String book_image) {
		this.book_image = book_image;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
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

	public String getQuiz_type() {
		return quiz_type;
	}

	public void setQuiz_type(String quiz_type) {
		this.quiz_type = quiz_type;
	}

	public String getQuiz_name() {
		return quiz_name;
	}

	public void setQuiz_name(String quiz_name) {
		this.quiz_name = quiz_name;
	}

	public String getCall_no() {
		return call_no;
	}

	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}

	public String getBook_desc() {
		return book_desc;
	}

	public void setBook_desc(String book_desc) {
		this.book_desc = book_desc;
	}

	public String getTop_html() {
		return top_html;
	}

	public void setTop_html(String top_html) {
		this.top_html = top_html;
	}

	public String getBottom_html() {
		return bottom_html;
	}

	public void setBottom_html(String bottom_html) {
		this.bottom_html = bottom_html;
	}

	public int getQuiz_req_count() {
		return quiz_req_count;
	}

	public void setQuiz_req_count(int quiz_req_count) {
		this.quiz_req_count = quiz_req_count;
	}

	public String getSchool_yn() {
		return school_yn;
	}

	public void setSchool_yn(String school_yn) {
		this.school_yn = school_yn;
	}

	public String getBan_yn() {
		return ban_yn;
	}

	public void setBan_yn(String ban_yn) {
		this.ban_yn = ban_yn;
	}

	public String getHak_yn() {
		return hak_yn;
	}

	public void setHak_yn(String hak_yn) {
		this.hak_yn = hak_yn;
	}

	public int getSelect_cnt() {
		return select_cnt;
	}

	public void setSelect_cnt(int select_cnt) {
		this.select_cnt = select_cnt;
	}

}
