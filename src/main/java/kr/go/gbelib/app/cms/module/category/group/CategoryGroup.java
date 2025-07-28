package kr.go.gbelib.app.cms.module.category.group;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.category.Category;

import java.util.List;

public class CategoryGroup extends PagingUtils {

	private int large_category_idx = 16;  //대분류IDX
	private String large_category_name;  //대분류명
	private int group_idx;  //그룹IDX(중분류)
	private String group_name;  //그룹명(중분류)
	private int print_seq;  //노출순서
	private String use_yn = "Y";  //사용여부
	private String add_date;  //등록일
	private String add_id;  //등록ID
	private String mod_date;  //수정일
	private String mod_id;  //수정ID
	private String delete_yn;  //삭제여부

	private String req_limit_yn = "N";  //신청제한여부
	private String req_limit_type = "1";  //신청제한타입
	private int req_limit_count;  //신청제한수
	
	private int cnt;

	private String homepage_view_yn = "Y"; //홈페이지 노출 여부 설정

	private List<Category> categoryList;

	public List<Category> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}

	public CategoryGroup() {}

	public CategoryGroup(String homepage_id){
		setHomepage_id(homepage_id);
	}
	
	public CategoryGroup(String homepage_id, int large_category_idx){
		setHomepage_id(homepage_id);
		this.large_category_idx = large_category_idx;
	}
	
	public int getGroup_idx() {
		return group_idx;
	}
	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
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
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	
	public String getReq_limit_yn() {
		return req_limit_yn;
	}

	
	public void setReq_limit_yn(String req_limit_yn) {
		this.req_limit_yn = req_limit_yn;
	}

	
	public String getReq_limit_type() {
		return req_limit_type;
	}

	
	public void setReq_limit_type(String req_limit_type) {
		this.req_limit_type = req_limit_type;
	}

	
	public int getReq_limit_count() {
		return req_limit_count;
	}

	
	public void setReq_limit_count(int req_limit_count) {
		this.req_limit_count = req_limit_count;
	}

	
	public int getCnt() {
		return cnt;
	}

	
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	
	public int getLarge_category_idx() {
		return large_category_idx;
	}

	
	public void setLarge_category_idx(int large_category_idx) {
		this.large_category_idx = large_category_idx;
	}

	
	public String getLarge_category_name() {
		return large_category_name;
	}

	
	public void setLarge_category_name(String large_category_name) {
		this.large_category_name = large_category_name;
	}

	public String getHomepage_view_yn() {
		return homepage_view_yn;
	}

	public void setHomepage_view_yn(String homepage_view_yn) {
		this.homepage_view_yn = homepage_view_yn;
	}

}