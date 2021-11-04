package kr.go.gbelib.app.cms.module.newelib.config;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Config extends PagingUtils {

	private int config_idx;
	private int user_max_lend;
	private int book_max_lend;
	private int lend_max_term;
	private int max_extention;
	private int ext_lend_term;
	private int max_reserve;
	private int book_max_reserve;
	private String modify_date;
	private String modify_id;
	private String modify_ip;
	private String name;
	private String value;
	public Config() { };
	public Config(String name, String value) {
		this.name = name;
		this.value = value;
	};
	public int getConfig_idx() {
		return config_idx;
	}
	public void setConfig_idx(int config_idx) {
		this.config_idx = config_idx;
	}
	public int getUser_max_lend() {
		return user_max_lend;
	}
	public void setUser_max_lend(int user_max_lend) {
		this.user_max_lend = user_max_lend;
	}
	public int getBook_max_lend() {
		return book_max_lend;
	}
	public void setBook_max_lend(int book_max_lend) {
		this.book_max_lend = book_max_lend;
	}
	public int getLend_max_term() {
		return lend_max_term;
	}
	public void setLend_max_term(int lend_max_term) {
		this.lend_max_term = lend_max_term;
	}
	public int getMax_extention() {
		return max_extention;
	}
	public void setMax_extention(int max_extention) {
		this.max_extention = max_extention;
	}
	public int getExt_lend_term() {
		return ext_lend_term;
	}
	public void setExt_lend_term(int ext_lend_term) {
		this.ext_lend_term = ext_lend_term;
	}
	public int getMax_reserve() {
		return max_reserve;
	}
	public void setMax_reserve(int max_reserve) {
		this.max_reserve = max_reserve;
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
	public int getBook_max_reserve() {
		return book_max_reserve;
	}
	public void setBook_max_reserve(int book_max_reserve) {
		this.book_max_reserve = book_max_reserve;
	}
	public String getModify_ip() {
		return modify_ip;
	}
	public void setModify_ip(String modify_ip) {
		this.modify_ip = modify_ip;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
}
