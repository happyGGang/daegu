package kr.go.gbelib.app.cms.module.elib.code;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ElibCode extends PagingUtils {

	private String type;
	private String com_code;
	private String comp_name;
	private String homepage_id;
	private String library_name;
	private String library_code;
	private int cnt;
	private int comp_idx;
	private int user_cnt;
	private String license_sdate;
	private String license_edate;
	private String copyright;
	private String use_yn = "Y";
	private String add_id;
	private String add_date;
	private String mod_id;
	private String mod_date;
	private String approved_yn = "Y";
	
	public ElibCode() {}
	
	public ElibCode(String type) {
		this.setType(type);
	}

	public String getType() {
		return type;
	}

	public String getCom_code() {
		return com_code;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setCom_code(String com_code) {
		this.com_code = com_code;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getLibrary_name() {
		return library_name;
	}

	public String getLibrary_code() {
		return library_code;
	}

	public void setLibrary_name(String library_name) {
		this.library_name = library_name;
	}

	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}

	public int getComp_idx() {
		return comp_idx;
	}

	public int getUser_cnt() {
		return user_cnt;
	}

	public String getLicense_sdate() {
		return license_sdate;
	}

	public String getLicense_edate() {
		return license_edate;
	}

	public String getCopyright() {
		return copyright;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public String getAdd_id() {
		return add_id;
	}

	public String getMod_id() {
		return mod_id;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setComp_idx(int comp_idx) {
		this.comp_idx = comp_idx;
	}

	public void setUser_cnt(int user_cnt) {
		this.user_cnt = user_cnt;
	}

	public void setLicense_sdate(String license_sdate) {
		this.license_sdate = license_sdate;
	}

	public void setLicense_edate(String license_edate) {
		this.license_edate = license_edate;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getAdd_date() {
		return add_date;
	}

	public String getApproved_yn() {
		return approved_yn;
	}

	public void setApproved_yn(String approved_yn) {
		this.approved_yn = approved_yn;
	}

}
