package kr.co.whalesoft.framework.utils;


public class BeanUtils extends Object implements Cloneable{

	private String homepage_id;
	private String subHomepageId;
	private String editMode = "ADD";
	private String menu_url;
	private String auth_id;
	private String cud_id;//create, update, delete

	private String before_url;
	private int menu_idx;

	private String key;
	private Object value;

	private String work_reason;

	public String getEditMode() {
		return editMode;
	}

	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public String getCud_id() {
		return cud_id;
	}

	public void setCud_id(String cud_id) {
		this.cud_id = cud_id;
	}

	public String getAuth_id() {
		return auth_id;
	}

	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}

	public String getBefore_url() {
		return before_url;
	}

	public void setBefore_url(String before_url) {
		this.before_url = before_url;
	}

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}


	public String getKey() {
		return key;
	}


	public void setKey(String key) {
		this.key = key;
	}


	public Object getValue() {
		return value;
	}


	public void setValue(Object value) {
		this.value = value;
	}

	public String getWork_reason() {
		return work_reason;
	}

	public void setWork_reason(String work_reason) {
		this.work_reason = work_reason;
	}

	public String getSubHomepageId() {
		return subHomepageId;
	}

	public void setSubHomepageId(String subHomepageId) {
		this.subHomepageId = subHomepageId;
	}
}