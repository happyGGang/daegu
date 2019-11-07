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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.CommonAPI;
import kr.go.gbelib.app.common.api.LibSearchAPI;

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

@Controller
@RequestMapping(value = {"/intro/{context_path}/search"})
public class LibrarySearchController extends BaseController {

	private final String basePath = "/intro/search/";

	@Autowired
	private LibrarySearchService service;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CalendarManageService calendarManageService;

	@ModelAttribute("liboneApiUrl")
	private String getLiboneApiUrl() {
		return CommonAPI.LIBONE_API_URL;
	}
	@ModelAttribute("libraryList")
	private Map<String, Object> getLibraryList() {
		return service.getLibraryList();
	}

	@ModelAttribute("searchCategory")
	private Map<String, Object> getSearchCategory() {
		return service.getSearchCategory();
	}

	@ModelAttribute
	public void introMenu(Model model) {
		model.addAttribute("introMenu", "자료검색");//임시
	}
	
	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
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

		// 소장처 코드
		List<String> libraryCodes = new ArrayList<String>();
		libraryCodes.add(homepage.getHomepage_codeList()[0]);//검색대에서는 첫번째 코드만 사용한다.
		libraryCodes.add("00000001");//검색대에서는 첫번째 코드만 사용한다.
		librarySearch.setLibraryCodes(libraryCodes);

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

//			if ( librarySearch.isSub_search() ) {
//				result = LibSearchAPI.getSubSearch(librarySearch);
//			}
//			else {
//				result = LibSearchAPI.getSearch(librarySearch, 1); // API로 Request 보냄
//			}
			//
			if ( librarySearch.isSub_search() ) {
				result = LibSearchAPI.getSubSearch(librarySearch);
			}
			else {
				String searchType = librarySearch.getSearch_type2();
				if ( StringUtils.isEmpty(searchType) ) {
					searchType = "L_TITLE";
					librarySearch.setSortField("TITLE");
					librarySearch.setSortType("ASC");
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
		model.addAttribute("homepage", homepage);
		return basePath + "index";
	}

	@RequestMapping(value = {"/table.*"})
	public String table(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Map<String, Object> result = null;
		int viewPage = 1;
		String beforSearchType = librarySearch.getSearch_type();

		if ( !StringUtils.isEmpty(librarySearch.getSearch_text()) ) {

			if ( StringUtils.isEmpty(librarySearch.getSearch_type()) ) {
				librarySearch.setSearch_type("SEARCH");
			}

			if ( librarySearch.getViewPage() > 1) { // 화면에서 페이지 버튼 클릭
				//librarySearch.setSearch_type("GOPAGE"); // GOPAGE 사용시 검색 카테고리 바꾸면 페이징 안됨. (API가 안됨...)
				viewPage = librarySearch.getViewPage();
			}

			// 소장처 코드
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add(homepage.getHomepage_codeList()[0]);//검색대에서는 첫번째 코드만 사용한다.
			librarySearch.setLibraryCodes(libraryCodes);

			result = LibSearchAPI.getSearch(librarySearch, viewPage); // API로 Request 보냄
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
		model.addAttribute("homepage", homepage);
		return basePath + "table_ajax";
	}

	@RequestMapping(value = {"/table2.*"})
	public String table2(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

		Map<String, Object> resultCountByWriter	 	= null;
		resultCountByWriter 	= LibSearchAPI.getSearchCountByWriter(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByWriter", resultCountByWriter); // 검색한 결과의 저자별 카운트

		return basePath + "table2_ajax";
	}

	@RequestMapping(value = {"/table3.*"})
	public String table3(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

		Map<String, Object> resultCountByPublisher	 	= null;
		resultCountByPublisher 	= LibSearchAPI.getSearchCountByPublisher(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByPublisher", resultCountByPublisher); // 검색한 결과의 출판사별 카운트

		return basePath + "table3_ajax";
	}

	@RequestMapping(value = {"/table4.*"})
	public String table4(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

		Map<String, Object> resultCountByYear	 	= null;
		resultCountByYear 	= LibSearchAPI.getSearchCountByYear(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByYear", resultCountByYear); // 검색한 결과의 연도별 카운트

		return basePath + "table4_ajax";
	}

	@RequestMapping(value = {"/table5.*"})
	public String table5(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

		Map<String, Object> resultCountByFormcode	 	= null;
		resultCountByFormcode 	= LibSearchAPI.getSearchCountByFormCode(librarySearch.getAllBookListStr(), librarySearch.getViewPage());//저자
		model.addAttribute("resultCountByFormcode", resultCountByFormcode); // 검색한 결과의 연도별 카운트

		return basePath + "table5_ajax";
	}

	@RequestMapping(value = {"/hotTrend.*"})
	public String hotTrend(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable String context_path) {
		model.addAttribute("hotTrendDailyList", LibSearchAPI.getHotTrendWordList(10, "1"));
		model.addAttribute("hotTrendWeeklyList", LibSearchAPI.getHotTrendWordList(10, "2"));

		return basePath + "hotTrend_ajax";
	}

	@RequestMapping(value = {"/autoFill.do"})
	public @ResponseBody Map<String, Object> autoFill(@RequestParam("searchKeyword")String searchKeyword) {
		return LibSearchAPI.getAutoFill(searchKeyword);
	}

	@RequestMapping(value = {"/{index}detail.*"})
	public String detail(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("index") String index) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("introMenu", "도서상세정보");//임시

		// 소장처 코드
		//librarySearch.setvLoca(homepage.getHomepage_code());

		Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);
		if("00000001".equals(librarySearch.getvLoca())) {
			LibSearchAPI.addMarcUrls(result);
		}
		model.addAttribute("detail", result);
		model.addAttribute("librarySearch", librarySearch);
		String returnPage = "detail";
		if (!StringUtils.isEmpty(index) && index.equals("index_")) {
			//결과리스트에서 이용가능여부 클릭 시
			returnPage = "index_detail_ajax";
		} else {
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
		}
		model.addAttribute("homepage", homepage);
		model.addAttribute("isTodayClosed", calendarManageService.isTodayClosed(homepage.getHomepage_id()));
		return basePath + returnPage;
	}

	@RequestMapping(value = {"/callNoBrowsing.*"})
	public String callNoBrowsing(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable String context_path) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));

		return String.format(basePath, homepage.getFolder()) + "callNoBrowsing_ajax";
	}

	@RequestMapping(value = {"/newBook/index.*"})
	public String getNewBookList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("introMenu", "신착도서");//임시

		if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			librarySearch.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), -30)));
			librarySearch.setSearch_end_date(sf.format(new Date()));
		}

		// 소장처 코드
		librarySearch.setvLoca(homepage.getHomepage_code());

		Map<String, Object> result = LibSearchAPI.getNewBookList(librarySearch, "MAIN");
		List<Map<String, Object>> resultPaging = new ArrayList<Map<String, Object>>();
		List<Object> list = (List<Object>) result.get("dsNewBookList");
		if (list != null && list.size() > 0 ) {
			service.setPaging(model, list.size(), librarySearch);
			int listIndex = librarySearch.getViewPage();
			int size = list.size() > 9 ? 10 : list.size();
			for (int i = 0; i < size; i++) {
				resultPaging.add((Map<String, Object>) list.get((librarySearch.getStartRowNum()-1)+i));
			}
			result.put("dsNewBookList", resultPaging);
		}

		model.addAttribute("newBookList", result);
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("homepage", homepage);
		return basePath + "newBook/index";
	}

	@RequestMapping(value = {"/bestBook/index.*"})
	public String bestBookList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("introMenu", "도서대출베스트");//임시

		// 소장처 코드
		librarySearch.setvLoca(homepage.getHomepage_code());
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Map<String, Object> result = LibSearchAPI.getBestBookList(librarySearch, "10", sdf.format(cal.getTime()));

		model.addAttribute("bestBookList", result);
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("homepage", homepage);
		return basePath + "bestBook/index";
	}

	@RequestMapping(value = {"/hope/index.*"})
	public String getHopeList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("희망도서 신청 가능한 회원이 아닙니다.", "/intro/" + homepage.getContext_path() + "/search/index.do", request, response);
				return null;
			}
		}
		model.addAttribute("introMenu", "희망도서신청리스트");//임시
		model.addAttribute("hopeList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "HOPE", null));
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("view_yn", true);
		model.addAttribute("homepage", homepage);
		return basePath + "hope/index";
	}

	@RequestMapping(value = {"/hope/req.*"})
	public String reqHope(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		Member member = getSessionMemberInfo(request);
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			librarySearch.setBefore_url(String.format("/intro/%s/search/hope/req.do", homepage.getContext_path()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/intro/%s/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()), request, response);
			return null;
		}

		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("희망도서 신청 가능한 회원이 아닙니다.", "/intro/" + homepage.getContext_path() + "/search/index.do", request, response);
				return null;
			}
		}

		if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
			service.alertMessageAndUrl("홈페이지 코드가 없어 신청 할 수 없습니다.", String.format("/intro/%s/index.do", homepage.getContext_path()), request, response);
			return null;
		}

		if ( !homepage.getHomepage_code().contains(member.getLoca())) {
			service.alertMessage("희망도서 신청은 소속도서관에서만 가능합니다.", request, response);
			return null;
		}

		model.addAttribute("introMenu", "희망도서신청");//임시
		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("homepage", homepage);
		return basePath + "hope/req";
	}

	@RequestMapping(value = {"/hope/search.*"})
	public String hopeSearch(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( StringUtils.isEmpty(homepage.getHomepage_code()) ) {
			service.alertMessageAndUrl("홈페이지 코드가 없어 신청 할 수 없습니다.", String.format("http://www.gbelib.kr/%s/index.do", homepage.getContext_path()), request, response);
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

		//model.addAttribute("introMenu", "희망도서신청");//임시
		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);

		Map<String, Object> map = null;
		if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
			map = LibSearchAPI.getNaverList(librarySearch);
			String totalCount = String.valueOf(((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("total"));
			List<Map<String, Object>> itemList = (List<Map<String, Object>>)((Map<String, Object>)((Map<String, Object>)map.get("rss")).get("channel")).get("item");
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
				model.addAttribute("naverResult", map);
			}
		}
		return String.format(basePath, homepage.getFolder()) + "hope/search_ajax";
	}

	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);

		if(librarySearch.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author", "저자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer", "출판사를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer_year", "연도를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "price", "가격을 입력하세요.");
		}

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
				if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
					res.setValid(false);
					res.setMessage("희망도서 신청 가능한 회원이 아닙니다.");
					return res;
				}
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

//				ApiResponse apiResult = LibSearchAPI.reqHope("WEB", librarySearch, member.getUser_id(), member.getLoca());
//				if ( apiResult.getStatus() ) {
//					res.setValid(true);
//					res.setMessage("등록 되었습니다.");
//				}
//				else {
//					res.setValid(false);
//					res.setMessage(apiResult.getMessage());
//				}
			}
			else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modHope("WEB", librarySearch, getSessionUserId(request));
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

	@RequestMapping(value = {"/resve/index.*"})
	public String myResve(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("예약 가능한 회원이 아닙니다.", "/intro/" + homepage.getContext_path() + "/search/index.do", request, response);
				return null;
			}
		}
		model.addAttribute("introMenu", "도서예약확인");
		model.addAttribute("resveList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "RESVE", null));
		model.addAttribute("homepage", homepage);
		return basePath + "resve/index";
	}

	@RequestMapping(value = {"/resve/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveResve(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			try {
				librarySearch.setBefore_url(URLEncoder.encode(request.getHeader("referer"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				librarySearch.setBefore_url(String.format("http://www.gbelib.kr/%s/intro/search/resve/index.do?menu_idx=%s", homepage.getContext_path(), librarySearch.getMenu_idx()));
			}
			result.reject("로그인 후 이용가능합니다.");
			res.setUrl(String.format("http://www.gbelib.kr/intro/%s/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), librarySearch.getMenu_idx(), librarySearch.getBefore_url()));
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
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
				else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			}
			else if ( librarySearch.getEditMode().equals("CANCEL") ) {
				ApiResponse apiResult = LibSearchAPI.modResve("WEB", librarySearch, getSessionUserId(request));
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

	@RequestMapping(value = {"/loan/index.*"})
	public String myLoan(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.isEmpty(member.getStatus_code()) ) {
			if (!(member.getStatus_code().equals("0001") || member.getStatus_code().equals("0") )) {
				service.alertMessageAndUrl("대출 가능한 회원이 아닙니다.", "/intro/" + homepage.getContext_path() + "/search/index.do", request, response);
				return null;
			}
		}
		model.addAttribute("introMenu", "도서대출확인");
		model.addAttribute("loanList", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", null));
		model.addAttribute("homepage", homepage);
		return basePath + "loan/index";
	}

	@RequestMapping(value = {"/loan/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse renewLoan(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
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

			if ( librarySearch.getEditMode().equals("ADD") ) {

			}
			else if ( librarySearch.getEditMode().equals("RENEW") ) {
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

	@RequestMapping(value = {"/print.*"}, method=RequestMethod.POST)
	public String print(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
					String[] key = oneInfo.split("_"); //${i.TITLE}|${i.CALL_NO}|${i.ACSSON_NO}|${i.AUTHOR}|${i.SUB_LOCA_NAME}|${i.BOOKSH_NAME}
					Map<String, Object> dsItemDetail = new HashMap<String, Object>();
					List<Object> dsItemList = new ArrayList<Object>();
					Map<String, Object> result = new HashMap<String, Object>();
					result.put("TITLE", key[0].replaceAll("@@@", "\'"));
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
					if ( key.length > 6 ) {
						result.put("PLACE_NO", key[6]);
					}
					if ( key.length > 7 ) {
						result.put("BOOKSH_NAME", key[7]);
					}
					dsItemList.add(result);
					dsItemDetail.put("dsItemDetail", dsItemList);
					resultList.add(dsItemDetail);
				}

			}
			model.addAttribute("resultList", resultList);
		}


		return basePath + "print_ajax";
	}



}