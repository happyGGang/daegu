package kr.co.whalesoft.app.cms.menu.menuLog;

import kr.co.whalesoft.framework.utils.PagingUtils;


public class MenuLog extends PagingUtils {

	private String work_type; //작업 종류 ex ) ADD, MODIFY, DELETE etc.. 
	private String work_date; //작업 날짜
	private String member_id;
	private String work_ip;
	private String homepage_id; //홈페이지ID
	private int group_idx; //메뉴그룹IDX
	private int menu_idx; //메뉴IDX
	private int parent_menu_idx; //상위메뉴IDX
	private String menu_url; //메뉴URL
	private String menu_name; //메뉴명
	private String menu_type; //메뉴타입
	private String html; 
	private String link_url; //링크될 주소
	
	public String getWork_type() {
		return work_type;
	}
	public void setWork_type(String work_type) {
		this.work_type = work_type;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getWork_ip() {
		return work_ip;
	}
	public void setWork_ip(String work_ip) {
		this.work_ip = work_ip;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
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
	public String getMenu_url() {
		return menu_url;
	}
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getMenu_type() {
		return menu_type;
	}
	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getLink_url() {
		return link_url;
	}
	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}
}