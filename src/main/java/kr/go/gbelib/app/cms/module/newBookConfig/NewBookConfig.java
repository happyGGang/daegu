package kr.go.gbelib.app.cms.module.newBookConfig;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class NewBookConfig extends PagingUtils {

	private String shelf_code; // 자료실코드
	private String[] shelf_code_arr;
	private String description; // 자료실명
	private String add_date; // 등록날자
	private String add_id; // 등록자
	private String mod_date; // 수정날자
	private String mod_id; // 수정자
	
	public NewBookConfig() {
		
	}
	
	public NewBookConfig(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public String getShelf_code() {
		return shelf_code;
	}

	public void setShelf_code(String shelf_code) {
		this.shelf_code = shelf_code;
	}

	public String[] getShelf_code_arr() {
		return shelf_code_arr;
	}

	public void setShelf_code_arr(String[] shelf_code_arr) {
		this.shelf_code_arr = shelf_code_arr;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

}
