package kr.co.whalesoft.app.homepage.sns;

public class SNSAccess {

	private String homepage_id; //홈페이지 ID
	private int menu_idx;  //메뉴IDX
	private String access_date;
	private int twitter;  //트위터
	private int facebook;  //페이스북
	private int kakaostory;  //카카오스토리
	
	private String type;
	
	public SNSAccess() {}

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
	public int getTwitter() {
		return twitter;
	}
	public void setTwitter(int twitter) {
		this.twitter = twitter;
	}
	public int getFacebook() {
		return facebook;
	}
	public void setFacebook(int facebook) {
		this.facebook = facebook;
	}
	public int getKakaostory() {
		return kakaostory;
	}
	public void setKakaostory(int kakaostory) {
		this.kakaostory = kakaostory;
	}

	public String getAccess_date() {
		return access_date;
	}

	public void setAccess_date(String access_date) {
		this.access_date = access_date;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "SNSAccess [homepage_id=" + homepage_id + ", menu_idx=" + menu_idx + ", access_date=" + access_date
				+ ", twitter=" + twitter + ", facebook=" + facebook + ", kakaostory=" + kakaostory + ", type=" + type
				+ "]";
	}
	
	
}
