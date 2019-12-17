package kr.co.whalesoft.app.cms.popup;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Popup extends PagingUtils {

	private int popup_idx;
	private String popup_name;
	private String html;
	private String html_use_yn = "N";
	private String popup_type = "LAYER";
	private String link_url;
	private String use_yn = "Y";
	private int print_seq;
	private String start_date;
	private String end_date;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;

	private int width; // 가로크기
	private int height; // 세로크기
	private int x_position; // X좌표
	private int y_position; // Y좌표
	private String org_file_name; // 이미지파일명
	private String server_file_name;
	private String file_extension;
	private long file_size;
	private String link_target = "CURRENT"; // 새창으로보기

	private String common_yn = "N";

	public Popup() {
	}

	public Popup(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public int getPopup_idx() {
		return popup_idx;
	}

	public void setPopup_idx(int popup_idx) {
		this.popup_idx = popup_idx;
	}

	public String getPopup_name() {
		return popup_name;
	}

	public void setPopup_name(String popup_name) {
		this.popup_name = popup_name;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getPopup_type() {
		return popup_type;
	}

	public void setPopup_type(String popup_type) {
		this.popup_type = popup_type;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
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

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getX_position() {
		return x_position;
	}

	public void setX_position(int x_position) {
		this.x_position = x_position;
	}

	public int getY_position() {
		return y_position;
	}

	public void setY_position(int y_position) {
		this.y_position = y_position;
	}

	public String getLink_target() {
		return link_target;
	}

	public void setLink_target(String link_target) {
		this.link_target = link_target;
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

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public String getHtml_use_yn() {
		return html_use_yn;
	}

	public void setHtml_use_yn(String html_use_yn) {
		this.html_use_yn = html_use_yn;
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

	public String getCommon_yn() {
		return common_yn;
	}

	public void setCommon_yn(String common_yn) {
		this.common_yn = common_yn;
	}

}
