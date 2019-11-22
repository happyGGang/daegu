package kr.co.whalesoft.app.cms.menu.menuHtml;

public class MenuTempFile {

	private String homepage_id; // 홈페이지 ID
	private int menu_idx; // 메뉴IDX
	private int file_idx; // 파일 IDX
	private String path; // 경로
	private String org_file_name; // 원본파일명
//	private MultipartFile menuTempFile; // 메뉴임시파일
//	private boolean isValid = false; // 사용여부

	public MenuTempFile() {
	}

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

//	public MultipartFile getMenuTempFile() {
//		return menuTempFile;
//	}
//
//	public void setMenuTempFile(MultipartFile menuTempFile) {
//		this.menuTempFile = menuTempFile;
//	}
//
//	public boolean isValid() {
//		return isValid;
//	}
//
//	public void setValid(boolean isValid) {
//		this.isValid = isValid;
//	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

}
