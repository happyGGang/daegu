package kr.go.gbelib.app.cms.module.lockerReq;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LockerReq extends PagingUtils {
	private int locker_idx;
	private int req_idx;
	private String req_name;
	private String phone;
	private String apply_id;
	private String cell_phone;
	private String add_date;
	private String add_id;
	private String mod_date;
	private String mod_id;
	private String delete_yn;
	private int locker_pre_idx;
	private String locker_status;
	private String member_key;
	
	private String phone1;
	private String phone2;
	private String phone3;
	private String cell_phone1;
	private String cell_phone2;
	private String cell_phone3;
	private String locker_pre_name;
	private String start_date;
	private String end_date;
	private String homepage_name;
	private String black_count;
	
	private String locker_name;
	
	private String locker_pre_type;
	
	private String search_api_type = "WEBID";
	
	private String self_info_yn = "N";
	
	private int isBlackList;
	private String web_id;
	
	public LockerReq() {}
	
	public LockerReq(String homepage_id, int locker_pre_idx) {
		setHomepage_id(homepage_id);
		this.locker_pre_idx = locker_pre_idx;
	}
	
	public LockerReq(String homepage_id, String member_key) {
		setHomepage_id(homepage_id);
		this.member_key = member_key;
	}
	
	public int getLocker_idx() {
		return locker_idx;
	}
	public void setLocker_idx(int locker_idx) {
		this.locker_idx = locker_idx;
	}
	public int getReq_idx() {
		return req_idx;
	}
	public void setReq_idx(int req_idx) {
		this.req_idx = req_idx;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCell_phone() {
		return cell_phone;
	}
	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}
	public String getApply_id() {
		return apply_id;
	}
	public void setApply_id(String apply_id) {
		this.apply_id = apply_id;
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
	public String getReq_name() {
		return req_name;
	}
	public void setReq_name(String req_name) {
		this.req_name = req_name;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getCell_phone1() {
		return cell_phone1;
	}
	public void setCell_phone1(String cell_phone1) {
		this.cell_phone1 = cell_phone1;
	}
	public String getCell_phone2() {
		return cell_phone2;
	}
	public void setCell_phone2(String cell_phone2) {
		this.cell_phone2 = cell_phone2;
	}
	public String getCell_phone3() {
		return cell_phone3;
	}
	public void setCell_phone3(String cell_phone3) {
		this.cell_phone3 = cell_phone3;
	}
	public int getLocker_pre_idx() {
		return locker_pre_idx;
	}
	public void setLocker_pre_idx(int locker_pre_idx) {
		this.locker_pre_idx = locker_pre_idx;
	}
	public String getLocker_pre_name() {
		return locker_pre_name;
	}
	public void setLocker_pre_name(String locker_pre_name) {
		this.locker_pre_name = locker_pre_name;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public String getBlack_count() {
		return black_count;
	}
	public void setBlack_count(String black_count) {
		this.black_count = black_count;
	}
	public String getLocker_status() {
		return locker_status;
	}
	public void setLocker_status(String locker_status) {
		this.locker_status = locker_status;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	public String getLocker_pre_type() {
		return locker_pre_type;
	}
	public void setLocker_pre_type(String locker_pre_type) {
		this.locker_pre_type = locker_pre_type;
	}

	public String getLocker_name() {
		return locker_name;
	}

	public void setLocker_name(String locker_name) {
		this.locker_name = locker_name;
	}

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

	public String getSelf_info_yn() {
		return self_info_yn;
	}

	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
	}

	public int getIsBlackList() {
		return isBlackList;
	}

	public void setIsBlackList(int isBlackList) {
		this.isBlackList = isBlackList;
	}

	
	public String getWeb_id() {
		return web_id;
	}

	
	public void setWeb_id(String web_id) {
		this.web_id = web_id;
	}
	
}
