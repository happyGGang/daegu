package kr.go.gbelib.app.cms.module.teach.teachSort;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class TeachSort extends PagingUtils {

	private  int sort_idx; //'정렬idx'
	private  String sort_name; //'정렬 이름'
	private  String add_date; //' 등록일시'
	private  String add_id; //'등록ID'
	private  String modify_date; //'수정 일자'
	private  String modify_id; //'수정ID'
	private  String sort_order; //'정렬차순'


	private  int set_sort_idx; // '정렬설정 IDX'
	private  String homepage_id; // '홈페이지IDX'
	private  int sort_num; // '정렬 순번'
	private  String set_sort_name; // '정렬 이름'
	private  String sort_column_name; // '정렬 기준명 '

	private int[] sort_idx_arr; //정렬기준 IDX 배열



	public int getSort_idx() {
		return sort_idx;
	}

	public void setSort_idx(int sort_idx) {
		this.sort_idx = sort_idx;
	}

	public String getSort_name() {
		return sort_name;
	}

	public void setSort_name(String sort_name) {
		this.sort_name = sort_name;
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

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public int getSet_sort_idx() {
		return set_sort_idx;
	}

	public void setSet_sort_idx(int set_sort_idx) {
		this.set_sort_idx = set_sort_idx;
	}

	@Override
	public String getHomepage_id() {
		return homepage_id;
	}

	@Override
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getSort_num() {
		return sort_num;
	}

	public void setSort_num(int sort_num) {
		this.sort_num = sort_num;
	}

	public String getSet_sort_name() {
		return set_sort_name;
	}

	public void setSet_sort_name(String set_sort_name) {
		this.set_sort_name = set_sort_name;
	}

	public int[] getSort_idx_arr() {
		return sort_idx_arr;
	}

	public void setSort_idx_arr(int[] sort_idx_arr) {
		this.sort_idx_arr = sort_idx_arr;
	}

	public String getSort_column_name() {
		return sort_column_name;
	}

	public void setSort_column_name(String sort_column_name) {
		this.sort_column_name = sort_column_name;
	}

	public String getSort_order() {
		return sort_order;
	}

	public void setSort_order(String sort_order) {
		this.sort_order = sort_order;
	}
}
