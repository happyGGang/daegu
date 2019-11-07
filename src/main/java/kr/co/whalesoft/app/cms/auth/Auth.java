package kr.co.whalesoft.app.cms.auth;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Auth extends PagingUtils {

	private String parent_auth_group_id; //부모코드그룹ID
	private String auth_group_id; //권한그룹ID
	private String auth_group_name; //권한그룹명
	private String auth_id; //권한Id
	private String auth_name; //권한명
	private String use_yn; //사용여부
	private int print_seq; //정렬순서
	private String remark; //설명
	private Date add_date; //등록일
	private String add_id; //등록ID
	private Date mod_date;
	private String mod_id;
	
	public Auth() {}
	
	public Auth(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public Auth(String homepage_id, String auth_group_id) {
		setHomepage_id(homepage_id);
		this.auth_group_id = auth_group_id;
	}
	
	public String getAuth_group_id() {
		return auth_group_id;
	}
	public void setAuth_group_id(String auth_group_id) {
		this.auth_group_id = auth_group_id;
	}
	public String getAuth_group_name() {
		return auth_group_name;
	}
	public void setAuth_group_name(String auth_group_name) {
		this.auth_group_name = auth_group_name;
	}
	public String getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}
	public String getAuth_name() {
		return auth_name;
	}
	public void setAuth_name(String auth_name) {
		this.auth_name = auth_name;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getParent_auth_group_id() {
		return parent_auth_group_id;
	}
	public void setParent_auth_group_id(String parent_auth_group_id) {
		this.parent_auth_group_id = parent_auth_group_id;
	}
	public int getPrint_seq() {
		return print_seq;
	}
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
}