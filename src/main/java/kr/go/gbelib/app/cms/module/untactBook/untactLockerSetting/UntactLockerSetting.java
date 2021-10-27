package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class UntactLockerSetting extends PagingUtils {
	
	private String homepage_id; 		 //홈페이지ID
	private int locker_number;  		//사물함번호
	private int[] locker_number_arr; 	//사물함번호_arr
	private String locker_type;  		//사물함용도
	
	private String member_name;

	public String getHomepage_id() {
		return homepage_id;
	}
	
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
	public int getLocker_number() {
		return locker_number;
	}
	
	public void setLocker_number(int locker_number) {
		this.locker_number = locker_number;
	}
	
	public int[] getLocker_number_arr() {
		return locker_number_arr;
	}
	
	public void setLocker_number_arr(int[] locker_number_arr) {
		this.locker_number_arr = locker_number_arr;
	}
	
	public String getLocker_type() {
		return locker_type;
	}
	
	public void setLocker_type(String locker_type) {
		this.locker_type = locker_type;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
}
