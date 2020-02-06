package kr.go.gbelib.app.intro.search;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LibrarySearch extends PagingUtils {

	private String allBookListStr;
	private List<String> libraryCodes;
	private String search_year;
	private String search_library;
	private String search_form_code;
	private String search_kdc;
	private String search_athor;
	private String search_publisher;
	private String search_type2;// 패싯 검색

	private boolean sub_search;
	private int menu_idx;

	// 희망 도서 관련 변수
	private String select_no;
	private String title;
	private String author;
	private String publer;
	private String publer_year;
	private String isbn;
	private String editon;
	private String user_remark;
	private String search_start_date;
	private String search_end_date;
	private String price;
	private String loca_name;
	private String cancelable_yn;
	private String insert_date;
	private String process_date;
	private String status_flag_display;
	private String sms_receipt_yn;
	private String furnish_status;//비치상태 1:신청중, 2:처리중, 3:소장중, 4:취소, null:전체
	private String recom_opinion;

	private int vStartPos;
	private int vEndPos;

	private String vCtrl;
	private String vLoca;
	private String vSubLoca;
	private String vImg;
	private String tid;

	// 도서 예약 관련 변수
	private String vAccNo; // 도서등록번호
	private String vResveNo; // 예약 일련번호

	// 도서 대출 관련 변수
	private String vLoanNo;

	// 상호대차 관련 변수
	private String vItemLoca;
	private String vRecptLoca;
	private String vSeqNo;
	private String out_check;

	private String print_cmd_page;
	private List<String> print_param;

	private String excel_type; // 희망도서냐, 대출이냐, 예약이냐,등등
	private String excel_type_detail; // 중이거냐 히스토리냐

	private String detailSearchYN = "N";

	private String birth_year; // yyyy
	private String sex; // m, f

	private String searchType;

	private String[] searchFormCode; // 자료유형

	/**
	 * KCMS용 변수
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @return
	 */
	private String manageCode; // 도서관부호 영문 2자리
	private String libCode; // 도서관부호 숫자6자리
	private String regNo; // 등록번호
	private String keyword; // 키워드
	private String shelfCode; // 자료실코드
	private String notShelfCode; // 자료실코드
	private String subjectCode; // 주제부호( comma로 여러개 )
	private String regCode; // 등록구분( comma로 여러개 )
	private String separateShelfCode; // 별치기호( comma로 여러개 )

	private String return_plan_date; // 반납예정일 YYYYMMDD
	private String return_delay_cnt; // 반납연기횟수
	private String loan_date; // 대출일 YYYYMMDD
	private String bookkey; // 책 key
	private String userkey; // 이용자 key
	private String booktype; // 자료타입(BO:단행본, SE:연속간행물)
	private String speciesKey; // 종키
	private String uselibcode; // 제공받을도서관 - 상호대차
	private String appendixrctyn; // 부록신청여부 - 상호대차
	private String loan_key;
	private String hold_lib_code;
	private String local_book_key;
	private String kl_member_yn;
	private String reservation_yn;//우선대출예약여부(Y/N)
	private String exprire_date_cnt;

	private String address;
	private String zip_code;
	private String phone;
	private String cell_phone1;
	private String cell_phone2;
	private String cell_phone3;

	private String media_code;
	private String worker;//무인예약,야간예약 장비

	private String shelf_list;	// 자료실 구분 (상세 검색 조건)

	private String facet_manage_code; //패싯 도서관 관리코드
	private String facet_author; //패싯 저자명
	private String facet_publisher; //패싯 발행자
	private String facet_pub_year; //패싯 발행년도
	private String facet_subject_code; //패싯 분류기호의 첫번째 숫자(0~9)
	private String facet_media_code; //패싯 매체구분

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public LibrarySearch() {
		this.setSortField("NONE");
		this.setSortType("");
	}

	public LibrarySearch(String vLoca, String vCtrl) {
		this.setSortType("ASC");
		this.vLoca = vLoca;
		this.vCtrl = vCtrl;
	}

	public LibrarySearch(int vStartPos, int vEndPos) {
		this.setSortType("ASC");
		this.vStartPos = vStartPos;
		this.vEndPos = vEndPos;
	}

	public LibrarySearch(String vLoca, int vStartPos, int vEndPos) {
		this.setSortType("ASC");
		this.vLoca = vLoca;
		this.vStartPos = vStartPos;
		this.vEndPos = vEndPos;
	}

	public LibrarySearch(String manageCode, String search_start_date, String search_end_date) {
		this.setSortField("NONE");
		this.setSortType("ASC");
		this.manageCode = manageCode;
		this.search_start_date = search_start_date;
		this.search_end_date = search_end_date;
	}

	public String getAllBookListStr() {
		return allBookListStr;
	}

	public void setAllBookListStr(String allBookListStr) {
		this.allBookListStr = allBookListStr;
	}

	public List<String> getLibraryCodes() {
		if (libraryCodes != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.libraryCodes);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setLibraryCodes(List<String> libraryCodes) {
		if (libraryCodes != null) {
			this.libraryCodes = new ArrayList<String>();
			this.libraryCodes.addAll(libraryCodes);
		}
	}

	public String getSearch_year() {
		return search_year;
	}

	public void setSearch_year(String search_year) {
		this.search_year = search_year;
	}

	public String getSearch_library() {
		return search_library;
	}

	public void setSearch_library(String search_library) {
		this.search_library = search_library;
	}

	public String getSearch_form_code() {
		return search_form_code;
	}

	public void setSearch_form_code(String search_form_code) {
		this.search_form_code = search_form_code;
	}

	public String getSearch_kdc() {
		return search_kdc;
	}

	public void setSearch_kdc(String search_kdc) {
		this.search_kdc = search_kdc;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPubler() {
		return publer;
	}

	public void setPubler(String publer) {
		this.publer = publer;
	}

	public String getPubler_year() {
		return publer_year;
	}

	public void setPubler_year(String publer_year) {
		this.publer_year = publer_year;
	}

	public String getIsbn() {
		return isbn;
	}

	public String getOut_check() {
		return out_check;
	}

	public void setOut_check(String out_check) {
		this.out_check = out_check;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getEditon() {
		return editon;
	}

	public void setEditon(String editon) {
		this.editon = editon;
	}

	public String getUser_remark() {
		return user_remark;
	}

	public void setUser_remark(String user_remark) {
		this.user_remark = user_remark;
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

	public boolean isSub_search() {
		return sub_search;
	}

	public void setSub_search(boolean sub_search) {
		this.sub_search = sub_search;
	}

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public String getSelect_no() {
		return select_no;
	}

	public void setSelect_no(String select_no) {
		this.select_no = select_no;
	}

	public String getvCtrl() {
		return vCtrl;
	}

	public void setvCtrl(String vCtrl) {
		this.vCtrl = vCtrl;
	}

	public String getvLoca() {
		return vLoca;
	}

	public void setvLoca(String vLoca) {
		this.vLoca = vLoca;
	}

	public String getvSubLoca() {
		return vSubLoca;
	}

	public void setvSubLoca(String vSubLoca) {
		this.vSubLoca = vSubLoca;
	}

	public String getvAccNo() {
		return vAccNo;
	}

	public void setvAccNo(String vAccNo) {
		this.vAccNo = vAccNo;
	}

	public String getvResveNo() {
		return vResveNo;
	}

	public void setvResveNo(String vResveNo) {
		this.vResveNo = vResveNo;
	}

	public String getvItemLoca() {
		return vItemLoca;
	}

	public void setvItemLoca(String vItemLoca) {
		this.vItemLoca = vItemLoca;
	}

	public String getvRecptLoca() {
		return vRecptLoca;
	}

	public void setvRecptLoca(String vRecptLoca) {
		this.vRecptLoca = vRecptLoca;
	}

	public String getvSeqNo() {
		return vSeqNo;
	}

	public void setvSeqNo(String vSeqNo) {
		this.vSeqNo = vSeqNo;
	}

	public String getvLoanNo() {
		return vLoanNo;
	}

	public void setvLoanNo(String vLoanNo) {
		this.vLoanNo = vLoanNo;
	}

	public int getvStartPos() {
		return vStartPos;
	}

	public void setvStartPos(int vStartPos) {
		this.vStartPos = vStartPos;
	}

	public int getvEndPos() {
		return vEndPos;
	}

	public void setvEndPos(int vEndPos) {
		this.vEndPos = vEndPos;
	}

	public String getvImg() {
		return vImg;
	}

	public void setvImg(String vImg) {
		this.vImg = vImg;
	}

	public String getSearch_athor() {
		return search_athor;
	}

	public void setSearch_athor(String search_athor) {
		this.search_athor = search_athor;
	}

	public String getSearch_publisher() {
		return search_publisher;
	}

	public void setSearch_publisher(String search_publisher) {
		this.search_publisher = search_publisher;
	}

	public String getPrint_cmd_page() {
		return print_cmd_page;
	}

	public void setPrint_cmd_page(String print_cmd_page) {
		this.print_cmd_page = print_cmd_page;
	}

	public List<String> getPrint_param() {
		return print_param;
	}

	public void setPrint_param(List<String> print_param) {
		this.print_param = new ArrayList<String>();
		this.print_param = print_param;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getCancelable_yn() {
		return cancelable_yn;
	}

	public void setCancelable_yn(String cancelable_yn) {
		this.cancelable_yn = cancelable_yn;
	}

	public String getLoca_name() {
		return loca_name;
	}

	public void setLoca_name(String loca_name) {
		this.loca_name = loca_name;
	}

	public String getInsert_date() {
		return insert_date;
	}

	public void setInsert_date(String insert_date) {
		this.insert_date = insert_date;
	}

	public String getProcess_date() {
		return process_date;
	}

	public void setProcess_date(String process_date) {
		this.process_date = process_date;
	}

	public String getStatus_flag_display() {
		return status_flag_display;
	}

	public void setStatus_flag_display(String status_flag_display) {
		this.status_flag_display = status_flag_display;
	}

	public String getExcel_type() {
		return excel_type;
	}

	public void setExcel_type(String excel_type) {
		this.excel_type = excel_type;
	}

	public String getExcel_type_detail() {
		return excel_type_detail;
	}

	public void setExcel_type_detail(String excel_type_detail) {
		this.excel_type_detail = excel_type_detail;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getSearch_type2() {
		return search_type2;
	}

	public void setSearch_type2(String search_type2) {
		this.search_type2 = search_type2;
	}


	public String getDetailSearchYN() {
		return detailSearchYN;
	}

	public void setDetailSearchYN(String detailSearchYN) {
		this.detailSearchYN = detailSearchYN;
	}

	public String getBirth_year() {
		return birth_year;
	}

	public void setBirth_year(String birth_year) {
		this.birth_year = birth_year;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}


	public String[] getSearchFormCode() {
		return searchFormCode;
	}

	public void setSearchFormCode(String[] searchFormCode) {
		this.searchFormCode = searchFormCode;
	}

	public String getManageCode() {
		return manageCode;
	}

	public void setManageCode(String manageCode) {
		this.manageCode = manageCode;
	}

	public String getLibCode() {
		return libCode;
	}

	public void setLibCode(String libCode) {
		this.libCode = libCode;
	}

	public String getRegNo() {
		return regNo;
	}

	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getShelfCode() {
		return shelfCode;
	}

	public void setShelfCode(String shelfCode) {
		this.shelfCode = shelfCode;
	}

	public String getSubjectCode() {
		return subjectCode;
	}

	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}

	public String getRegCode() {
		return regCode;
	}

	public void setRegCode(String regCode) {
		this.regCode = regCode;
	}

	public String getReturn_plan_date() {
		return return_plan_date;
	}

	public void setReturn_plan_date(String return_plan_date) {
		this.return_plan_date = return_plan_date;
	}

	public String getReturn_delay_cnt() {
		return return_delay_cnt;
	}

	public void setReturn_delay_cnt(String return_delay_cnt) {
		this.return_delay_cnt = return_delay_cnt;
	}

	public String getLoan_date() {
		return loan_date;
	}

	public void setLoan_date(String loan_date) {
		this.loan_date = loan_date;
	}

	public String getBookkey() {
		return bookkey;
	}

	public void setBookkey(String bookkey) {
		this.bookkey = bookkey;
	}

	public String getUserkey() {
		return userkey;
	}

	public void setUserkey(String userkey) {
		this.userkey = userkey;
	}

	public String getBooktype() {
		return booktype;
	}

	public void setBooktype(String booktype) {
		this.booktype = booktype;
	}

	public String getSpeciesKey() {
		return speciesKey;
	}

	public void setSpeciesKey(String speciesKey) {
		this.speciesKey = speciesKey;
	}

	public String getUselibcode() {
		return uselibcode;
	}

	public void setUselibcode(String uselibcode) {
		this.uselibcode = uselibcode;
	}

	public String getAppendixrctyn() {
		return appendixrctyn;
	}

	public void setAppendixrctyn(String appendixrctyn) {
		this.appendixrctyn = appendixrctyn;
	}

	public String getLoan_key() {
		return loan_key;
	}

	public void setLoan_key(String loan_key) {
		this.loan_key = loan_key;
	}

	public String getHold_lib_code() {
		return hold_lib_code;
	}

	public void setHold_lib_code(String hold_lib_code) {
		this.hold_lib_code = hold_lib_code;
	}

	public String getLocal_book_key() {
		return local_book_key;
	}

	public void setLocal_book_key(String local_book_key) {
		this.local_book_key = local_book_key;
	}

	public String getKl_member_yn() {
		return kl_member_yn;
	}

	public void setKl_member_yn(String kl_member_yn) {
		this.kl_member_yn = kl_member_yn;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZip_code() {
		return zip_code;
	}

	public void setZip_code(String zip_code) {
		this.zip_code = zip_code;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCell_phone1() {
		return cell_phone1;
	}

	public void setCell_phone1(String cell_phone1) {
		this.cell_phone1 = cell_phone1;
	}

	public String getCell_phone2() {
		return cell_phone2;
	}

	public void setCell_phone2(String cell_phone2) {
		this.cell_phone2 = cell_phone2;
	}

	public String getCell_phone3() {
		return cell_phone3;
	}

	public void setCell_phone3(String cell_phone3) {
		this.cell_phone3 = cell_phone3;
	}

	public String getMedia_code() {
		return media_code;
	}

	public void setMedia_code(String media_code) {
		this.media_code = media_code;
	}

	public String getShelf_list() {
		return shelf_list;
	}

	public void setShelf_list(String shelf_list) {
		this.shelf_list = shelf_list;
	}

	public String getSms_receipt_yn() {
		return sms_receipt_yn;
	}

	public void setSms_receipt_yn(String sms_receipt_yn) {
		this.sms_receipt_yn = sms_receipt_yn;
	}

	public String getFurnish_status() {
		return furnish_status;
	}

	public void setFurnish_status(String furnish_status) {
		this.furnish_status = furnish_status;
	}

	public String getRecom_opinion() {
		return recom_opinion;
	}

	public void setRecom_opinion(String recom_opinion) {
		this.recom_opinion = recom_opinion;
	}


	public String getWorker() {
		return worker;
	}


	public void setWorker(String worker) {
		this.worker = worker;
	}


	public String getSeparateShelfCode() {
		return separateShelfCode;
	}


	public void setSeparateShelfCode(String separateShelfCode) {
		this.separateShelfCode = separateShelfCode;
	}


	public String getFacet_manage_code() {
		return facet_manage_code;
	}


	public String getFacet_author() {
		return facet_author;
	}


	public String getFacet_publisher() {
		return facet_publisher;
	}


	public String getFacet_pub_year() {
		return facet_pub_year;
	}


	public String getFacet_subject_code() {
		return facet_subject_code;
	}


	public String getFacet_media_code() {
		return facet_media_code;
	}


	public void setFacet_manage_code(String facet_manage_code) {
		this.facet_manage_code = facet_manage_code;
	}


	public void setFacet_author(String facet_author) {
		this.facet_author = facet_author;
	}


	public void setFacet_publisher(String facet_publisher) {
		this.facet_publisher = facet_publisher;
	}


	public void setFacet_pub_year(String facet_pub_year) {
		this.facet_pub_year = facet_pub_year;
	}


	public void setFacet_subject_code(String facet_subject_code) {
		this.facet_subject_code = facet_subject_code;
	}


	public void setFacet_media_code(String facet_media_code) {
		this.facet_media_code = facet_media_code;
	}


	public String getNotShelfCode() {
		return notShelfCode;
	}


	public void setNotShelfCode(String notShelfCode) {
		this.notShelfCode = notShelfCode;
	}


	public String getReservation_yn() {
		return reservation_yn;
	}


	public void setReservation_yn(String reservation_yn) {
		this.reservation_yn = reservation_yn;
	}


	public String getExprire_date_cnt() {
		return exprire_date_cnt;
	}


	public void setExprire_date_cnt(String exprire_date_cnt) {
		this.exprire_date_cnt = exprire_date_cnt;
	}

}
