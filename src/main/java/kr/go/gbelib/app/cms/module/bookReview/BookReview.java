package kr.go.gbelib.app.cms.module.bookReview;


import java.util.Date;
import java.util.Map;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookReview extends PagingUtils {

	private int br_idx; // 서평IDX
	private String br_loan_id; // 대출자IDX
	private String br_web_id; // 웹ID
	private String br_name; // 이름
	private String br_content; // 서평내용
	private float br_score; // 서평점수
	private String br_loca; // 도서관코드
	private String br_ctrlno; // 제어번호
	private Date add_date; // 등록일
	private Date mod_date; // 수정일
	
	private Map<String, Object> dsItemDetail;
	private String search_type_date;
	private String search_start_date;
	private String search_end_date;
	private String search_loca;
	
	public int getBr_idx() {
		return br_idx;
	}

	public void setBr_idx(int br_idx) {
		this.br_idx = br_idx;
	}

	public String getBr_loan_id() {
		return br_loan_id;
	}

	public void setBr_loan_id(String br_loan_id) {
		this.br_loan_id = br_loan_id;
	}

	public String getBr_web_id() {
		return br_web_id;
	}

	public void setBr_web_id(String br_web_id) {
		this.br_web_id = br_web_id;
	}

	public String getBr_name() {
		return br_name;
	}

	public void setBr_name(String br_name) {
		this.br_name = br_name;
	}

	public String getBr_content() {
		return br_content;
	}

	public void setBr_content(String br_content) {
		this.br_content = br_content;
	}

	public float getBr_score() {
		return br_score;
	}

	public void setBr_score(float br_score) {
		this.br_score = br_score;
	}

	public String getBr_loca() {
		return br_loca;
	}

	public void setBr_loca(String br_loca) {
		this.br_loca = br_loca;
	}

	public String getBr_ctrlno() {
		return br_ctrlno;
	}

	public void setBr_ctrlno(String br_ctrlno) {
		this.br_ctrlno = br_ctrlno;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public Date getMod_date() {
		return mod_date;
	}

	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}

	public Map<String, Object> getDsItemDetail() {
		return dsItemDetail;
	}

	public void setDsItemDetail(Map<String, Object> dsItemDetail) {
		this.dsItemDetail = dsItemDetail;
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
