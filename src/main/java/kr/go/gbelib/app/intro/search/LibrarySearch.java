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
	private String search_type2;//패싯 검색
	
	private boolean sub_search;
	private int menu_idx;
	
	//희망 도서 관련 변수
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
	
	private int vStartPos;
	private int vEndPos;
	
	private String vCtrl;
	private String vLoca;
	private String vSubLoca;
	private String vImg;
	private String tid;
	
	//도서 예약 관련 변수 
	private String vAccNo; //도서등록번호
	private String vResveNo; //예약 일련번호
	
	//도서 대출 관련 변수
	private String vLoanNo;
	
	//상호대차 관련 변수 
	private String vItemLoca;
	private String vRecptLoca;
	private String vSeqNo;
	private String out_check;
	
	private String print_cmd_page;
	private List<String> print_param;
	
	private String excel_type; //희망도서냐, 대출이냐, 예약이냐,등등 
	private String excel_type_detail; // 중이거냐 히스토리냐
	
	private String searchType1="TITLE";//서명(TITLE), 저자(AUTHOR), 출판사(PUBLISHER), 키워드 (KEYWORD) 중 택 1.
	private String searchType2="AUTHOR";//서명(TITLE), 저자(AUTHOR), 출판사(PUBLISHER), 키워드 (KEYWORD) 중 택 1.
	private String searchType3="PUBLISHER";//서명(TITLE), 저자(AUTHOR), 출판사(PUBLISHER), 키워드 (KEYWORD) 중 택 2.
	private String searchType4="KEYWORD";//서명(TITLE), 저자(AUTHOR), 출판사(PUBLISHER), 키워드 (KEYWORD) 중 택 1.
	private String searchKeyword1 = "";//searchType1 의 검색어
	private String searchKeyword2 = "";//searchType2 의 검색어
	private String searchKeyword3 = "";//searchType3 의 검색어
	private String searchKeyword4 = "";//searchType4 의 검색어
	private String logicFunction1 = "AND";//searchKeyowrd1 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction2 = "AND";//searchKeyowrd2 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction3 = "AND";//searchKeyowrd3 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String logicFunction4 = "AND";//searchKeyowrd4 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String isbnSearch = "";//ISBN 검색어(경북은 ISBN 만 존재합니다.)
	private String logicFunction5 = "AND";//isbnSearch 뒤의 조건절 (AND, OR, NOT 중 택 1)
	private String kdcSearch = "";//10진분류(KDC) 검색어
	private String langType;//본문언어(언어 종류는 퓨처에 문의 하시기 바랍니다.)
	private String searchStYear;//발행년도 시작일 (숫자 4자리 체크해주세요.)
	private String searchEdYear;//발행년도 종료일 (숫자 4자리 체크해주세요.)

	private String detailSearchYN = "N";
	
	private String birth_year; //yyyy
	private String sex;	//m, f
	
	private String searchType;
	
	private String searchSubType1 = "RIGHT";	// 검색 범위1
	private String searchSubType2 = "RIGHT";	// 검색 범위2
	private String searchSubType3 = "RIGHT";	// 검색 범위3
	private String searchSubType4 = "RIGHT";	// 검색 범위4
	
	private String[] searchFormCode;	// 자료유형
	
	public String getSearchType() {
		return searchType;
	}

	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public LibrarySearch() {
		this.setSortType("ASC");
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
	
	public LibrarySearch(String vLoca, String search_start_date, String search_end_date) {
		this.setSortType("ASC");
		this.vLoca = vLoca;
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
		if(libraryCodes != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.libraryCodes);
			return arrayList;
		} else {
			return null;
		}
	}
	public void setLibraryCodes(List<String> libraryCodes) {
		if(libraryCodes != null) {
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

	public String getSearchType1() {
		return searchType1;
	}

	public void setSearchType1(String searchType1) {
		this.searchType1 = searchType1;
	}

	public String getSearchType2() {
		return searchType2;
	}

	public void setSearchType2(String searchType2) {
		this.searchType2 = searchType2;
	}

	public String getSearchType3() {
		return searchType3;
	}

	public void setSearchType3(String searchType3) {
		this.searchType3 = searchType3;
	}

	public String getSearchType4() {
		return searchType4;
	}

	public void setSearchType4(String searchType4) {
		this.searchType4 = searchType4;
	}

	public String getLogicFunction1() {
		return logicFunction1;
	}

	public void setLogicFunction1(String logicFunction1) {
		this.logicFunction1 = logicFunction1;
	}

	public String getLogicFunction2() {
		return logicFunction2;
	}

	public void setLogicFunction2(String logicFunction2) {
		this.logicFunction2 = logicFunction2;
	}

	public String getLogicFunction3() {
		return logicFunction3;
	}

	public void setLogicFunction3(String logicFunction3) {
		this.logicFunction3 = logicFunction3;
	}

	public String getLogicFunction4() {
		return logicFunction4;
	}

	public void setLogicFunction4(String logicFunction4) {
		this.logicFunction4 = logicFunction4;
	}

	public String getIsbnSearch() {
		return isbnSearch;
	}

	public void setIsbnSearch(String isbnSearch) {
		this.isbnSearch = isbnSearch;
	}

	public String getLogicFunction5() {
		return logicFunction5;
	}

	public void setLogicFunction5(String logicFunction5) {
		this.logicFunction5 = logicFunction5;
	}

	public String getKdcSearch() {
		return kdcSearch;
	}

	public void setKdcSearch(String kdcSearch) {
		this.kdcSearch = kdcSearch;
	}

	public String getLangType() {
		return langType;
	}

	public void setLangType(String langType) {
		this.langType = langType;
	}

	public String getSearchStYear() {
		return searchStYear;
	}

	public void setSearchStYear(String searchStYear) {
		this.searchStYear = searchStYear;
	}

	public String getSearchEdYear() {
		return searchEdYear;
	}

	public void setSearchEdYear(String searchEdYear) {
		this.searchEdYear = searchEdYear;
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

	public String getSearchKeyword1() {
		return searchKeyword1;
	}

	public void setSearchKeyword1(String searchKeyword1) {
		this.searchKeyword1 = searchKeyword1;
	}

	public String getSearchKeyword2() {
		return searchKeyword2;
	}

	public void setSearchKeyword2(String searchKeyword2) {
		this.searchKeyword2 = searchKeyword2;
	}

	public String getSearchKeyword3() {
		return searchKeyword3;
	}

	public void setSearchKeyword3(String searchKeyword3) {
		this.searchKeyword3 = searchKeyword3;
	}

	public String getSearchKeyword4() {
		return searchKeyword4;
	}

	public void setSearchKeyword4(String searchKeyword4) {
		this.searchKeyword4 = searchKeyword4;
	}


	public String getSearchSubType1() {
		return searchSubType1;
	}


	public void setSearchSubType1(String searchSubType1) {
		this.searchSubType1 = searchSubType1;
	}


	public String getSearchSubType2() {
		return searchSubType2;
	}


	public void setSearchSubType2(String searchSubType2) {
		this.searchSubType2 = searchSubType2;
	}


	public String getSearchSubType3() {
		return searchSubType3;
	}


	public void setSearchSubType3(String searchSubType3) {
		this.searchSubType3 = searchSubType3;
	}


	public String getSearchSubType4() {
		return searchSubType4;
	}


	public void setSearchSubType4(String searchSubType4) {
		this.searchSubType4 = searchSubType4;
	}


	public String[] getSearchFormCode() {
		return searchFormCode;
	}


	public void setSearchFormCode(String[] searchFormCode) {
		this.searchFormCode = searchFormCode;
	}
	
}
