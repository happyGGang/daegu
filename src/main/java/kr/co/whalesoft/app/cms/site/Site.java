package kr.co.whalesoft.app.cms.site;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Site extends PagingUtils {

	private int site_idx;  //접수IDX
	private String site_name;  //사이트명
	private String site_desc;  // 사이트설명
	private String link_target;  //링크
	private int print_seq;
	private String add_date;  //등록일
	
	public Site(){}
	
	public Site(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public int getSite_idx() {
		return site_idx;
	}
	public void setSite_idx(int site_idx) {
		this.site_idx = site_idx;
	}
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getSite_desc() {
		return site_desc;
	}
	public void setSite_desc(String site_desc) {
		this.site_desc = site_desc;
	}
	public String getLink_target() {
		return link_target;
	}
	public void setLink_target(String link_target) {
		this.link_target = link_target;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
}