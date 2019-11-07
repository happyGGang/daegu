package kr.co.whalesoft.app.cms.statusMng;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class StatusMng extends PagingUtils {

	// 직렬
	private int div_idx;
	private String div_name;
	private int col_cnt;
	private int div_print_seq;

	// 조직현황
	private int status_idx;
	private String rating = "-";
	private int max_cnt;
	private int cur_cnt;
	private int print_seq;

	// 공통
	private String add_id;
	private Date add_date;
	private String mod_id;
	private Date mod_date;

	public int getDiv_idx() {
		return div_idx;
	}

	public void setDiv_idx(int div_idx) {
		this.div_idx = div_idx;
	}

	public String getDiv_name() {
		return div_name;
	}

	public void setDiv_name(String div_name) {
		this.div_name = div_name;
	}

	public int getCol_cnt() {
		return col_cnt;
	}

	public void setCol_cnt(int col_cnt) {
		this.col_cnt = col_cnt;
	}
	
	public int getDiv_print_seq() {
		return div_print_seq;
	}

	public void setDiv_print_seq(int div_print_seq) {
		this.div_print_seq = div_print_seq;
	}

	public int getStatus_idx() {
		return status_idx;
	}

	public void setStatus_idx(int status_idx) {
		this.status_idx = status_idx;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public int getMax_cnt() {
		return max_cnt;
	}

	public void setMax_cnt(int max_cnt) {
		this.max_cnt = max_cnt;
	}

	public int getCur_cnt() {
		return cur_cnt;
	}

	public void setCur_cnt(int cur_cnt) {
		this.cur_cnt = cur_cnt;
	}
	
	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
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

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public Date getMod_date() {
		return mod_date;
	}

	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}

}
