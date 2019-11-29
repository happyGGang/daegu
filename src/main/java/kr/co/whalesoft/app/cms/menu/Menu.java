package kr.co.whalesoft.app.cms.menu;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Menu extends PagingUtils {

	private int group_idx; // 메뉴그룹IDX
	private int menu_idx; // 메뉴IDX
	private int parent_menu_idx; // 상위메뉴IDX
	private int print_seq; // 표시순서
	private String menu_url; // 메뉴URL
	private String menu_url_param; // 메뉴URL변수
	private int menu_level; // 메뉴레벨
	private int manage_idx; // 게시판 IDX
	private String menu_full_path_name; // 메뉴전체경로명

	private int move_target_menu_idx; // 이동할 메뉴
	private String menu_name; // 메뉴명
	private String menu_name_html; // 메뉴명HTML
	private String use_yn; // 메뉴사용여부
	private String view_yn; // 메뉴표시여부
	private String mobile_view_yn; // 모바일 메뉴 표시여부
	private Date add_date; // 등록날짜
	private String add_id;
	private String add_ip;
	private Date modify_date; // 수정날짜
	private String modify_id;
	private String mod_ip;
	private String menu_full_path; // 메뉴전체경로
	private String menu_type = "NONE"; // 메뉴타입
	private String board_type; // 게시판타입
	private String menu_path; // 메뉴경로
	private String menu_layout; // 메뉴레이아웃

	private String include_menu_name_yn = "Y"; // 컨텐츠 화면에 메뉴이름 표시여부
	private String link_url; // 링크될 주소
	private String menu_img; // 이미지파일명
	private String view_menu_img; // 이미지파일명
	private String delete_use_yn; // 삭제가능여부

	private String id;
	private String label;
	private Menu children;

	private boolean load_on_demand;

	private String menu_top_icon;
	private String menu_left_icon;

	private String board_category1;

	private String auth_id;
	private String[] auth_id_array;

	private String temp_yn = "N";

	private String moduleName;
	private String auth_group_id;

	private int manager_idx; // 메뉴 담당자 번호
	private String manager_dept; // 메뉴 담당자 부서
	private String manager_name; // 메뉴 담당자명
	private String manager_phone; // 메뉴 담당자 연락처

	public Menu() {
	}

	public Menu(String homepage_id, int menu_idx) {
		setHomepage_id(homepage_id);
		this.menu_idx = menu_idx;
	}

	public Menu(String homepage_id, int menu_idx, int group_idx) {
		setHomepage_id(homepage_id);
		this.menu_idx = menu_idx;
		this.group_idx = group_idx;
	}

	public Menu(String homepage_id, String link_url) {
		setHomepage_id(homepage_id);
		this.link_url = link_url;
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

	public int getMove_target_menu_idx() {
		return move_target_menu_idx;
	}

	public void setMove_target_menu_idx(int move_target_menu_idx) {
		this.move_target_menu_idx = move_target_menu_idx;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_name_html() {
		return menu_name_html;
	}

	public void setMenu_name_html(String menu_name_html) {
		this.menu_name_html = menu_name_html;
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

	public String getMobile_view_yn() {
		return mobile_view_yn;
	}

	public void setMobile_view_yn(String mobile_view_yn) {
		this.mobile_view_yn = mobile_view_yn;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
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

	public String getBoard_type() {
		return board_type;
	}

	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getMenu_path() {
		return menu_path;
	}

	public void setMenu_path(String menu_path) {
		this.menu_path = menu_path;
	}

	public String getMenu_layout() {
		return menu_layout;
	}

	public void setMenu_layout(String menu_layout) {
		this.menu_layout = menu_layout;
	}

	public String getInclude_menu_name_yn() {
		return include_menu_name_yn;
	}

	public void setInclude_menu_name_yn(String include_menu_name_yn) {
		this.include_menu_name_yn = include_menu_name_yn;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getMenu_img() {
		return menu_img;
	}

	public void setMenu_img(String menu_img) {
		this.menu_img = menu_img;
	}

	public String getView_menu_img() {
		return view_menu_img;
	}

	public void setView_menu_img(String view_menu_img) {
		this.view_menu_img = view_menu_img;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Menu getChildren() {
		return children;
	}

	public void setChildren(Menu children) {
		this.children = children;
	}

	public boolean isLoad_on_demand() {
		return load_on_demand;
	}

	public void setLoad_on_demand(boolean load_on_demand) {
		this.load_on_demand = load_on_demand;
	}

	public String getMenu_top_icon() {
		return menu_top_icon;
	}

	public void setMenu_top_icon(String menu_top_icon) {
		this.menu_top_icon = menu_top_icon;
	}

	public String getMenu_left_icon() {
		return menu_left_icon;
	}

	public void setMenu_left_icon(String menu_left_icon) {
		this.menu_left_icon = menu_left_icon;
	}

	public String getBoard_category1() {
		return board_category1;
	}

	public void setBoard_category1(String board_category1) {
		this.board_category1 = board_category1;
	}

	public String getAuth_id() {
		return auth_id;
	}

	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}

	public String[] getAuth_id_array() {
		String[] ret = null;
		if (this.auth_id_array != null) {
			ret = new String[this.auth_id_array.length];
			for (int i = 0; i < this.auth_id_array.length; i++) {
				ret[i] = this.auth_id_array[i];
			}
		}
		return ret;
	}

	public void setAuth_id_array(String[] auth_id_array) {
		this.auth_id_array = new String[auth_id_array.length];
		for (int i = 0; i < auth_id_array.length; i++) {
			this.auth_id_array[i] = auth_id_array[i];
		}
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public String getAdd_ip() {
		return add_ip;
	}

	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getMod_ip() {
		return mod_ip;
	}

	public void setMod_ip(String mod_ip) {
		this.mod_ip = mod_ip;
	}

	public String getDelete_use_yn() {
		return delete_use_yn;
	}

	public void setDelete_use_yn(String delete_use_yn) {
		this.delete_use_yn = delete_use_yn;
	}

	public String getMenu_url_param() {
		return menu_url_param;
	}

	public void setMenu_url_param(String menu_url_param) {
		this.menu_url_param = menu_url_param;
	}

	public String getTemp_yn() {
		return temp_yn;
	}

	public void setTemp_yn(String temp_yn) {
		this.temp_yn = temp_yn;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getAuth_group_id() {
		return auth_group_id;
	}

	public void setAuth_group_id(String auth_group_id) {
		this.auth_group_id = auth_group_id;
	}

	public int getManager_idx() {
		return manager_idx;
	}

	public void setManager_idx(int manager_idx) {
		this.manager_idx = manager_idx;
	}

	public String getManager_dept() {
		return manager_dept;
	}

	public void setManager_dept(String manager_dept) {
		this.manager_dept = manager_dept;
	}

	public String getManager_name() {
		return manager_name;
	}

	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}

	public String getManager_phone() {
		return manager_phone;
	}

	public void setManager_phone(String manager_phone) {
		this.manager_phone = manager_phone;
	}

}
