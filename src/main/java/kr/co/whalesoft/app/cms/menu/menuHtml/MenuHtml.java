package kr.co.whalesoft.app.cms.menu.menuHtml;

import java.util.Date;

public class MenuHtml {

	private String homepage_id;
	private int menu_idx;
	private int html_idx;
	private String html;
	private String add_id;
	private String add_ip;
	private Date add_date;
	private String mod_id;
	private Date mod_date;
	private String mod_ip;
	
	public MenuHtml() {}
	
	public MenuHtml(String homepage_id, int menu_idx) {
		this.homepage_id = homepage_id;
		this.menu_idx = menu_idx;
	}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getMenu_idx() {
		return menu_idx;
	}
	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
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
	public String getAdd_ip() {
		return add_ip;
	}
	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}
	public int getHtml_idx() {
		return html_idx;
	}
	public void setHtml_idx(int html_idx) {
		this.html_idx = html_idx;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_ip() {
		return mod_ip;
	}
	public void setMod_ip(String mod_ip) {
		this.mod_ip = mod_ip;
	}
}