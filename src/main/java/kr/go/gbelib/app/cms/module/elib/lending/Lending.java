package kr.go.gbelib.app.cms.module.elib.lending;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.elib.book.Book;

public class Lending extends PagingUtils {

	private int lend_idx;
	private int book_idx;
	private int cate_id;
	private String lend_dt;
	private String return_due_dt;
	private String return_dt;
	private String book_name;
	private String author_name;
	private String book_pubname;
	private String book_pubdt;
	private String book_image;
	private String device;
	private String cate_name;
	private String parent_name;
	private String type;
	private String type_name;
	private String com_code;
	private String comp_name;
	private String library_code;
	private int user_idx;
	private String user_id;
	private String user_pw;
	private String user_name;
	private int user_level;
	private String user_dt;
	private int library_idx;
	private String library_name;
	private String seq_no;
	private int parent_id;
	private String reserve_yn;
	private int reserve_idx;
	private String section;
	private String reserve_dt;
	private String isReserve;
	private String menu;
	private String lendable_dt;
	private int book_lend;
	private int book_reserve;
	private int extention_count;
	private String member_id;
	private String favorite_regdt;
	private String book_code;
	private String status;
	private String cmd;
	private String barcode;
	private String libcode;
	private String lesson_no;
	private String start_date;
	private String end_date;
	private String book_regdt;
	private String search_sdt;
	private String search_edt;
	private String format;
	
	public Lending() {}
	public Lending(int lend_idx) {
		this.lend_idx = lend_idx;
	}
	public Lending(Book book) {
		this.book_idx = book.getBook_idx();
		this.member_id = book.getMember_id();
	}
	public int getLend_idx() {
		return lend_idx;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public int getCate_id() {
		return cate_id;
	}
	public String getLend_dt() {
		return lend_dt;
	}
	public String getReturn_due_dt() {
		return return_due_dt;
	}
	public String getReturn_dt() {
		return return_dt;
	}
	public String getBook_name() {
		return book_name;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public String getBook_pubname() {
		return book_pubname;
	}
	public String getDevice() {
		return device;
	}
	public String getCate_name() {
		return cate_name;
	}
	public String getType() {
		return type;
	}
	public String getCom_code() {
		return com_code;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public int getUser_level() {
		return user_level;
	}
	public String getUser_dt() {
		return user_dt;
	}
	public int getLibrary_idx() {
		return library_idx;
	}
	public String getSeq_no() {
		return seq_no;
	}
	public void setLend_idx(int lend_idx) {
		this.lend_idx = lend_idx;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public void setLend_dt(String lend_dt) {
		this.lend_dt = lend_dt;
	}
	public void setReturn_due_dt(String return_due_dt) {
		this.return_due_dt = return_due_dt;
	}
	public void setReturn_dt(String return_dt) {
		this.return_dt = return_dt;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	public void setBook_pubname(String book_pubname) {
		this.book_pubname = book_pubname;
	}
	public void setDevice(String device) {
		this.device = device;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setCom_code(String com_code) {
		this.com_code = com_code;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
	public void setUser_dt(String user_dt) {
		this.user_dt = user_dt;
	}
	public void setLibrary_idx(int library_idx) {
		this.library_idx = library_idx;
	}
	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public String getReserve_yn() {
		return reserve_yn;
	}
	public void setReserve_yn(String reserve_yn) {
		this.reserve_yn = reserve_yn;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public String getSection() {
		return section;
	}
	public String getReserve_dt() {
		return reserve_dt;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public void setReserve_dt(String reserve_dt) {
		this.reserve_dt = reserve_dt;
	}
	public String getIsReserve() {
		return isReserve;
	}
	public void setIsReserve(String isReserve) {
		this.isReserve = isReserve;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getBook_image() {
		return book_image;
	}
	public void setBook_image(String book_image) {
		this.book_image = book_image;
	}
	public String getLibrary_name() {
		return library_name;
	}
	public void setLibrary_name(String library_name) {
		this.library_name = library_name;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public String getLendable_dt() {
		return lendable_dt;
	}
	public void setLendable_dt(String lendable_dt) {
		this.lendable_dt = lendable_dt;
	}
	public int getBook_lend() {
		return book_lend;
	}
	public void setBook_lend(int book_lend) {
		this.book_lend = book_lend;
	}
	public int getExtention_count() {
		return extention_count;
	}
	public void setExtention_count(int extention_count) {
		this.extention_count = extention_count;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getLibrary_code() {
		return library_code;
	}
	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}
	public String getFavorite_regdt() {
		return favorite_regdt;
	}
	public void setFavorite_regdt(String favorite_regdt) {
		this.favorite_regdt = favorite_regdt;
	}
	public String getBook_code() {
		return book_code;
	}
	public void setBook_code(String book_code) {
		this.book_code = book_code;
	}
	public String getBook_pubdt() {
		return book_pubdt;
	}
	public void setBook_pubdt(String book_pubdt) {
		this.book_pubdt = book_pubdt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getBook_reserve() {
		return book_reserve;
	}
	public void setBook_reserve(int book_reserve) {
		this.book_reserve = book_reserve;
	}
	public String getCmd() {
		return cmd;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	
	public String getLibcode() {
		return libcode;
	}
	
	public void setLibcode(String libcode) {
		this.libcode = libcode;
	}
	
	public String getLesson_no() {
		return lesson_no;
	}
	
	public void setLesson_no(String lesson_no) {
		this.lesson_no = lesson_no;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getBook_regdt() {
		return book_regdt;
	}
	public void setBook_regdt(String book_regdt) {
		this.book_regdt = book_regdt;
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
	public String getParent_name() {
		return parent_name;
	}
	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	
}
