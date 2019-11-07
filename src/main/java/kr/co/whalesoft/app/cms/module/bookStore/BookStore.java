package kr.co.whalesoft.app.cms.module.bookStore;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookStore extends PagingUtils {
	
	private int bookstore_idx;
	
	private String loan_seq;
	
	private String loan_name;
	
	private String title;
	
	private String regist_num;
	
	private String claim_sign;
	
	private String add_id;
	
	private String add_date;
	
	private String modify_id;
	
	private String modify_date;

	public int getBookstore_idx() {
		return bookstore_idx;
	}

	public void setBookstore_idx(int bookstore_idx) {
		this.bookstore_idx = bookstore_idx;
	}

	public String getLoan_seq() {
		return loan_seq;
	}

	public void setLoan_seq(String loan_seq) {
		this.loan_seq = loan_seq;
	}

	public String getLoan_name() {
		return loan_name;
	}

	public void setLoan_name(String loan_name) {
		this.loan_name = loan_name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRegist_num() {
		return regist_num;
	}

	public void setRegist_num(String regist_num) {
		this.regist_num = regist_num;
	}

	public String getClaim_sign() {
		return claim_sign;
	}

	public void setClaim_sign(String claim_sign) {
		this.claim_sign = claim_sign;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	
}
