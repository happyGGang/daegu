package kr.go.gbelib.app.cms.module.elib.book;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.elib.lending.Lending;

public class Book extends PagingUtils {

	private int book_idx;
	private String book_code;
	private int cate_id = 0;
	private int cate_id_1;
	private String cate_name;
	private String book_name;
	private String book_author;
	private String author_name;
	private String book_pubname;
	private String isbn13;
	private String isbn;
	private int book_lend = 0;
	private int lend_total = 0;
	private int max_lend = 0;
	private int book_reserve = 0;
	private String com_code;
	private String book_pubdt;
	private String book_regdt;
	private String use_yn = "N";
	private String smart_use;
	private String tablet_use;
	private String type = "EBK";
	private String type_name = "전자책";
	private String format;
	private String book_image;
	private int parent_id;
	private String parent_name;
	private int recommend_cnt = 0;
	private int library_idx = 0;
	private String library_name;
	private String library_code;
	private String comp_name;
	private String comp_id;
	private String book_info;
	private String author_info;
	private String book_table;
	private int read_count = 0;
	private String add_date;
	private String add_id;
	private String modify_date;
	private String modify_id;
	private int audio_idx;
	private String play_time;
	private String play_size;
	private String link_url;
	private String mobile_link_url;
	private String menu = "";
	private int lending_count;
	private String status;
	private String available_devices;
	private int user_idx;
	private int recommend_idx;
	private String user_id;
	private String member_id;
	private List<String> libraryCodes;
	int cnt;
	private String search_author_name;
	private String search_book_pubname;
	private String search_book_pub_year;
	private String search_type;
	private String name;
	private String book_year;
	private int bestbook_idx;
	private int print_seq;
	private int cat_bestbook_idx;
	private String device;
	private String label;
	private String option;
	private int course_idx;
	private int lesson_no;
	private String lesson_name;
	private String lesson_url;
	private String pop_width;
	private String pop_height;
	private String player_use;
	private String mobile_url;
	private String mkSessData;
	private int audio_no;
	private String audio_name;
	private int view_count;

	private String approved_yn = "Y";
	private MultipartFile mfile;
	
	//공급사가 요청한 API를 위한 book_idx 리스트 2021-11-19
	private String book_idx_list;
	private String lend_idx;
	private String lend_dt;
	private String return_due_dt;
	private String orderOption;
	private String loanExtendsAvailableYn;
	private String loanExtendsAbleReason;

	public Book() {
		this.setSortField("book_pubdt");
	}
	public Book(int book_idx) {
		this.setSortField("book_pubdt");
		this.book_idx = book_idx;
	}
	public Book(Lending lending) {
		this.setSortField("book_pubdt");
		this.book_idx = lending.getBook_idx();
		this.member_id = lending.getMember_id();
		this.book_code = lending.getBook_code();
		this.com_code = lending.getCom_code();
		this.library_code = lending.getLibrary_code();
	}
	public int getBook_idx() {
		return book_idx;
	}
	public String getBook_code() {
		return book_code;
	}
	public int getCate_id() {
		return cate_id;
	}
	public int getCate_id_1() {
		return cate_id_1;
	}
	public String getCate_name() {
		return cate_name;
	}
	public String getBook_name() {
		return book_name;
	}
	public String getBook_author() {
		return book_author;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public String getBook_pubname() {
		return book_pubname;
	}
	public String getIsbn13() {
		return isbn13;
	}
	public int getBook_lend() {
		return book_lend;
	}
	public int getLend_total() {
		return lend_total;
	}
	public int getMax_lend() {
		return max_lend;
	}
	public int getBook_reserve() {
		return book_reserve;
	}
	public String getCom_code() {
		return com_code;
	}
	public String getBook_pubdt() {
		return book_pubdt;
	}
	public String getBook_regdt() {
		return book_regdt;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public String getSmart_use() {
		return smart_use;
	}
	public String getTablet_use() {
		return tablet_use;
	}
	public String getType() {
		return type;
	}
	public String getType_name() {
		return type_name;
	}
	public String getFormat() {
		return format;
	}
	public String getBook_image() {
		return book_image;
	}
	public int getParent_id() {
		return parent_id;
	}
	public String getParent_name() {
		return parent_name;
	}
	public int getRecommend_cnt() {
		return recommend_cnt;
	}
	public int getLibrary_idx() {
		return library_idx;
	}
	public String getLibrary_name() {
		return library_name;
	}
	public String getLibrary_code() {
		return library_code;
	}
	public String getComp_name() {
		return comp_name;
	}
	public String getComp_id() {
		return comp_id;
	}
	public String getBook_info() {
		return book_info;
	}
	public String getAuthor_info() {
		return author_info;
	}
	public String getBook_table() {
		return book_table;
	}
	public int getRead_count() {
		return read_count;
	}
	public String getAdd_date() {
		return add_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public String getModify_date() {
		return modify_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public int getAudio_idx() {
		return audio_idx;
	}
	public String getPlay_time() {
		return play_time;
	}
	public String getPlay_size() {
		return play_size;
	}
	public String getLink_url() {
		return link_url;
	}
	public String getMobile_link_url() {
		return mobile_link_url;
	}
	public String getMenu() {
		return menu;
	}
	public int getLending_count() {
		return lending_count;
	}
	public String getStatus() {
		return status;
	}
	public String getAvailable_devices() {
		return available_devices;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public int getRecommend_idx() {
		return recommend_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public List<String> getLibraryCodes() {
		return libraryCodes;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public void setBook_code(String book_code) {
		this.book_code = book_code;
	}
	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}
	public void setCate_id_1(int cate_id_1) {
		this.cate_id_1 = cate_id_1;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	public void setBook_pubname(String book_pubname) {
		this.book_pubname = book_pubname;
	}
	public void setIsbn13(String isbn13) {
		this.isbn13 = isbn13;
	}
	public void setBook_lend(int book_lend) {
		this.book_lend = book_lend;
	}
	public void setLend_total(int lend_total) {
		this.lend_total = lend_total;
	}
	public void setMax_lend(int max_lend) {
		this.max_lend = max_lend;
	}
	public void setBook_reserve(int book_reserve) {
		this.book_reserve = book_reserve;
	}
	public void setCom_code(String com_code) {
		this.com_code = com_code;
	}
	public void setBook_pubdt(String book_pubdt) {
		this.book_pubdt = book_pubdt;
	}
	public void setBook_regdt(String book_regdt) {
		this.book_regdt = book_regdt;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public void setSmart_use(String smart_use) {
		this.smart_use = smart_use;
	}
	public void setTablet_use(String tablet_use) {
		this.tablet_use = tablet_use;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public void setBook_image(String book_image) {
		this.book_image = book_image;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}
	public void setRecommend_cnt(int recommend_cnt) {
		this.recommend_cnt = recommend_cnt;
	}
	public void setLibrary_idx(int library_idx) {
		this.library_idx = library_idx;
	}
	public void setLibrary_name(String library_name) {
		this.library_name = library_name;
	}
	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
	public void setComp_id(String comp_id) {
		this.comp_id = comp_id;
	}
	public void setBook_info(String book_info) {
		this.book_info = book_info;
	}
	public void setAuthor_info(String author_info) {
		this.author_info = author_info;
	}
	public void setBook_table(String book_table) {
		this.book_table = book_table;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public void setAudio_idx(int audio_idx) {
		this.audio_idx = audio_idx;
	}
	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}
	public void setPlay_size(String play_size) {
		this.play_size = play_size;
	}
	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}
	public void setMobile_link_url(String mobile_link_url) {
		this.mobile_link_url = mobile_link_url;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public void setLending_count(int lending_count) {
		this.lending_count = lending_count;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setAvailable_devices(String available_devices) {
		this.available_devices = available_devices;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setRecommend_idx(int recommend_idx) {
		this.recommend_idx = recommend_idx;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setLibraryCodes(List<String> libraryCodes) {
		this.libraryCodes = libraryCodes;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getSearch_author_name() {
		return search_author_name;
	}
	public String getSearch_book_pubname() {
		return search_book_pubname;
	}
	public String getSearch_book_pub_year() {
		return search_book_pub_year;
	}
	public void setSearch_author_name(String search_author_name) {
		this.search_author_name = search_author_name;
	}
	public void setSearch_book_pubname(String search_book_pubname) {
		this.search_book_pubname = search_book_pubname;
	}
	public void setSearch_book_pub_year(String search_book_pub_year) {
		this.search_book_pub_year = search_book_pub_year;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBook_year() {
		return book_year;
	}
	public void setBook_year(String book_year) {
		this.book_year = book_year;
	}
	public int getBestbook_idx() {
		return bestbook_idx;
	}
	public void setBestbook_idx(int bestbook_idx) {
		this.bestbook_idx = bestbook_idx;
	}
	public int getPrint_seq() {
		return print_seq;
	}
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
	public int getCat_bestbook_idx() {
		return cat_bestbook_idx;
	}
	public void setCat_bestbook_idx(int cat_bestbook_idx) {
		this.cat_bestbook_idx = cat_bestbook_idx;
	}
	public String getDevice() {
		return device;
	}
	public void setDevice(String device) {
		this.device = device;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public int getCourse_idx() {
		return course_idx;
	}
	public void setCourse_idx(int course_idx) {
		this.course_idx = course_idx;
	}
	public int getLesson_no() {
		return lesson_no;
	}
	public void setLesson_no(int lesson_no) {
		this.lesson_no = lesson_no;
	}
	public String getLesson_name() {
		return lesson_name;
	}
	public void setLesson_name(String lesson_name) {
		this.lesson_name = lesson_name;
	}
	public String getLesson_url() {
		return lesson_url;
	}
	public void setLesson_url(String lesson_url) {
		this.lesson_url = lesson_url;
	}
	public String getPop_width() {
		return pop_width;
	}
	public void setPop_width(String pop_width) {
		this.pop_width = pop_width;
	}
	public String getPop_height() {
		return pop_height;
	}
	public void setPop_height(String pop_height) {
		this.pop_height = pop_height;
	}
	public String getPlayer_use() {
		return player_use;
	}
	public void setPlayer_use(String player_use) {
		this.player_use = player_use;
	}
	public String getMobile_url() {
		return mobile_url;
	}
	public void setMobile_url(String mobile_url) {
		this.mobile_url = mobile_url;
	}
	public String getMkSessData() {
		return mkSessData;
	}
	public void setMkSessData(String mkSessData) {
		this.mkSessData = mkSessData;
	}
	public String getApproved_yn() {
		return approved_yn;
	}
	public void setApproved_yn(String approved_yn) {
		this.approved_yn = approved_yn;
	}
	public MultipartFile getMfile() {
		return mfile;
	}
	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}
	public int getAudio_no() {
		return audio_no;
	}
	public void setAudio_no(int audio_no) {
		this.audio_no = audio_no;
	}
	public String getAudio_name() {
		return audio_name;
	}
	public void setAudio_name(String audio_name) {
		this.audio_name = audio_name;
	}
	public String getBook_idx_list() {
		return book_idx_list;
	}
	public void setBook_idx_list(String book_idx_list) {
		this.book_idx_list = book_idx_list;
	}
	public String getLend_idx() {
		return lend_idx;
	}
	public void setLend_idx(String lend_idx) {
		this.lend_idx = lend_idx;
	}
	
	public String getLend_dt() {
		return lend_dt;
	}
	public void setLend_dt(String lend_dt) {
		this.lend_dt = lend_dt;
	}
	public String getReturn_due_dt() {
		return return_due_dt;
	}
	public void setReturn_due_dt(String return_due_dt) {
		this.return_due_dt = return_due_dt;
	}
	public String getOrderOption() {
		return orderOption;
	}
	public void setOrderOption(String orderOption) {
		this.orderOption = orderOption;
	}
	public String getLoanExtendsAvailableYn() {
		return loanExtendsAvailableYn;
	}
	public void setLoanExtendsAvailableYn(String loanExtendsAvailableYn) {
		this.loanExtendsAvailableYn = loanExtendsAvailableYn;
	}
	public String getLoanExtendsAbleReason() {
		return loanExtendsAbleReason;
	}
	public void setLoanExtendsAbleReason(String loanExtendsAbleReason) {
		this.loanExtendsAbleReason = loanExtendsAbleReason;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	@Override
	public String toString() {
		return String.format("Book [book_idx=%s, book_code=%s, com_code=%s]", book_idx, book_code, com_code);
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

}
