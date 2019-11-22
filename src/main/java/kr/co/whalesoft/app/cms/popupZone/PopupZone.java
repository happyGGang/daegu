package kr.co.whalesoft.app.cms.popupZone;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PopupZone extends PagingUtils {

	private int popup_zone_idx;
	private String popup_zone_name;
	private int popup_zone_seq; // 출력순서
	private String use_yn = "Y";
	private Date add_date;
	private String start_date;
	private String end_date;
	private String img_file_name;	//이미지파일명
	private String real_file_name;
	private String file_extension;
	private long file_size;
	private String link_url;
	private String link_target = "CURRENT"; //새창으로보기
	private String content;
	
	public PopupZone() { }
	
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
	public int getPopup_zone_seq() {
		return popup_zone_seq;
	}
	public void setPopup_zone_seq(int popup_zone_seq) {
		this.popup_zone_seq = popup_zone_seq;
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
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getImg_file_name() {
		return img_file_name;
	}
	public void setImg_file_name(String img_file_name) {
		this.img_file_name = img_file_name;
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

	public String getReal_file_name() {
		return real_file_name;
	}

	public void setReal_file_name(String real_file_name) {
		this.real_file_name = real_file_name;
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
	
}