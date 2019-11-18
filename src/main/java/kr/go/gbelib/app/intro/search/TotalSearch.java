package kr.go.gbelib.app.intro.search;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.teach.Teach;

public class TotalSearch extends PagingUtils {

	private int book_more_count = 1;
	private int notice_more_count = 1;
	private int teach_more_count = 1;

	private String total_search_type = "TOTAL";
	private String sort_type;
	private String date_type = "ALL";
	private String start_date;
	private String end_date;
	private String more_type = "";

	// 도서 상세검색에 사용되는 변수들
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

	private String searchSubType1 = "RIGHT";	// 검색 범위1
	private String searchSubType2 = "RIGHT";	// 검색 범위2
	private String searchSubType3 = "RIGHT";	// 검색 범위3
	private String searchSubType4 = "RIGHT";	// 검색 범위4

	private String[] searchFormCode;	// 자료유형

	public TotalSearch() {
	}

	public String getSort_type() {
		return sort_type;
	}

	public void setSort_type(String sort_type) {
		this.sort_type = sort_type;
	}

	public String getDate_type() {
		return date_type;
	}

	public void setDate_type(String date_type) {
		this.date_type = date_type;
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

	public String getTotal_search_type() {
		return total_search_type;
	}

	public void setTotal_search_type(String total_search_type) {
		this.total_search_type = total_search_type;
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

	public LibrarySearch copyDetailSearchParam(LibrarySearch librarySearch) {
//		librarySearch.setSearchType1(this.getSearchType1());
//		librarySearch.setSearchType2(this.getSearchType2());
//		librarySearch.setSearchType3(this.getSearchType3());
//		librarySearch.setSearchType4(this.getSearchType4());
//
//		librarySearch.setSearchKeyword1(this.getSearchKeyword1());
//		librarySearch.setSearchKeyword2(this.getSearchKeyword2());
//		librarySearch.setSearchKeyword3(this.getSearchKeyword3());
//		librarySearch.setSearchKeyword4(this.getSearchKeyword4());
//
//		librarySearch.setSearchSubType1(this.getSearchSubType1());
//		librarySearch.setSearchSubType2(this.getSearchSubType2());
//		librarySearch.setSearchSubType3(this.getSearchSubType3());
//		librarySearch.setSearchSubType4(this.getSearchSubType4());
//
//		librarySearch.setLogicFunction1(this.getLogicFunction1());
//		librarySearch.setLogicFunction2(this.getLogicFunction2());
//		librarySearch.setLogicFunction3(this.getLogicFunction3());
//		librarySearch.setLogicFunction4(this.getLogicFunction4());
//		librarySearch.setLogicFunction5(this.getLogicFunction5());
//
//		librarySearch.setIsbnSearch(this.getIsbnSearch());
//		librarySearch.setKdcSearch(this.getKdcSearch());
//		librarySearch.setLangType(this.getLangType());
//		librarySearch.setSearchStYear(this.getSearchStYear());
//		librarySearch.setSearchEdYear(this.getSearchEdYear());

		System.out.println("########### : " + this.getIsbnSearch());
		System.out.println("########### : " + this.getKdcSearch());
		System.out.println("########### : " + this.getLangType());

		return librarySearch;
	}

	public Teach copyDetailSearchParam(Teach teach) {
		teach.setSearchKeyword1(this.getSearchKeyword1());
		teach.setSearchKeyword2(this.getSearchKeyword2());
		teach.setSearchKeyword3(this.getSearchKeyword3());
		teach.setSearchKeyword4(this.getSearchKeyword4());

		teach.setLogicFunction1(this.getLogicFunction1());
		teach.setLogicFunction2(this.getLogicFunction2());
		teach.setLogicFunction3(this.getLogicFunction3());
		teach.setLogicFunction4(this.getLogicFunction4());
		return teach;
	}

	public Board copyDetailSearchParam(Board board) {
		board.setSearchKeyword1(this.getSearchKeyword1());
		board.setSearchKeyword2(this.getSearchKeyword2());
		board.setSearchKeyword3(this.getSearchKeyword3());
		board.setSearchKeyword4(this.getSearchKeyword4());

		board.setLogicFunction1(this.getLogicFunction1());
		board.setLogicFunction2(this.getLogicFunction2());
		board.setLogicFunction3(this.getLogicFunction3());
		board.setLogicFunction4(this.getLogicFunction4());
		return board;
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

	public String getMore_type() {
		return more_type;
	}

	public void setMore_type(String more_type) {
		this.more_type = more_type;
	}

	public int getBook_more_count() {
		return book_more_count;
	}

	public void setBook_more_count(int book_more_count) {
		this.book_more_count = book_more_count;
	}

	public int getNotice_more_count() {
		return notice_more_count;
	}

	public void setNotice_more_count(int notice_more_count) {
		this.notice_more_count = notice_more_count;
	}

	public int getTeach_more_count() {
		return teach_more_count;
	}

	public void setTeach_more_count(int teach_more_count) {
		this.teach_more_count = teach_more_count;
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
