package kr.co.whalesoft.app.cms.menu.menuAccess;

public class MenuAccess {
	
	private String homepage_id;
	private String homepage_name;
	private int menu_idx; //메뉴URL
	private String menu_name;
	private int menu_level;
	private String access_date; //접속날짜(20140808)
	private int access_count; //해당 날짜 메뉴의 count
	private String start_date; //검색 시작날짜
	private String end_date; //검색 종료날짜
	
	private long total_count;
	private long max_count;
	private long min_count;
	
	public MenuAccess() {}
	
	public MenuAccess(String homepage_id, int menu_idx) {
		this.homepage_id = homepage_id;
		this.menu_idx = menu_idx;
	}
	
	public int getMenu_idx() {
		return menu_idx;
	}
	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_level() {
		return menu_level;
	}
	public void setMenu_level(int menu_level) {
		this.menu_level = menu_level;
	}
	public String getAccess_date() {
		return access_date;
	}
	public void setAccess_date(String access_date) {
		this.access_date = access_date;
	}
	public int getAccess_count() {
		return access_count;
	}
	public void setAccess_count(int access_count) {
		this.access_count = access_count;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public long getTotal_count() {
		return total_count;
	}
	public void setTotal_count(long total_count) {
		this.total_count = total_count;
	}
	public long getMax_count() {
		return max_count;
	}
	public void setMax_count(long max_count) {
		this.max_count = max_count;
	}
	public long getMin_count() {
		return min_count;
	}
	public void setMin_count(long min_count) {
		this.min_count = min_count;
	}
}
