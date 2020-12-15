package kr.go.gbelib.app.common.api;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.intro.search.LibrarySearch;

public class LibSearchAPI {

	protected final static Logger log = LoggerFactory.getLogger(LibSearchAPI.class);

	/**
	 * K.API - 1
	 *
	 * 단행본 검색 조회 (단행본 일반검색은 getBookNormal)
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookNormal(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("search_txt", librarySearch.getSearch_text());
		param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "normal");

		result = CommonAPI.sendKCMS("booksearch", param);

		return result;
	}

	/**
	 * K.API - 2
	 *
	 * 단행본 상세검색 조회 (단행본 일반검색은 getBookNormal)
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookDetail(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		try {
			// 서명
			if (StringUtils.isNotEmpty(librarySearch.getTitle()))
				param.put("search_title", URLEncoder.encode(librarySearch.getTitle(), "UTF-8"));
			// 저자
			if (StringUtils.isNotEmpty(librarySearch.getAuthor()))
				param.put("search_author", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8"));
			// 발행자
			if (StringUtils.isNotEmpty(librarySearch.getPubler()))
				param.put("search_publisher", URLEncoder.encode(librarySearch.getPubler(), "UTF-8"));
			// 키워드
			if (StringUtils.isNotEmpty(librarySearch.getKeyword()))
				param.put("search_keyword", URLEncoder.encode(librarySearch.getKeyword(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {}

		// ISBN
		if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
			String isbnArr[] = librarySearch.getIsbn().split(" ");
			String isbn = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10 || isbnArr[i].length() == 13) {
					isbn = isbnArr[i];
				}
			}
			if (StringUtils.isNotEmpty(isbn)) {
				param.put("search_isbn_issn", isbn);
			}
		}
		// 발행년시작 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date()))
			param.put("search_year_start", librarySearch.getSearch_start_date());
		// 발행년종료 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date()))
			param.put("search_year_end", librarySearch.getSearch_end_date());
		// 자료실코드
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()))
			param.put("search_shelf", librarySearch.getShelfCode());
		//검색 제외 자료실코드. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getNotShelfCode()))
			param.put("not_search_shelf", librarySearch.getNotShelfCode());
		// 주제부호 : 분류기호의 첫번째 숫자(0~9). 여러 개인 경우 comma(,)로 연결. ※ IDX_BO_TBL의 CLASS_NO 필드의 첫번째 숫자값으로 확인 (ex : 816.6 -> 8)
		if (StringUtils.isNotEmpty(librarySearch.getSubjectCode()))
			param.put("subject_code", librarySearch.getSubjectCode());
		// 등록구분. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getRegCode()))
			param.put("reg_code", librarySearch.getRegCode());
		// 별치기호. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getSeparateShelfCode()))
			param.put("separate_shelf_code", librarySearch.getSeparateShelfCode());

		if (StringUtils.isNotEmpty(librarySearch.getFacet_manage_code()))
			param.put("facet_manage_code", librarySearch.getFacet_manage_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_author()))
			param.put("facet_author", librarySearch.getFacet_author());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_media_code()))
			param.put("facet_media_code", librarySearch.getFacet_media_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_pub_year()))
			param.put("facet_pub_year", librarySearch.getFacet_pub_year());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_publisher()))
			param.put("facet_publisher", librarySearch.getFacet_publisher());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_subject_code()))
			param.put("facet_subject_code", librarySearch.getFacet_subject_code());

		try {
			// 자료검색용
			param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		} catch (Exception e) {
			// 신착도서 등 자료검색 제외
			param.put("manage_code", librarySearch.getManageCode());
		}

		if (StringUtils.isNotEmpty(librarySearch.getShelf_list())) {
			param.put("search_shelf", librarySearch.getShelf_list());
		}

		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "detail");
		if (!StringUtils.equals(librarySearch.getSortField(), "NONE")) {
			param.put("orderby_item", librarySearch.getSortField());
			param.put("orderby", librarySearch.getSortType());
		}

		result = CommonAPI.sendKCMS("booksearch", param);

		return result;
	}

	/**
	 * K.API - 3
	 *
	 * 연속간행물 일반검색
	 *
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getSerialNormal(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("search_txt", librarySearch.getSearch_text());
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "normal");
		param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		if (!StringUtils.equals(librarySearch.getSortField(), "NONE")) {
			param.put("orderby_item", librarySearch.getSortField());
			param.put("orderby", librarySearch.getSortType());
		}

		result = CommonAPI.sendKCMS("serialsearch", param);

		return result;
	}

	/**
	 * K.API - 4
	 *
	 * 연속간행물 상세검색
	 *
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getSerialDetail(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		try {
			// 서명
			if (StringUtils.isNotEmpty(librarySearch.getTitle()))
				param.put("search_title", URLEncoder.encode(librarySearch.getTitle(), "UTF-8"));
			// 저자
			if (StringUtils.isNotEmpty(librarySearch.getAuthor()))
				param.put("search_author", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8"));
			// 발행자
			if (StringUtils.isNotEmpty(librarySearch.getPubler()))
				param.put("search_publisher", URLEncoder.encode(librarySearch.getPubler(), "UTF-8"));
			// 키워드
			if (StringUtils.isNotEmpty(librarySearch.getKeyword()))
				param.put("search_keyword", URLEncoder.encode(librarySearch.getKeyword(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {}

		// ISBN
		if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
			String isbnArr[] = librarySearch.getIsbn().split(" ");
			String isbn = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10 || isbnArr[i].length() == 13) {
					isbn = isbnArr[i];
				}
			}
			if (StringUtils.isNotEmpty(isbn)) {
				param.put("search_isbn_issn", isbn);
			}
		}
		// 발행년시작 - YYYY
		// if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date())) param.put("search_year_start", librarySearch.getSearch_start_date());
		// 발행년종료 - YYYY
		// if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date())) param.put("search_year_end", librarySearch.getSearch_end_date());
		// 자료실코드
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()))
			param.put("search_shelf", librarySearch.getShelfCode());
		// 주제부호 : 분류기호의 첫번째 숫자(0~9). 여러 개인 경우 comma(,)로 연결. ※ IDX_BO_TBL의 CLASS_NO 필드의 첫번째 숫자값으로 확인 (ex : 816.6 -> 8)
		// if (StringUtils.isNotEmpty(librarySearch.getSubjectCode())) param.put("subject_code", librarySearch.getSubjectCode());
		// 등록구분. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getRegCode()))
			param.put("reg_code", librarySearch.getRegCode());

		try {
			// 자료검색용
			param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		} catch (Exception e) {
			// 신착도서 등 자료검색 제외
			param.put("manage_code", librarySearch.getManageCode());
		}

		if (StringUtils.isNotEmpty(librarySearch.getShelf_list())) {
			param.put("search_shelf", librarySearch.getShelf_list());
		}
		//검색 제외 자료실코드. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getNotShelfCode()))
			param.put("not_search_shelf", librarySearch.getNotShelfCode());

		if (StringUtils.isNotEmpty(librarySearch.getFacet_manage_code()))
			param.put("facet_manage_code", librarySearch.getFacet_manage_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_author()))
			param.put("facet_author", librarySearch.getFacet_author());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_media_code()))
			param.put("facet_media_code", librarySearch.getFacet_media_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_pub_year()))
			param.put("facet_pub_year", librarySearch.getFacet_pub_year());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_publisher()))
			param.put("facet_publisher", librarySearch.getFacet_publisher());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_subject_code()))
			param.put("facet_subject_code", librarySearch.getFacet_subject_code());

		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "detail");
		// param.put("reg_no", librarySearch.getRegNo());
		if (!StringUtils.equals(librarySearch.getSortField(), "NONE")) {
			param.put("orderby_item", librarySearch.getSortField());
			param.put("orderby", librarySearch.getSortType());
		}

		result = CommonAPI.sendKCMS("serialsearch", param);

		return result;
	}

	/**
	 * K.API - 5
	 *
	 * 연속간행물 다른권호 더보기
	 *
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getSerialSpecies(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("species_key", librarySearch.getSpeciesKey());
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));

		result = CommonAPI.sendKCMS("serialdetail", param);

		return result;
	}

	/**
	 * K.API - 6
	 *
	 * 비도서 일반 검색
	 *
	 * @author YONGJU 2018. 1. 4.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getNonBookNormal(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("search_txt", librarySearch.getSearch_text());
		param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "normal");

		result = CommonAPI.sendKCMS("nonbooksearch", param);

		return result;
	}

	/**
	 * K.API - 7
	 *
	 * 비도서 상세 검색 조회
	 *
	 * @author whalesoft YONGJU 2019. 11. 11.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getNonBookDetail(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		try {
			// 서명
			if (StringUtils.isNotEmpty(librarySearch.getTitle()))
				param.put("search_title", URLEncoder.encode(librarySearch.getTitle(), "UTF-8"));
			// 저자
			if (StringUtils.isNotEmpty(librarySearch.getAuthor()))
				param.put("search_author", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8"));
			// 발행자
			if (StringUtils.isNotEmpty(librarySearch.getPubler()))
				param.put("search_publisher", URLEncoder.encode(librarySearch.getPubler(), "UTF-8"));
			// 키워드
			if (StringUtils.isNotEmpty(librarySearch.getKeyword()))
				param.put("search_keyword", URLEncoder.encode(librarySearch.getKeyword(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {}

		// ISBN
		if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
			String isbnArr[] = librarySearch.getIsbn().split(" ");
			String isbn = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10 || isbnArr[i].length() == 13) {
					isbn = isbnArr[i];
				}
			}
			if (StringUtils.isNotEmpty(isbn)) {
				param.put("search_isbn_issn", isbn);
			}
		}
		// 발행년시작 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date()))
			param.put("search_year_start", librarySearch.getSearch_start_date());
		// 발행년종료 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date()))
			param.put("search_year_end", librarySearch.getSearch_end_date());
		// 자료실코드
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()))
			param.put("search_shelf", librarySearch.getShelfCode());
		//검색 제외 자료실코드. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getNotShelfCode()))
			param.put("not_search_shelf", librarySearch.getNotShelfCode());
		// 주제부호 : 분류기호의 첫번째 숫자(0~9). 여러 개인 경우 comma(,)로 연결. ※ IDX_BO_TBL의 CLASS_NO 필드의 첫번째 숫자값으로 확인 (ex : 816.6 -> 8)
		if (StringUtils.isNotEmpty(librarySearch.getSubjectCode()))
			param.put("subject_code", librarySearch.getSubjectCode());
		// 등록구분. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getRegCode()))
			param.put("reg_code", librarySearch.getRegCode());

		if (StringUtils.isNotEmpty(librarySearch.getShelf_list())) {
			param.put("search_shelf", librarySearch.getShelf_list());
		}

		if (StringUtils.isNotEmpty(librarySearch.getFacet_manage_code()))
			param.put("facet_manage_code", librarySearch.getFacet_manage_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_author()))
			param.put("facet_author", librarySearch.getFacet_author());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_media_code()))
			param.put("facet_media_code", librarySearch.getFacet_media_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_pub_year()))
			param.put("facet_pub_year", librarySearch.getFacet_pub_year());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_publisher()))
			param.put("facet_publisher", librarySearch.getFacet_publisher());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_subject_code()))
			param.put("facet_subject_code", librarySearch.getFacet_subject_code());

		try {
			// 자료검색용
			param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		} catch (Exception e) {
			// 신착도서 등 자료검색 제외
			param.put("manage_code", librarySearch.getManageCode());
		}

		//매체구분
		if (StringUtils.isNotEmpty(librarySearch.getMedia_code())){
			param.put("media_code", librarySearch.getMedia_code());
		}

		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "detail");

		if (!StringUtils.equals(librarySearch.getSortField(), "NONE")) {
			param.put("orderby_item", librarySearch.getSortField());
			param.put("orderby", librarySearch.getSortType());
		}

		result = CommonAPI.sendKCMS("nonbooksearch", param);

		return result;
	}

	/**
	 * K.API - 8
	 *
	 * 대출현황조회
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param userkey
	 * @return
	 */
	public static Map<String, Object> getBookLoanList(String userkey) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", userkey);

		return CommonAPI.sendKCMS("bookloanlist", param);
	}
	
	public static Map<String, Object> getBookLoanList(String userkey, String manage_code) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", userkey);
		if (StringUtils.isNotEmpty(manage_code)) {
			param.put("manage_code", manage_code);
		}

		return CommonAPI.sendKCMS("bookloanlist", param);
	}

	/**
	 * K.API - 9
	 *
	 * 대출자료 반납연기
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse renewLoan(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("loankey", librarySearch.getLoan_key());

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookreturndelay", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 10
	 *
	 * 대출이력 조회
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookLoanHistory(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());
		param.put("startdate", librarySearch.getSearch_start_date().replaceAll("-", ""));
		param.put("enddate", librarySearch.getSearch_end_date().replaceAll("-", ""));
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		if (StringUtils.isNotEmpty(librarySearch.getManageCode())) {
			param.put("manage_code", librarySearch.getManageCode());
		}

		return CommonAPI.sendKCMS("bookreturnlist", param);
	}

	/**
	 * K.API - 11
	 *
	 * 비치희망자료 신청내역 (이용자)
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookFurnishList(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("orderby_item", "APPLICANT_DATE");
		param.put("orderby", "DESC");

		return CommonAPI.sendKCMS("bookfurnishlist", param);

	}

	/**
	 * K.API - 12
	 *
	 * 비치희망신청 가능여부 확인
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param userkey
	 * @param isbn
	 * @param manage_code
	 * @return
	 */
	public static ApiResponse hopeUserCheck(String userkey, String isbn, String manage_code) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", userkey);
		if (StringUtils.isNotBlank(isbn)) {
			param.put("isbn", isbn);
		}
		param.put("manage_code", manage_code);
		// param.put("user_no", user_no);

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookfurnishrequestcheck", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}

	}

	/**
	 * K.API - 13
	 *
	 * 비치희망 신청
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param librarySearch
	 * @param member
	 * @return
	 */
	public static ApiResponse reqHope(LibrarySearch librarySearch, Member member) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", member.getRec_key());
		param.put("publish_year", librarySearch.getPubler_year());
		param.put("isbn", librarySearch.getIsbn());
		param.put("manage_code", librarySearch.getManageCode());

		if (StringUtils.isNotEmpty(librarySearch.getTitle())) {
			try {
				param.put("title", URLEncoder.encode(librarySearch.getTitle(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {}
		}

		if (StringUtils.isNotEmpty(librarySearch.getAuthor())) {
			try {
				param.put("author", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {}
		}

		if (StringUtils.isNotEmpty(librarySearch.getPrice())) {
			param.put("price", librarySearch.getPrice());
		}

		if (StringUtils.isNotEmpty(librarySearch.getPubler())) {
			try {
				param.put("publisher", URLEncoder.encode(librarySearch.getPubler(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {}
		}

		if (StringUtils.isNotEmpty(librarySearch.getRecom_opinion())) {
			try {
				param.put("recom_opinion", URLEncoder.encode(librarySearch.getRecom_opinion(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {}
		}

		if (StringUtils.isNotEmpty(librarySearch.getSms_receipt_yn())) {
			param.put("sms_receipt_yn", "Y");
		}

		if (StringUtils.equals(librarySearch.getReservation_yn(), "Y")) {
			param.put("reservation_yn", "Y");
		} else {
			param.put("reservation_yn", "N");
		}

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookfurnishrequest", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}

	}

	/**
	 * K.API - 14
	 *
	 * 비치희망신청 취소
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse modHope(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("reckey", librarySearch.getSelect_no());

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookfurnishcancel", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 15
	 *
	 * 예약자료조회
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param userkey
	 * @return
	 */
	public static Map<String, Object> getReserveList(String userkey) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", userkey);

		return CommonAPI.sendKCMS("bookreservelist", param);
	}

	/**
	 * K.API - 16
	 *
	 * 예약취소
	 *
	 * @author YONGJU 2017. 12. 30.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse cancelResve(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());// 이용자key
		param.put("reckey", librarySearch.getBookkey());// 대출key

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookreservecancel", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 17
	 *
	 * 서지예약
	 *
	 * @author YONGJU 2017. 12. 30.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse reqResve(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());// 이용자key
		param.put("bookkey", librarySearch.getBookkey());// 책key
		String booktype = librarySearch.getBooktype();
		if (!StringUtils.equals(booktype, "BO") && !StringUtils.equals(booktype, "SE")) {
			booktype = StringUtils.equals(booktype, "BOOK") ? "BO" : "SE";
		}
		param.put("booktype", booktype);// 자료타입 BO:단행본, SE:연속간행물

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("bookreserve", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 29
	 *
	 * 대출베스트 조회
	 *
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBestBookList(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		if (StringUtils.isNotEmpty(librarySearch.getManageCode()))
			param.put("manage_code", librarySearch.getManageCode());
		param.put("display", librarySearch.getRowCount());
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date()))
			param.put("startdate", librarySearch.getSearch_start_date().replaceAll("-", ""));// YYYYMMDD
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date()))
			param.put("enddate", librarySearch.getSearch_end_date().replaceAll("-", ""));// YYYYMMDD
		if (StringUtils.isNotEmpty(librarySearch.getBooktype()))
			param.put("option", librarySearch.getBooktype());
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()))
			param.put("shelf_loc_code", librarySearch.getShelfCode());
		if (StringUtils.isNotEmpty(librarySearch.getRegCode()))
			param.put("reg_code", librarySearch.getRegCode());
		if (StringUtils.isNotEmpty(librarySearch.getSubjectCode()))
			param.put("subject_code", librarySearch.getSubjectCode());
		// if (StringUtils.isNotEmpty(librarySearch.getManageCode())) param.put("min_loan_cnt",librarySearch.getManageCode());
		if (StringUtils.isNotEmpty(librarySearch.getMedia_code()))
			param.put("media_code", librarySearch.getMedia_code());

		result = CommonAPI.sendKCMS("bookloanbest", param);

		return result;
	}

	/**
	 * K.API - 30
	 *
	 * 신착자료 리스트 조회
	 *
	 * @author YONGJU 2018. 3. 13.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getNewBookList(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		if (StringUtils.isNotEmpty(librarySearch.getManageCode())) {
			param.put("manage_code", librarySearch.getManageCode());
		}
		param.put("pageno", librarySearch.getViewPage());

		param.put("display", librarySearch.getRowCount());
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date())) {
			param.put("startdate", librarySearch.getSearch_start_date().replaceAll("-", ""));// YYYYMMDD
		}

		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date())) {
			param.put("enddate", librarySearch.getSearch_end_date().replaceAll("-", ""));// YYYYMMDD
		}

		if (StringUtils.isNotEmpty(librarySearch.getMedia_code())) {
			param.put("media_code", librarySearch.getMedia_code());
		}

//		if (!CollectionUtils.isEmpty(librarySearch.getShelfCodeList())) {
//			param.put("shelf_loc_code", StringUtils.join(librarySearch.getShelfCodeList(), ","));
//		}
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()) && !StringUtils.equals(librarySearch.getShelfCode(), "ALL")) {
			param.put("shelf_loc_code", librarySearch.getShelfCode());
		}

		if (StringUtils.isNotEmpty(librarySearch.getSubjectCode())) {
			param.put("subject_code", librarySearch.getSubjectCode());
		}

		param.put("option", librarySearch.getBooktype());

		result = CommonAPI.sendKCMS("newbooklist", param);

		return result;
	}
	
	public static Map<String, Object> getPopularBookList(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;
		
		param.put("startDt", librarySearch.getStartDt());
		param.put("endDt", librarySearch.getEndDt());
		param.put("pageNo", librarySearch.getViewPage());
		param.put("pageSize", librarySearch.getRowCount());
		
		if(librarySearch.getGender() != null && !librarySearch.getGender().isEmpty()) {
			param.put("gender", librarySearch.getGender());
		}
		if(librarySearch.getAge() != null && librarySearch.getAge().length != 0) {
			String age[] = null;
			String finalAge = "";
			if(librarySearch.getAge().length > 1) {
				age = librarySearch.getAge();
				for(int i = 0; i < age.length; i++) {
					if(i == 0) {
						finalAge = age[i];
					}else {
						finalAge = finalAge + ";" + age[i];
					}
				}
			}
			param.put("age", finalAge);
		}
		if(librarySearch.getKdc() != null && librarySearch.getKdc().length != 0) {
			String kdc[] = null;
			String finalKdc = "";
			if(librarySearch.getKdc().length > 1) {
				kdc = librarySearch.getKdc();
				for(int i = 0; i < kdc.length; i++) {
					if(i == 0) {
						finalKdc = kdc[i];
					}else {
						finalKdc = finalKdc + ";" + kdc[i];
					}
				}
			}
			param.put("kdc", finalKdc);
		}
		if(librarySearch.getRegion() != null && librarySearch.getRegion().length != 0) {
			String region[] = null;
			String finalRegion = "";
			if(librarySearch.getRegion().length > 1) {
				region = librarySearch.getRegion();
				for(int i = 0; i < region.length; i++) {
					if(i == 0) {
						finalRegion = region[i];
					}else {
						finalRegion = finalRegion + ";" + region[i];
					}
				}
			}
			param.put("region", finalRegion);
		}
		if(librarySearch.getLibCode() != null && !librarySearch.getLibCode().isEmpty()) {
			param.put("libCode", librarySearch.getLibCode());
			result = CommonAPI.sendData4Library(param, "loanItemSrchByLib");
		} else {
			result = CommonAPI.sendData4Library(param, "loanItemSrch");
		}
		

		
		return result;
	}
	
	public static Map<String, Object> getPopularBook(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;
		
		param.put("isbn13", librarySearch.getIsbn13());
		param.put("loaninfoYN", "Y");
		result = CommonAPI.sendData4Library(param, "srchDtlList");
		return result;
	}

	/**
	 * K.API - 35
	 *
	 * 단일 서지정보 조회
	 *
	 * @author YONGJU 2018. 4. 16.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookInfo(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("manage_code", librarySearch.getManageCode());
		param.put("reg_no", librarySearch.getRegNo());

		result = CommonAPI.sendKCMS("getbookinfo", param);

		return result;
	}

	/**
	 * K.API - 37
	 *
	 * 인기검색어 10
	 *
	 * @author whalesoft YONGJU 2019. 11. 11.
	 * @param manage_code
	 *        도서관부호 2자리
	 * @return
	 */
	public static Map<String, Object> getHotTrendWordList(String manage_code) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("manage_code", manage_code);
		return CommonAPI.sendKCMS("searchwordbest", param);
	}

	/**
	 * K.API - 37
	 *
	 * 도서관 설정정보 조회
	 *
	 * @author whalesoft YONGJU 2020. 4. 2.
	 * @param manage_code 검색대상 도서관 관리코드 여러 개인 경우 comma(,)로 연결 미입력시 전체도서관 검색
	 * @param option 0 : KBILL 미사용 조회, 1 : KBILL 사용 조회 (미입력시 기본값 : 0)
	 * @param offer_yn KBILL 사용 시 상호대차 제공여부
	 * @param loan_yn KBILL 사용 시 상호대차 대출가능여부
	 * @param return_yn KBILL 사용 시 상호대차 반납가능여부
	 * @param group_code KBILL 사용 시 상호대차 그룹코드
	 * @return
	 */
	public static Map<String, Object> getLibSettingInfoView(String manage_code, String option, String offer_yn, String loan_yn, String return_yn, String group_code) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("manage_code", manage_code);
		if (StringUtils.isNotEmpty(option)) {
			param.put("option", option);
		}
		if (StringUtils.isNotEmpty(offer_yn)) {
			param.put("offer_yn", offer_yn);
		}
		if (StringUtils.isNotEmpty(loan_yn)) {
			param.put("loan_yn", loan_yn);
		}
		if (StringUtils.isNotEmpty(return_yn)) {
			param.put("return_yn", return_yn);
		}
		if (StringUtils.isNotEmpty(group_code)) {
			param.put("group_code", group_code);
		}
		return CommonAPI.sendKCMS("libsettinginfoview", param);
	}

	/**
	 * K.API - 44
	 *
	 * 단행본 상세검색 조회 (단행본 일반검색은 getBookNormal)
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getBookAndNonbookDetail(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		try {
			// 서명
			if (StringUtils.isNotEmpty(librarySearch.getTitle()))
				param.put("search_title", URLEncoder.encode(librarySearch.getTitle(), "UTF-8"));
			// 저자
			if (StringUtils.isNotEmpty(librarySearch.getAuthor()))
				param.put("search_author", URLEncoder.encode(librarySearch.getAuthor(), "UTF-8"));
			// 발행자
			if (StringUtils.isNotEmpty(librarySearch.getPubler()))
				param.put("search_publisher", URLEncoder.encode(librarySearch.getPubler(), "UTF-8"));
			// 키워드
			if (StringUtils.isNotEmpty(librarySearch.getKeyword()))
				param.put("search_keyword", URLEncoder.encode(librarySearch.getKeyword(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {}

		// ISBN
		if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
			String isbnArr[] = librarySearch.getIsbn().split(" ");
			String isbn = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10 || isbnArr[i].length() == 13) {
					isbn = isbnArr[i];
				}
			}
			if (StringUtils.isNotEmpty(isbn)) {
				param.put("search_isbn_issn", isbn);
			}
		}
		// 발행년시작 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date()))
			param.put("search_year_start", librarySearch.getSearch_start_date());
		// 발행년종료 - YYYY
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date()))
			param.put("search_year_end", librarySearch.getSearch_end_date());
		// 자료실코드
		if (StringUtils.isNotEmpty(librarySearch.getShelfCode()))
			param.put("search_shelf", librarySearch.getShelfCode());
		//검색 제외 자료실코드. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getNotShelfCode()))
			param.put("not_search_shelf", librarySearch.getNotShelfCode());
		// 주제부호 : 분류기호의 첫번째 숫자(0~9). 여러 개인 경우 comma(,)로 연결. ※ IDX_BO_TBL의 CLASS_NO 필드의 첫번째 숫자값으로 확인 (ex : 816.6 -> 8)
		if (StringUtils.isNotEmpty(librarySearch.getSubjectCode()))
			param.put("subject_code", librarySearch.getSubjectCode());
		// 등록구분. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getRegCode()))
			param.put("reg_code", librarySearch.getRegCode());
		// 매체구분. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getMedia_code()))
			param.put("media_code", librarySearch.getMedia_code());
		// 별치기호. 여러개인 경우 comma(,)로 연결
		if (StringUtils.isNotEmpty(librarySearch.getSeparateShelfCode()))
			param.put("separate_shelf_code", librarySearch.getSeparateShelfCode());

		if (StringUtils.isNotEmpty(librarySearch.getFacet_manage_code()))
			param.put("facet_manage_code", librarySearch.getFacet_manage_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_author()))
			param.put("facet_author", librarySearch.getFacet_author());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_media_code()))
			param.put("facet_media_code", librarySearch.getFacet_media_code());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_pub_year()))
			param.put("facet_pub_year", librarySearch.getFacet_pub_year());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_publisher()))
			param.put("facet_publisher", librarySearch.getFacet_publisher());
		if (StringUtils.isNotEmpty(librarySearch.getFacet_subject_code()))
			param.put("facet_subject_code", librarySearch.getFacet_subject_code());

		try {
			// 자료검색용
			param.put("manage_code", StringUtils.join(librarySearch.getLibraryCodes(), ",").replaceAll("lib_", ""));
		} catch (Exception e) {
			// 신착도서 등 자료검색 제외
			param.put("manage_code", librarySearch.getManageCode());
		}

		if (StringUtils.isNotEmpty(librarySearch.getShelf_list())) {
			param.put("search_shelf", librarySearch.getShelf_list());
		}

		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		param.put("search_type", "detail");
		if (!StringUtils.equals(librarySearch.getSortField(), "NONE")) {
			param.put("orderby_item", librarySearch.getSortField());
			param.put("orderby", librarySearch.getSortType());
		}

		result = CommonAPI.sendKCMS("bookandnonbooksearch", param);

		return result;
	}

	/**
	 * K.API - 46
	 *
	 * 코드조회
	 *
	 * @author whalesoft dseok63 2019. 12. 09.
	 * @param class_code
	 *        1 : 관리구분(manage_code)
	 *        4 : 등록구분(reg_code)
	 *        5 : 매체구분(media_code)
	 *        16 : 이용제한구분(use_limit_code)
	 *        19 : 자료실구분(shelf_loc_code)
	 *        30 : 소속 (user_position_code)
	 *        31 : 직급 (user_class_code)
	 * @param manage_code
	 * @return
	 */
	public static Map<String, Object> getSubLocaInfo(String class_code, String manage_code) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("class_code", class_code);
		param.put("manage_code", manage_code);
		return CommonAPI.sendKCMS("getcodeinfo", param);
	}

	/**
	 * K.API - 56
	 *
	 * 야간대출예약
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse nightloanreserve(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());// 이용자key
		param.put("bookkey", librarySearch.getBookkey());// 책key
		String booktype = librarySearch.getBooktype();
		if (!StringUtils.equals(booktype, "BO") && !StringUtils.equals(booktype, "SE")) {
			booktype = StringUtils.equals(booktype, "BOOK") ? "BO" : "SE";
		}
		param.put("booktype", booktype);// 자료타입 BO:단행본, SE:연속간행물
		param.put("worker", librarySearch.getWorker());// 장비ID
		param.put("expire_date_cnt", librarySearch.getExprire_date_cnt());// 예약만기일수 -입력시 예약만기일 : API 서비스 요청 당일+예약만기일수. -미입력시 예약만기일 : 당일

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("nightloanreserve", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 60
	 *
	 * 야간대출예약 전체건수 조회
	 *
	 * @author whalesoft YONGJU 2020. 4. 9.
	 * @param librarySearch
	 * @param type
	 * @return
	 */
	public static Map<String, Object> getNightLoanReserveCnt(LibrarySearch librarySearch, String type) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("worker", librarySearch.getWorker());// 장비ID
		param.put("type", type);//카운트대상		- DATA : 야간대출예약건수		- USER : 야간대출예약자수		(미입력시 기본값 : DATA)
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date())) {
			param.put("startdate", librarySearch.getSearch_start_date());//예약일 검색시작일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date())) {
			param.put("enddate", librarySearch.getSearch_end_date());//예약일 검색종료일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}

		return CommonAPI.sendKCMS("getnightloanreservecnt", param);
	}

	/**
	 * K.API - 62
	 *
	 * 무인대출예약
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param librarySearch
	 * @return
	 */
	public static ApiResponse unmannedloanreserve(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("userkey", librarySearch.getUserkey());// 이용자key
		param.put("bookkey", librarySearch.getBookkey());// 책key
		String booktype = librarySearch.getBooktype();
		if (!StringUtils.equals(booktype, "BO") && !StringUtils.equals(booktype, "SE")) {
			booktype = StringUtils.equals(booktype, "BOOK") ? "BO" : "SE";
		}
		param.put("booktype", booktype);// 자료타입 BO:단행본, SE:연속간행물
		param.put("worker", librarySearch.getWorker());// 장비ID
		param.put("expire_date_cnt", librarySearch.getExprire_date_cnt());// 예약만기일수


		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("unmannedloanreserve", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}


	/**
	 * K.API - 64
	 *
	 * 무인대출예약 건수 조회
	 *
	 * @author whalesoft YONGJU 2020. 4. 9.
	 * @param librarySearch
	 * @param type
	 * @return
	 */
	public static Map<String, Object> getUnmannedLoanReserveCnt(LibrarySearch librarySearch, String type) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("worker", librarySearch.getWorker());// 장비ID
		param.put("type", type);//카운트대상		- DATA : 무인대출예약건수		- USER : 무인대출예약자수		(미입력시 기본값 : DATA)
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date())) {
			param.put("startdate", librarySearch.getSearch_start_date());//예약일 검색시작일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date())) {
			param.put("enddate", librarySearch.getSearch_end_date());//예약일 검색종료일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}

		return CommonAPI.sendKCMS("getunmannedloanreservecnt", param);
	}

	/**
	 * K.API - 63
	 *
	 * 무인대출예약 목록 조회
	 *
	 * @author whalesoft YONGJU 2020. 4. 9.
	 * @param librarySearch
	 * @param workno
	 * @return
	 */
	public static Map<String, Object> getUnmannedLoanReserveList(LibrarySearch librarySearch, String workno) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("worker", librarySearch.getWorker());// 장비ID
		if (StringUtils.isNotEmpty(librarySearch.getSearch_start_date())) {
			param.put("startdate", librarySearch.getSearch_start_date());//예약일 검색시작일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}
		if (StringUtils.isNotEmpty(librarySearch.getSearch_end_date())) {
			param.put("enddate", librarySearch.getSearch_end_date());//예약일 검색종료일 YYYYMMDDHH24MISS 형식 (14자리)	(미입력시 기본값 : 검색당일)
		}
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());
		if (StringUtils.isNotEmpty(librarySearch.getBookkey())) {
			param.put("bookkey", librarySearch.getBookkey());
		}
		if (StringUtils.isNotEmpty(librarySearch.getRegNo())) {
			param.put("reg_no", librarySearch.getRegNo());
		}
		if (StringUtils.isNotEmpty(librarySearch.getUserkey())) {
			param.put("userkey", librarySearch.getUserkey());
		}
		if (StringUtils.isNotEmpty(workno)) {
			param.put("workno", workno);
		}

		return CommonAPI.sendKCMS("getunmannedloanreservelist", param);
	}

	/**
	 * K.API - 66
	 *
	 * 휴관일 여부 조회
	 *
	 * @author whalesoft YONGJU 2019. 12. 6.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> getCheckHoliday(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("manage_code", librarySearch.getManageCode());
		param.put("search_date", librarySearch.getSearch_start_date());

		result = CommonAPI.sendKCMS("checkHoliday", param);

		return result;
	}

	/**
	 * K.API - 70
	 *
	 * SMS 발송
	 *
	 * @author whalesoft YONGJU 2020. 2. 6.
	 * @param librarySearch
	 * @param msg
	 * @param ip
	 *
	 * @return
	 */
	public static ApiResponse sendSms(LibrarySearch librarySearch, String msg, String ip) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("api_key", "79724C6D73152DC1035B16B6198665D34A640D5D11E8ACD60083FA80FE417E58");
		param.put("manage_code", librarySearch.getManageCode());
		param.put("userkey", librarySearch.getUserkey());
		try {
			param.put("msg", URLEncoder.encode(msg, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error("@@@@@@@@@@@@@@@@ sendsms utf8 encode error : " + msg);
		}
		param.put("client_ip", ip);
		param.put("worker", "HOMEPAGE");

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("sendsms", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 74
	 *
	 * MARC 조회
	 *
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param regno
	 * @return
	 */
	public static Map<String, Object> getMarc(String regno) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("option", 1);
		if (StringUtils.isNotBlank(regno)) {
			param.put("regno", regno);
		}
		
		return CommonAPI.sendMARC("getmarc", param);
	}

	/**
	 * === K.API 공통 ===
	 *
	 * KCMS API 결과 SEARCH_COUNT를 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 0을 리턴한다.
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static int getSearchCount(Map<String, Object> map) {
		int cnt = 0;
		List<Map<String, Object>> list = null;

		if (map != null && !map.isEmpty() && map.get("RESULT_MESSAGE") != null) {
			return 0;
		}

		if (map != null && !map.isEmpty() && map.get("LIST_DATA") != null) {
			list = new ArrayList<Map<String, Object>>();
			list.addAll((List<Map<String, Object>>) map.get("LIST_DATA"));
			if (list != null && list.size() > 0) {
				Map<String, Object> countMap = list.get(0);
				if (countMap != null && !countMap.isEmpty() && countMap.containsKey("SEARCH_COUNT")) {
					cnt = Integer.parseInt(String.valueOf(countMap.get("SEARCH_COUNT")));
				}
			}
		}

		return cnt;
	}

	/**
	 * === K.API 공통 ===
	 *
	 * KCMS API 자료검색 결과 FACET_GROUP을 반환
	 *
	 * @author YONGJU 2020. 01. 15.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static Map<String, Object> getFacetGroup(Map<String, Object> map) {
		List<Map<String, Object>> list = null;
		Map<String, Object> facet = null;

		if (map != null && !map.isEmpty() && map.get("LIST_DATA") != null) {
			list = new ArrayList<Map<String, Object>>();
			list.addAll((List<Map<String, Object>>) map.get("LIST_DATA"));
			if (list != null && list.size() > 0) {
				Map<String, Object> countMap = list.get(0);
				if (countMap != null && !countMap.isEmpty() && countMap.containsKey("FACET_GROUP")) {
					facet = (Map<String, Object>) countMap.get("FACET_GROUP");
				}
			}
		}

		return facet;
	}

	/**
	 * === K.API 공통 ===
	 *
	 * KCMS API 결과 SEARCH_COUNT를 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 0을 리턴한다.
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static int getSearchCount(Map<String, Object> map, String list_name) {
		int cnt = 0;
		List<Map<String, Object>> list = null;

		if (map != null && !map.isEmpty() && map.get("RESULT_MESSAGE") != null) {
			return 0;
		}

		if (map != null && !map.isEmpty() && map.get(list_name) != null) {
			list = new ArrayList<Map<String, Object>>();
			list.addAll((List<Map<String, Object>>) map.get(list_name));
			if (list != null && list.size() > 0) {
				Map<String, Object> countMap = list.get(0);
				if (countMap != null && !countMap.isEmpty() && countMap.containsKey("SEARCH_COUNT")) {
					cnt = Integer.parseInt(String.valueOf(countMap.get("SEARCH_COUNT")));
				}
			}
		}

		return cnt;
	}

	/**
	 * === K.API 공통 ===
	 *
	 * KCMS API 결과 DATA를 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 null을 리턴한다.
	 *
	 * @author YONGJU 2017. 12. 15.
	 * @param map
	 * @param list_name
	 *        - LIST_DATA, USER_DATA 등
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static List<Map<String, Object>> getListData(Map<String, Object> map, String list_name) {
		List<Map<String, Object>> list = null;

		if (map != null && !map.isEmpty() && map.get("RESULT_MESSAGE") != null) {
			return null;
		}

		if (map != null && !map.isEmpty() && map.get(list_name) != null) {
			list = new ArrayList<Map<String, Object>>();
			try {
				list.addAll((List<Map<String, Object>>) map.get(list_name));
			} catch (ClassCastException e) {
				list.add((Map<String, Object>) map.get(list_name));
			}
			if (list != null && list.size() > 0) {
				Map<String, Object> countMap = list.get(0);
				if (countMap != null && !countMap.isEmpty() && countMap.containsKey("SEARCH_COUNT")) {
					list.remove(0);
				}
			}
		}

		return list;
	}

	/**
	 * === K.API 공통 ===
	 *
	 * KCMS API 결과 LIST_DATA를 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 null을 리턴한다.
	 *
	 * @author YONGJU 2017. 12. 13.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static List<Map<String, Object>> getListData(Map<String, Object> map) {
		List<Map<String, Object>> list = null;

		if (map != null && !map.isEmpty() && map.get("RESULT_MESSAGE") != null) {
			return null;
		}

		if (map != null && !map.isEmpty() && map.get("LIST_DATA") != null) {
			list = new ArrayList<Map<String, Object>>();
			list.addAll((List<Map<String, Object>>) map.get("LIST_DATA"));
			if (list != null && list.size() > 0) {
				Map<String, Object> countMap = list.get(0);
				if (countMap != null && !countMap.isEmpty() && countMap.containsKey("SEARCH_COUNT")) {
					list.remove(0);
				}
			}
		}

		return list;
	}

	/********************************************************************************************************************/
	/********************************************* 이하 알라딘 **************************************************************/
	/*******************************************************************************************************************/

	/**
	 * 알라딘 API 책 1권의 정보를 가져온다.
	 * cover : item.corver
	 * @author YONGJU 2017. 11. 23.
	 * @param map ISBN
	 */
	public static Map<String, Object> getAladinDetail(Map<String, Object> map) {
		Map<String, Object> param = new HashMap<String, Object>();
		String isbnOrg = String.valueOf(map.get("ISBN"));
		if (StringUtils.isNotEmpty(isbnOrg)) {
			isbnOrg = isbnOrg.trim();
		}

		if (StringUtils.isNotEmpty(isbnOrg)) {
			String isbnArr[] = isbnOrg.split(" ");
			String isbn = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10) {
					isbn = isbnArr[i];
					param.put("ItemIdType", "ISBN");
					param.put("ItemId", isbn.trim());
				}
				if (isbnArr[i].length() == 13) {
					isbn = isbnArr[i];
					param.put("ItemIdType", "ISBN13");
					param.put("ItemId", isbn.trim());
				}
			}
		} else {
			return null;
		}

		return CommonAPI.sendALADIN(param, "detail");
//		return null;
	}


	/********************************************************************************************************************/
	/********************************************* 이하 상호대차 **************************************************************/
	/*******************************************************************************************************************/

	/**
	 * SANGHO - 8
	 *
	 * 지역상호대차 신청가능여부 판단
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param librarySearch
	 * @return
	 */
	public static Map<String, Object> sanghoReqYn(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", "reqyn");
		param.put("userno", librarySearch.getUserkey());
		param.put("regno", librarySearch.getRegNo());
		param.put("libcode", librarySearch.getLibCode());
		param.put("specieskey", librarySearch.getSpeciesKey());

		return CommonAPI.sendSANGHO(param);
	}

	/**
	 * SANGHO - 9
	 *
	 * 지역상호대차 신청
	 *
	 * @author YONGJU 2018. 4. 4.
	 * @param librarySearch
	 */
	public static Map<String, Object> sanghoReq(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", "req");
		param.put("userno", librarySearch.getUserkey());
		param.put("regno", librarySearch.getRegNo());
		param.put("libcode", librarySearch.getLibCode());
		param.put("specieskey", librarySearch.getSpeciesKey());
		param.put("uselibcode", librarySearch.getUselibcode());
		param.put("localkey", librarySearch.getBookkey());
		if (StringUtils.isNotEmpty(librarySearch.getAppendixrctyn())) {
			param.put("appendixrctyn", librarySearch.getAppendixrctyn());
		}

		return CommonAPI.sendSANGHO(param);
	}

	/**
	 * SANGHO - 10
	 *
	 * 지역상호대차 신청 취소
	 *
	 * @author YONGJU 2018. 4. 4.
	 * @param librarySearch
	 */
	public static Map<String, Object> sanghoReqCancel(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", "reqcancel");
		param.put("loankey", librarySearch.getLoan_key());
		param.put("libcode", librarySearch.getHold_lib_code());
		param.put("localkey", librarySearch.getLocal_book_key());

		return CommonAPI.sendSANGHO(param);
	}

	/**
	 * SANGHO - 11
	 *
	 * 상호대차 신청내역
	 *
	 * @author YONGJU 2018. 4. 4.
	 * @param librarySearch
	 */
	public static Map<String, Object> getSanghoHistory(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", "requseinfo");
		param.put("reqseloption", "ing");
		param.put("userno", librarySearch.getUserkey());
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());

		return CommonAPI.sendSANGHO(param);
	}

	/**
	 * SANGHO - 12
	 *
	 * 상호대차 이용내역
	 *
	 * @author YONGJU 2018. 4. 4.
	 * @param librarySearch
	 */
	public static Map<String, Object> getSanghoUsedHistory(LibrarySearch librarySearch) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", "requseinfo");
		param.put("reqseloption", "complete");
		param.put("userno", librarySearch.getUserkey());
		param.put("pageno", librarySearch.getViewPage());
		param.put("display", librarySearch.getRowCount());

		return CommonAPI.sendSANGHO(param);
	}

	/**
	 * === 상호대차 공통 ===
	 *
	 * 상호대차 API 결과 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 null을 리턴한다.
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static List<Map<String, Object>> getSanghoListData(Map<String, Object> map) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		try {
			if (map.get("ITEM") instanceof HashMap) {
				Map<String, Object> item = (Map<String, Object>) map.get("ITEM");
				if (!item.containsKey("ERROR")) {
					list.add(item);
				}
			} else {
				List<Map<String, Object>> items = (List<Map<String, Object>>) map.get("ITEM");

				for (int i = 0; i < items.size(); i++) {
					list.add(items.get(i));
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return list;
	}

	/**
	 * === 상호대차 공통 ===
	 *
	 * 상호대차 API 결과 카운트 반환 API 결과가 정상인 경우에만 리턴되며 실패할경우 0을 리턴한다.
	 *
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param map
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static int getSanghoSearchCount(Map<String, Object> map) {
		int cnt = 0;

		if (map.containsKey("ERROR")) {
			cnt = 0;
		} else {
			Object info = map.get("INFO");
			if (info instanceof Map) {
				try {
					cnt = Integer.parseInt(String.valueOf(((Map<String, Object>) info).get("TOTAL")));
				} catch (NumberFormatException e) {
					cnt = 0;
				}
			}
		}

		return cnt;
	}

	/********************************************************************************************************************/
	/********************************************* 이하 네이버 ***************************************************************/
	/*******************************************************************************************************************/

	/**
	 * 네이버 책검색 - list
	 *
	 * @param pagingUtils search_text
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static Map<String, Object> getNaverList(PagingUtils pagingUtils) {
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("query", URLEncoder.encode(pagingUtils.getSearch_text(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			param.put("query", "");
		}
		param.put("start", (pagingUtils.getViewPage() - 1) * 10 + 1);

		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("totalCount", 0);
		returnMap.put("list", null);
		List<Map<String, Object>> returnList = null;

		Map<String, Object> resultMap = CommonAPI.sendNAVER(param, "list");

		if (resultMap != null) {
			Map<String, Object> rssMap = (Map<String, Object>) resultMap.get("rss");
			if (rssMap != null) {
				Map<String, Object> channelMap = (Map<String, Object>) rssMap.get("channel");
				if (channelMap != null) {
					Object item = channelMap.get("item");
					if (item instanceof Map) {
						returnList = new ArrayList<Map<String, Object>>();
						returnList.add((Map<String, Object>) item);
					} else {
						returnList = (List<Map<String, Object>>) item;
					}
					returnMap.put("totalCount", channelMap.get("total"));
					returnMap.put("list", returnList);
				}
			}
		}

		return returnMap;
	}

	/**
	 * 네이버 책검색 - isbn
	 *
	 * @param isbn
	 * @return
	 */
	@SuppressWarnings ("unchecked")
	public static List<Map<String, Object>> getNaverDetail(String isbn) {
		List<Map<String, Object>> returnList = null;
		Map<String, Object> param = new HashMap<String, Object>();
		try {
			param.put("d_isbn", isbn);
		} catch (Exception e) {
			return null;
		}

		Map<String, Object> resultMap = CommonAPI.sendNAVER(param, "detail");

		if (resultMap != null) {
			Map<String, Object> rssMap = (Map<String, Object>) resultMap.get("rss");
			if (rssMap != null) {
				Map<String, Object> channelMap = (Map<String, Object>) rssMap.get("channel");
				if (channelMap != null) {
					Object item = channelMap.get("item");
					if (item instanceof Map) {
						returnList = new ArrayList<Map<String, Object>>();
						returnList.add((Map<String, Object>) item);
					} else {
						returnList = (List<Map<String, Object>>) item;
					}
					return returnList;
				}
			}
		}

		// naverDetail.rss.channel.item

		return null;
	}

	/********************************************************************************************************************/
	/********************************************* 이하 일루스 ***************************************************************/
	/*******************************************************************************************************************/

	/**
	 * 전자책의 마크URL 구하기
	 *
	 * @param vCtrl
	 * @return
	 */
	public static String getMarcUrl(String vCtrl) {
		// Map<String, Object> param = new HashMap<String, Object>();
		// param.put("USERID", "WEB");
		// param.put("className", "action.lnk.LnkMarcInfo");
		// param.put("vCtrl", vCtrl);
		// param.put("vDataType", "MARC XML");
		//
		// Document doc = CommonAPI.sendILUS(param);
		//
		// XPath xPath = XPathFactory.newInstance().newXPath();
		// String path = "//list[@name=\"dsMarcView\"]/item[field[@name=\"TAG\" and text() = \"856\"]]/field[@name=\"FIELD\"]/text()";
		// XPathExpression expr = null;
		// String value = null;
		// try {
		// expr = xPath.compile(path);
		// value = (String) expr.evaluate(doc, XPathConstants.STRING);
		// } catch (XPathExpressionException e) {
		// return "";
		// }
		//
		// if(StringUtils.defaultString(value).length() < 3) {
		// return "";
		// } else {
		// // value = "▼u https://www.gbelib.kr/elib/module/elib/book/view.do?menu_idx=14&type=EBK&book_idx=13773"
		// return value.substring(3);
		// }
		return null;
	}

	public static Map<String, Object> addMarcUrls(Map<String, Object> result) {
		// List<Map<String, Object>> data = null;
		// String isbnField = "isbn";
		// String locaField = "libCode";
		// String type = "data";
		//
		// if(result.get("data") != null) {
		// data = (List<Map<String, Object>>) result.get("data");
		// isbnField = "isbn";
		// locaField = "libCode";
		// type = "data";
		// } else if(result.get("dsLoanBestList") != null) {
		// data = (List<Map<String, Object>>) result.get("dsLoanBestList");
		// isbnField = "ISBN";
		// locaField = "LOCA";
		// type = "dsLoanBestList";
		// } else if(result.get("dsNewBookList") != null) {
		// data = (List<Map<String, Object>>) result.get("dsNewBookList");
		// isbnField = "ISBN";
		// locaField = "LOCA";
		// type = "dsNewBookList";
		// } else if(result.get("dsItemDetail") != null) {
		// data = (List<Map<String, Object>>) result.get("dsItemDetail");
		// type = "dsItemDetail";
		// locaField = "LOCA";
		// } else {
		//
		// }
		//
		// if(data != null) {
		// for(Map<String, Object> item: data) {
		//
		// String marcUrl = "";
		// if("data".equals(type) || "dsLoanBestList".equals(type) || "dsNewBookList".equals(type)) {
		// String libCode = String.valueOf(item.get(locaField));
		// if("00000001".equals(libCode)) {
		// String isbn = String.valueOf(item.get(isbnField));
		// marcUrl = LibSearchAPI.getMarcUrlByIsbn(isbn);
		// }
		// } else if("dsItemDetail".equals(type)) {
		// String libCode = String.valueOf(item.get(locaField));
		// if("00000001".equals(libCode)) {
		// String vCtrl = String.valueOf(item.get("CTRLNO"));
		// marcUrl = LibSearchAPI.getMarcUrl(vCtrl);
		// }
		// }
		//
		// if(StringUtils.isNotEmpty(marcUrl)) {
		// item.put("marc_url", marcUrl);
		// }
		// }
		// }

		return result;
	}

	/**
	 * 도서관 정보나루
	 * @author whalesoft YONGJU 2020. 1. 14.
	 * @param isbn
	 * @return
	 */
	public static Map<String, Object> getSrchDtlList(String isbn) {
		Map<String, Object> param = new HashMap<String, Object>();

		if (StringUtils.isEmpty(isbn)) {
			return null;
		} else {
			param.put("isbn13", isbn);
		}

		param.put("loaninfoYN", "Y");
		param.put("displayInfo", "age");


		return CommonAPI.sendData4Library(param, "srchDtlList");
	}

	/**
	 * @author YONGJU 2018. 4. 11.
	 * @param isbn
	 */
	public static Map<String, Object> getKeywordList(String isbn) {
		Map<String, Object> param = new HashMap<String, Object>();

		if (StringUtils.isEmpty(isbn)) {
			return null;
		} else {
			param.put("isbn13", isbn);
		}

		return CommonAPI.sendData4Library(param, "keywordList");
	}

	/**
	 * @author YONGJU 2018. 4. 11.
	 * @param isbn
	 */
	public static Map<String, Object> getRecommandList(String isbn) {
		Map<String, Object> param = new HashMap<String, Object>();

		String isbnOrg = isbn;
		if (StringUtils.isNotEmpty(isbnOrg)) {
			isbnOrg = isbnOrg.trim();
		}

		if (StringUtils.isNotEmpty(isbnOrg)) {
			String isbnArr[] = isbnOrg.split(" ");
			String isbnTemp = "";
			for (int i = 0; i < isbnArr.length; i++) {
				if (isbnArr[i].length() == 10) {
					isbnTemp = isbnArr[i];
					param.put("isbn13", isbnTemp.trim());
				}
				if (isbnArr[i].length() == 13) {
					isbnTemp = isbnArr[i];
					param.put("isbn13", isbnTemp.trim());
				}
			}
		} else {
			return null;
		}

		return CommonAPI.sendData4Library(param, "recommandList");
	}

}
