package kr.co.whalesoft.app.cms.quickMenu;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class QuickMenu extends PagingUtils {

	private int quick_idx; // 퀵메뉴IDX
	private String menu_name; // 메뉴명
	private String link_url; // 링크 URL
	private String link_target = "CURRENT"; //링크 대상
	private String org_file_name; //파일원본명
	private String server_file_name; // 파일서버명
	private String file_extension; // 파일 확장자
	private long file_size; // 파일크기
	private String view_yn = "Y";  //노출여부
	private String link_use_yn = "Y";  //링크사용여부
	private String add_id; // 등록ID
	private Date add_date;  //등록일시
	private String modify_id; //수정ID
	private Date modify_date; //수정일시
	private int print_seq; // 출력순서
	
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

	
	public int getPrint_seq() {
		return print_seq;
	}

	
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	
	public MultipartFile getIcon_file() {
		return icon_file;
	}

	
	public void setIcon_file(MultipartFile icon_file) {
		this.icon_file = icon_file;
	}
	
}