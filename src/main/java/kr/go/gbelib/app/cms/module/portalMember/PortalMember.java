package kr.go.gbelib.app.cms.module.portalMember;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PortalMember extends PagingUtils {

	private int portal_member_idx; // 대표회원IDX
	private int[] portal_member_arr;
	private String agency_name; // 기관명
	private String agency_id; // 아이디
	private String agency_password; // 비밀번호
	private String password_check; // 비밀번호 체크
	private String auth_group; // 권한그룹
	private String library_code; // 도서관 코드
	private Date last_connect; // 최근접속일
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	private boolean login; // 로그인상태

	public int getPortal_member_idx() {
		return portal_member_idx;
	}

	public void setPortal_member_idx(int portal_member_idx) {
		this.portal_member_idx = portal_member_idx;
	}

	public int[] getPortal_member_arr() {
		return portal_member_arr;
	}

	public void setPortal_member_arr(int[] portal_member_arr) {
		this.portal_member_arr = portal_member_arr;
	}

	public String getAgency_name() {
		return agency_name;
	}

	public void setAgency_name(String agency_name) {
		this.agency_name = agency_name;
	}

	public String getAgency_id() {
		return agency_id;
	}

	public void setAgency_id(String agency_id) {
		this.agency_id = agency_id;
	}

	public String getAgency_password() {
		return agency_password;
	}

	public void setAgency_password(String agency_password) {
		this.agency_password = agency_password;
	}

	public String getPassword_check() {
		return password_check;
	}

	public void setPassword_check(String password_check) {
		this.password_check = password_check;
	}

	public String getAuth_group() {
		return auth_group;
	}

	public void setAuth_group(String auth_group) {
		this.auth_group = auth_group;
	}

	public String getLibrary_code() {
		return library_code;
	}

	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
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

	public boolean isLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}

}
