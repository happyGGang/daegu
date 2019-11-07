package kr.co.whalesoft.app.cms.memberOrganization;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.app.cms.member.Member;

public class MemberOrganization extends Member {
	private List<String> member_id_list;
	
	private int orga_idx;
	private int parent_orga_idx;
	private String orga_name;
	private String orga_phone;

	public MemberOrganization() { }

	public int getOrga_idx() {
		return orga_idx;
	}

	public void setOrga_idx(int orga_idx) {
		this.orga_idx = orga_idx;
	}

	public int getParent_orga_idx() {
		return parent_orga_idx;
	}

	public void setParent_orga_idx(int parent_orga_idx) {
		this.parent_orga_idx = parent_orga_idx;
	}

	public String getOrga_name() {
		return orga_name;
	}

	public void setOrga_name(String orga_name) {
		this.orga_name = orga_name;
	}

	public String getOrga_phone() {
		return orga_phone;
	}

	public void setOrga_phone(String orga_phone) {
		this.orga_phone = orga_phone;
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

	@Override
	public String toString() {
		return "MemberOrganization [orga_idx=" + orga_idx + ", parent_orga_idx=" + parent_orga_idx + ", orga_name="
				+ orga_name + ", orga_phone=" + orga_phone + "]";
	}
	
}