package kr.go.gbelib.app.cms.module.supportMember;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class SupportMember extends PagingUtils {

	private int support_member_idx;
	private int[] support_member_arr;
	private String school_name; // 학교명
	private String member_id; // 회원ID
	private String member_password; // 회원 비밀번호
	private String password_check; // 비밀번호 확인
	private String auth_group; // 그룹
	private Date last_connect; // 마지막 접속일
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	private boolean login; // 로그인상태
	private boolean admin;

	/* 권한 */
	private List<Integer> authGroupIdxList;// 권한그룹목록
	private List<Homepage> authorityHomepageList;// 관리홈페이지리스트
	private Map<String, Object> authMap; // 내권한목록

	private MultipartFile mfile;
	
	public int getSupport_member_idx() {
		return support_member_idx;
	}

	public void setSupport_member_idx(int support_member_idx) {
		this.support_member_idx = support_member_idx;
	}

	public int[] getSupport_member_arr() {
		return support_member_arr;
	}

	public void setSupport_member_arr(int[] support_member_arr) {
		this.support_member_arr = support_member_arr;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
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

	public String getAuth_group() {
		return auth_group;
	}

	public void setAuth_group(String auth_group) {
		this.auth_group = auth_group;
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
	
	public boolean isAdmin() {
		return admin;
	}
	
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public List<Integer> getAuthGroupIdxList() {
		return authGroupIdxList;
	}

	public void setAuthGroupIdxList(List<Integer> authGroupIdxList) {
		this.authGroupIdxList = authGroupIdxList;
	}

	public List<Homepage> getAuthorityHomepageList() {
		return authorityHomepageList;
	}

	public void setAuthorityHomepageList(List<Homepage> authorityHomepageList) {
		this.authorityHomepageList = authorityHomepageList;
	}

	public Map<String, Object> getAuthMap() {
		return authMap;
	}

	public void setAuthMap(Map<String, Object> authMap) {
		this.authMap = authMap;
	}
	
	public MultipartFile getMfile() {
		return mfile;
	}

	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}

	@Override
	public String toString() {
		return "SupportMember [support_member_idx=" + support_member_idx + ", school_name=" + school_name + ", member_id=" + member_id + ", member_password=" + member_password + ", auth_group=" + auth_group + ", last_connect=" + last_connect + ", add_id=" + add_id + ", add_date=" + add_date + ", modify_id=" + modify_id + ", modify_date=" + modify_date + "]";
	}

}
