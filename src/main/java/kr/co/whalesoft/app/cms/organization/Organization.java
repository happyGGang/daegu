package kr.co.whalesoft.app.cms.organization;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Organization extends PagingUtils {

	private int orga_idx;
	private int parent_orga_idx;
	private String parent_orga_name;
	private String orga_name;
	private String orga_phone;

	public Organization() { }

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

	public String getParent_orga_name() {
		return parent_orga_name;
	}

	public void setParent_orga_name(String parent_orga_name) {
		this.parent_orga_name = parent_orga_name;
	}
	
}