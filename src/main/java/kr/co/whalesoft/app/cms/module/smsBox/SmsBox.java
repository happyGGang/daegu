package kr.co.whalesoft.app.cms.module.smsBox;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class SmsBox extends PagingUtils {
	
	private int box_idx;
	
	private String title;
	
	private String contents;
	
	private String use_yn = "Y";
	
	private String delete_yn;
	
	private String add_id;
	
	private String add_date;
	
	private String modify_id;
	
	private String modify_date;

	public int getBox_idx() {
		return box_idx;
	}

	public void setBox_idx(int box_idx) {
		this.box_idx = box_idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
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
