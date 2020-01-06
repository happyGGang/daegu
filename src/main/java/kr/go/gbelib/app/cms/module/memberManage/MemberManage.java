package kr.go.gbelib.app.cms.module.memberManage;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MemberManage extends PagingUtils {

	private int member_manage_idx;
	private int[] member_manage_arr;
	private String member_name;
	private String member_id;
	private String member_password;
	private String password_check;
	private String school;
	private Date last_connect;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;

	public int getMember_manage_idx() {
		return member_manage_idx;
	}

	public void setMember_manage_idx(int member_manage_idx) {
		this.member_manage_idx = member_manage_idx;
	}

	public int[] getMember_manage_arr() {
		return member_manage_arr;
	}

	public void setMember_manage_arr(int[] member_manage_arr) {
		this.member_manage_arr = member_manage_arr;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_password() {
		return member_password;
	}

	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}

	public String getPassword_check() {
		return password_check;
	}

	public void setPassword_check(String password_check) {
		this.password_check = password_check;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public Date getLast_connect() {
		return last_connect;
	}

	public void setLast_connect(Date last_connect) {
		this.last_connect = last_connect;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

}
