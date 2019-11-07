package kr.co.whalesoft.app.cms.module.bookStoreReq;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookStoreReq extends PagingUtils {
	
	private int req_idx;
	
	private String loan_seq;
	
	private String member_name;
	
	private String store_name;
	
	private String add_id;
	
	private String add_date;
	
	private String modify_id;
	
	private String modify_date;

	public int getReq_idx() {
		return req_idx;
	}

	public void setReq_idx(int req_idx) {
		this.req_idx = req_idx;
	}

	public String getLoan_seq() {
		return loan_seq;
	}

	public void setLoan_seq(String loan_seq) {
		this.loan_seq = loan_seq;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getStore_name() {
		return store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
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
