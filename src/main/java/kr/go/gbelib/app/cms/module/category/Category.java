package kr.go.gbelib.app.cms.module.category;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Category extends PagingUtils {

	private int large_category_idx = 16; // 대분류IDX
	private String large_category_name; // 대분류명
	private int group_idx; // 카테고리 그룹(중분류)
	private String group_name; // 카테고리 그룹명(중분류)
	private int category_idx; // 카테고리IDX(소분류)
	private String category_name; // 카테고리명(소분류)
	private int print_seq; // 노출순서
	private String use_yn = "Y"; // 사용여부
	private String add_date; // 등록일
	private String add_id;
	private String modify_date;
	private String modify_id;
	private String delete_yn;

	private String teach_type;
	private String teach_type_nm;

	private String req_limit_yn = "N"; // 신청제한여부
	private String req_limit_type = "1"; // 신청제한타입
	private int req_limit_count; // 신청제한수

	private int cnt;

	public Category() {
	}

	public Category(String homepage_id) {
		this.setHomepage_id(homepage_id);
	}

	public Category(String homepage_id, int group_idx) {
		this.setHomepage_id(homepage_id);
		this.group_idx = group_idx;
	}

	public Category(String homepage_id, int group_idx, int large_category_idx) {
		this.setHomepage_id(homepage_id);
		this.group_idx = group_idx;
		this.large_category_idx = large_category_idx;
	}

	public int getCategory_idx() {
		return category_idx;
	}

	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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

	public String getModify_date() {
		return modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getTeach_type() {
		return teach_type;
	}

	public void setTeach_type(String teach_type) {
		this.teach_type = teach_type;
	}

	public String getTeach_type_nm() {
		return teach_type_nm;
	}

	public void setTeach_type_nm(String teach_type_nm) {
		this.teach_type_nm = teach_type_nm;
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

}
