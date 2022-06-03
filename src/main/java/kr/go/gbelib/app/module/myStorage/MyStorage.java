package kr.go.gbelib.app.module.myStorage;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MyStorage {

	private String member_key;
	private int storage_idx;
	private int parent_storage_idx;
	private String storage_name;
	private String homepage_id;
	private String editMode;
	private String before_url;
	private String menu_idx;

	public MyStorage() { }

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public String getEditMode() {
		return editMode;
	}

	public String getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(String menu_idx) {
		this.menu_idx = menu_idx;
	}

	public String getBefore_url() {
		return before_url;
	}

	public void setBefore_url(String before_url) {
		this.before_url = before_url;
	}

	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}

	public MyStorage(String homepage_id, String member_key) {
		setHomepage_id(homepage_id);
		this.setMember_key(member_key);
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public int getStorage_idx() {
		return storage_idx;
	}

	public void setStorage_idx(int storage_idx) {
		this.storage_idx = storage_idx;
	}

	public int getParent_storage_idx() {
		return parent_storage_idx;
	}

	public void setParent_storage_idx(int parent_storage_idx) {
		this.parent_storage_idx = parent_storage_idx;
	}

	public String getStorage_name() {
		return storage_name;
	}

	public void setStorage_name(String storage_name) {
		this.storage_name = storage_name;
	}
}