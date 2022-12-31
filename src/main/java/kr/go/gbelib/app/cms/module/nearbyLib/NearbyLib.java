package kr.go.gbelib.app.cms.module.nearbyLib;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author ttkaz
 * 2022. 9. 27.
 *
 */
public class NearbyLib extends PagingUtils {
	
	private String homepage_id; // 홈페이지ID
	private String device_name; // 장비명
	private int	device_idx; //장비IDX
	private String device_code; //장비코드
	private int reserve_idx; //예약IDX
	private int reserve_bundle_idx; //건당묶음예약IDX(한건에 최대 대출 두권)
	private int locker_idx; //사물함idx
	private int locker_each_idx; //장비별 사물함 idx
	private int device_password; //장비비밀번호
	private String reserve_status; //예약상태 
	// (1:예약신청, 2:대출승인(사물함 배정), 3:사물함투입(배송기사가 사물함에 도서 투입), 4:대출(대출신청자가 도서를 가져감), 5:회수대기(대출자가 책을 가져가지 않아 회수로 바뀜), 6:회수중(배송기사가 사물함에서 도서를 회수), 7:회수완료(배송기사가 도서관에 도서 반납), 8:미승인(취소))
	private String reg_no; //도서제어번호
	private String book_name; //도서명
	private String member_id; //회원ID
	private String user_key; //회원KEY
	private String member_name; //회원명
	private Date lend_date; //대출날짜
	private Date add_date; //등록날짜
	private String add_id; //등록ID
	private String add_ip; //등록IP
	private String cancel_yn; //취소여부
	private String cancel_reason; //취소사유
	private String cancel_id; //취소ID
	private String cancel_ip; //취소IP
	private String sms_send_yn; //SMS발송여부
	private Date sms_send_date; //SMS발송날짜
	private int take_term; //취거기간
	private int expire_date_cnt; //예약만기일수
	private String large_book_yn; //큰책여부(도서 사이즈가 크면 사서가'Y'로 미리 체크 함, 사물함 크기가 달라서 큰 사물함에 넣기위한 변수)
	private String reserve_idx_arr; //체크박스용
	private String reserve_start_date; //해당예약의 예약시작 날짜and시간
	private String reserve_end_date; //해당예약의 예약종료 날짜and시간
	private String return_device_code; //반납시 반납기 코드
	
	//도서API 정보 받아오기용 변수
	private String title_info; //도서명
	private String img_url; //이미지url
	private String ctrl_no; //등록번호
	private String call_no; //청구기호
	private String lib_name; // 도서관명
	private String publer; //
	private String author; //저자
	private String book_key; //책key
	private String booktype; //
	private String publisher; //발행자
	private String pub_year; //발행연도
	private String media_name; //매체구분명
	private String price;	//가격
	private String page;	//면장수
	private String book_size; //도서크기
	private String media_code; //매체구분코드
	private String book_isbn;	//ISBN
	private String class_no;
	private String loan_code; //대출가능여부 (OK:대출가능(비치중))
	private String description; 
	private String appendix_info;
	private String appendix_cnt; 
	private String marc;	
	private String shelf_loc_code; //배가위치부호
	private String shelf_loc_name; //자료실명
	private String return_plan_date; //반납예정이
	private String manage_code; //매체구분
	private String homepage_send_tell; //홈페이지 전화번호
	private String applicant_cell_phone; //신청자전화번호
	private String tomorrow_end_day_yn; //예약종료시간이 00시를 넘어가면 날짜가 바뀌므로 'Y'로 설정된다. ex)09시 ~ 09시까지
	private String pk; //예약key
	private String user_no; //대출자번호
	
	/*검색용*/
	private String search_date;
	private String search_date2;
	private String search_tomorrow_type;
	private String search_time;
	private String reserve_status_array;
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getDevice_name() {
		return device_name;
	}
	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	public int getDevice_idx() {
		return device_idx;
	}
	public void setDevice_idx(int device_idx) {
		this.device_idx = device_idx;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public int getDevice_password() {
		return device_password;
	}
	public void setDevice_password(int device_password) {
		this.device_password = device_password;
	}
	public String getReserve_status() {
		return reserve_status;
	}
	public void setReserve_status(String reserve_status) {
		this.reserve_status = reserve_status;
	}
	public String getReg_no() {
		return reg_no;
	}
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getUser_key() {
		return user_key;
	}
	public void setUser_key(String user_key) {
		this.user_key = user_key;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getAdd_ip() {
		return add_ip;
	}
	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}
	public String getCancel_reason() {
		return cancel_reason;
	}
	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}
	public String getCancel_id() {
		return cancel_id;
	}
	public void setCancel_id(String cancel_id) {
		this.cancel_id = cancel_id;
	}
	public String getCancel_ip() {
		return cancel_ip;
	}
	public void setCancel_ip(String cancel_ip) {
		this.cancel_ip = cancel_ip;
	}
	public String getSms_send_yn() {
		return sms_send_yn;
	}
	public void setSms_send_yn(String sms_send_yn) {
		this.sms_send_yn = sms_send_yn;
	}
	public String getDevice_code() {
		return device_code;
	}
	public void setDevice_code(String device_code) {
		this.device_code = device_code;
	}
	public Date getLend_date() {
		return lend_date;
	}
	public void setLend_date(Date lend_date) {
		this.lend_date = lend_date;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public Date getSms_send_date() {
		return sms_send_date;
	}
	public void setSms_send_date(Date sms_send_date) {
		this.sms_send_date = sms_send_date;
	}
	public int getLocker_idx() {
		return locker_idx;
	}
	public void setLocker_idx(int locker_idx) {
		this.locker_idx = locker_idx;
	}
	public int getReserve_bundle_idx() {
		return reserve_bundle_idx;
	}
	public void setReserve_bundle_idx(int reserve_bundle_idx) {
		this.reserve_bundle_idx = reserve_bundle_idx;
	}
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}
	public String getCtrl_no() {
		return ctrl_no;
	}
	public void setCtrl_no(String ctrl_no) {
		this.ctrl_no = ctrl_no;
	}
	public String getCall_no() {
		return call_no;
	}
	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}
	public String getPubler() {
		return publer;
	}
	public void setPubler(String publer) {
		this.publer = publer;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getBook_key() {
		return book_key;
	}
	public void setBook_key(String book_key) {
		this.book_key = book_key;
	}
	public String getBooktype() {
		return booktype;
	}
	public void setBooktype(String booktype) {
		this.booktype = booktype;
	}
	public String getTitle_info() {
		return title_info;
	}
	public void setTitle_info(String title_info) {
		this.title_info = title_info;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPub_year() {
		return pub_year;
	}
	public void setPub_year(String pub_year) {
		this.pub_year = pub_year;
	}
	public String getMedia_name() {
		return media_name;
	}
	public void setMedia_name(String media_name) {
		this.media_name = media_name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getBook_size() {
		return book_size;
	}
	public void setBook_size(String book_size) {
		this.book_size = book_size;
	}
	public String getMedia_code() {
		return media_code;
	}
	public void setMedia_code(String media_code) {
		this.media_code = media_code;
	}
	public String getBook_isbn() {
		return book_isbn;
	}
	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}
	public String getClass_no() {
		return class_no;
	}
	public void setClass_no(String class_no) {
		this.class_no = class_no;
	}
	public String getLoan_code() {
		return loan_code;
	}
	public void setLoan_code(String loan_code) {
		this.loan_code = loan_code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAppendix_cnt() {
		return appendix_cnt;
	}
	public void setAppendix_cnt(String appendix_cnt) {
		this.appendix_cnt = appendix_cnt;
	}
	public String getMarc() {
		return marc;
	}
	public void setMarc(String marc) {
		this.marc = marc;
	}
	public String getShelf_loc_code() {
		return shelf_loc_code;
	}
	public void setShelf_loc_code(String shelf_loc_code) {
		this.shelf_loc_code = shelf_loc_code;
	}
	public String getAppendix_info() {
		return appendix_info;
	}
	public void setAppendix_info(String appendix_info) {
		this.appendix_info = appendix_info;
	}
	public String getReturn_plan_date() {
		return return_plan_date;
	}
	public void setReturn_plan_date(String return_plan_date) {
		this.return_plan_date = return_plan_date;
	}
	public String getShelf_loc_name() {
		return shelf_loc_name;
	}
	public void setShelf_loc_name(String shelf_loc_name) {
		this.shelf_loc_name = shelf_loc_name;
	}
	public String getLib_name() {
		return lib_name;
	}
	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}
	public String getManage_code() {
		return manage_code;
	}
	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	public String getSearch_date() {
		return search_date;
	}
	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}
	public String getSearch_time() {
		return search_time;
	}
	public void setSearch_time(String search_time) {
		this.search_time = search_time;
	}
	public String getReserve_status_array() {
		return reserve_status_array;
	}
	public void setReserve_status_array(String reserve_status_array) {
		this.reserve_status_array = reserve_status_array;
	}
	public String getSearch_date2() {
		return search_date2;
	}
	public void setSearch_date2(String search_date2) {
		this.search_date2 = search_date2;
	}
	public String getSearch_tomorrow_type() {
		return search_tomorrow_type;
	}
	public void setSearch_tomorrow_type(String search_tomorrow_type) {
		this.search_tomorrow_type = search_tomorrow_type;
	}
	public String getTomorrow_end_day_yn() {
		return tomorrow_end_day_yn;
	}
	public void setTomorrow_end_day_yn(String tomorrow_end_day_yn) {
		this.tomorrow_end_day_yn = tomorrow_end_day_yn;
	}
	public String getHomepage_send_tell() {
		return homepage_send_tell;
	}
	public void setHomepage_send_tell(String homepage_send_tell) {
		this.homepage_send_tell = homepage_send_tell;
	}
	public String getApplicant_cell_phone() {
		return applicant_cell_phone;
	}
	public void setApplicant_cell_phone(String applicant_cell_phone) {
		this.applicant_cell_phone = applicant_cell_phone;
	}
	public int getTake_term() {
		return take_term;
	}
	public void setTake_term(int take_term) {
		this.take_term = take_term;
	}
	public int getExpire_date_cnt() {
		return expire_date_cnt;
	}
	public void setExpire_date_cnt(int expire_date_cnt) {
		this.expire_date_cnt = expire_date_cnt;
	}
	public String getPk() {
		return pk;
	}
	public void setPk(String pk) {
		this.pk = pk;
	}
	public String getLarge_book_yn() {
		return large_book_yn;
	}
	public void setLarge_book_yn(String large_book_yn) {
		this.large_book_yn = large_book_yn;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public int getLocker_each_idx() {
		return locker_each_idx;
	}
	public void setLocker_each_idx(int locker_each_idx) {
		this.locker_each_idx = locker_each_idx;
	}
	public String getReserve_idx_arr() {
		return reserve_idx_arr;
	}
	public void setReserve_idx_arr(String reserve_idx_arr) {
		this.reserve_idx_arr = reserve_idx_arr;
	}
	public String getReserve_end_date() {
		return reserve_end_date;
	}
	public void setReserve_end_date(String reserve_end_date) {
		this.reserve_end_date = reserve_end_date;
	}
	public String getReturn_device_code() {
		return return_device_code;
	}
	public void setReturn_device_code(String return_device_code) {
		this.return_device_code = return_device_code;
	}
	public String getReserve_start_date() {
		return reserve_start_date;
	}
	public void setReserve_start_date(String reserve_start_date) {
		this.reserve_start_date = reserve_start_date;
	}
}
