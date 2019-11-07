package kr.co.whalesoft.app.cms.memberGroupAuth;

import java.util.Date;
import java.util.List;
import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * 그룹권한 관리 테이블 : WB_MEMBER_GROUP_AUTH
 * 
 * @author YONGJU
 *
 */
public class MemberGroupAuth extends PagingUtils {

	private int member_group_idx; // 그룹IDX
	private String site_id; // 홈페이지ID
	private int menu_idx; // 메뉴IDX
	private int module_idx; // 모듈IDX
	private String auth_code_id; // 권한코드ID
	private String module_type; // 모듈타입
	private Date add_dttm; // 등록일
	private String add_id; // 등록ID

	private String member_id;

	private String moduleType = "CMS";
	private String auth_group_id; // 권한코드그룹ID
	
	private List<String> authCodeList; // 변수 전달을 위한 리스트

	public int getMember_group_idx() {
		return member_group_idx;
	}

	public void setMember_group_idx(int member_group_idx) {
		this.member_group_idx = member_group_idx;
	}

	public String getSite_id() {
		return site_id;
	}

	public void setSite_id(String site_id) {
		this.site_id = site_id;
	}

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public int getModule_idx() {
		return module_idx;
	}

	public void setModule_idx(int module_idx) {
		this.module_idx = module_idx;
	}

	public String getAuth_code_id() {
		return auth_code_id;
	}

	public void setAuth_code_id(String auth_code_id) {
		this.auth_code_id = auth_code_id;
	}

	public String getModule_type() {
		return module_type;
	}

	public void setModule_type(String module_type) {
		this.module_type = module_type;
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

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getModuleType() {
		return moduleType;
	}

	public void setModuleType(String moduleType) {
		this.moduleType = moduleType;
	}

	public List<String> getAuthCodeList() {
		return authCodeList;
	}

	public void setAuthCodeList(List<String> authCodeList) {
		this.authCodeList = authCodeList;
	}

	
	public String getAuth_group_id() {
		return auth_group_id;
	}

	
	public void setAuth_group_id(String auth_group_id) {
		this.auth_group_id = auth_group_id;
	}

}
