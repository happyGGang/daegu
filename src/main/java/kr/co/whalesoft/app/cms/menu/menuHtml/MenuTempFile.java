package kr.co.whalesoft.app.cms.menu.menuHtml;

import org.springframework.web.multipart.MultipartFile;

public class MenuTempFile {
	private String homepage_id;
	private int menu_idx;
	private int file_idx;
	private String path;
	private String orig_filename;
	private MultipartFile menuTempFile;
	private boolean isValid = false;
	
	public MenuTempFile() { }
	
	public MenuTempFile(String homepage_id, int menu_idx) {
		this.homepage_id = homepage_id;
		this.menu_idx = menu_idx;
	}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getMenu_idx() {
		return menu_idx;
	}
	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public MultipartFile getMenuTempFile() {
		return menuTempFile;
	}
	public void setMenuTempFile(MultipartFile menuTempFile) {
		this.menuTempFile = menuTempFile;
	}
	public boolean isValid() {
		return isValid;
	}
	public void setValid(boolean isValid) {
		this.isValid = isValid;
	}
	public String getOrig_filename() {
		return orig_filename;
	}
	public void setOrig_filename(String orig_filename) {
		this.orig_filename = orig_filename;
	}
	
}
