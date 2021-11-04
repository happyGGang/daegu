package kr.go.gbelib.app.cms.module.newelib.statistics;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ElibStatistics extends PagingUtils {

	private String library_code;
	private String library_name;
	private String reg_dt;
	private int lend_pc;
	private int lend_smart;
	private String type = "EBK";
	private String com_code;
	private String lend_dt;
	private String search_sdt;
	private String search_edt;
	private int library_idx;
	private String menu = "HOURS";
	private String cate_name;
	private int p_cnt;
	private int s_cnt;
	private int a_cnt;
	private int i_cnt;
	private int e_cnt;
	private int book_idx;
	private String book_name;
	private String user_id;
	private String user_name;
	private String member_id;
	private int age;
	private String sex;
	private int lend_cnt;
	private String age_group;
	private int comments_cnt;
	private int total_reserves_cnt;
	private int reserves_cnt;
	private String device_cnt;
	
	public String getReg_dt() {
		return reg_dt;
	}
	public int getLend_pc() {
		return lend_pc;
	}
	public int getLend_smart() {
		return lend_smart;
	}
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	public void setLend_pc(int lend_pc) {
		this.lend_pc = lend_pc;
	}
	public void setLend_smart(int lend_smart) {
		this.lend_smart = lend_smart;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCom_code() {
		return com_code;
	}
	public void setCom_code(String com_code) {
		this.com_code = com_code;
	}
	public String getLend_dt() {
		return lend_dt;
	}
	public void setLend_dt(String lend_dt) {
		this.lend_dt = lend_dt;
	}
	public int getLibrary_idx() {
		return library_idx;
	}
	public void setLibrary_idx(int library_idx) {
		this.library_idx = library_idx;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getSearch_sdt() {
		return search_sdt;
	}
	public void setSearch_sdt(String search_sdt) {
		this.search_sdt = search_sdt;
	}
	public String getSearch_edt() {
		return search_edt;
	}
	public void setSearch_edt(String search_edt) {
		this.search_edt = search_edt;
	}
	public String getCate_name() {
		return cate_name;
	}
	public int getP_cnt() {
		return p_cnt;
	}
	public int getS_cnt() {
		return s_cnt;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public void setP_cnt(int p_cnt) {
		this.p_cnt = p_cnt;
	}
	public void setS_cnt(int s_cnt) {
		this.s_cnt = s_cnt;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getAge() {
		return age;
	}
	public int getLend_cnt() {
		return lend_cnt;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public void setLend_cnt(int lend_cnt) {
		this.lend_cnt = lend_cnt;
	}
	public String getLibrary_code() {
		return library_code;
	}
	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getAge_group() {
		return age_group;
	}
	public void setAge_group(String age_group) {
		this.age_group = age_group;
	}
	public int getComments_cnt() {
		return comments_cnt;
	}
	public void setComments_cnt(int comments_cnt) {
		this.comments_cnt = comments_cnt;
	}
	public int getTotal_reserves_cnt() {
		return total_reserves_cnt;
	}
	public void setTotal_reserves_cnt(int total_reserves_cnt) {
		this.total_reserves_cnt = total_reserves_cnt;
	}
	public int getReserves_cnt() {
		return reserves_cnt;
	}
	public void setReserves_cnt(int reserves_cnt) {
		this.reserves_cnt = reserves_cnt;
	}
	public String getLibrary_name() {
		return library_name;
	}
	public void setLibrary_name(String library_name) {
		this.library_name = library_name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getA_cnt() {
		return a_cnt;
	}
	public void setA_cnt(int a_cnt) {
		this.a_cnt = a_cnt;
	}
	public int getI_cnt() {
		return i_cnt;
	}
	public void setI_cnt(int i_cnt) {
		this.i_cnt = i_cnt;
	}
	public int getE_cnt() {
		return e_cnt;
	}
	public void setE_cnt(int e_cnt) {
		this.e_cnt = e_cnt;
	}
	public String getDevice_cnt() {
		return device_cnt;
	}
	public void setDevice_cnt(String device_cnt) {
		this.device_cnt = device_cnt;
	}
	
}
