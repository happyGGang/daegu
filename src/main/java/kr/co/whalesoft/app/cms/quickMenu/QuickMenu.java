package kr.co.whalesoft.app.cms.quickMenu;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class QuickMenu extends PagingUtils {

	private int quick_idx;  //퀵메뉴IDX
	private String menu_name;  //메뉴명
	private String link_url;  // 링크 URL
	private String link_target;  //링크 대상
	private String icon_file_name;  //아이콘파일명
	private String real_file_name;
	private String file_extension;
	private long file_size;
	private String view_yn = "Y";  //노출여부
	private String link_use_yn = "Y";  //링크사용여
	private String add_date;  //등록일
	private int print_seq;
	
	private MultipartFile icon_file;
	
	public QuickMenu() { }
	
	public QuickMenu(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public int getQuick_idx() {
		return quick_idx;
	}
	public void setQuick_idx(int quick_idx) {
		this.quick_idx = quick_idx;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public String getLink_target() {
		return link_target;
	}
	public void setLink_target(String link_target) {
		this.link_target = link_target;
	}
	public String getIcon_file_name() {
		return icon_file_name;
	}
	public void setIcon_file_name(String icon_file_name) {
		this.icon_file_name = icon_file_name;
	}
	public String getView_yn() {
		return view_yn;
	}
	public void setView_yn(String view_yn) {
		this.view_yn = view_yn;
	}
	public String getLink_use_yn() {
		return link_use_yn;
	}
	public void setLink_use_yn(String link_use_yn) {
		this.link_use_yn = link_use_yn;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public MultipartFile getIcon_file() {
		return icon_file;
	}
	public void setIcon_file(MultipartFile icon_file) {
		this.icon_file = icon_file;
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

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}
}