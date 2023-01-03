package kr.go.gbelib.app.cms.module.bookOfFamous;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookOfFamous extends PagingUtils {

	private int book_famous_idx; // 명사의서재IDX
	private String homepage_id; //홈페이지ID
	private String notice_yn; //공지여부
	private String selection_year; // 선정년도
	private String famous_name; // 명사 이름
	private String book_name; // 도서명
	private String book_author; // 저자
	private String book_publisher; // 출판사
	private String book_year; // 출판년도
	private String book_regno; // 등록번호
	private String book_isbn; // ISBN
	private String book_img_url; // 도서이미지URL
	private String book_content; // 상세내용
	private String top_html; // 상단HTML
	private String bottom_html; // 하단HTML
	private String add_id; // 등록ID
	private Date add_date; // 등록일
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일
	private String delete_yn; //삭제여부
	
	public String getSelection_year() {
		return selection_year;
	}

	public void setSelection_year(String selection_year) {
		this.selection_year = selection_year;
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

	public String getBook_year() {
		return book_year;
	}

	public void setBook_year(String book_year) {
		this.book_year = book_year;
	}

	public String getBook_regno() {
		return book_regno;
	}

	public void setBook_regno(String book_regno) {
		this.book_regno = book_regno;
	}

	public String getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}

	public String getBook_img_url() {
		return book_img_url;
	}

	public void setBook_img_url(String book_img_url) {
		this.book_img_url = book_img_url;
	}

	public String getBook_content() {
		return book_content;
	}

	public void setBook_content(String book_content) {
		this.book_content = book_content;
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

	public String getNotice_yn() {
		return notice_yn;
	}

	public void setNotice_yn(String notice_yn) {
		this.notice_yn = notice_yn;
	}

	public String getFamous_name() {
		return famous_name;
	}

	public void setFamous_name(String famous_name) {
		this.famous_name = famous_name;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getBook_famous_idx() {
		return book_famous_idx;
	}

	public void setBook_famous_idx(int book_famous_idx) {
		this.book_famous_idx = book_famous_idx;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	
}
