package kr.go.gbelib.app.intro.search;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfig;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfigService;
import kr.go.gbelib.app.cms.module.ilusReqConfig.ILUSReqConfig;
import kr.go.gbelib.app.cms.module.ilusReqConfig.ILUSReqConfigService;
import kr.go.gbelib.app.cms.module.smsReception.SmsReception;
import kr.go.gbelib.app.cms.module.smsReception.SmsReceptionService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.CommonAPI;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller
@RequestMapping(value = {"/{homepagePath}/intro/search"})
public class CommonSearchController extends BaseController {

	private String basePath = "/homepage/%s/commonIntro/search/";

	@Autowired
	private LibrarySearchService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuHtmlService menuHtmlService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private ILUSReqConfigService ilusReqConfigService;

	@Autowired
	private HopebookConfigService hopebookConfigService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private SmsReceptionService smsReceptionService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@ModelAttribute("siteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	@ModelAttribute("searchCategory")
	private Map<String, Object> getSearchCategory() {
		return service.getSearchCategory();
	}

	@ModelAttribute("liboneApiUrl")
	private String getLiboneApiUrl() {
		return CommonAPI.LIBONE_API_URL;
	}

	@ModelAttribute("libraryList")
	private Map<String, Object> getLibraryList() {
		return service.getLibraryList();
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
			librarySearch.setSearch_type("L_TITLEAUTHOR");
		}

		Map<String, Object> result	 				= null;
		Map<String, Object> resultCountByYear 		= null;
		Map<String, Object> resultCountByLibrary 	= null;
		Map<String, Object> resultCountByFormCode 	= null;
		Map<String, Object> resultCountByKDC	 	= null;
		Map<String, Object> resultCountByPlace	 	= null;
		Map<String, Object> resultCountByPform	 	= null;
		Map<String, Object> resultCountByPublisher	= null;
		Map<String, Object> resultCountByWriter	 	= null;
		// 도서관 목록 -> 정보센터 디폴트 [00147046]
		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
				libraryCodes.add("ALL");
			}
			else {
				libraryCodes.add(homepage.getHomepage_code());
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {
//			librarySearch.setSearch_type("SEARCH");
			librarySearch.setViewPage(1);

			Member member = getSessionMemberInfo(request);
			if (member.isLogin() && member.getLoginType().equals("HOMEPAGE")) {
				if (StringUtils.isNotEmpty(member.getBirth_day()) && member.getBirth_day().length() >= 4) {
					librarySearch.setBirth_year(member.getBirth_day().substring(0, 4));
				}
				if (StringUtils.isNotEmpty(member.getSex()) && member.getSex().length() == 4) {
					librarySearch.setSex(StringUtils.equals(member.getSex(), "0001") ? "m" : "f");
				}
			}

			if ( librarySearch.isSub_search() ) {
				result = LibSearchAPI.getSubSearch(librarySearch);
			}
			else {
				String searchType = librarySearch.getSearch_type2();
				if ( StringUtils.isEmpty(searchType) ) {
					searchType = "L_TITLE";
					librarySearch.setSortField("TITLE");
					librarySearch.setSortType("DESC");
				}
				result = LibSearchAPI.getSearch(librarySearch, 1); // API로 Request 보냄
			}


			if ( result != null ) {
				if (!StringUtils.equals(result.get("code").toString(), "0000")) {
					service.alertMessage(result.get("msg").toString(), request, response);
					return null;
				}
				String allBookListStr = result.get("allBookListStr").toString();
				resultCountByFormCode 	= LibSearchAPI.getSearchCountByFormCode(allBookListStr, 1);//유형
				resultCountByWriter 	= LibSearchAPI.getSearchCountByWriter(allBookListStr, 1);//저자
				resultCountByPublisher 	= LibSearchAPI.getSearchCountByPublisher(allBookListStr, 1);//출판사
				resultCountByYear 		= LibSearchAPI.getSearchCountByYear(allBookListStr, 1);//연도
//				resultCountByLibrary 	= LibSearchAPI.getSearchCountByLibrary(allBookListStr);
//				resultCountByKDC	 	= LibSearchAPI.getSearchCountByKDC(allBookListStr);
//				resultCountByPlace	 	= LibSearchAPI.getSearchCountByPlace(allBookListStr);
//				resultCountByPform	 	= LibSearchAPI.getSearchCountByPform(allBookListStr);

				int totalCount = 0;
				if ( result.get("totalCnt") != null ) {
					totalCount = Integer.parseInt(result.get("totalCnt").toString());
				}


				service.setPaging(model, totalCount, librarySearch); // 페이징 처리

				LibSearchAPI.addMarcUrls(result);

				model.addAttribute("result", result); // 검색한 결과
				model.addAttribute("resultCountByFormCode", resultCountByFormCode); // 검색한 결과의 유형별 카운트
				model.addAttribute("resultCountByWriter", resultCountByWriter); // 검색한 결과의 저자별 카운트
				model.addAttribute("resultCountByPublisher", resultCountByPublisher); // 검색한 결과의 출판사별 카운트
				model.addAttribute("resultCountByYear", resultCountByYear); 		// 검색한 결과의 연도별 카운트
//				model.addAttribute("resultCountByLibrary", resultCountByLibrary); 	// 검색한 결과의 도서관별 카운트
//				model.addAttribute("resultCountByKDC", resultCountByKDC); 			// 검색한 결과의 주제별 카운트
//				model.addAttribute("resultCountByPlace", resultCountByPlace); 		// 검색한 결과의 자료실별 카운트
//				model.addAttribute("resultCountByPform", resultCountByPform); 		// 검색한 결과의 종류별 카운트

			}
		}
		model.addAttribute("librarySearch", librarySearch);
//		model.addAttribute("hotTrendWordList", LibSearchAPI.getHotTrendWordList(10));

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	/**
	 * 추천도서, 테마도서 검색용
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/indexForBoard.*"})
	public String indexForBoard(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
			librarySearch.setSearch_type("L_TITLE");
		}

		Map<String, Object> result	 				= null;
		Map<String, Object> resultCountByYear 		= null;
		Map<String, Object> resultCountByLibrary 	= null;
		Map<String, Object> resultCountByFormCode 	= null;
		Map<String, Object> resultCountByKDC	 	= null;
		Map<String, Object> resultCountByPlace	 	= null;
		Map<String, Object> resultCountByPform	 	= null;
		Map<String, Object> resultCountByPublisher	= null;
		Map<String, Object> resultCountByWriter	 	= null;
		List<String> libraryCodes = new ArrayList<String>();
		libraryCodes.add(homepage.getHomepage_code());
		if(librarySearch.getLibraryCodes() != null) {
			libraryCodes.addAll(librarySearch.getLibraryCodes());
		}
		librarySearch.setLibraryCodes(libraryCodes);

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {
//			librarySearch.setSearch_type("SEARCH");
			librarySearch.setViewPage(1);

			String searchType = librarySearch.getSearch_type2();
			if ( StringUtils.isEmpty(searchType) ) {
				searchType = "L_TITLE";
				librarySearch.setSortField("TITLE");
				librarySearch.setSortType("ASC");
			}
			if(librarySearch.getLibraryCodes() != null) {
				libraryCodes.addAll(librarySearch.getLibraryCodes());
			}
			result = LibSearchAPI.getSearch(librarySearch, 1); // API로 Request 보냄


			if ( result != null ) {
				if (!StringUtils.equals(result.get("code").toString(), "0000")) {
					service.alertMessage(result.get("msg").toString(), request, response);
					return null;
				}
//				String allBookListStr = result.get("allBookListStr").toString();
//				resultCountByFormCode 	= LibSearchAPI.getSearchCountByFormCode(allBookListStr, 1);//유형
//				resultCountByWriter 	= LibSearchAPI.getSearchCountByWriter(allBookListStr, 1);//저자
//				resultCountByPublisher 	= LibSearchAPI.getSearchCountByPublisher(allBookListStr, 1);//출판사
//				resultCountByYear 		= LibSearchAPI.getSearchCountByYear(allBookListStr, 1);//연도
//				resultCountByLibrary 	= LibSearchAPI.getSearchCountByLibrary(allBookListStr);
//				resultCountByKDC	 	= LibSearchAPI.getSearchCountByKDC(allBookListStr);
//				resultCountByPlace	 	= LibSearchAPI.getSearchCountByPlace(allBookListStr);
//				resultCountByPform	 	= LibSearchAPI.getSearchCountByPform(allBookListStr);

				int totalCount = 0;
				if ( result.get("totalCnt") != null ) {
					totalCount = Integer.parseInt(result.get("totalCnt").toString());
				}

				service.setPaging(model, totalCount, librarySearch); // 페이징 처리

				model.addAttribute("result", result); // 검색한 결과
//				model.addAttribute("resultCountByFormCode", resultCountByFormCode); // 검색한 결과의 유형별 카운트
//				model.addAttribute("resultCountByWriter", resultCountByWriter); // 검색한 결과의 저자별 카운트
//				model.addAttribute("resultCountByPublisher", resultCountByPublisher); // 검색한 결과의 출판사별 카운트
//				model.addAttribute("resultCountByYear", resultCountByYear); 		// 검색한 결과의 연도별 카운트
//				model.addAttribute("resultCountByLibrary", resultCountByLibrary); 	// 검색한 결과의 도서관별 카운트
//				model.addAttribute("resultCountByKDC", resultCountByKDC); 			// 검색한 결과의 주제별 카운트
//				model.addAttribute("resultCountByPlace", resultCountByPlace); 		// 검색한 결과의 자료실별 카운트
//				model.addAttribute("resultCountByPform", resultCountByPform); 		// 검색한 결과의 종류별 카운트
			}
		}
		model.addAttribute("librarySearch", librarySearch);
//		model.addAttribute("hotTrendWordList", LibSearchAPI.getHotTrendWordList(10));

		return String.format(basePath, homepage.getFolder()) + "indexForBoard_ajax";
	}


	@RequestMapping(value = {"/tableForBoard.*"})
	public String tableForBoard(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> result = null;
		int viewPage = 1;
		String beforSearchType = librarySearch.getSearch_type2();

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {

			if ( StringUtils.isEmpty(librarySearch.getSearch_type2()) ) {
				librarySearch.setSearch_type("SEARCH");
			}

			if ( librarySearch.getViewPage() > 1) { // 화면에서 페이지 버튼 클릭
				//librarySearch.setSearch_type("GOPAGE"); // GOPAGE 사용시 검색 카테고리 바꾸면 페이징 안됨. (API가 안됨...)
				viewPage = librarySearch.getViewPage();
			}

			if ( librarySearch.getLibraryCodes() == null ) {
				List<String> libraryCodes = new ArrayList<String>();
				libraryCodes.add(homepage.getHomepage_code());
				librarySearch.setLibraryCodes(libraryCodes);
			}

			if ( librarySearch.isSub_search() ) {
				result = LibSearchAPI.getSubSearch(librarySearch);
			}
			else {
				result = LibSearchAPI.getSearch(librarySearch, viewPage); // API로 Request 보냄
			}

//			result = LibSearchAPI.getSearch(librarySearch, viewPage); // API로 Request 보냄
			int totalCount = 0;
			if ( result != null && result.get("totalCnt") != null ) {
				String totalCnt = result.get("totalCnt").toString();
				if ( totalCnt != null && !totalCnt.equals("") ) {
					totalCount = Integer.parseInt(totalCnt);
				}
			}

			service.setPaging(model, totalCount, librarySearch); // 페이징 처리

			model.addAttribute("result", result); // 검색한 결과
		}
		librarySearch.setSearch_type(beforSearchType);// 페이징 할때 search_type 바뀌기 때문에 이전에 무슨 타입으로 검색 했는지 되돌리기 위해서 함.
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "tableForBoard_ajax";
	}

	@RequestMapping(value = {"/detailSearch.*"})
	public String detailSearch(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> result	 				= null;
		Map<String, Object> resultCountByYear 		= null;
		Map<String, Object> resultCountByLibrary 	= null;
		Map<String, Object> resultCountByFormCode 	= null;
		Map<String, Object> resultCountByKDC	 	= null;
		Map<String, Object> resultCountByPlace	 	= null;
		Map<String, Object> resultCountByPform	 	= null;
		Map<String, Object> resultCountByPublisher	= null;
		Map<String, Object> resultCountByWriter	 	= null;
		// 도서관 목록 -> 정보센터 디폴트 [00147046]
		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
				libraryCodes.add("ALL");
			}
			else {
				libraryCodes.add(homepage.getHomepage_code());
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {
			librarySearch.setViewPage(1);

			result = LibSearchAPI.getDetailSearch(librarySearch); // API로 Request 보냄

			if ( result != null ) {
				String allBookListStr = result.get("allBookListStr").toString();
				resultCountByFormCode 	= LibSearchAPI.getSearchCountByFormCode(allBookListStr, 1);//유형
				resultCountByWriter 	= LibSearchAPI.getSearchCountByWriter(allBookListStr, 1);//저자
				resultCountByPublisher 	= LibSearchAPI.getSearchCountByPublisher(allBookListStr, 1);//출판사
				resultCountByYear 		= LibSearchAPI.getSearchCountByYear(allBookListStr, 1);//연도
//				resultCountByLibrary 	= LibSearchAPI.getSearchCountByLibrary(allBookListStr);
//				resultCountByKDC	 	= LibSearchAPI.getSearchCountByKDC(allBookListStr);
//				resultCountByPlace	 	= LibSearchAPI.getSearchCountByPlace(allBookListStr);
//				resultCountByPform	 	= LibSearchAPI.getSearchCountByPform(allBookListStr);

				int totalCount = 0;
				if ( result.get("totalCnt") != null ) {
					totalCount = Integer.parseInt(result.get("totalCnt").toString());
				}

				service.setPaging(model, totalCount, librarySearch); // 페이징 처리

				model.addAttribute("result", result); // 검색한 결과
				model.addAttribute("resultCountByFormCode", resultCountByFormCode); // 검색한 결과의 유형별 카운트
				model.addAttribute("resultCountByWriter", resultCountByWriter); // 검색한 결과의 저자별 카운트
				model.addAttribute("resultCountByPublisher", resultCountByPublisher); // 검색한 결과의 출판사별 카운트
				model.addAttribute("resultCountByYear", resultCountByYear); 		// 검색한 결과의 연도별 카운트
//				model.addAttribute("resultCountByLibrary", resultCountByLibrary); 	// 검색한 결과의 도서관별 카운트
//				model.addAttribute("resultCountByKDC", resultCountByKDC); 			// 검색한 결과의 주제별 카운트
//				model.addAttribute("resultCountByPlace", resultCountByPlace); 		// 검색한 결과의 자료실별 카운트
//				model.addAttribute("resultCountByPform", resultCountByPform); 		// 검색한 결과의 종류별 카운트
			}
		}
		model.addAttribute("librarySearch", librarySearch);
//		model.addAttribute("hotTrendWordList", LibSearchAPI.getHotTrendWordList(10));

		return String.format(basePath, homepage.getFolder()) + "detailSearch";
	}

	@RequestMapping(value = {"/hotTrend.*"})
	public String hotTrend(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("hotTrendDailyList", LibSearchAPI.getHotTrendWordList(10, "1"));
		model.addAttribute("hotTrendWeeklyList", LibSearchAPI.getHotTrendWordList(10, "2"));

		return String.format(basePath, homepage.getFolder()) + "hotTrend_ajax";
	}

	@RequestMapping(value = {"/bestBook.*"})
	public String bestBook(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		librarySearch.setvLoca(homepage.getHomepage_code());
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date d = cal.getTime();
		String vStartDate = sdf.format(d);
		Map<String, Object> bestBookList = null;
		if (homepage.getHomepage_id().equals("h13")) {
			bestBookList = LibSearchAPI.getBestBookJCList(librarySearch, "10", vStartDate);
		} else {
			bestBookList = LibSearchAPI.getBestBookList(librarySearch, "10", vStartDate);
		}
		model.addAttribute("bestBookList", bestBookList);

		return String.format(basePath, homepage.getFolder()) + "bestBook_ajax";
	}

	@RequestMapping(value = {"/ageLoanBest.*"})
	public String ageLoanBest(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		List<String> locaList = new ArrayList<String>();
		locaList.add(homepage.getHomepage_code());

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String startDate = sdf.format(cal.getTime());
		String endDate = sdf.format(new Date());
		model.addAttribute("ageLoanBestList", LibSearchAPI.getAgeLoanBestList(startDate, endDate, locaList));
		model.addAttribute("searchMenuIdx", homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 2));
		return String.format(basePath, homepage.getFolder()) + "ageLoanBest_ajax";
	}

	@RequestMapping(value = {"/table.*"})
	public String table(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> result = null;
		int viewPage = 1;
		String beforSearchType = librarySearch.getSearch_type2();

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {

			if ( StringUtils.isEmpty(librarySearch.getSearch_type2()) ) {
				librarySearch.setSearch_type("SEARCH");
			}

			if ( librarySearch.getViewPage() > 1) { // 화면에서 페이지 버튼 클릭
				//librarySearch.setSearch_type("GOPAGE"); // GOPAGE 사용시 검색 카테고리 바꾸면 페이징 안됨. (API가 안됨...)
				viewPage = librarySearch.getViewPage();
			}

			if ( librarySearch.getLibraryCodes() == null ) {
				List<String> libraryCodes = new ArrayList<String>();
				libraryCodes.add(homepage.getHomepage_code());
				librarySearch.setLibraryCodes(libraryCodes);
			}

			if ( librarySearch.isSub_search() ) {
				result = LibSearchAPI.getSubSearch(librarySearch);
			}
			else {
				result = LibSearchAPI.getSearch(librarySearch, viewPage); // API로 Request 보냄
			}

//			result = LibSearchAPI.getSearch(librarySearch, viewPage); // API로 Request 보냄
			int totalCount = 0;
			if ( result != null && result.get("totalCnt") != null ) {
				String totalCnt = result.get("totalCnt").toString();
				if ( totalCnt != null && !totalCnt.equals("") ) {
					totalCount = Integer.parseInt(totalCnt);
				}
			}

			service.setPaging(model, totalCount, librarySearch); // 페이징 처리

			LibSearchAPI.addMarcUrls(result);

			model.addAttribute("result", result); // 검색한 결과
		}
		librarySearch.setSearch_type(beforSearchType);// 페이징 할때 search_type 바뀌기 때문에 이전에 무슨 타입으로 검색 했는지 되돌리기 위해서 함.
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "table_ajax";
	}

	@RequestMapping(value = {"/table2.*"})
	public String table2(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> resultCountByWriter	 	= null;
		resultCountByWriter 	= LibSearchAPI.getSearchCountByWriter(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByWriter", resultCountByWriter); // 검색한 결과의 저자별 카운트

		return String.format(basePath, homepage.getFolder()) + "table2_ajax";
	}

	@RequestMapping(value = {"/table3.*"})
	public String table3(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> resultCountByPublisher	 	= null;
		resultCountByPublisher 	= LibSearchAPI.getSearchCountByPublisher(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByPublisher", resultCountByPublisher); // 검색한 결과의 저자별 카운트

		return String.format(basePath, homepage.getFolder()) + "table3_ajax";
	}

	@RequestMapping(value = {"/table4.*"})
	public String table4(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> resultCountByYear	 	= null;
		resultCountByYear 	= LibSearchAPI.getSearchCountByYear(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByYear", resultCountByYear); // 검색한 결과의 연도별 카운트

		return String.format(basePath, homepage.getFolder()) + "table4_ajax";
	}

	@RequestMapping(value = {"/table5.*"})
	public String table5(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> resultCountByFormcode	 	= null;
		resultCountByFormcode 	= LibSearchAPI.getSearchCountByFormCode(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//유형
		model.addAttribute("resultCountByFormcode", resultCountByFormcode); // 검색한 결과의 유형별 카운트

		return String.format(basePath, homepage.getFolder()) + "table5_ajax";
	}

	@RequestMapping(value = {"/autoFill.do"})
	public @ResponseBody Map<String, Object> autoFill(@RequestParam("searchKeyword")String searchKeyword) {
		return LibSearchAPI.getAutoFill(searchKeyword);
	}

	@RequestMapping(value = {"/detail.*"})
	public String detail(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		//model.addAttribute("introMenu", "도서상세정보");//임시
		Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);

		if("00000001".equals(librarySearch.getvLoca())) {
			LibSearchAPI.addMarcUrls(result);
		}

		model.addAttribute("detail", result);
		model.addAttribute("librarySearch", librarySearch);
		String returnPage = "detail";
		if (StringUtils.isNotEmpty(librarySearch.getTid())) {
			model.addAttribute("descIndex", LibSearchAPI.getDescriptionIndex(librarySearch.getTid()));
		}
		model.addAttribute("ageChart", LibSearchAPI.getAgeChart(librarySearch));
		model.addAttribute("withBook", LibSearchAPI.getWithBook(librarySearch));
		model.addAttribute("tagCloud", LibSearchAPI.getTagCloud(librarySearch));
//			model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));
		try {
			List<String> locaList = new ArrayList<String>();
			for (Homepage home : homepageService.getHomepage()) {
				String homepageCode = home.getHomepage_code();
				if (StringUtils.isNotEmpty(homepageCode)) {
					if (homepageCode.length() >= 8) {
						locaList.add(homepageCode.substring(0, 8));
					}
				}
			}
//				locaList.add("00147046");
			List<Map<String, Object>> dsPlaceBookList = null;
			Map<String, Object> sameBookList = LibSearchAPI.getSameBookList("WEB", librarySearch.getIsbn(), locaList);
			if (sameBookList != null) {
				List<Map<String, Object>> tempSameBookList = (List<Map<String, Object>>) sameBookList.get("dsSameBookList");
				if (tempSameBookList != null) {
					dsPlaceBookList = new ArrayList<Map<String, Object>>();
					for (Map<String, Object> map : tempSameBookList) {
						Map<String, Object> searchItemD = LibSearchAPI.getBookDetail(new LibrarySearch(String.valueOf(map.get("LOCA")), String.valueOf(map.get("CTRLNO"))));
						if (searchItemD != null) {
							dsPlaceBookList.add(searchItemD);
						}
					}
				}
			}
			model.addAttribute("sameBook", dsPlaceBookList);
			if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
				model.addAttribute("naverDetail", LibSearchAPI.getNaverDetail(librarySearch.getIsbn()));
			}

		} catch (Exception e) {
		}

		model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));
		model.addAttribute("sameAuthorBookList", LibSearchAPI.getSameAuthorBookList(result));
		model.addAttribute("isTodayClosed", calendarManageService.isTodayClosed(homepage.getHomepage_id()));
		returnPage = "detail";
		return String.format(basePath, homepage.getFolder()) + returnPage;
	}

	@RequestMapping(value = {"/index_detail.*"})
	public String indexDetail(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		//model.addAttribute("introMenu", "도서상세정보");//임시
		Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);
		model.addAttribute("detail", result);
		model.addAttribute("librarySearch", librarySearch);
		String returnPage = "detail";
		//결과리스트에서 이용가능여부 클릭 시
		returnPage = "index_detail_ajax";
		return String.format(basePath, homepage.getFolder()) + returnPage;
	}


	@RequestMapping(value = {"/callNoBrowsing.*"})
	public String callNoBrowsing(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));

		return String.format(basePath, homepage.getFolder()) + "callNoBrowsing_ajax";
	}

	@RequestMapping(value = {"/detailPopup.*"})
	public String detailPopup(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		//model.addAttribute("introMenu", "도서상세정보");//임시
		Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);
		model.addAttribute("detail", result);
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("isTodayClosed", calendarManageService.isTodayClosed(homepage.getHomepage_id()));
		return String.format(basePath, homepage.getFolder()) + "detailPopup_ajax";
	}

	@RequestMapping(value = {"/newBook/index.*"})
	public String getNewBookList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			librarySearch.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), -30)));
			librarySearch.setSearch_end_date(sf.format(new Date()));
		}

		// 소장처 코드
		if (StringUtils.isEmpty(librarySearch.getvLoca())) {
			librarySearch.setvLoca(homepage.getHomepage_code());
		}

		Map<String, Object> result = LibSearchAPI.getNewBookList(librarySearch, null);
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("dsNewBookListCnt");
		Map<String, Object> cnt = (Map<String, Object>) list.get(0);
		int count = Integer.parseInt(String.valueOf(cnt.get("CNT")));

		librarySearch.setTotalDataCount(count);
		result = LibSearchAPI.getNewBookList(librarySearch, null);
		service.setPaging(model, count, librarySearch);

//		List<Map<String, Object>> resultPaging = new ArrayList<Map<String, Object>>();
//		List<Object> list = (List<Object>) result.get("dsNewBookList");
//		if (list != null && list.size() > 0 ) {
//			service.setPaging(model, list.size(), librarySearch);
//			result.put("totalDataCount", list.size());
//			int listIndex = librarySearch.getViewPage();
//			int size = list.size() > 9 ? 10 : list.size();
//			for (int i = 0; i < size; i++) {
//				if ( list.size() > (librarySearch.getStartRowNum()-1)+i ) {
//					resultPaging.add((Map<String, Object>) list.get((librarySearch.getStartRowNum()-1)+i));
//				}
//			}
//			result.put("dsNewBookList", resultPaging);
//		}

		// 2019.06.27 전자책만 전자책 바로보기 버튼 표시해달라는 요청으로 주석 처리
//		LibSearchAPI.addMarcUrls(result);

		model.addAttribute("newBookList", result);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "newBook/index";
	}

	@RequestMapping(value = {"/lnkBook/index.*"})
	public String getLnkBookList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		// 소장처 코드
		librarySearch.setvLoca(homepage.getHomepage_code());

		Map<String, Object> result = LibSearchAPI.getLnkBookList(librarySearch, "N");
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("dsLibraryListCnt");
		Map<String, Object> cnt = (Map<String, Object>) list.get(0);
		int count = Integer.parseInt(String.valueOf(cnt.get("CNT")));

		librarySearch.setTotalDataCount(count);

		service.setPaging(model, count, librarySearch);
		result = LibSearchAPI.getLnkBookList(librarySearch, "N");
		model.addAttribute("lnkBookList", result);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "lnkBook/index";
	}

	@RequestMapping(value = {"/lnkBook/lnkBook.*"})
	public String getLnkBookList2(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		// 소장처 코드
		librarySearch.setvLoca(homepage.getHomepage_code());

		Map<String, Object> result = LibSearchAPI.getLnkBookList(librarySearch, "N");
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("dsLibraryListCnt");
		Map<String, Object> cnt = (Map<String, Object>) list.get(0);
		int count = Integer.parseInt(String.valueOf(cnt.get("CNT")));

		librarySearch.setTotalDataCount(count);
		result = LibSearchAPI.getLnkBookList(librarySearch, null);
		service.setPaging(model, count, librarySearch);

		model.addAttribute("lnkBookList", result);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "lnkBook/lnkBook_ajax";
	}

	@RequestMapping(value = {"/bestBook/index.*"})
	public String bestBookList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		// 소장처 코드
		librarySearch.setvLoca(homepage.getHomepage_code());

		if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			librarySearch.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), -30)));
			librarySearch.setSearch_end_date(sf.format(new Date()));
		}

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -3);
		Map<String, Object> result = LibSearchAPI.getBestBookList(librarySearch);

		// 2019.06.27 전자책만 전자책 바로보기 버튼 표시해달라는 요청으로 주석 처리
//		LibSearchAPI.addMarcUrls(result);

		model.addAttribute("bestBookList", result);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "bestBook/index";
	}

	@RequestMapping(value = {"/ageLoanBest/index.*"})
	public String ageLoanBestList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
//		List<String> locaList = new ArrayList<String>();
//		locaList.add(homepage.getHomepage_code());
//
//		Calendar cal = Calendar.getInstance();
//		cal.add(Calendar.MONTH, -3);
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//
//		String startDate = sdf.format(cal.getTime());
//		String endDate = sdf.format(new Date());
//		model.addAttribute("ageLoanBestList", LibSearchAPI.getAgeLoanBestList(startDate, endDate, locaList));
		model.addAttribute("searchMenuIdx", homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 2));
		return String.format(basePath, homepage.getFolder()) + "ageLoanBest/index";
	}

	@RequestMapping(value = {"/ageLoanBest/ageLoanBest.*"})
	public String ageLoanBest2(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		List<String> locaList = new ArrayList<String>();
		locaList.add(homepage.getHomepage_code());

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		String startDate = sdf.format(cal.getTime());
		String endDate = sdf.format(new Date());
		model.addAttribute("ageLoanBestList", LibSearchAPI.getAgeLoanBestList(startDate, endDate, locaList));
		model.addAttribute("searchMenuIdx", homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 2));
		return String.format(basePath, homepage.getFolder()) + "ageLoanBest_ajax";
	}

	@RequestMapping(value = {"/hope/index.*"})
	public String hopeIndex(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Menu menuOne = (Menu) request.getAttribute("menuOne");
		if ( menuOne != null ) {
			model.addAttribute("html", menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage.getHomepage_id(), menuOne.getMenu_idx())));
		}

		model.addAttribute("hopeHistoryMenuIdx", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 12)));
		model.addAttribute("hopeList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "HOPE", null));
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("view_yn", false);
		return String.format(basePath, homepage.getFolder()) + "hope/index";
	}

	@RequestMapping(value = {"/hope/history.*"})
	public String hopeHistory(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("/%s/intro/search/hope/history.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

//		model.addAttribute("hopeList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "HOPE", null));
		Map<String, String> paramMap = new HashMap<String, String>();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}
		paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
		paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
		paramMap.put("vSrchDateKey", "INSERT_DATE");
		paramMap.put("vSortKey", "INSERT_DATE");
		paramMap.put("vSortDir", "DESC");


		model.addAttribute("hopeList", LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "HOPE", null, paramMap));
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "hope/history";
	}

	@RequestMapping(value = {"/hope/req.*"})
	public String reqHope(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
			service.alertMessageAndUrl("홈페이지 코드가 없어 신청 할 수 없습니다.", String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), request, response);
			return null;
		}

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("/%s/intro/search/hope/req.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("희망도서 신청 가능한 회원이 아닙니다.", String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), request, response);
				return null;
			}
		}

		if ( !homepage.getHomepage_code().contains(member.getLoca())) {
			service.alertMessage("희망도서 신청은 소속도서관에서만 가능합니다.", request, response);
			return null;
		}

		//model.addAttribute("introMenu", "희망도서신청");//임시
		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "hope/req";
	}

	@RequestMapping(value = {"/hope/search.*"})
	public String hopeSearch(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
			service.alertMessageAndUrl("홈페이지 코드가 없어 신청 할 수 없습니다.", String.format("http://www.gbelib.kr/%s/search.do", homepage.getContext_path()), request, response);
			return null;
		}

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("/%s/intro/search/hope/search.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()) + "%26editMode%3DNOAJAX");
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("희망도서 신청 가능한 회원이 아닙니다.", String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), request, response);
				return null;
			}
		}

		if ( !homepage.getHomepage_code().contains(member.getLoca())) {
			service.alertMessage("희망도서 신청은 소속도서관에서만 가능합니다.", request, response);
			return null;
		}

		HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
		if(hopebookConfig != null) {
			service.alertMessage(hopebookConfig.getRes_msg().replaceAll("(\r\n|\r|\n|\n\r)", "\\\\n"), request, response);
			return null;
		}

		//model.addAttribute("introMenu", "희망도서신청");//임시
		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);

		Map<String, Object> map = null;
		if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
			map = LibSearchAPI.getNaverList(librarySearch);
			String totalCount = String.valueOf(((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("total"));

			List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
			Object o = ((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("item");
			if (o instanceof List) {
				itemList = (List<Map<String, Object>>) o;
			} else if (o instanceof Map){
				itemList.add((Map<String, Object>) o);
			}
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map2 : itemList) {
					String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
					for (int i = 0; i < isbnArr.length; i++) {
						String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];

						Map<String, Object> sameBook = (Map<String, Object>) LibSearchAPI.getSameBookList("WEB", isbn, homepage.getHomepage_codeList()[0]);
						if (sameBook != null) {
							List<Map<String, Object>> sameBookList = (List<Map<String, Object>>)sameBook.get("dsSameBookList");
							if (sameBookList != null && sameBookList.size() > 0) {
								map2.put("already", true);
								map2.put("ctrlno", sameBookList.get(0).get("CTRLNO"));
							}
						}

					}

//					if (LibSearchAPI.getSameBookList("WEB", isbn13, homepage.getHomepage_codeList()[0]).get("dsSameBookList") != null) {
//						map2.put("already", true);
//					}
				}
				service.setPaging(model, Integer.parseInt(totalCount), librarySearch);
				model.addAttribute("naverResult", itemList);
			}
		}
		model.addAttribute("librarySearch", librarySearch);
		if ( "NOAJAX".equals(librarySearch.getEditMode()) ) {
			return String.format(basePath, homepage.getFolder()) + "hope/search";
		}

		return String.format(basePath, homepage.getFolder()) + "hope/search_ajax";
	}

	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);

		if(librarySearch.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author", "저자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer", "출판사를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer_year", "연도를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "price", "가격을 입력하세요.");
		}

		Member member = getSessionMemberInfo(request);

		if (homepage.getContext_path().equals("jc")) {
			//점촌은 가은과 같이 있음. 선택을 할 수 있기 때문에 선택한 도서관으로 신청한다.
			member.setLoca(librarySearch.getvLoca());
		}

		/*
		member.setCheck_certify_type("WEBID");
		Map<String, String> memberInfo = MemberAPI.getMemberCertify("WEB", member);

		if ( memberInfo == null ) {
			res.setValid(false);
			res.setMessage("해당 ID는 유효한 회원이 아닙니다.");
			return res;
		}*/

		if(!result.hasErrors()) {
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("희망도서 신청 가능한 회원이 아닙니다.");
					return res;
				}
			}

			HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
			if(hopebookConfig != null) {
				res.setValid(false);
				res.setMessage(hopebookConfig.getRes_msg());
				return res;
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {
				if ( !homepage.getHomepage_code().contains(",") ) {
					librarySearch.setvLoca(homepage.getHomepage_code());
				}

				StringBuilder sb = new StringBuilder();
				sb.append(librarySearch.getEditMode() + "\n");
				sb.append(librarySearch.getvLoca() + "\n");
				sb.append(librarySearch.getTitle() + "\n");
				sb.append(librarySearch.getAuthor() + "\n");
				sb.append(librarySearch.getPubler() + "\n");
				sb.append(librarySearch.getPubler_year() + "\n");
				sb.append(librarySearch.getIsbn() + "\n");
				sb.append(librarySearch.getEditon() + "\n");
				sb.append(librarySearch.getUser_remark() + "\n");
				sb.append(librarySearch.getPrice() + "\n");
				String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
				if (addResult != null) {
					res.setValid(false);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				ApiResponse hopeUserCheck = LibSearchAPI.hopeUserCheck("WEB", librarySearch, member.getUser_id(), member.getLoca());

				if ( hopeUserCheck.getStatus() ) {
					ApiResponse apiResult = LibSearchAPI.reqHope("WEB", librarySearch, member.getUser_id(), member.getLoca());
					if ( apiResult.getStatus() ) {
						res.setValid(true);
						res.setMessage("등록 되었습니다.");
					}
					else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
				else {
					res.setValid(false);
					res.setMessage(hopeUserCheck.getMessage());
				}

				//ApiResponse apiResult = LibSearchAPI.reqHope("WEB", librarySearch, "future");

			}
			else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modHope("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.modHope("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
			/*else if ( librarySearch.getEditMode().equals("DELETE") ) {
				ApiResponse apiResult = LibSearchAPI.modHope("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.modHope("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}*/
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/resve/index.*", "/resve/detail.*"})
	public String myResve(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				librarySearch.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/resve/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			}
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
//		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
//			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
//				service.alertMessageAndUrl("예약 가능한 회원이 아닙니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
//				return null;
//			}
//		}

		if(request.getRequestURI().endsWith("/resve/detail.do")) {
			model.addAttribute("resveDetail", LibSearchAPI.getResveDetail("WEB", librarySearch.getvResveNo()));
		    return String.format(basePath, homepage.getFolder()) + "resve/detail";
		}
		else {
			model.addAttribute("resveList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "RESVE", null));
			return String.format(basePath, homepage.getFolder()) + "resve/index";
		}
	}

	@RequestMapping(value = {"/resve/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveResve(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				librarySearch.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/resve/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			}
			result.reject("로그인 후 이용가능합니다.");
			res.setUrl(String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()));
		}

		// 0001:예약, 0002:연장, 0003:야간대출
		ILUSReqConfig ilusReqConfig = ilusReqConfigService.getILUSReqConfigInfo(librarySearch, "0001");
		if(ilusReqConfig != null) {
			res.setValid(false);
			res.setMessage(ilusReqConfig.getRes_msg());
			return res;
		}

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("예약 신청 가능한 회원이 아닙니다.");
					return res;
				}
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {
				ApiResponse apiResult = LibSearchAPI.reqResve("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.reqResve("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					String message = "등록되었습니다.";

					// 예약자순위 가져오기
					Map<String, Object> myLibraryList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "RESVE", null);
					if (myLibraryList != null && myLibraryList.containsKey("dsMyLibraryList")) {
						List<Map<String, String>> resveList = (List<Map<String, String>>) myLibraryList.get("dsMyLibraryList");
						if (resveList != null && resveList.size() > 0) {
							for ( Map<String, String> map : resveList ) {
								if(StringUtils.equals(map.get("CTRLNO"), librarySearch.getvCtrl()) && "0002".equals(map.get("RESVE_STATUS"))) {
									 message = map.get("RESVE_RANK") + "번째로 예약이 완료되었습니다.";
									 break;
								}
							}
						}
					}

					res.setValid(true);
					res.setMessage(message);
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
			else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modResve("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.modResve("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/close/index.*"})
	public String myClose(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				librarySearch.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/close/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			}
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Map<String, Object> closeList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "CLOSE", null);

		model.addAttribute("closeList", closeList);
		return String.format(basePath, homepage.getFolder()) + "close/index";
	}

	@RequestMapping(value = {"/close/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveClose(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				librarySearch.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/close/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			}
			result.reject("로그인 후 이용가능합니다.");
			res.setUrl(String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()));
		}

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("보존서고 신청 가능한 회원이 아닙니다.");
					return res;
				}
			}

			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage.getHomepage_id());
			smsReception.setWork_code("0001");	// 보존서고:0001, 상호대차:0002
			List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			Homepage smsHomepage = new Homepage();
			smsHomepage.setHomepage_code(librarySearch.getvLoca());
			smsHomepage = homepageService.getHomepageOneByCode(smsHomepage);

			if ( librarySearch.getEditMode().equals("ADD") ) {
				ApiResponse apiResult = LibSearchAPI.reqClose("WEB", librarySearch, getSessionUserId(request));
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("신청 되었습니다.");

					// 신청자에게 SMS 전송
					String message = "보존서고 신청이 완료 되었습니다.[" + librarySearch.getTitle() + "]";
					if (isSmsReceive("WEBID", getSessionMemberId(request))) {
						PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), message, smsHomepage.getHomepage_send_tell(), true);
					}

					// 관리자에게 SMS 전송
					for(SmsReception one : receptionsList) {
						PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), message, smsHomepage.getHomepage_send_tell(), false);
					}
				} else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			} else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modClose("WEB", librarySearch, getSessionUserId(request));
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
					// 신청자에게 SMS 전송
					String message = "보존서고 신청이 취소 되었습니다.[" + librarySearch.getTitle() + "]";
					if (isSmsReceive("WEBID", getSessionMemberId(request))) {
						PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), message, smsHomepage.getHomepage_send_tell(), true);
					}

					// 관리자에게 SMS 전송
					for(SmsReception one : receptionsList) {
						PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), message, smsHomepage.getHomepage_send_tell(), false);
					}
				} else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 *
	 * @param mode WEBID, USERID
	 * @param id webid, user_id
	 * @return
	 */
	public boolean isSmsReceive(String mode, String id) {
		Member member = new Member();
		Map<String, String> map = null;
		if ("WEBID".equals(mode)) {
			member.setCheck_certify_type("WEBID");
			member.setCheck_certify_data(id);
			map = MemberAPI.getMemberCertify("WEB", member);
			member.setUser_id(map.get("USER_ID"));
		} else {
			member.setUser_id(id);
		}
		map = MemberAPI.getMember("WEB", member);

		if(map != null) {
			return StringUtils.equals(map.get("SMS_CHECK"), "Y");
		} else {
			return false;
		}
	}


	@RequestMapping(value = {"/pouch/index.*", "/pouch/detail.*"})
	public String myPouch(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/pouch/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("예약 가능한 회원이 아닙니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
				return null;
			}
		}

		if(request.getRequestURI().endsWith("/pouch/detail.do")) {
			model.addAttribute("pouchDetail", LibSearchAPI.getPouchDetail("WEB", librarySearch.getvSeqNo()));
		    return String.format(basePath, homepage.getFolder()) + "pouch/detail";
		}
		else {
			model.addAttribute("pouchList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "BEACH", null));
//			model.addAttribute("pouchList", LibSearchAPI.getPouchList("WEB", member.getUser_id(), "req", homepage.getHomepage_code(), ""));
			return String.format(basePath, homepage.getFolder()) + "pouch/index";
		}

//		model.addAttribute("pouchList", LibSearchAPI.getPouchList("WEB", member.getUser_id(), "req", homepage.getHomepage_code(), ""));
//		return String.format(basePath, homepage.getFolder()) + "pouch/index";
	}

	@RequestMapping(value = {"/pouch/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse savePouch(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("예약 신청 가능한 회원이 아닙니다.");
					return res;
				}
			}

			// 0001:예약, 0002:연장, 0003:야간대출
			ILUSReqConfig ilusReqConfig = ilusReqConfigService.getILUSReqConfigInfo(librarySearch, "0003");
			if(ilusReqConfig != null) {
				res.setValid(false);
				res.setMessage(ilusReqConfig.getRes_msg());
				return res;
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {
				ApiResponse apiResult = LibSearchAPI.reqPouch("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.reqResve("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("신청 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
			else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modPouch("WEB", librarySearch, getSessionUserId(request));
				//ApiResponse apiResult = LibSearchAPI.modResve("WEB", librarySearch, "future");
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/loan/index.*", "/loan/detail.*", "/loan/history.*"})
	public String myLoan(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/loan/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
//				service.aler tMessageAndUrl("대출 가능한 회원이 아닙니다.", String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), request, response);
//				return null;
			}
		}
		/*model.addAttribute("introMenu", "도서대출확인");*/
		//model.addAttribute("loanList", LibSearchAPI.getMyLibraryList("WEB", "future", "LOAN", "0001"));//임시

		if(request.getRequestURI().endsWith("/loan/detail.do")) {
			model.addAttribute("loanDetail", LibSearchAPI.getLoanDetail("WEB", librarySearch.getvLoanNo()));
		    return String.format(basePath, homepage.getFolder()) + "loan/detail";
		}
		else if(request.getRequestURI().endsWith("/loan/history.do")) {
			model.addAttribute("loanList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", null));
			return String.format(basePath, homepage.getFolder()) + "loan/history";
		}
		else {
			model.addAttribute("loanList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", "0001"));
		    return String.format(basePath, homepage.getFolder()) + "loan/index";
		}
	}

	@RequestMapping(value = {"/loan/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse renewLoan(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("대출 연장 신청 가능한 회원이 아닙니다.");
					return res;
				}
			}

			// 0001:예약, 0002:연장, 0003:야간대출
			ILUSReqConfig ilusReqConfig = ilusReqConfigService.getILUSReqConfigInfo(librarySearch, "0002");
			if(ilusReqConfig != null) {
				res.setValid(false);
				res.setMessage(ilusReqConfig.getRes_msg());
				return res;
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {

			}
			else if ( librarySearch.getEditMode().equals("RENEW") ) {
				//ApiResponse apiResult = LibSearchAPI.renewLoan("WEB", librarySearch, "future");
				ApiResponse apiResult = LibSearchAPI.renewLoan("WEB", librarySearch, getSessionUserId(request));
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("대출 연장 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = {"/out/history.*"})
	public String myOut(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		// String vOption = '0001' 신청|배송중|대출대기만 리스트에 출력됨

		Map<String, String> paramMap = new HashMap<String, String>();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}

		paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
		paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));

		// paramMap.put("vSrchDateKey", "STATUS_CHANGE_DATE");

		paramMap.put("vSortKey", "STATUS_CHANGE_DATE");
		paramMap.put("vSortDir", "DESC");

		// 페이징을 위한 전체 카운터 조회
		Map<String, Object> result = LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "OUT", null, paramMap);
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("dsMyLibraryListCnt");
		Map<String, Object> cnt = (Map<String, Object>) list.get(0);

		int count = Integer.parseInt(String.valueOf(cnt.get("CNT")));

		librarySearch.setTotalDataCount(count);
		// 페이징 변수 시작, 끝값
		paramMap.put("vStartPos", Integer.toString(librarySearch.getStartRowNum()));
		paramMap.put("vEndPos",Integer.toString(librarySearch.getEndRowNum()));

		result = LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "OUT", null, paramMap);

		service.setPaging(model, count, librarySearch);

		model.addAttribute("totalCount", count);
		model.addAttribute("outList", result);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "out/history";
	}


	@RequestMapping(value = {"/out/edit.*"}, method = RequestMethod.POST)
	public String OutEdit(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member member = getSessionMemberInfo(request);


		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/loan/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			service.alertMessageAndUrl("통합회원만 상호대차 신청이 가능합니다.\\n로그인 후 이용하시기 바랍니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		} else if ( isLogin(request) && !member.getUnAgreeFlag().equals("0001")) {
			service.alertMessage("통합회원만 이용 하실 수 있습니다.", request, response);
			return null;
		} else if (librarySearch.getvLoca().equals(member.getLoca())) {
			service.alertMessage("소속도서관은 상대호차를 이용 할 수 없습니다.", request, response);
			return null;
		}

		Map<String, Object> sameBookList = LibSearchAPI.getSameBookList(member.getUser_id(), librarySearch.getIsbn(), member.getLoca());
		if (!sameBookList.isEmpty()) {
			System.out.println("SANGHO : these book is in ur library.");
			System.out.println("SANGHO : ISBN : " + librarySearch.getIsbn());
			System.out.println("SANGHO : LOCA : " + member.getLoca());
			service.alertMessage("소속도서관("+member.getLoca_name()+")에 동일 자료가 존재합니다. 소속 도서관을 이용하시기 바랍니다.", request, response);
			return null;
		}

		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("member", member);

		return String.format(basePath, homepage.getFolder()) + "out/edit";
	}

	@RequestMapping(value = {"/out/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse out(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Member member = getSessionMemberInfo(request);

		librarySearch.setvRecptLoca(member.getLoca());

		if(!result.hasErrors()) {

			Homepage homepage_code = new Homepage();

			homepage_code.setHomepage_code(librarySearch.getvItemLoca());

			Homepage homepage2 = homepageService.getHomepageOneByCode(homepage_code);

			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage2.getHomepage_id());
			smsReception.setWork_code("0002");	// 보존서고:0001, 상호대차:0002
			List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			if (librarySearch.getEditMode().equals("ADD")) {
				ApiResponse addOut = LibSearchAPI.reqOutReg("WEB", librarySearch, member.getUser_id());

				if (addOut.getStatus()) {
					res.setValid(true);
					res.setUrl("/"+homepage.getContext_path()+"/intro/search/detail.do?vLoca="+librarySearch.getvItemLoca()+"&vCtrl="+librarySearch.getvCtrl()+"&vImg="+librarySearch.getvImg()+"&isbn="+librarySearch.getIsbn()+"&tid="+librarySearch.getTid()+"&menu_idx="+librarySearch.getMenu_idx());
					res.setMessage("상호대차 신청이 완료되었습니다.\r신청 내역은 MyLibrary에서 확인 가능합니다.");

					// 신청자에게 SMS 전송
					//2019.02.26 이용자에게 신청 문자 삭제(일루스에서 전송)
//					String userMessage = "상호대차 신청이 완료되었습니다. ["+librarySearch.getTitle()+"]";
//					if (isSmsReceive("WEBID", getSessionMemberId(request))) {
//						PushAPI.sendMessage(homepage2, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), userMessage, homepage2.getHomepage_send_tell(), true);
//					}
					// 관리자에게 SMS 전송
					String adminMessage = "상호대차 신청건이 발생하였습니다. 수령:"+member.getLoca_name()+" 도서명:"+librarySearch.getTitle();
					for(SmsReception one : receptionsList) {
						PushAPI.sendMessage(homepage2, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), adminMessage, homepage2.getHomepage_send_tell(), true);
					}
				} else {
					res.setValid(false);
					res.setMessage(addOut.getMessage());
				}
			} else if (librarySearch.getEditMode().equals("CANCEL")) {
				ApiResponse cancelOut = LibSearchAPI.modOutReg("WEB", librarySearch, getSessionUserId(request));
				if (cancelOut.getStatus()) {
					res.setValid(true);
					res.setMessage("상호대차가 취소되었습니다.");

					//신청자에게 SMS 전송
					String userMessage = "상호대차 신청취소 완료되었습니다. ["+librarySearch.getTitle()+"]";
					if (isSmsReceive("WEBID", getSessionMemberId(request))) {
						PushAPI.sendMessage(homepage2, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), userMessage, homepage2.getHomepage_send_tell(), true);
					}
					// 관리자에게 SMS 전송
					String adminMessage = "상호대차 취소건이 발생하였습니다. 수령:"+member.getLoca_name()+" 도서명:"+librarySearch.getTitle();
					for(SmsReception one : receptionsList) {
						PushAPI.sendMessage(homepage2, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), adminMessage, homepage2.getHomepage_send_tell(), true);
					}
				} else {
					res.setValid(false);
					res.setMessage(cancelOut.getMessage());
				}
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/print.*"}, method=RequestMethod.POST)
	public String print(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( librarySearch.getPrint_param() != null ) {
			List<Object> resultList = new ArrayList<Object>();
			List<String> paramList 		= librarySearch.getPrint_param();
			if ( librarySearch.getPrint_cmd_page().equals("INDEX") ) {
				for ( String oneInfo : paramList ) {
					String[] keys = oneInfo.split("_"); /// 0 - vLoca, 1 - vCtrl
					if ( keys.length > 1 ) {
						Map<String, Object> result = LibSearchAPI.getBookDetail(new LibrarySearch(keys[0], keys[1]));
						resultList.add(result);
					}
				}

			}
			else if ( librarySearch.getPrint_cmd_page().equals("DETAIL") ) {
				for ( String oneInfo : paramList ) {
					String[] key = oneInfo.split("_"); //${i.TITLE}|${i.CALL_NO}|${i.ACSSON_NO}|${i.AUTHOR}|${i.SUB_LOCA_NAME}
					Map<String, Object> dsItemDetail = new HashMap<String, Object>();
					List<Object> dsItemList = new ArrayList<Object>();
					Map<String, Object> result = new HashMap<String, Object>();
					result.put("TITLE", key[0]);
					if ( key.length > 1 ) {
						result.put("CALL_NO", key[1]);
					}
					if ( key.length > 2 ) {
						result.put("ACSSON_NO", key[2]);
					}
					if ( key.length > 3 ) {
						result.put("AUTHOR", key[3]);
					}
					if ( key.length > 4 ) {
						result.put("SUB_LOCA_NAME", key[4]);
					}
					if ( key.length > 5 ) {
						result.put("PUBLISHER", key[5]);
					}
					/*if ( key.length > 6 ) {
						result.put("BOOK_STATUS_NAME", key[6]);
					}*/
					dsItemList.add(result);
					dsItemDetail.put("dsItemDetail", dsItemList);
					resultList.add(dsItemDetail);
				}

			}
			model.addAttribute("resultList", resultList);
		}


		return String.format(basePath, homepage.getFolder()) + "print_ajax";
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.GET)
	public LibrarySearchView excel(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {


		if (StringUtils.equals(librarySearch.getExcel_type(), "POUCH")) {
			model.addAttribute("result", LibSearchAPI.getPouchList("WEB", getSessionUserId(request), "req", librarySearch.getvLoca(), ""));
			model.addAttribute("librarySearch", librarySearch);
		} else if (StringUtils.equals(librarySearch.getExcel_type(), "HOPE")) {

			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
			paramMap.put("vSrchDateKey", "INSERT_DATE");
			paramMap.put("vSortKey", "INSERT_DATE");
			paramMap.put("vSortDir", "DESC");


			model.addAttribute("result", LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "HOPE", null, paramMap));
			model.addAttribute("librarySearch", librarySearch);
		} else if (StringUtils.equals(librarySearch.getExcel_type(), "NEWBOOK")) {

			// 소장처 코드
			Homepage homepage = (Homepage) request.getAttribute("homepage");
			if (StringUtils.isEmpty(librarySearch.getvLoca())) {
				librarySearch.setvLoca(homepage.getHomepage_code());
			}

			Map<String, Object> newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
			@SuppressWarnings ("unchecked")
			List<Map<String, String>> newBookCnt = (List<Map<String, String>>) newBookResult.get("dsNewBookListCnt");
			int totalCnt = Integer.parseInt(String.valueOf(newBookCnt.get(0).get("CNT")));
			librarySearch.setEndRowNum(totalCnt);
			newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
			@SuppressWarnings ("unchecked")
			List<Map<String, String>> newBookListTmp = (List<Map<String, String>>) newBookResult.get("dsNewBookList");
			List<Map<String, Object>> newBookList = new ArrayList<Map<String, Object>>();
			for ( Map<String, String> map : newBookListTmp ) {
				LibrarySearch tmp = new LibrarySearch();
				tmp.setvLoca(map.get("LOCA"));
				tmp.setvCtrl(map.get("CTRLNO"));
				Map<String, Object> detailResult = LibSearchAPI.getBookDetail(tmp);
				@SuppressWarnings ("unchecked")
				List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailResult.get("dsItemDetail");
				for ( Map<String, Object> map2 : detailList ) {
					newBookList.add(map2);
				}
			}
			Map<String, Object> newBook = new HashMap<String, Object>();
			newBook.put("newBook", newBookList);

			model.addAttribute("result", newBook);
			model.addAttribute("librarySearch", librarySearch);

		} else if (StringUtils.equals(librarySearch.getExcel_type(), "OUT")) {
			Map<String, String> paramMap = new HashMap<String, String>();

			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
		//	paramMap.put("vSrchDateKey", "STATUS_CHANGE_DATE");
			paramMap.put("vSortKey", "STATUS_CHANGE_DATE");
			paramMap.put("vSortDir", "DESC");

			model.addAttribute("result", LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "OUT", null, paramMap));
			model.addAttribute("librarySearch", librarySearch);
		} else if (StringUtils.equals(librarySearch.getExcel_type(), "CLOSE")) {
			model.addAttribute("result", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "CLOSE", null));
			model.addAttribute("librarySearch", librarySearch);
		} else {
			model.addAttribute("result", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), librarySearch.getExcel_type(), librarySearch.getExcel_type_detail()));
			model.addAttribute("librarySearch", librarySearch);

		}

		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.GET)
	public void csv(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = null;

		if (StringUtils.equals(librarySearch.getExcel_type(), "POUCH")) {
			result = LibSearchAPI.getPouchList("WEB", getSessionUserId(request), "req", librarySearch.getvLoca(), "");
		} else if (StringUtils.equals(librarySearch.getExcel_type(), "HOPE")) {

			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
			paramMap.put("vSrchDateKey", "INSERT_DATE");
			paramMap.put("vSortKey", "INSERT_DATE");
			paramMap.put("vSortDir", "DESC");

			result = LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "HOPE", null, paramMap);
		} else if (StringUtils.equals(librarySearch.getExcel_type(), "NEWBOOK")) {

			// 소장처 코드
			Homepage homepage = (Homepage) request.getAttribute("homepage");
			if (StringUtils.isEmpty(librarySearch.getvLoca())) {
				librarySearch.setvLoca(homepage.getHomepage_code());
			}

			Map<String, Object> newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
			@SuppressWarnings ("unchecked")
			List<Map<String, String>> newBookCnt = (List<Map<String, String>>) newBookResult.get("dsNewBookListCnt");
			int totalCnt = Integer.parseInt(String.valueOf(newBookCnt.get(0).get("CNT")));
			librarySearch.setEndRowNum(totalCnt);
			newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
			@SuppressWarnings ("unchecked")
			List<Map<String, String>> newBookListTmp = (List<Map<String, String>>) newBookResult.get("dsNewBookList");
			List<Map<String, Object>> newBookList = new ArrayList<Map<String, Object>>();
			for ( Map<String, String> map : newBookListTmp ) {
				LibrarySearch tmp = new LibrarySearch();
				tmp.setvLoca(map.get("LOCA"));
				tmp.setvCtrl(map.get("CTRLNO"));
				Map<String, Object> detailResult = LibSearchAPI.getBookDetail(tmp);
				@SuppressWarnings ("unchecked")
				List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailResult.get("dsItemDetail");
				for ( Map<String, Object> map2 : detailList ) {
					newBookList.add(map2);
				}
			}
			Map<String, Object> newBook = new HashMap<String, Object>();
			newBook.put("newBook", newBookList);

			result = newBook;

		} else if (StringUtils.equals(librarySearch.getExcel_type(), "CLOSE")) {

			result = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "CLOSE", null);
		}else {
			result = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), librarySearch.getExcel_type(), librarySearch.getExcel_type_detail());
		}

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public LibrarySearchView excelDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> result	 				= null;
		result = LibSearchAPI.getSearch(librarySearch, librarySearch.getViewPage()); // API로 Request 보냄
		model.addAttribute("result", result);
		model.addAttribute("librarySearch", librarySearch);

		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.POST)
	public void csvDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = null;
		result = LibSearchAPI.getSearch(librarySearch, librarySearch.getViewPage()); // API로 Request 보냄

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}

	@RequestMapping(value = {"/marcView.*"})
	public String marc_view(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> marcView = LibSearchAPI.getMarcView("WEB", "MARC XML", librarySearch);
		@SuppressWarnings ("unchecked")
		List<Map<String, String>> marcList = (List<Map<String, String>>) marcView.get("dsMarcView");
		model.addAttribute("marcList", marcList);

		return String.format(basePath, homepage.getFolder()) + "marcView_ajax";
	}

}