package kr.co.whalesoft.app.cms.terms;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Terms extends PagingUtils {

	private int module_idx;
	
	private int terms_idx;
	
	private String terms_type;
	
	private String terms_type_name;
	
	private String title;
	
	private String contents;
	
	private String use_yn = "Y";
	
	private String delete_yn;
	
	private String add_id;
	
	private String add_date;
	
	private String modify_id;
	
	private String modify_date;

	public Terms() { }
	
	public Terms(int module_idx) {
		this.module_idx = module_idx;
	}
	
	public int getTerms_idx() {
		return terms_idx;
	}

	public void setTerms_idx(int terms_idx) {
		this.terms_idx = terms_idx;
	}

	public String getTerms_type() {
		return terms_type;
	}

	public void setTerms_type(String terms_type) {
		this.terms_type = terms_type;
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

	public String getTerms_type_name() {
		return terms_type_name;
	}

	public void setTerms_type_name(String terms_type_name) {
		this.terms_type_name = terms_type_name;
	}

	public int getModule_idx() {
		return module_idx;
	}

	public void setModule_idx(int module_idx) {
		this.module_idx = module_idx;
	}

}
