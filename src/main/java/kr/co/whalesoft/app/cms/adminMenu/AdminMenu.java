package kr.co.whalesoft.app.cms.adminMenu;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AdminMenu extends PagingUtils {

	private int menu_idx; // 메뉴IDX
	private int group_idx; // 메뉴그룹IDX
	private int parent_menu_idx; // 상위메뉴IDX
	private int print_seq; // 표시순서
	private String menu_url; // 메뉴URL
	private int menu_level; // 메뉴레벨
	private int manage_idx; // 게시판 IDX
	private String menu_full_path_name; // 메뉴전체경로명

	private int move_target_menu_idx; // 이동할 메뉴
	private String menu_name; // 메뉴명
	private String menu_desc; // 메뉴설명
	private String use_yn; // 메뉴사용여부
	private String view_yn; // 메뉴표시여부
	private String admin_access_yn = "N"; // 최고관리자전용여부
	private Date add_date; // 등록날짜
	private Date modify_date; // 수정날짜
	private String menu_full_path; // 메뉴전체경로
	private String menu_type = "container"; // 메뉴타입 (container : 내부링크, module : 모듈, _blank : 외부링크)
	private String css_type = "fa-desktop"; // css종류

	private String auth_id;
	private String[] auth_id_array;

	private List<Integer> menu_idx_list;
	private String grp_seqno;
	private String[] menu_auth_group_arr;

	private int module_idx;
	private String link_url;

	private List<Integer> authgroupIdxList;
	private String moduleName;
	private String auth_group_id;

	private String member_id;

	private boolean includeElib = false;

	public AdminMenu() {
	}

	public AdminMenu(String menu_url) {
		this.menu_url = menu_url;
	}

	public AdminMenu(String menu_url, List<Integer> menu_idx_list) {
		this.menu_url = menu_url;
		this.menu_idx_list = menu_idx_list;
	}

	public int getGroup_idx() {
		return group_idx;
	}

	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	public int getMenu_idx() {

		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public int getParent_menu_idx() {
		return parent_menu_idx;
	}

	public void setParent_menu_idx(int parent_menu_idx) {
		this.parent_menu_idx = parent_menu_idx;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public int getMenu_level() {
		return menu_level;
	}

	public void setMenu_level(int menu_level) {
		this.menu_level = menu_level;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public String getMenu_full_path_name() {
		return menu_full_path_name;
	}

	public void setMenu_full_path_name(String menu_full_path_name) {
		this.menu_full_path_name = menu_full_path_name;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_desc() {
		return menu_desc;
	}

	public void setMenu_desc(String menu_desc) {
		this.menu_desc = menu_desc;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getView_yn() {
		return view_yn;
	}

	public void setView_yn(String view_yn) {
		this.view_yn = view_yn;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getMenu_full_path() {
		return menu_full_path;
	}

	public void setMenu_full_path(String menu_full_path) {
		this.menu_full_path = menu_full_path;
	}

	public String getMenu_type() {
		return menu_type;
	}

	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}

	public String getAuth_id() {
		return auth_id;
	}

	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}

	public String[] getAuth_id_array() {
		String[] ret = null;
		if ( this.auth_id_array != null ) {
			ret = new String[this.auth_id_array.length];
			for ( int i = 0; i < this.auth_id_array.length; i++ ) {
				ret[i] = this.auth_id_array[i];
			}
		}
		return ret;
	}

	public void setAuth_id_array(String[] auth_id_array) {
		this.auth_id_array = new String[auth_id_array.length];
		for ( int i = 0; i < auth_id_array.length; i++ ) {
			this.auth_id_array[i] = auth_id_array[i];
		}
	}

	public String getCss_type() {
		return css_type;
	}

	public void setCss_type(String css_type) {
		this.css_type = css_type;
	}

	public int getMove_target_menu_idx() {
		return move_target_menu_idx;
	}

	public void setMove_target_menu_idx(int move_target_menu_idx) {
		this.move_target_menu_idx = move_target_menu_idx;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public List<Integer> getMenu_idx_list() {
		if ( menu_idx_list != null ) {
			List<Integer> arrayList = new ArrayList<Integer>();
			arrayList.addAll(this.menu_idx_list);
			return arrayList;
		}
		else {
			return null;
		}
	}

	/**
	 * 시큐어 코딩
	 *
	 * @param menu_idx_list
	 */
	public void setMenu_idx_list(List<Integer> menu_idx_list) {
		if ( menu_idx_list != null ) {
			this.menu_idx_list = new ArrayList<Integer>();
			this.menu_idx_list.addAll(menu_idx_list);
		}
	}

	/**
	 * 시큐어 코딩
	 *
	 * @return
	 */
	public String[] getMenu_auth_group_arr() {
		String[] ret = null;
		if ( this.menu_auth_group_arr != null ) {
			ret = new String[this.menu_auth_group_arr.length];
			for ( int i = 0; i < this.menu_auth_group_arr.length; i++ ) {
				ret[i] = this.menu_auth_group_arr[i];
			}
		}
		return ret;
	}

	/**
	 * 시큐어 코딩
	 *
	 * @param menu_auth_group_arr
	 */
	public void setMenu_auth_group_arr(String[] menu_auth_group_arr) {
		this.menu_auth_group_arr = new String[menu_auth_group_arr.length];
		for ( int i = 0; i < menu_auth_group_arr.length; i++ ) {
			this.menu_auth_group_arr[i] = menu_auth_group_arr[i];
		}
	}

	public String getGrp_seqno() {
		return grp_seqno;
	}

	public void setGrp_seqno(String grp_seqno) {
		this.grp_seqno = grp_seqno;
	}

	public int getModule_idx() {
		return module_idx;
	}

	public void setModule_idx(int module_idx) {
		this.module_idx = module_idx;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public List<Integer> getAuthgroupIdxList() {
		return authgroupIdxList;
	}

	public void setAuthgroupIdxList(List<Integer> authgroupIdxList) {
		this.authgroupIdxList = authgroupIdxList;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getAdmin_access_yn() {
		return admin_access_yn;
	}

	public void setAdmin_access_yn(String admin_access_yn) {
		this.admin_access_yn = admin_access_yn;
	}

	public String getAuth_group_id() {
		return auth_group_id;
	}

	public void setAuth_group_id(String auth_group_id) {
		this.auth_group_id = auth_group_id;
	}


	public boolean isIncludeElib() {
		return includeElib;
	}


	public void setIncludeElib(boolean includeElib) {
		this.includeElib = includeElib;
	}
}