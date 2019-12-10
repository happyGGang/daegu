package kr.go.gbelib.app.cms.module.bookReview;

import java.util.Date;
import java.util.Map;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookReview extends PagingUtils {

	private int book_review_idx; // 서평IDX
	private String book_review_loan_id; // 대출자IDX
	private String book_review_web_id; // 웹ID
	private String book_review_name; // 이름
	private String book_review_content; // 서평내용
	private float book_review_score; // 서평점수
	private String manage_code; // 관리코드
	private String reg_no; // 등록번호
	private String book_type; // 서지형태
	private String add_id; // 등록ID
	private Date add_date; // 등록일
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일

	private Map<String, Object> book_info;
	private String search_type_date;
	private String search_start_date;
	private String search_end_date;
	private String search_loca;

	public int getBook_review_idx() {
		return book_review_idx;
	}

	public void setBook_review_idx(int book_review_idx) {
		this.book_review_idx = book_review_idx;
	}

	public String getBook_review_loan_id() {
		return book_review_loan_id;
	}

	public void setBook_review_loan_id(String book_review_loan_id) {
		this.book_review_loan_id = book_review_loan_id;
	}

	public String getBook_review_web_id() {
		return book_review_web_id;
	}

	public void setBook_review_web_id(String book_review_web_id) {
		this.book_review_web_id = book_review_web_id;
	}

	public String getBook_review_name() {
		return book_review_name;
	}

	public void setBook_review_name(String book_review_name) {
		this.book_review_name = book_review_name;
	}

	public String getBook_review_content() {
		return book_review_content;
	}

	public void setBook_review_content(String book_review_content) {
		this.book_review_content = book_review_content;
	}

	public float getBook_review_score() {
		return book_review_score;
	}

	public void setBook_review_score(float book_review_score) {
		this.book_review_score = book_review_score;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}

	public String getReg_no() {
		return reg_no;
	}

	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}

	public String getBook_type() {
		return book_type;
	}

	public void setBook_type(String book_type) {
		this.book_type = book_type;
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

	public Map<String, Object> getBook_info() {
		return book_info;
	}

	public void setBook_info(Map<String, Object> book_info) {
		this.book_info = book_info;
	}

	public String getSearch_type_date() {
		return search_type_date;
	}

	public void setSearch_type_date(String search_type_date) {
		this.search_type_date = search_type_date;
	}

	public String getSearch_start_date() {
		return search_start_date;
	}

	public void setSearch_start_date(String search_start_date) {
		this.search_start_date = search_start_date;
	}

	public String getSearch_end_date() {
		return search_end_date;
	}

	public void setSearch_end_date(String search_end_date) {
		this.search_end_date = search_end_date;
	}

	public String getSearch_loca() {
		return search_loca;
	}

	public void setSearch_loca(String search_loca) {
		this.search_loca = search_loca;
	}

}
