package kr.co.whalesoft.app.homepage.module.bookDream;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookDream extends PagingUtils {

	private String title;		//검색 결과 문서의 제목을 나타낸다. 제목에서 검색어와 일치하는 부분은 태그로 감싸져 있다.
    private String link;		//검색 결과 문서의 하이퍼텍스트 link를 나타낸다.
    private String image;		//썸네일 이미지의 URL이다. 이미지가 있는 경우만 나타납난다.
    private String author;		//저자 정보이다. 
    private int price;		//정가 정보이다. 절판도서 등으로 가격이 없으면 나타나지 않는다. 
    private int discount;	//할인 가격 정보이다. 절판도서 등으로 가격이 없으면 나타나지 않는다. 
    private String publisher;	//출판사 정보이다. 
    private String pubdate;		//출간일 정보이다. 
    private String isbn;		//ISBN 넘버이다. 
    private String description;	//검색 결과 문서의 내용을 요약한 패시지 정보이다. 문서 전체의 내용은 link를 따라가면 읽을 수 있다. 패시지에서 검색어와 일치하는 부분은 태그로 감싸져 있다. 
	
    private String storeCode;	//서점코드
    
    private String mobileno;	//신청자 전화번호
    private String email;		//신청자 이메일
    private String tellno;		//신청자 전화
    private String addres;		//신청자 주소
    private String userId;
    private String userName;
    
    private List<BookDream> innerList = new ArrayList<BookDream>();
    
    private int a_no;  //
    private String a_id;  //
    private String a_pw;  //
    private int a_level;  //
    private String a_assign;  //
    private String a_name;  //
    private Date a_created;  //
    private Date a_updated;  //
    private Date a_last;  //
    
    private int c_no;  //
    private String c_code;  //
    private String c_name;  //
    private String c_value;  //
    private String c_note;  //
    private Date c_created;  //
    private Date c_updated;  //
    private String c_state;  //
    
    private int r_no;  //
    private String r_src;  //
    private String r_src_nm;  //
    private String user_no;  //
    private String user_id;  //
    private int store_no;  //
    private String co_no;  //
    private String r_isbn;  //
    private String r_title;  //
    private String r_author;  //
    private int r_price;  //
    private String r_pay_type;  //
    private int r_pay;  //
    private String r_image;  //
    private String r_publisher;  //
    private String r_pubdate;  //
    private String r_name;  //
    private String r_hp;  //
    private String r_tel;  //
    private String r_zip;  //
    private String r_addr;  //
    private String r_email;  //
    private String r_state;  //
    private String r_state_nm;  //
    private Date r_calc;  //정산일시
    private Date r_payed;  //구매일시
    private Date r_return_close;  //
    private Date r_return_close14;  //
    private Date r_return;  //반환일시
    private Date r_refund;  //환불일시
    private Date r_created;  //등록일시
    private Date r_created5;  //등록일시
    private Date r_updated;  //수정일시
    
    private int s_no;  //
    private String s_id;  //
    private String s_pw;  //
    private String s_name;  //
    private String s_owner;  //
    private String s_tel;  //
    private Date s_created;  //
    private Date s_updated;  //

	private int rh_no;  //
//	private int r_no;  //
	private String rh_type;  //
	private String rh_set;  //
	private String rh_get;  //
	private String rh_post;  //
	private String rh_session;  //
	private String rh_ip;  //
	private String rh_referer;  //
	private String rh_url;  //
	private String rh_state;  //
	private Date rh_created;  //
	
	private String search_date = "r_created";
	private String start_date;
	private String end_date;
	private List<String> search_lib;
	private List<String> search_state;
	
	private String fromTel;
	private String fromTel2;
	private String fromTel3;
	
	private String d3_send_yn;
	private String dday_send_yn;
	
	private String batch;
	private int[] chkOne;
	
	public BookDream() {
		if (StringUtils.isEmpty(getSortField())) {
			setSortField("r_created");
		}
		if (StringUtils.isEmpty(getSortType())) {
			setSortType("DESC");
		}
	}
	
	public BookDream(String src, String isbn) {
		if (src.equals("00147039")) {
			this.r_src = "pungsan";
		} else if (src.equals("00147011")) {
			this.r_src = "yongsang";
		} else {
			this.r_src = "andong";
		}
		this.r_isbn = isbn;
	}
	
	
	
    public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPubdate() {
		return pubdate;
	}
	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStoreCode() {
		return storeCode;
	}
	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}
	public String getMobileno() {
		return mobileno;
	}
	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTellno() {
		return tellno;
	}
	public void setTellno(String tellno) {
		this.tellno = tellno;
	}
	public String getAddres() {
		return addres;
	}
	public void setAddres(String addres) {
		this.addres = addres;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public String getA_id() {
		return a_id;
	}
	public void setA_id(String a_id) {
		this.a_id = a_id;
	}
	public String getA_pw() {
		return a_pw;
	}
	public void setA_pw(String a_pw) {
		this.a_pw = a_pw;
	}
	public int getA_level() {
		return a_level;
	}
	public void setA_level(int a_level) {
		this.a_level = a_level;
	}
	public String getA_assign() {
		return a_assign;
	}
	public void setA_assign(String a_assign) {
		this.a_assign = a_assign;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public Date getA_created() {
		return a_created;
	}
	public void setA_created(Date a_created) {
		this.a_created = a_created;
	}
	public Date getA_updated() {
		return a_updated;
	}
	public void setA_updated(Date a_updated) {
		this.a_updated = a_updated;
	}
	public Date getA_last() {
		return a_last;
	}
	public void setA_last(Date a_last) {
		this.a_last = a_last;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getC_code() {
		return c_code;
	}
	public void setC_code(String c_code) {
		this.c_code = c_code;
	}
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}
	public String getC_value() {
		return c_value;
	}
	public void setC_value(String c_value) {
		this.c_value = c_value;
	}
	public String getC_note() {
		return c_note;
	}
	public void setC_note(String c_note) {
		this.c_note = c_note;
	}
	public Date getC_created() {
		return c_created;
	}
	public void setC_created(Date c_created) {
		this.c_created = c_created;
	}
	public Date getC_updated() {
		return c_updated;
	}
	public void setC_updated(Date c_updated) {
		this.c_updated = c_updated;
	}
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public String getR_src() {
		return r_src;
	}
	public void setR_src(String r_src) {
		this.r_src = r_src;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getStore_no() {
		return store_no;
	}
	public void setStore_no(int store_no) {
		this.store_no = store_no;
	}
	public String getCo_no() {
		return co_no;
	}
	public void setCo_no(String co_no) {
		this.co_no = co_no;
	}
	public String getR_isbn() {
		return r_isbn;
	}
	public void setR_isbn(String r_isbn) {
		this.r_isbn = r_isbn;
	}
	public String getR_title() {
		return r_title;
	}
	public void setR_title(String r_title) {
		this.r_title = r_title;
	}
	public String getR_author() {
		return r_author;
	}
	public void setR_author(String r_author) {
		this.r_author = r_author;
	}
	public int getR_price() {
		return r_price;
	}
	public void setR_price(int r_price) {
		this.r_price = r_price;
	}
	public String getR_pay_type() {
		return r_pay_type;
	}
	public void setR_pay_type(String r_pay_type) {
		this.r_pay_type = r_pay_type;
	}
	public int getR_pay() {
		return r_pay;
	}
	public void setR_pay(int r_pay) {
		this.r_pay = r_pay;
	}
	public String getR_image() {
		return r_image;
	}
	public void setR_image(String r_image) {
		this.r_image = r_image;
	}
	public String getR_publisher() {
		return r_publisher;
	}
	public void setR_publisher(String r_publisher) {
		this.r_publisher = r_publisher;
	}
	public String getR_pubdate() {
		return r_pubdate;
	}
	public void setR_pubdate(String r_pubdate) {
		this.r_pubdate = r_pubdate;
	}
	public String getR_name() {
		return r_name;
	}
	public void setR_name(String r_name) {
		this.r_name = r_name;
	}
	public String getR_hp() {
		return r_hp;
	}
	public void setR_hp(String r_hp) {
		this.r_hp = r_hp;
	}
	public String getR_tel() {
		return r_tel;
	}
	public void setR_tel(String r_tel) {
		this.r_tel = r_tel;
	}
	public String getR_zip() {
		return r_zip;
	}
	public void setR_zip(String r_zip) {
		this.r_zip = r_zip;
	}
	public String getR_addr() {
		return r_addr;
	}
	public void setR_addr(String r_addr) {
		this.r_addr = r_addr;
	}
	public String getR_email() {
		return r_email;
	}
	public void setR_email(String r_email) {
		this.r_email = r_email;
	}
	public String getR_state() {
		return r_state;
	}
	public void setR_state(String r_state) {
		this.r_state = r_state;
	}
	public Date getR_calc() {
		return r_calc;
	}
	public void setR_calc(Date r_calc) {
		this.r_calc = r_calc;
	}
	public Date getR_payed() {
		return r_payed;
	}
	public void setR_payed(Date r_payed) {
		this.r_payed = r_payed;
	}
	public Date getR_return_close() {
		return r_return_close;
	}
	public void setR_return_close(Date r_return_close) {
		this.r_return_close = r_return_close;
	}
	public Date getR_return() {
		return r_return;
	}
	public void setR_return(Date r_return) {
		this.r_return = r_return;
	}
	public Date getR_refund() {
		return r_refund;
	}
	public void setR_refund(Date r_refund) {
		this.r_refund = r_refund;
	}
	public Date getR_created() {
		return r_created;
	}
	public void setR_created(Date r_created) {
		this.r_created = r_created;
	}
	public Date getR_updated() {
		return r_updated;
	}
	public void setR_updated(Date r_updated) {
		this.r_updated = r_updated;
	}
	public int getS_no() {
		return s_no;
	}
	public void setS_no(int s_no) {
		this.s_no = s_no;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getS_pw() {
		return s_pw;
	}
	public void setS_pw(String s_pw) {
		this.s_pw = s_pw;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_owner() {
		return s_owner;
	}
	public void setS_owner(String s_owner) {
		this.s_owner = s_owner;
	}
	public String getS_tel() {
		return s_tel;
	}
	public void setS_tel(String s_tel) {
		this.s_tel = s_tel;
	}
	public Date getS_created() {
		return s_created;
	}
	public void setS_created(Date s_created) {
		this.s_created = s_created;
	}
	public Date getS_updated() {
		return s_updated;
	}
	public void setS_updated(Date s_updated) {
		this.s_updated = s_updated;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public List<BookDream> getInnerList() {
		return innerList;
	}
	public void setInnerList(List<BookDream> innerList) {
		this.innerList = innerList;
	}
	public int getRh_no() {
		return rh_no;
	}
	public void setRh_no(int rh_no) {
		this.rh_no = rh_no;
	}
	public String getRh_type() {
		return rh_type;
	}
	public void setRh_type(String rh_type) {
		this.rh_type = rh_type;
	}
	public String getRh_set() {
		return rh_set;
	}
	public void setRh_set(String rh_set) {
		this.rh_set = rh_set;
	}
	public String getRh_get() {
		return rh_get;
	}
	public void setRh_get(String rh_get) {
		this.rh_get = rh_get;
	}
	public String getRh_post() {
		return rh_post;
	}
	public void setRh_post(String rh_post) {
		this.rh_post = rh_post;
	}
	public String getRh_session() {
		return rh_session;
	}
	public void setRh_session(String rh_session) {
		this.rh_session = rh_session;
	}
	public String getRh_ip() {
		return rh_ip;
	}
	public void setRh_ip(String rh_ip) {
		this.rh_ip = rh_ip;
	}
	public String getRh_referer() {
		return rh_referer;
	}
	public void setRh_referer(String rh_referer) {
		this.rh_referer = rh_referer;
	}
	public String getRh_url() {
		return rh_url;
	}
	public void setRh_url(String rh_url) {
		this.rh_url = rh_url;
	}
	public Date getRh_created() {
		return rh_created;
	}
	public void setRh_created(Date rh_created) {
		this.rh_created = rh_created;
	}
	public String getR_state_nm() {
		return r_state_nm;
	}
	public void setR_state_nm(String r_state_nm) {
		this.r_state_nm = r_state_nm;
	}
	public String getRh_state() {
		return rh_state;
	}
	public void setRh_state(String rh_state) {
		this.rh_state = rh_state;
	}
	public String getR_src_nm() {
		return r_src_nm;
	}
	public void setR_src_nm(String r_src_nm) {
		this.r_src_nm = r_src_nm;
	}
	public String getSearch_date() {
		return search_date;
	}
	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}
	public String getStart_date() {
		if (StringUtils.isEmpty(this.start_date)) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -1);
			Date date = cal.getTime();
			this.start_date = new SimpleDateFormat("yyyy-MM-dd").format(date);
		}
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		if (StringUtils.isEmpty(this.end_date)) {
			this.end_date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		}
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public List<String> getSearch_lib() {
		return search_lib;
	}
	public void setSearch_lib(List<String> search_lib) {
		this.search_lib = search_lib;
	}
	public List<String> getSearch_state() {
		return search_state;
	}
	public void setSearch_state(List<String> search_state) {
		this.search_state = search_state;
	}
	public Date getR_created5() {
		return r_created5;
	}
	public void setR_created5(Date r_created5) {
		this.r_created5 = r_created5;
	}
	public Date getR_return_close14() {
		return r_return_close14;
	}
	public void setR_return_close14(Date r_return_close14) {
		this.r_return_close14 = r_return_close14;
	}
	public String getFromTel() {
		return fromTel;
	}
	public void setFromTel(String fromTel) {
		this.fromTel = fromTel;
	}
	public String getFromTel2() {
		return fromTel2;
	}
	public void setFromTel2(String fromTel2) {
		this.fromTel2 = fromTel2;
	}
	public String getFromTel3() {
		return fromTel3;
	}
	public void setFromTel3(String fromTel3) {
		this.fromTel3 = fromTel3;
	}
	public String getD3_send_yn() {
		return d3_send_yn;
	}
	public void setD3_send_yn(String d3_send_yn) {
		this.d3_send_yn = d3_send_yn;
	}
	public String getDday_send_yn() {
		return dday_send_yn;
	}
	public void setDday_send_yn(String dday_send_yn) {
		this.dday_send_yn = dday_send_yn;
	}
	public String getBatch() {
		return batch;
	}
	public void setBatch(String batch) {
		this.batch = batch;
	}
	public int[] getChkOne() {
		return chkOne;
	}
	public void setChkOne(int[] chkOne) {
		this.chkOne = chkOne;
	}
	
}
