package kr.co.whalesoft.app.cms.popupZone;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PopupZone extends PagingUtils {

	private int popup_zone_idx;
	private String popup_zone_name;
	private int print_seq; // 출력순서
	private String use_yn;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;
	private String start_date;
	private String end_date;
	private String org_file_name; // 이미지파일명
	private String server_file_name;
	private String file_extension;
	private long file_size;
	private String link_url;
	private String link_target; // 새창으로보기
	private String content;
	private String alt_text; //대체 텍스트

	public PopupZone() {
	}

	public PopupZone(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public int getPopup_zone_idx() {
		return popup_zone_idx;
	}

	public void setPopup_zone_idx(int popup_zone_idx) {
		this.popup_zone_idx = popup_zone_idx;
	}

	public String getPopup_zone_name() {
		return popup_zone_name;
	}

	public void setPopup_zone_name(String popup_zone_name) {
		this.popup_zone_name = popup_zone_name;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getLink_target() {
		return link_target;
	}

	public void setLink_target(String link_target) {
		this.link_target = link_target;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public String getAlt_text() {
		return alt_text;
	}


	public void setAlt_text(String alt_text) {
		this.alt_text = alt_text;
	}

}
