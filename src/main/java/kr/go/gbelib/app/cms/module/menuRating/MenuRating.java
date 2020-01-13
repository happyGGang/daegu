package kr.go.gbelib.app.cms.module.menuRating;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MenuRating extends PagingUtils {

	// TABLE
	private String homepage_id;
	private int menu_idx;
	private int menu_rating_idx;
	private float menu_rating_score;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;

	// RESULT
	private String menu_name;
	private String search_date_type;
	private String search_start_date;
	private String search_end_date;
	private float rating_average_score;

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

	public int getMenu_rating_idx() {
		return menu_rating_idx;
	}

	public void setMenu_rating_idx(int menu_rating_idx) {
		this.menu_rating_idx = menu_rating_idx;
	}

	public float getMenu_rating_score() {
		return menu_rating_score;
	}

	public void setMenu_rating_score(float menu_rating_score) {
		this.menu_rating_score = menu_rating_score;
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

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getSearch_date_type() {
		return search_date_type;
	}

	public void setSearch_date_type(String search_date_type) {
		this.search_date_type = search_date_type;
	}

	public String getSearch_start_date() {
		return search_start_date;
	}

	public void setSearch_start_date(String search_start_date) {
		this.search_start_date = search_start_date;
	}

	public String getSearch_end_date() {
		return search_end_date;
	}

	public void setSearch_end_date(String search_end_date) {
		this.search_end_date = search_end_date;
	}

	public float getRating_average_score() {
		return rating_average_score;
	}

	public void setRating_average_score(float rating_average_score) {
		this.rating_average_score = rating_average_score;
	}

}
