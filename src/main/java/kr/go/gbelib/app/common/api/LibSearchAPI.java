package kr.go.gbelib.app.common.api;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.intro.search.LibrarySearch;

public class LibSearchAPI {
	protected final static Logger log = LoggerFactory.getLogger(LibSearchAPI.class);

	public final static String API_TYPE = "LIBONE";

	/**
	 * 검색 목록
	 *
	 * @param searchType
	 * @param searchKeyword
	 * @param searchKind
	 * @param curPageNum
	 * @param allBookListStr
	 * @return Map<String, Object> 검색결과
	 */
	public static Map<String, Object> getSearch(LibrarySearch librarySearch, int curPageNum) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("pageSize", librarySearch.getRowCount());
		try {
			param.put("searchKeyword", URLEncoder.encode(librarySearch.getSearch_text(), "UTF-8"));
		}
		catch ( UnsupportedEncodingException e ) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		param.put("curPageNum", curPageNum);
		String searchType = librarySearch.getSearch_type2();
		if ( StringUtils.isEmpty(searchType) ) {
			searchType = "L_TITLE";
			librarySearch.setSortField("TITLE");
			librarySearch.setSortType("DESC");
		}

		if (librarySearch.getSortField().equals("add_date")) {
			librarySearch.setSortField("TITLE");
		}

		param.put("order", librarySearch.getSortField());
		param.put("sort", librarySearch.getSortType());

		param.put("cmd", searchType);
		if ( StringUtils.isNotEmpty(librarySearch.getBirth_year()) ) {
			param.put("birth_year", librarySearch.getBirth_year());
		}
		if ( StringUtils.isNotEmpty(librarySearch.getSex()) ) {
			param.put("sex", librarySearch.getSex());
		}
		if ( librarySearch.getLibraryCodes() == null || librarySearch.getLibraryCodes().contains("ALL") ) {
			param.put("searchKind", "ALL");
		}
		else {
			param.put("searchKind", StringUtils.join(librarySearch.getLibraryCodes(), ","));
		}

		if ( !StringUtils.isEmpty(librarySearch.getAllBookListStr()) ) {
			param.put("allBookListStr", librarySearch.getAllBookListStr());
		}

		if ( searchType.equals("L_YEAR") ) {
			param.put("l_year", librarySearch.getSearch_year());
		}
		if ( !StringUtils.isEmpty(librarySearch.getSearch_year()) ) {}

		if ( !StringUtils.isEmpty(librarySearch.getSearch_library()) ) {
			// param.put("l_library", librarySearch.getSearch_library());
		}

		if ( searchType.equals("L_FORMCODE") ) {
			param.put("l_formcode", librarySearch.getSearch_form_code());
		}
		if ( !StringUtils.isEmpty(librarySearch.getSearch_form_code()) ) {}

		if ( !StringUtils.isEmpty(librarySearch.getSearch_kdc()) ) {
			// param.put("classNo", librarySearch.getSearch_kdc());
		}

		if ( searchType.equals("L_AUTHORFORM") ) {
			param.put("author", librarySearch.getSearch_athor());
		}
		if ( !StringUtils.isEmpty(librarySearch.getSearch_athor()) ) {}

		if ( searchType.equals("L_PUBLISHERFORM") ) {
			param.put("publisher", librarySearch.getSearch_publisher());
		}
		if ( !StringUtils.isEmpty(librarySearch.getSearch_publisher()) ) {}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 *
	 * @param librarySearch
	 * @param curPageNum
	 * @return
	 */
	public static Map<String, Object> getDetailSearch(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("pageSize", librarySearch.getRowCount());
		param.put("curPageNum", librarySearch.getViewPage());

		try {
			//if (StringUtils.isNotEmpty(librarySearch.getsearchKeyword1())) {
			param.put("searchType1", URLEncoder.encode(librarySearch.getSearchType1(), "UTF-8"));
			param.put("searchKeyword1", URLEncoder.encode(librarySearch.getSearchKeyword1(), "UTF-8"));
			param.put("searchSubType1", URLEncoder.encode(librarySearch.getSearchSubType1(), "UTF-8"));
			param.put("logicFunction1", URLEncoder.encode(librarySearch.getLogicFunction1(), "UTF-8"));
			//}
			param.put("searchType2", URLEncoder.encode(librarySearch.getSearchType2(), "UTF-8"));
			param.put("searchKeyword2", URLEncoder.encode(librarySearch.getSearchKeyword2(), "UTF-8"));
			param.put("searchSubType2", URLEncoder.encode(librarySearch.getSearchSubType2(), "UTF-8"));
			param.put("logicFunction2", URLEncoder.encode(librarySearch.getLogicFunction2(), "UTF-8"));

			param.put("searchType3", URLEncoder.encode(librarySearch.getSearchType3(), "UTF-8"));
			param.put("searchKeyword3", URLEncoder.encode(librarySearch.getSearchKeyword3(), "UTF-8"));
			param.put("searchSubType3", URLEncoder.encode(librarySearch.getSearchSubType3(), "UTF-8"));
			param.put("logicFunction3", URLEncoder.encode(librarySearch.getLogicFunction3(), "UTF-8"));

			param.put("searchType4", URLEncoder.encode(librarySearch.getSearchType4(), "UTF-8"));
			param.put("searchKeyword4", URLEncoder.encode(librarySearch.getSearchKeyword4(), "UTF-8"));
			param.put("searchSubType4", URLEncoder.encode(librarySearch.getSearchSubType4(), "UTF-8"));
			param.put("logicFunction4", URLEncoder.encode(librarySearch.getLogicFunction4(), "UTF-8"));

			param.put("isbnSearch", URLEncoder.encode(librarySearch.getIsbnSearch(), "UTF-8"));
			param.put("logicFunction5", URLEncoder.encode(librarySearch.getLogicFunction5(), "UTF-8"));

			param.put("kdcSearch", URLEncoder.encode(librarySearch.getKdcSearch(), "UTF-8"));

			param.put("cmd", "D_SEARCH");

		}
		catch ( UnsupportedEncodingException e ) {
			e.printStackTrace();
		}

		if ( librarySearch.getLibraryCodes() == null || librarySearch.getLibraryCodes().indexOf("ALL") > -1 ) {
			librarySearch.setLibraryCodes(new ArrayList<String>());
			librarySearch.getLibraryCodes().clear();
			librarySearch.getLibraryCodes().add("ALL");
		}

		param.put("searchKind", StringUtils.join(librarySearch.getLibraryCodes(), ","));

		if ( !StringUtils.isEmpty(librarySearch.getAllBookListStr()) ) {
			param.put("allBookListStr", librarySearch.getAllBookListStr());
		}

		if ( StringUtils.isNotEmpty(librarySearch.getLangType()) ) {
			param.put("langType", librarySearch.getLangType());
		}

		if ( StringUtils.isNotEmpty(librarySearch.getSearchStYear()) ) {
			param.put("searchStYear", librarySearch.getSearchStYear());
		}

		if ( StringUtils.isNotEmpty(librarySearch.getSearchEdYear()) ) {
			param.put("searchEdYear", librarySearch.getSearchEdYear());
		}
		
		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 검색결과 내 재검색
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSubSearch(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("pageSize", librarySearch.getRowCount());
		try {
			param.put("searchKeyword", URLEncoder.encode(librarySearch.getSearch_text(), "UTF-8"));
		}
		catch ( UnsupportedEncodingException e ) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		param.put("searchKind", StringUtils.join(librarySearch.getLibraryCodes(), ","));
		param.put("curPageNum", librarySearch.getViewPage());
		param.put("cmd", "SUBSEARCH");
		param.put("subCmd", librarySearch.getSearch_type2());
		param.put("allBookListStr", librarySearch.getAllBookListStr());
		if ( StringUtils.isNotEmpty(librarySearch.getBirth_year()) ) {
			param.put("birth_year", librarySearch.getBirth_year());
		}
		if ( StringUtils.isNotEmpty(librarySearch.getSex()) ) {
			param.put("sex", librarySearch.getSex());
		}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 검색결과 연도별 카운트 조회
	 *
	 * @param
	 * @return Map<String, Object> name:검색cmd, type:검색카테고리명
	 */
	public static Map<String, Object> getSearchCategory() {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "SEARCH_CATEGORY");

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 연도별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByYear(String allBookListStr, int page) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "M_YEARFORM");
		param.put("allBookListStr", allBookListStr);
		param.put("row", 5);
		param.put("page", page);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 도서관별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByLibrary(String allBookListStr) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "C_LIBRARY");
		param.put("allBookListStr", allBookListStr);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 유형별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByFormCode(String allBookListStr, int page) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "M_FORMCODEFORM");
		param.put("allBookListStr", allBookListStr);
		param.put("row", 5);
		param.put("page", page);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 저자별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByWriter(String allBookListStr, int page) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "M_AUTHORFORM");
		param.put("allBookListStr", allBookListStr);
		param.put("row", 5);
		param.put("page", page);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 출판사별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByPublisher(String allBookListStr, int page) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "M_PUBLISHERFORM");
		param.put("allBookListStr", allBookListStr);
		param.put("row", 5);
		param.put("page", page);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 주제별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByKDC(String allBookListStr) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "C_KDC");
		param.put("allBookListStr", allBookListStr);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 자료실별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByPlace(String allBookListStr) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "C_PLACE");
		param.put("allBookListStr", allBookListStr);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 검색결과 종류별 카운트 조회
	 *
	 * @param allBookListStr
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSearchCountByPform(String allBookListStr) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "C_PFORM");
		param.put("allBookListStr", allBookListStr);

		Map<String, Object> result = CommonAPI.sendLIBONE(param);

		return result;
	}

	/**
	 * 도서관 목록 조회
	 *
	 * @return Map<String, Object> 도서관 목록
	 */
	public static Map<String, Object> getLibraryList() {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "LIBINFO");

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 실시간 검색어 순위 (주간)
	 *
	 * @return Map<String, Object> 실시간 검색어 주간순위
	 */
	public static Map<String, Object> getHotTrendWordList(int row) {
		return getHotTrendWordList(row, "2");
	}

	/**
	 * 실시간 검색어 순위
	 *
	 * @param row
	 *        출력갯수 ( 기본값 5 )
	 * @param type
	 *        "1" : 일일, "2" : 주간 ( 기본값 "2" )
	 * @return Map<String, Object> 실시간 검색어 순위
	 */
	public static Map<String, Object> getHotTrendWordList(int row, String type) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "HOTTRENDWORD");
		if ( row < 1 ) {
			param.put("row", 5);
		}
		else {
			param.put("row", row);
		}
		if ( StringUtils.isNotEmpty(type) ) {
			param.put("type", type);
		}
		else {
			param.put("type", "2");
		}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 도서관 목록 조회
	 *
	 * @return Map<String, Object> 도서관 목록
	 */
	public static Map<String, Object> getLibraryList(String ilus) {
		Map<String, Object> param = new HashMap<String, Object>();

		Map<String, Object> result = null;
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}
	
	/**
	 * 
	 * @param 
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getCuration() {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("pageIndex", "1");
		param.put("recordCountPerPage", "10");
		param.put("searchType", "Tags");
		param.put("searchKeyword", "%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84%EA%B5%90%EC%9C%A1%EC%B2%AD%EC%A0%95%EB%B3%B4%EC%84%BC%ED%84%B0");
		param.put("orderType", "2");
		param.put("searchOrder", "D");
		param.put("callback", "jsonp_callback");

		Map<String, Object> result = CommonAPI.curation(param);

		return result;
	}

	/**
	 * 검색 자동 완성 기능
	 *
	 * @param searchKeyword
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getAutoFill(String searchKeyword) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "GETAUTOFILL");
		param.put("searchKeyword", searchKeyword);
		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 도서 상세 검색
	 *
	 * @param librarySearch(vCtrl,
	 *        vLoca)
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getBookDetail(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkSearchItemD");
		param.put("vCtrl", StringUtils.leftPad(librarySearch.getvCtrl(), 12, "0"));
		if ( !StringUtils.isEmpty(librarySearch.getvLoca()) ) {
			param.put("vLoca", librarySearch.getvLoca());
		}

		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 신착도서 리스트 조회
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */

	/**
	 * 신착도서 리스트 조회
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getNewBookList(LibrarySearch librarySearch, String isMain) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkNewBookList");
		param.put("vStartDate", librarySearch.getSearch_start_date().replaceAll("-", ""));
		param.put("vEndDate", librarySearch.getSearch_end_date().replaceAll("-", ""));
		param.put("vCntYn", "Y"); // 총 건수 여부 - Y: 총 건수 정보 추가

		param.put("vStartPos", librarySearch.getStartRowNum());
		param.put("vEndPos", librarySearch.getEndRowNum());

//		if ( StringUtils.equals(isMain, "MAIN") ) {
//			param.put("vCnt", 20);
//		}
//		else {
//			param.put("vCnt", 1000);
//		}

		if ( isMain != null ) {
			param.put("vListType", isMain);
		}
		if ( StringUtils.isNotEmpty(librarySearch.getvLoca()) ) {
			param.put("vLoca", librarySearch.getvLoca().replaceAll(",", ";"));
		}
		if ( StringUtils.isNotEmpty(librarySearch.getSearch_text()) ) {
			if ( StringUtils.isNotEmpty(librarySearch.getSearch_text().replaceAll("|", "")) ) {
				try {
					param.put("vSrch", URLEncoder.encode(librarySearch.getSearch_type() + "|" + librarySearch.getSearch_text(), "UTF-8"));
				}
				catch ( UnsupportedEncodingException e ) {
					e.printStackTrace();
				}
			}
		}
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 대출 인기 도서 리스트 조회
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getBestBookList(LibrarySearch librarySearch, String vRank, String vStartDate) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkListLoanBest");
		param.put("vType", "0001"); // 0001-ITEM단위(일치검색), 0002-서지 단위(일치검색), 0003-서지+권호기호 단위(일치검색)
		param.put("vRank", StringUtils.isEmpty(vRank) ? "10" : vRank);
		if ( StringUtils.isEmpty(vStartDate) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -3);
			param.put("vStartDate", sf.format(cal.getTime()));
		}
		else {
			param.put("vStartDate", vStartDate.replaceAll("-", ""));
		}
		try {
			param.put("vLoca", librarySearch.getvLoca().replaceAll(",", ";"));
		} catch (Exception e) {
			param.put("vLoca", librarySearch.getvLoca());
		}
		/*
		 * if ( librarySearch.getLibraryCodes() != null && librarySearch.getLibraryCodes().size() > 0 ) { if ( librarySearch.getLibraryCodes().indexOf("ALL") == -1 ) { param.put("vLoca", StringUtils.join(librarySearch.getLibraryCodes(), ';')); } }
		 */
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 대출 인기 도서 리스트 조회 - 점촌용
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getBestBookJCList(LibrarySearch librarySearch, String vRank, String vStartDate) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkListLoanBest");
		param.put("vType", "0004"); // 0001-ITEM단위(일치검색), 0002-서지 단위(일치검색), 0003-서지+권호기호 단위(일치검색)
		param.put("vRank", StringUtils.isEmpty(vRank) ? "10" : vRank);
		if ( StringUtils.isEmpty(vStartDate) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -3);
			param.put("vStartDate", sf.format(cal.getTime()));
		}
		else {
			param.put("vStartDate", vStartDate.replaceAll("-", ""));
		}
		try {
			param.put("vLoca", librarySearch.getvLoca().replaceAll(",", ";"));
		} catch (Exception e) {
			param.put("vLoca", librarySearch.getvLoca());
		}
		/*
		 * if ( librarySearch.getLibraryCodes() != null && librarySearch.getLibraryCodes().size() > 0 ) { if ( librarySearch.getLibraryCodes().indexOf("ALL") == -1 ) { param.put("vLoca", StringUtils.join(librarySearch.getLibraryCodes(), ';')); } }
		 */
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 대출 인기 도서 리스트 조회
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getBestBookList(LibrarySearch librarySearch, String vRank) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkListLoanBest");
		param.put("vType", "0001"); // 0001-ITEM단위(일치검색), 0002-서지 단위(일치검색), 0003-서지+권호기호 단위(일치검색)
		param.put("vRank", StringUtils.isEmpty(vRank) ? "10" : vRank);
		param.put("vLoca", librarySearch.getvLoca());
		param.put("vStartDate", librarySearch.getSearch_start_date().replaceAll("-", ""));
		param.put("vEndDate", librarySearch.getSearch_end_date().replaceAll("-", ""));
		/*
		 * if ( librarySearch.getLibraryCodes() != null && librarySearch.getLibraryCodes().size() > 0 ) { if ( librarySearch.getLibraryCodes().indexOf("ALL") == -1 ) { param.put("vLoca", StringUtils.join(librarySearch.getLibraryCodes(), ';')); } }
		 */
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 대출 인기 도서 리스트 조회
	 *
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getBestBookList(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkListLoanBest");
		param.put("vType", "0001"); // 0001-ITEM단위(일치검색), 0002-서지 단위(일치검색), 0003-서지+권호기호 단위(일치검색)
		param.put("vRank", librarySearch.getRowCount());
		param.put("vLoca", librarySearch.getvLoca());
		param.put("vStartDate", librarySearch.getSearch_start_date().replaceAll("-", ""));
		param.put("vEndDate", librarySearch.getSearch_end_date().replaceAll("-", ""));
		/*
		 * if ( librarySearch.getLibraryCodes() != null && librarySearch.getLibraryCodes().size() > 0 ) { if ( librarySearch.getLibraryCodes().indexOf("ALL") == -1 ) { param.put("vLoca", StringUtils.join(librarySearch.getLibraryCodes(), ';')); } }
		 */
		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}

	public static Map<String, Object> getLnkBookList(LibrarySearch librarySearch, String vMainYn) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkList");
		param.put("vType", librarySearch.getSearchType()); // 0001-신간도서(리스트형식), 0002-추천도서
		param.put("vCntYn", "Y"); // 총 건수 여부 - Y: 총 건수 정보 추가

		param.put("vStartPos", librarySearch.getStartRowNum());
		param.put("vEndPos", librarySearch.getEndRowNum());
		param.put("vLoca", librarySearch.getvLoca());
		if ( StringUtils.isEmpty(vMainYn) ) {
			vMainYn = "N";
		}
		param.put("vMainYn", vMainYn);

		if ( StringUtils.isNotEmpty(librarySearch.getvLoca()) ) {
			param.put("vLoca", librarySearch.getvLoca());
		}
		if ( StringUtils.isNotEmpty(librarySearch.getSearch_text()) ) {
			if ( StringUtils.isNotEmpty(librarySearch.getSearch_text().replaceAll("|", "")) ) {
				try {
					param.put("vSrch", librarySearch.getSearch_type() + "|" + URLEncoder.encode(librarySearch.getSearch_text(), "UTF-8"));
				}
				catch ( UnsupportedEncodingException e ) {
					e.printStackTrace();
				}
			}
		}

		Document doc = CommonAPI.sendILUS(param);

		result = CommonAPI.parseXml(doc);

		return result;
	}
	
	public static Map<String, Object> getMyLibraryList(String worker_id, String user_id, String vType, String vOption) {
		return getMyLibraryList(worker_id, user_id, vType, vOption, null, null);
	}

	/**
	 * 공지사항, 대출내역, 예약내역, 희망도서 신청내역, 상호대차내역, 파우치신청내역 조회
	 *
	 * @param worker_id
	 * @param user_id
	 * @param vType
	 * @param vOption
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getMyLibraryList(String worker_id, String user_id, String vType, String vOption, String vStartPos, String vEndPos) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibrary");
		param.put("vUserId", user_id);
		param.put("vType", vType); // NOTICE - 개인공지사항, LOAN - 대출내역, RESVE - 예약내역, HOPE - 희망도서 신청내역, OUT - 상호대차내역, POUCH - 파우치 신청내역, BEACH - 비치도서예약신청, CLOSE - 보존서고 신청내역

		if ( StringUtils.isNotEmpty(vOption) ) {
			param.put("vOption", vOption); // NULL - 전체
			// 0001 - (LOAN=대출중,RESVE=예약중|도착통보,HOPE=선정대상|선청,OUT=신청|배송중|대출대기,POUCH=신청,BEACH=비치도서예약)
			// 0002 - (LOAN=대출중 제외,HOPE=선정취소,POUCH=취소,BEACH=비치도서예약)
		}

		if ( StringUtils.equals(vType, "LOAN") ) {
			param.put("vSortKey", "LOAN_DATE");
			param.put("vSortDir", "DESC");
		}
		if ( StringUtils.equals(vType, "HOPE") || StringUtils.equals(vType, "NOTICE") ) {
			param.put("vSortKey", "INSERT_DATE");
			param.put("vSortDir", "DESC");
		}
		
//		if ( StringUtils.equals(vType, "CLOSE") ) {
//			param.put("vStartPos", vStartPos);
//			param.put("vEndPos", vEndPos);
//			param.put("vCntYn", "Y");
//		}
		
		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 공지사항, 대출내역, 예약내역, 희망도서 신청내역, 상호대차내역, 파우치신청내역 검색
	 *
	 * @param worker_id
	 * @param user_id
	 * @param vType
	 * @param vOption
	 * @param paramMap<String,String>
	 *  vStartPos	페이지의 시작 위치
        vEndPos		페이지의 마지막 위치
        vSrchKey	"검색항목 - TITLE(서명) / AUTHOR(저자) / INFORM_TITLE(제목) / INSERT_ID(작성자)"
        vSrchText	검색어 - 입력값
        vBrowser	"한글포함여부 - Y"
        vSrchDateKey"검색항목 - LOAN_DATE(대출일) / RESVE_DATE(예약일) / STATUS_CHANGE_DATE (상태변경일) / INSERT_DATE (작성일)"
        vSrchDateS	입력날짜 <=
        vSrchDateE	입력날짜 >=
        vSortKey	"정렬항목 - TITLE(서명) / AUTHOR(저자) / INFORM_TITLE(제목) / INSERT_ID(작성자) / LOAN_DATE(대출일) / RESVE_DATE(예약일) / STATUS_CHANGE_DATE (상태변경일) / INSERT_DATE (작성일)"
        vSortDir	"정렬방향 - ASC (오름차순) (기본) - DESC (내림차순)"
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getMyLibrarySearchList(String worker_id, String user_id, String vType, String vOption, Map<String, String> paramMap) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryS");
		param.put("vUserId", user_id);
		param.put("vType", vType); // NOTICE - 개인공지사항, LOAN - 대출내역, RESVE - 예약내역, HOPE - 희망도서 신청내역, OUT - 상호대차내역, POUCH - 파우치 신청내역, BEACH - 비치도서예약신청

		param.put("vCntYn", "Y");//전체 리스트 카운트(페이징처리를 위해 필요)


		if ( StringUtils.isNotEmpty(vOption) ) {
			param.put("vOption", vOption); // NULL - 전체
			// 0001 - (LOAN=대출중,RESVE=예약중|도착통보,HOPE=선정대상|선청,OUT=신청|배송중|대출대기,POUCH=신청,BEACH=비치도서예약)
			// 0002 - (LOAN=대출중 제외,HOPE=선정취소,POUCH=취소,BEACH=비치도서예약)
		}

		for ( Map.Entry<String, String> map : paramMap.entrySet() ) {
			param.put(map.getKey(), map.getValue());
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 개인공지사항 상세
	 * @author YONGJU 2017. 12. 14.
	 * @param worker_id
	 * @param member_id
	 * @param informNo
	 * @return
	 */
	public static Map<String, Object> getNoticeDetail(String worker_id, String informNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryD");
		param.put("vType", "NOTICE");
		param.put("vSeqNo", informNo);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 상세 대출 내역 조회
	 *
	 * @param worker_id
	 * @param member_id
	 * @param loan_no
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getLoanDetail(String worker_id, String loan_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryD");
		param.put("vType", "LOAN");
		param.put("vSeqNo", loan_no);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	public static Map<String, Object> getResveDetail(String worker_id, String resve_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryD");
		param.put("vType", "RESVE");
		param.put("vSeqNo", resve_no);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 희망도서 신청 확인
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse hopeUserCheck(String worker_id, LibrarySearch librarySearch, String user_id, String loca) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkHopeUserCheck");
		param.put("vUserId", user_id);
		if (StringUtils.isEmpty(loca)) {
			param.put("vHopeLoca", librarySearch.getvLoca());
		} else {
			param.put("vHopeLoca", loca);
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 희망도서 신청
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse reqHope(String worker_id, LibrarySearch librarySearch, String user_id, String loca) {
		return reqHope(worker_id, librarySearch, user_id, loca, "0001");
	}

	/**
	 * 희망도서 신청 - 용도 구분
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse reqHope(String worker_id, LibrarySearch librarySearch, String user_id, String loca, String useKind) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<String> values = new ArrayList<String>();
		try {
			values.add(String.format("%s|%s", "TITLE", URLEncoder.encode(librarySearch.getTitle(), "UTF-8")));
			values.add(String.format("%s|%s", "AUTHOR", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8")));
			values.add(String.format("%s|%s", "PUBLER", URLEncoder.encode(librarySearch.getPubler(), "UTF-8")));
			values.add(String.format("%s|%s", "PUBLER_YEAR", URLEncoder.encode(librarySearch.getPubler_year(), "UTF-8")));
			if ( StringUtils.isNotEmpty(librarySearch.getIsbn()) ) {
				values.add(String.format("%s|%s", "ISBN", URLEncoder.encode(librarySearch.getIsbn(), "UTF-8")));
			}
			if ( StringUtils.isNotEmpty(librarySearch.getEditon()) ) {
				values.add(String.format("%s|%s", "EDITON", URLEncoder.encode(librarySearch.getEditon(), "UTF-8")));
			}
			if ( StringUtils.isNotEmpty(librarySearch.getUser_remark()) ) {
				values.add(String.format("%s|%s", "USER_REMARK", URLEncoder.encode(librarySearch.getUser_remark(), "UTF-8")));
			}
			values.add(String.format("%s|%s", "PRICE", URLEncoder.encode(librarySearch.getPrice(), "UTF-8")));
		}
		catch ( UnsupportedEncodingException e ) {
			e.printStackTrace();
			return new ApiResponse(false, "희망도서 신청에 실패하였습니다. 재 시도 해주세요.");
		}

		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkHopeReg");
		param.put("vUserId", user_id);
		param.put("value", StringUtils.join(values, "><"));
		param.put("vHopeLoca", loca);
		param.put("vUseKind", useKind);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 희망도서 신청 취소 및 삭제
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse modHope(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		String vType = librarySearch.getEditMode();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkHopeInfoMod");
		param.put("vType", vType); // CANCEL - 취소, DELETE - 삭제
		param.put("vUserId", user_id);
		if ( vType.equals("CANCEL") ) {
			param.put("vSelectNo", librarySearch.getSelect_no());
		}
		else if ( vType.equals("DELETE") ) {
			param.put("vDelType", ""); // 여기 값 확인해서 채워넣기
			param.put("vDelNO", librarySearch.getSelect_no()); // 일단 SELECT_NO.
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 도서 예약 신청
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse reqResve(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkResveReg");
		param.put("vUserId", user_id);
		param.put("vLoca", librarySearch.getvLoca());
		param.put("vAccNo", librarySearch.getvAccNo());
		// param.put("vLimitDate", null); //예약 유효일 [YYYYMMDD]

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 도서 예약 신청 취소 및 삭제
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse modResve(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkResveCan");
		param.put("vUserId", user_id);
		// param.put("vLoca", librarySearch.getvLoca());
		// param.put("vAccNo", librarySearch.getvAccNo());
		param.put("vResveNo", librarySearch.getvResveNo());
		// param.put("vLimitDate", null); //예약 유효일 [YYYYMMDD]

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	public static ApiResponse renewLoan(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkLoanRenewProc");
		param.put("vUserId", user_id);
		// param.put("vLoca", librarySearch.getvLoca());
		// param.put("vAccNo", librarySearch.getvAccNo());
		param.put("vLoanNo", librarySearch.getvLoanNo());
		// param.put("vLimitDate", null); //예약 유효일 [YYYYMMDD]

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * Marc 조회
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getMarcInfo(String worker_id, LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMarcInfo");
		param.put("vCtrl", librarySearch.getvCtrl());

		Document doc = CommonAPI.sendILUS(param);

		Map<String, Object> result = CommonAPI.parseXml(doc);

		return result;
	}
	
	/**
	 * Marc 보기
	 *
	 * @param worker_id
	 * @param vDataType
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getMarcView(String worker_id, String vDataType, LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMarcInfo");
		param.put("vCtrl", librarySearch.getvCtrl());
		param.put("vDataType", vDataType);

		Document doc = CommonAPI.sendILUS(param);

		Map<String, Object> result = CommonAPI.parseXml(doc);

		return result;
	}

	/**
	 * 상호대차 신청
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return
	 */
	public static ApiResponse reqOutReg(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkOutReg");
		param.put("vUserId", user_id);
		param.put("vItemLoca", librarySearch.getvItemLoca());
		param.put("vAccNo", librarySearch.getvAccNo());
		param.put("vRecptLoca", librarySearch.getvRecptLoca());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 상호 대차 신청 취소
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse modOutReg(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkOutLocBookCan");
		param.put("vUserId", user_id);
		param.put("vSeqNo", librarySearch.getvSeqNo());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}
	
	/**
	 * 보존서고 신청
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse reqClose(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lon.fnc.LonFuncMPouchReq");
		param.put("vUserId", user_id);
		param.put("vBookLocation", librarySearch.getvLoca());
		param.put("vBookAccNo", librarySearch.getvAccNo());
		param.put("vReqType", "0004");

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}
	
	/**
	 * 보존서고 신청 취소
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse modClose(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lon.fnc.LonFuncMPouchCancel");
		param.put("vUserId", user_id);
		param.put("vSeqNo", librarySearch.getvSeqNo());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 파우치 신청(정보센터 야간대출)
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse reqPouch(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lon.fnc.LonFuncMPouchReq");
		param.put("vUserId", user_id);
		// param.put("vItemLoca", librarySearch.getvItemLoca());
		// param.put("vAccNo", librarySearch.getvAccNo());
		param.put("vBookLocation", librarySearch.getvLoca());
		param.put("vBookAccNo", librarySearch.getvAccNo());
		param.put("vReqType", "0002");

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 파우치 신청 취소
	 *
	 * @param worker_id
	 * @param librarySearch
	 * @param user_id
	 * @return ApiResponse
	 */
	public static ApiResponse modPouch(String worker_id, LibrarySearch librarySearch, String user_id) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lon.fnc.LonFuncMPouchCancel");
		param.put("vUserId", user_id);
		param.put("vSeqNo", librarySearch.getvSeqNo());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return new ApiResponse(true);
		}
		else {
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 파우치신청내역 조회
	 *
	 * @param worker_id
	 * @param user_id
	 * @param vType
	 * @param vOption
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getPouchList(String worker_id, String user_id, String vSearchType, String vLocation, String vOverType) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkPouchList");
		param.put("vUserId", user_id);
		param.put("vLocation", vLocation);
		param.put("vSearchType", vSearchType); // 검색유형 : req – 신청(투입대기자료), wait – 대기(투입된자료), collect – 회수(투입된자료회수), over – 대출기간만료
		if ( StringUtils.isNotEmpty(vSearchType) && vSearchType.equals("over") ) {
			param.put("vOverType", vOverType); // 검색유형이 “over”일 경우 : date – 날짜가 만료된 자료, time – 날짜 + 시간까지 만료된 자료
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 파우치 상세내용
	 *
	 * @param worker_id
	 * @param member_id
	 * @param resve_no
	 * @return
	 */
	public static Map<String, Object> getPouchDetail(String worker_id, String resve_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryD");
//		param.put("vType", "POUCH");
		param.put("vType", "BEACH");//20170601 DVD신청 추가로 수정
		param.put("vSeqNo", resve_no);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}
	
	/**
	 * 보존서고 상세내용
	 *
	 * @param worker_id
	 * @param member_id
	 * @param close_no
	 * @return
	 */
	public static Map<String, Object> getCloseDetail(String worker_id, String close_no) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkMyLibraryD");
		param.put("vType", "CLOSE");
		param.put("vSeqNo", close_no);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 동일도서 리스트
	 *
	 * @param worker_id
	 * @param member_id
	 * @param resve_no
	 * @return
	 */
	public static Map<String, Object> getSameBookList(String worker_id, String isbn, String loca, String listType) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", worker_id);
		param.put("className", "action.lnk.LnkSameBookList");
		param.put("vIsbn", isbn);
		param.put("vCnt", 10);
		param.put("vLoca", loca);
		param.put("vListType", listType);

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 동일도서 리스트 - 권단위 기준 (등록번호 기준)
	 *
	 * @param worker_id
	 * @param member_id
	 * @param resve_no
	 * @return
	 */
	public static Map<String, Object> getSameBookList(String worker_id, String isbn, String loca) {
		return getSameBookList(worker_id, isbn, loca, "ITEM");
	}

	/**
	 * 동일도서 리스트 (다중)
	 *
	 * @param worker_id
	 * @param member_id
	 * @param resve_no
	 * @return
	 */
	public static Map<String, Object> getSameBookList(String worker_id, String isbn, List<String> loca) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("USERID", worker_id);
			param.put("className", "action.lnk.LnkSameBookList");
			param.put("vIsbn", isbn);
			param.put("vCnt", 10);
			param.put("vLoca", StringUtils.join(loca, ";"));
		}
		catch ( Exception e ) {
			return null;
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 연령별 최다 인기도서 리스트(다중)
	 *
	 * @param vStartDate
	 * @param vEndDate
	 * @param loca
	 * @return
	 */
	public static Map<String, Object> getAgeLoanBestList(String vStartDate, String vEndDate, List<String> loca) {
		return getAgeLoanBestList(vStartDate, vEndDate, loca, 20);
	}

	/**
	 * 연령별 최다 인기도서 리스트(다중)
	 *
	 * @param vStartDate
	 * @param vEndDate
	 * @param loca
	 * @return
	 */
	public static Map<String, Object> getAgeLoanBestList(String vStartDate, String vEndDate, List<String> loca, int cnt) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("USERID", "WEB");
			param.put("className", "action.lnk.LnkListAgeLoanBest");
			param.put("vStartDate", vStartDate);
			param.put("vEndDate", vEndDate);
			param.put("vCnt", cnt);
			param.put("vType", "type2");
			param.put("vLoca", StringUtils.join(loca, ","));

		}
		catch ( Exception e ) {
			return null;
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 청구기호 Browsing (동일 주제 다른 책)
	 *
	 * @param vStartDate
	 * @param vEndDate
	 * @param loca
	 * @return
	 */
	public static Map<String, Object> getCallNoBrowsingList(String vCtrl, String vCount) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("USERID", "WEB");
			param.put("className", "action.lnk.LnkCallNoBrowsing");
			param.put("vCtrlNo", vCtrl);
			param.put("vCount", vCount);
		}
		catch ( Exception e ) {
			return null;
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 휴관일 API
	 *
	 * @param vLoca
	 *        - 도서관코드
	 * @param planDate
	 *        - YYYYMM
	 * @return list - dsHoliday
	 * @return field - HOLIDY_DATE (YYYYMMDD)
	 * @return field - HOILDY_NAME
	 * @return field - REMARK
	 */
	public static Map<String, Object> getHolidays(String vLoca, String vSdate, String vEdate) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("USERID", "WEB");
			param.put("className", "action.lnk.LnkLibHolidayList");
			param.put("vLocation", vLoca);
			param.put("vSDate", vSdate);
			param.put("vEDate", vEdate);
		}
		catch ( Exception e ) {
			return null;
		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * 서평정보 조회 및 목차 조회
	 *
	 * @param tid
	 * @return
	 */
	public static Map<String, Object> getDescriptionIndex(String tid) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "SELECT_BOOK_TBL");
		param.put("allBookListStr", tid);

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 연령별 선호도 차트
	 *
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getAgeChart(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("cmd", "AGE_CHART");
			param.put("recKey", librarySearch.getvCtrl());
			param.put("lib_code", librarySearch.getvLoca());
		}
		catch ( Exception e ) {
			return null;
		}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 함께 빌려본 다른 도처 추천
	 *
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getWithBook(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("cmd", "WITH_BOOK");
			param.put("recKey", librarySearch.getvCtrl());
			param.put("lib_code", librarySearch.getvLoca());
		}
		catch ( Exception e ) {
			return null;
		}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 태그 클라우드
	 *
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getTagCloud(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("cmd", "CLOUD_TAG");
			param.put("tid", librarySearch.getTid());
		}
		catch ( Exception e ) {
			return null;
		}

		return CommonAPI.sendLIBONE(param);
	}

	/**
	 * 네이버 책검색 - list
	 *
	 * @param search_text
	 * @return
	 */
	public static Map<String, Object> getNaverList(PagingUtils pagingUtils) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("query", URLEncoder.encode(pagingUtils.getSearch_text(), "UTF-8"));
		}
		catch ( UnsupportedEncodingException e ) {
			param.put("query", "");
		}
		param.put("start", ( pagingUtils.getViewPage() - 1 ) * 10 + 1);
		// 정보센터 apikey로 호출한다.
		return CommonAPI.sendNAVER(param, "list", "h27");

		// naverDetail.rss.channel.item

	}

	/**
	 * 네이버 책검색 - isbn
	 *
	 * @param isbn
	 * @return
	 */
	public static List<Map<String, Object>> getNaverDetail(String isbn) {
		List<Map<String, Object>> returnList = null;
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("d_isbn", isbn);
		}
		catch ( Exception e ) {
			return null;
		}
		Map<String, Object> resultMap = CommonAPI.sendNAVER(param, "detail", "h27");

		if ( resultMap != null ) {
			Map<String, Object> rssMap = (Map<String, Object>) resultMap.get("rss");
			if ( rssMap != null ) {
				Map<String, Object> channelMap = (Map<String, Object>) rssMap.get("channel");
				if ( channelMap != null ) {
					Object item = channelMap.get("item");
					if ( item instanceof Map ) {
						returnList = new ArrayList<Map<String, Object>>();
						returnList.add((Map<String, Object>) item);
					}
					else {
						returnList = (List<Map<String, Object>>) item;
					}
					return returnList;
				}
			}
		}

		// naverDetail.rss.channel.item

		// 정보센터 apikey로 호출한다.
		return null;
	}
	
	/**
	 * 주제별 검색
	 *
	 * @param searchKeyword
	 * @param searchKind
	 * @param curPageNum
	 * @param pageSize
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSubjectSearch(LibrarySearch librarySearch, int curPageNum) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cmd", "SEARCH_KDC");
		param.put("searchKeyword", librarySearch.getKdcSearch());
		param.put("searchKind", "ALL");
		param.put("curPageNum", curPageNum);
		param.put("pageSize", librarySearch.getRowCount());
		return CommonAPI.sendLIBONE(param);
	}
	
	/**
	 * ISBN에 해당하는 전자책의 마크URL 구하기
	 *
	 * @param worker_id
	 * @param vDataType
	 * @param librarySearch
	 * @return Map<String, Object>
	 */
	public static String getMarcUrlByIsbn(String isbn) {
		// 전자도서관 vLoca=00000001
		Map<String, Object> sameBooks = (Map<String, Object>) LibSearchAPI.getSameBookList("WEB", isbn, "00000001");
		
		if(sameBooks == null) {
			return "";
		} else {
			List<Map<String, Object>> sameBookList = (List<Map<String, Object>>)sameBooks.get("dsSameBookList");
			
			if(sameBookList == null || sameBookList.size() == 0) {
				return "";
			} else {
				String vCtrl = String.valueOf(sameBookList.get(0).get("CTRLNO"));
				return getMarcUrl(vCtrl);
			}
		}
	}
	
	/**
	 * 전자책의 마크URL 구하기
	 * @param vCtrl
	 * @return
	 */
	public static String getMarcUrl(String vCtrl) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkMarcInfo");
		param.put("vCtrl", vCtrl);
		param.put("vDataType", "MARC XML");
		
		Document doc = CommonAPI.sendILUS(param);
		
		XPath xPath =  XPathFactory.newInstance().newXPath();
		String path = "//list[@name=\"dsMarcView\"]/item[field[@name=\"TAG\" and text() = \"856\"]]/field[@name=\"FIELD\"]/text()";
		XPathExpression expr = null;
		String value = null;
		try {
			expr = xPath.compile(path);
			value = (String) expr.evaluate(doc, XPathConstants.STRING);
		} catch (XPathExpressionException e) {
			return "";
		}

		if(StringUtils.defaultString(value).length() < 3) {
			return "";
		} else {
			// value = "▼u https://www.gbelib.kr/elib/module/elib/book/view.do?menu_idx=14&type=EBK&book_idx=13773"
			return value.substring(3);
		}
	}
	
	public static Map<String, Object> addMarcUrls(Map<String, Object> result) {
		List<Map<String, Object>> data = null;
		String isbnField = "isbn";
		String locaField = "libCode";
		String type = "data";
		
		if(result.get("data") != null) {
			data = (List<Map<String, Object>>) result.get("data");
			isbnField = "isbn";
			locaField = "libCode";
			type = "data";
		} else if(result.get("dsLoanBestList") != null) {
			data = (List<Map<String, Object>>) result.get("dsLoanBestList");
			isbnField = "ISBN";
			locaField = "LOCA";
			type = "dsLoanBestList";
		} else if(result.get("dsNewBookList") != null) {
			data = (List<Map<String, Object>>) result.get("dsNewBookList");
			isbnField = "ISBN";
			locaField = "LOCA";
			type = "dsNewBookList";
		} else if(result.get("dsItemDetail") != null) {
			data = (List<Map<String, Object>>) result.get("dsItemDetail");
			type = "dsItemDetail";
			locaField = "LOCA";
		} else {
			
		}
		
		if(data != null) {
			for(Map<String, Object> item: data) {
				
				String marcUrl = "";
				if("data".equals(type) || "dsLoanBestList".equals(type) || "dsNewBookList".equals(type)) {
					String libCode = String.valueOf(item.get(locaField));
					if("00000001".equals(libCode)) {
						String isbn = String.valueOf(item.get(isbnField));
						marcUrl = LibSearchAPI.getMarcUrlByIsbn(isbn);
					}
				} else if("dsItemDetail".equals(type)) {
					String libCode = String.valueOf(item.get(locaField));
					if("00000001".equals(libCode)) {
						String vCtrl = String.valueOf(item.get("CTRLNO"));
						marcUrl = LibSearchAPI.getMarcUrl(vCtrl);
					}
				}
				
				if(StringUtils.isNotEmpty(marcUrl)) {
					item.put("marc_url", marcUrl);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * 자료실 목록 검색
	 * 
	 * @param homepage_code
	 * @return Map<String, Object>
	 */
	public static Map<String, Object> getSubLocaInfo(String homepage_code) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;
		
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkLibInfoQry");
		param.put("vSearchType", "0002");
		param.put("vLocation", homepage_code);
		
		Document doc = CommonAPI.sendILUS(param);
		
		result = CommonAPI.parseXml(doc);
		
		return result;
	}

	/**
	 * 동일 저자 도서 리스트
	 * @param author
	 * @param loca
	 * @return
	 */
	public static Map<String, Object> getSameAuthorBookList(String author, String loca) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkSearchList");
		param.put("vSysdiv", "TOT"); // 일반검색(검색시스템(TOT, CAT 등))
		param.put("vSType", "KWRD"); // 검색방식(키워드[KWRD], 전방일치[FRNT], 완전일치[EXCT])
		param.put("vSrchKey0", "000000000002"); // 검색필드0(서명: 000000000001, 저자: 000000000002, 출판사: 000000000003, 주제어: 000000000004)
		param.put("vSrchText0", author); // 검색어0
		param.put("vStartPos", 1);
		param.put("vEndPos", 10);
		if(StringUtils.isNotEmpty(loca)) {
			param.put("vLoca", loca);
		}

		Document doc = CommonAPI.sendILUS(param);
		
		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.parseXml(doc);
		}
		else {
			return null;
		}
	}
	
	/**
	 * 동일 저자 도서 리스트
	 * @param detail
	 * @param loca
	 * @return
	 */
	public static Map<String, Object> getSameAuthorBookList(Map<String, Object> detail) {
		try {
			List<Map<String, Object>> dsItemDetail = (List<Map<String, Object>>) detail.get("dsItemDetail");
			if(dsItemDetail== null) {
				return new HashMap<String, Object>();
			} else {
				Map<String, Object> detailOne = dsItemDetail.get(0);
				String AUTHOR = String.valueOf(detailOne.get("AUTHOR"));
				String[] authors = StringUtils.split(AUTHOR, ";");
				String author = authors[0].replaceFirst("(지음|감수|그림|제작|번역|역자|원작|연출|지은이|공저|강의|옮김| 글| 저| 역)", "").replaceAll("[,.(--)+\\[\\]{}()\\\\/:;]", "").trim();
				
				Map<String, Object> result = getSameAuthorBookList(author, String.valueOf(detailOne.get("LOCA")));
				if(result == null) return null;
				
				List<Map<String, Object>> dsResult = (List<Map<String, Object>>) result.get("dsResult");
				if(dsResult == null) {
					return null;
				} else {
					for(Map<String, Object> i: dsResult) {
						if(i.get("DISP02") != null) {
							i.put("DISP02", String.valueOf(i.get("DISP02")).replaceAll("\\[\\d+m", ""));
						}
					}
				}
				return result;
			}
		} catch(Exception e) {
			e.printStackTrace();
			return new HashMap<String, Object>();
		}
	}

}
