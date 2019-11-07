package kr.co.whalesoft.app.cms.snsStatistics;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class SnsStatistics extends PagingUtils {

	private int menu_level;
	private int menu_idx;
	private int parent_menu_idx;
	private String menu_name;
	private long twitter;
	private long facebook;
	private long kakaostory;
	
	private String searchType = "ALL";
	
	private String startDate;
	private String endDate;
	
	public SnsStatistics() {}
	
	public SnsStatistics(String homepage_id) {
		setHomepage_id(homepage_id);
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
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public long getTwitter() {
		return twitter;
	}
	public void setTwitter(long twitter) {
		this.twitter = twitter;
	}
	public long getFacebook() {
		return facebook;
	}
	public void setFacebook(long facebook) {
		this.facebook = facebook;
	}
	public long getKakaostory() {
		return kakaostory;
	}
	public void setKakaostory(long kakaostory) {
		this.kakaostory = kakaostory;
	}

	public int getMenu_level() {
		return menu_level;
	}

	public void setMenu_level(int menu_level) {
		this.menu_level = menu_level;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
}
