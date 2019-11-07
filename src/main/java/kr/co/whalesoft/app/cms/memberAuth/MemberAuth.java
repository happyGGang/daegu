package kr.co.whalesoft.app.cms.memberAuth;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.app.cms.member.Member;

public class MemberAuth extends Member {

	private String homepage_id;
	private List<String> homepage_id_list;
	private List<String> member_id_list;
	
	public MemberAuth() {}
	
	public MemberAuth(String member_id) {
		setMember_id(member_id);
	}
	
	public MemberAuth(String member_id, String auth_id) {
		setMember_id(member_id);
		setAuth_id(auth_id);
	}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public List<String> getHomepage_id_list() {
		if(homepage_id_list != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.homepage_id_list);
			return arrayList;
		} else {
			return null;
		}
	}
	public void setHomepage_id_list(List<String> homepage_id_list) {
		if(homepage_id_list != null) {
			this.homepage_id_list = new ArrayList<String>();
			this.homepage_id_list.addAll(homepage_id_list);
		}
	}
	public List<String> getMember_id_list() {
		if(member_id_list != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.member_id_list);
			return arrayList;
		} else {
			return null;
		}
	}
	public void setMember_id_list(List<String> member_id_list) {
		if(member_id_list != null) {
			this.member_id_list = new ArrayList<String>();
			this.member_id_list.addAll(member_id_list);
		}
	}
	
}