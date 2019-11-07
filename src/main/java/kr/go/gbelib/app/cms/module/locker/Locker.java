package kr.go.gbelib.app.cms.module.locker;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Locker extends PagingUtils {
	private int locker_idx;
	private int locker_pre_idx;
	private int locker_count;
	private int req_idx;
	private String locker_name;
	private String locker_desc;
	private String status;
	private String add_date;
	private String add_id;
	private String mod_date;
	private String mod_id;
	private String delete_yn;
	private String apply_id;
	private String req_name;
	private String state;
	private String blackList_yn;
	private String locker_pre_type;
	private String member_key;
	
	public Locker() {}
	
	public Locker(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	public Locker(String homepage_id, int locker_pre_idx) {
		setHomepage_id(homepage_id);
		this.locker_pre_idx = locker_pre_idx;
	}
	
	public Locker(String homepage_id, int locker_pre_idx, int locker_idx) {
		setHomepage_id(homepage_id);
		this.locker_pre_idx = locker_pre_idx;
		this.locker_idx = locker_idx;
	}

	public Locker(String homepage_id, int locker_pre_idx, int locker_idx, String status) {
		setHomepage_id(homepage_id);
		this.locker_pre_idx = locker_pre_idx;
		this.locker_idx = locker_idx;
		this.status = status;
	}

	
	public int getLocker_idx() {
		return locker_idx;
	}
	public void setLocker_idx(int locker_idx) {
		this.locker_idx = locker_idx;
	}
	public String getLocker_name() {
		return locker_name;
	}
	public void setLocker_name(String locker_name) {
		this.locker_name = locker_name;
	}
	public String getLocker_desc() {
		return locker_desc;
	}
	public void setLocker_desc(String locker_desc) {
		this.locker_desc = locker_desc;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public int getLocker_pre_idx() {
		return locker_pre_idx;
	}

	public void setLocker_pre_idx(int locker_pre_idx) {
		this.locker_pre_idx = locker_pre_idx;
	}

	public String getApply_id() {
		return apply_id;
	}

	public void setApply_id(String apply_id) {
		this.apply_id = apply_id;
	}

	public String getReq_name() {
		return req_name;
	}

	public void setReq_name(String req_name) {
		this.req_name = req_name;
	}

	public int getReq_idx() {
		return req_idx;
	}

	public void setReq_idx(int req_idx) {
		this.req_idx = req_idx;
	}

	public int getLocker_count() {
		return locker_count;
	}

	public void setLocker_count(int locker_count) {
		this.locker_count = locker_count;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getBlackList_yn() {
		return blackList_yn;
	}

	public void setBlackList_yn(String blackList_yn) {
		this.blackList_yn = blackList_yn;
	}

	public String getLocker_pre_type() {
		return locker_pre_type;
	}

	public void setLocker_pre_type(String locker_pre_type) {
		this.locker_pre_type = locker_pre_type;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	
}
