package kr.co.whalesoft.app.cms.banner;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Banner extends PagingUtils {

	private String homepage_id;
	private int banner_idx;
	private String banner_name;
	private String org_file_name;
	private String server_file_name;
	private String file_extension;
	private long file_size;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private String modify_date;
	private String use_yn = "Y";
	private String banner_link;
	private String start_date;
	private String end_date;
	private int print_seq;

	public Banner() {
	}

	public Banner(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getBanner_idx() {
		return banner_idx;
	}

	public void setBanner_idx(int banner_idx) {
		this.banner_idx = banner_idx;
	}

	public String getBanner_name() {
		return banner_name;
	}

	public void setBanner_name(String banner_name) {
		this.banner_name = banner_name;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getBanner_link() {
		return banner_link;
	}

	public void setBanner_link(String banner_link) {
		this.banner_link = banner_link;
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

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
}
