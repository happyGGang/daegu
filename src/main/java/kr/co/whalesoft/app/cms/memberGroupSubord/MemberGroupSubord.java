package kr.co.whalesoft.app.cms.memberGroupSubord;

import java.util.List;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;

public class MemberGroupSubord extends MemberGroup {

	private String member_id;
	private String member_name;
	private List<String> memberList;
	
	public String getMember_name() {
		return member_name;
	}

	
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	
	public List<String> getMemberList() {
		return memberList;
	}


	
	public void setMemberList(List<String> memberList) {
		this.memberList = memberList;
	}
	
	
}
