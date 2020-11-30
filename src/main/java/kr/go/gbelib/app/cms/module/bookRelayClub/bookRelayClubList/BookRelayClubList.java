package kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookRelayClubList extends PagingUtils{
	
	private int club_idx;	//동아리IDX 
	private int relaylist_idx;	//릴레이명단IDX 
	private String relay_name;	//이름 
	private String relay_phone;	//연락처 
	private String relay_etc;	//비고 
	
	public BookRelayClubList() {}
	
	public BookRelayClubList(String homepage_id, int club_idx) {
		setHomepage_id(homepage_id);
		this.club_idx = club_idx;
	}

	public int getClub_idx() {
		return club_idx;
	}

	public void setClub_idx(int club_idx) {
		this.club_idx = club_idx;
	}

	public int getRelaylist_idx() {
		return relaylist_idx;
	}

	public void setRelaylist_idx(int relaylist_idx) {
		this.relaylist_idx = relaylist_idx;
	}

	public String getRelay_name() {
		return relay_name;
	}

	public void setRelay_name(String relay_name) {
		this.relay_name = relay_name;
	}

	public String getRelay_phone() {
		return relay_phone;
	}

	public void setRelay_phone(String relay_phone) {
		this.relay_phone = relay_phone;
	}

	public String getRelay_etc() {
		return relay_etc;
	}

	public void setRelay_etc(String relay_etc) {
		this.relay_etc = relay_etc;
	}
	
}
