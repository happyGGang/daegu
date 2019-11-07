package kr.co.whalesoft.app.cms.authCode;

import java.io.Serializable;
import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AuthCode extends PagingUtils implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String parent_auth_group_id; // 부모코드그룹ID
	private String auth_group_id; // 권한그룹ID
	private String auth_group_name; // 권한그룹명
	private String auth_code_id; // 권한코드ID
	private String auth_code_name; // 권한코드명
	private int print_seq; // 정렬순서
	private String remark; // 설명
	private Date add_dttm; // 등록일
	private String add_id; // 등록ID
	private Date mod_dttm;
	private String mod_id;

	public AuthCode() {
	}

	public AuthCode(String auth_group_id) {
		this.auth_group_id = auth_group_id;
	}

	public String getParent_auth_group_id() {
		return parent_auth_group_id;
	}

	public void setParent_auth_group_id(String parent_auth_group_id) {
		this.parent_auth_group_id = parent_auth_group_id;
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

	public String getAuth_code_id() {
		return auth_code_id;
	}

	public void setAuth_code_id(String auth_code_id) {
		this.auth_code_id = auth_code_id;
	}

	public String getAuth_code_name() {
		return auth_code_name;
	}

	public void setAuth_code_name(String auth_code_name) {
		this.auth_code_name = auth_code_name;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getAdd_dttm() {
		return add_dttm;
	}

	public void setAdd_dttm(Date add_dttm) {
		this.add_dttm = add_dttm;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getMod_dttm() {
		return mod_dttm;
	}

	public void setMod_dttm(Date mod_dttm) {
		this.mod_dttm = mod_dttm;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

}