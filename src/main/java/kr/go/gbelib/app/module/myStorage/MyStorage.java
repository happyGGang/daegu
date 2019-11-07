package kr.go.gbelib.app.module.myStorage;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MyStorage extends PagingUtils {

	private String member_key;
	private int storage_idx;
	private int parent_storage_idx;
	private String storage_name;

	public MyStorage() { }
	
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