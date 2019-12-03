package kr.go.gbelib.app.intro.search;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfigService;
import kr.go.gbelib.app.cms.module.ilusReqConfig.ILUSReqConfigService;
import kr.go.gbelib.app.cms.module.smsReception.SmsReceptionService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.MemberAPI;

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

	@ModelAttribute("recommendSiteList")
	public List<RecommendSite> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		return recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id()));
	}

	/**
	 * 자료검색
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		List<Homepage> normalHomepage = homepageService.getNormalHomepage();
		// 소장처 코드
		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
			librarySearch.setManageCode(homepage.getHomepage_code());
		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( !StringUtils.isEmpty(homepage.getHomepage_code()) ) {
				libraryCodes.add(homepage.getHomepage_code());
			} else {
				for (Homepage home : normalHomepage) {
					libraryCodes.add(home.getHomepage_code());
				}
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
    		Map<String, Object> result = new HashMap<String, Object>();

    		if ( librarySearch.getBooktype().equals("BOOK") ) {
    			result = LibSearchAPI.getBookDetail(librarySearch);
    		} else if (librarySearch.getBooktype().equals("NONBOOK")) {
    			result = LibSearchAPI.getNonBookDetail(librarySearch);
    		} else if (librarySearch.getBooktype().equals("SERIAL")) {
    			result = LibSearchAPI.getSerialDetail(librarySearch);
    		}

    		List<Map<String, Object>> list = null;

    		int count = LibSearchAPI.getSearchCount(result);

    		librarySearch.setTotalDataCount(count);
    		service.setPaging(model, count, librarySearch);

    		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
    			list = LibSearchAPI.getListData(result);
    		}

    		model.addAttribute("bookSearch", list);
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	/**
	 * 자료 상세페이지
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/detail.*"})
	public String detail(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		Map<String, Object> result = new HashMap<String, Object>();

		result = LibSearchAPI.getBookInfo(librarySearch);

		model.addAttribute("librarySearch", librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( count > 0 ) {
			list = LibSearchAPI.getListData(result);
			Map<String, Object> map = list.get(0);


			librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
			librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
			librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
			librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));

			Map<String, Object> sanghoReqYn = LibSearchAPI.sanghoReqYn(librarySearch);
			@SuppressWarnings ("unchecked")
			Map<String, Object> sanghoReqYnResult = (Map<String, Object>) sanghoReqYn.get("ITEM");

			map.put("SANGHO_REQ_YN", "N");
			if (sanghoReqYnResult.containsKey("RESULT") && String.valueOf(sanghoReqYnResult.get("RESULT")).equals("OK")) {
				// 정상 신청가능
				map.put("SANGHO_REQ_YN", "Y");
			}

			model.addAttribute("detail", map);
		}
		return String.format(basePath, homepage.getFolder()) + "detail";
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
		Homepage homepage = getSessionHomepage(request);
		//TODO 작업해야함

		return String.format(basePath, homepage.getFolder()) + "indexForBoard_ajax";
	}


	/**
	 * 인기검색어
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param homepagePath
	 * @return
	 */
	@RequestMapping(value = {"/hotTrend.*"})
	public String hotTrend(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = getSessionHomepage(request);
		Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getHomepage_code());

		int count = LibSearchAPI.getSearchCount(hotTrendWordList);

		if ( count > 0 ) {
			model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
		}

		return String.format(basePath, homepage.getFolder()) + "hotTrend_ajax";
	}

	/**
	 * 대출베스트 ajax용
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param homepagePath
	 * @return
	 */
	@RequestMapping(value = {"/bestBook.*"})
	public String bestBook(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable("homepagePath") String homepagePath) {
		Homepage homepage = getSessionHomepage(request);
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			librarySearch.setManageCode(homepage.getHomepage_code());
		}

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}

		Map<String, Object> result = LibSearchAPI.getBestBookList(librarySearch);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> map : list ) {
				if ( map.containsKey("ISBN") ) {
					LibrarySearch book = new LibrarySearch();
					book.setIsbn(String.valueOf(map.get("ISBN")));
					book.setManageCode(librarySearch.getManageCode());
					book.setRowCount(1);
					Map<String, Object> bookDetail = null;
					if (librarySearch.getBooktype().equals("0")) {
						//도서 상세정보
						bookDetail = LibSearchAPI.getBookDetail(book);
					} else if (librarySearch.getBooktype().equals("1")) {
						//간행물 상세정보
						bookDetail = LibSearchAPI.getSerialDetail(book);
					} else if (librarySearch.getBooktype().equals("2")) {
						//비도서 상세정보
						bookDetail = LibSearchAPI.getNonBookDetail(book);
					}
					List<Map<String, Object>> detailList = LibSearchAPI.getListData(bookDetail);
					if ( detailList != null && detailList.size() > 0 ) {
						map.put("IMAGE", detailList.get(0).get("IMAGE"));
					}
				}
			}
		}


		model.addAttribute("bestBookList", list);

		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "bestBook_ajax";
	}

	/**
	 * 신착도서
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/newBook/index.*"})
	public String getNewBookList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		//접속 도서관 확인
		Homepage homepage = getSessionHomepage(request);
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			librarySearch.setManageCode(homepage.getHomepage_code());
		}

		//기본값 '1달 전'
		if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
			librarySearch.setSearch_type("3");
		}

		//검색기간 설정
		if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

			int beforeDays = -30;
			if (librarySearch.getSearch_type().equals("1")) {
				//1주전
				beforeDays = -7;
			} else if (librarySearch.getSearch_type().equals("2")) {
				//2주전
				beforeDays = -14;
			} else if (librarySearch.getSearch_type().equals("3")) {
				//1달전
				beforeDays = -30;
			}
			librarySearch.setSearch_start_date(sf.format(DateUtils.addDays(new Date(), beforeDays)));
			librarySearch.setSearch_end_date(sf.format(new Date()));
		}

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}

		Map<String, Object> result = LibSearchAPI.getNewBookList(librarySearch);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

			list = LibSearchAPI.getListData(result);
			for (Map<String, Object> map : list) {
				if (map.containsKey("ISBN")) {
					LibrarySearch book = new LibrarySearch();
					book.setIsbn(String.valueOf(map.get("ISBN")));
					book.setManageCode(librarySearch.getManageCode());
					book.setRowCount(1);
					Map<String, Object> bookDetail = null;
					if (librarySearch.getBooktype().equals("0")) {
						// 도서 상세정보
						bookDetail = LibSearchAPI.getBookDetail(book);
					} else if (librarySearch.getBooktype().equals("1")) {
						// 간행물 상세정보
						bookDetail = LibSearchAPI.getSerialDetail(book);
					} else if (librarySearch.getBooktype().equals("2")) {
						// 비도서 상세정보
						bookDetail = LibSearchAPI.getNonBookDetail(book);
					}
					List<Map<String, Object>> detailList = LibSearchAPI.getListData(bookDetail);
					if (detailList != null && detailList.size() > 0) {
						map.put("IMAGE", detailList.get(0).get("IMAGE"));
					}
				}
			}
		}

		model.addAttribute("newBookList", list);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "newBook/index";
	}

	/**
	 * 대출베스트
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/bestBook/index.*"})
	public String bestBookList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			librarySearch.setManageCode(homepage.getHomepage_code());
		}

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}

		Map<String, Object> result = LibSearchAPI.getBestBookList(librarySearch);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);
			for ( Map<String, Object> map : list ) {
				if ( map.containsKey("ISBN") ) {
					LibrarySearch book = new LibrarySearch();
					book.setIsbn(String.valueOf(map.get("ISBN")));
					book.setManageCode(librarySearch.getManageCode());
					book.setRowCount(1);
					Map<String, Object> bookDetail = null;
					if (librarySearch.getBooktype().equals("0")) {
						//도서 상세정보
						bookDetail = LibSearchAPI.getBookDetail(book);
					} else if (librarySearch.getBooktype().equals("1")) {
						//간행물 상세정보
						bookDetail = LibSearchAPI.getSerialDetail(book);
					} else if (librarySearch.getBooktype().equals("2")) {
						//비도서 상세정보
						bookDetail = LibSearchAPI.getNonBookDetail(book);
					}
					List<Map<String, Object>> detailList = LibSearchAPI.getListData(bookDetail);
					if ( detailList != null && detailList.size() > 0 ) {
						map.put("IMAGE", detailList.get(0).get("IMAGE"));
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);

		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "bestBook/index";
	}


	/**
	 * ???????
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/index.*"})
	public String hopeIndex(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		return String.format(basePath, homepage.getFolder()) + "hope/index";
	}

	/**
	 * 희망도서신청 내역
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/history.*"})
	public String hopeHistory(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		librarySearch.setUserkey(member.getRec_key());
		Map<String, Object> result = LibSearchAPI.getBookFurnishList(librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);

		service.setPaging(model, count, librarySearch);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

			list = LibSearchAPI.getListData(result);

		}

		model.addAttribute("hopeList", list);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "hope/history";
	}

	/**
	 * 희망도서 신청 폼
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/req.*"})
	public String reqHope(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		Member member = getSessionMemberInfo(request);
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

//		if ( !homepage.getHomepage_code().contains(member.getLoca())) {
//			service.alertMessage("희망도서 신청은 소속도서관에서만 가능합니다.", request, response);
//			return null;
//		}

		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "hope/req";
	}

	/**
	 * 네이버 책 검색(희망도서신청용)
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/search.*"})
	public String hopeSearch(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);

		Map<String, Object> map = null;
		if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
			map = LibSearchAPI.getNaverList(librarySearch);
			int totalCount = (Integer) map.get("totalCount");
			@SuppressWarnings ("unchecked")
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map.get("list");
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map2 : itemList) {
					String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
					for (int i = 0; i < isbnArr.length; i++) {
						String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];
						map2.put("isbn"+isbn.length(), isbn);

						LibrarySearch bookSerach = new LibrarySearch();
						bookSerach.setManageCode(homepage.getHomepage_code());
						bookSerach.setIsbn(isbn);
						Map<String, Object> sameBook = (Map<String, Object>) LibSearchAPI.getBookDetail(bookSerach);

						int sameBookCount = LibSearchAPI.getSearchCount(sameBook);

						if (sameBookCount > 0) {
							map2.put("already"+isbn.length(), true);
						}

					}

				}
				service.setPaging(model, totalCount, librarySearch);
				model.addAttribute("naverResult", map);
			}
		}

		return String.format(basePath, homepage.getFolder()) + "hope/search_ajax";
	}

	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		Homepage homepage = getSessionHomepage(request);

		JsonResponse res = new JsonResponse(request);

		if(librarySearch.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author", "저자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer", "출판사를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "publer_year", "연도를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "price", "가격을 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "price", "가격은 숫자만 입력가능합니다.");
		}

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if (!StringUtils.equals(member.getMember_class(), "0")) {
				res.setValid(false);
				res.setMessage("희망도서 신청 가능한 회원이 아닙니다.");
				return res;
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {

				//웹필터 체크
//				StringBuilder sb = new StringBuilder();
//				sb.append(librarySearch.getEditMode() + "\n");
//				sb.append(librarySearch.getvLoca() + "\n");
//				sb.append(librarySearch.getTitle() + "\n");
//				sb.append(librarySearch.getAuthor() + "\n");
//				sb.append(librarySearch.getPubler() + "\n");
//				sb.append(librarySearch.getPubler_year() + "\n");
//				sb.append(librarySearch.getIsbn() + "\n");
//				sb.append(librarySearch.getEditon() + "\n");
//				sb.append(librarySearch.getUser_remark() + "\n");
//				sb.append(librarySearch.getPrice() + "\n");
//				String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
//				if (addResult != null) {
//					res.setValid(false);
//					res.setUrl(addResult);
//					res.setTargetOpener(true);
//					return res;
//				}

				ApiResponse hopeUserCheck = LibSearchAPI.hopeUserCheck(member.getRec_key(), librarySearch.getIsbn(), librarySearch.getManageCode());

				if (hopeUserCheck.getStatus()) {
					ApiResponse apiResult = LibSearchAPI.reqHope(librarySearch, member);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("신청 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
					res.setValid(false);
					res.setMessage(hopeUserCheck.getMessage());
				}
			} else if (librarySearch.getEditMode().equals("CANCEL")) {
				ApiResponse apiResult = LibSearchAPI.modHope(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
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
	 * 예약중 도서 조회
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/resve/index.*"})
	public String myResve(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/intro/%s/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		Map<String, Object> result = LibSearchAPI.getReserveList(member.getRec_key());
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
			list = LibSearchAPI.getListData(result);
		}

		model.addAttribute("resveList", list);

		return String.format(basePath, homepage.getFolder()) + "resve/index";
	}

	/**
	 * 예약신청, 예약취소
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/resve/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveResve(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			return res;
		}

		if (!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}

			librarySearch.setUserkey(member.getRec_key());
			if (librarySearch.getEditMode().equals("ADD")) {
				ApiResponse apiResult = LibSearchAPI.reqResve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("예약되었습니다. 단, 대출 가능일은 자료반납 여부에 따라 변동될 수 있습니다.");
				} else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			} else if (librarySearch.getEditMode().equals("CANCEL")) {
				ApiResponse apiResult = LibSearchAPI.cancelResve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
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
	 * 대출중도서, 대출내역조회
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/loan/index.*", "/loan/detail.*", "/loan/history.*"})
	public String myLoan(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/intro/%s/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		if ( request.getRequestURI().endsWith("/loan/detail.do") ) {

			// Map<String, Object> result = LibSearchAPI.getLoanDetail("WEB", getSessionUserId(request), librarySearch.getvLoanNo());

			// List<Map<String, Object>> list = null;
			//
			// int count = LibSearchAPI.getSearchCount(result);
			//
			// librarySearch.setTotalDataCount(count);
			//
			// service.setPaging(model, count, librarySearch);
			//
			// if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
			//
			// list = LibSearchAPI.getListData(result);
			//
			// }

			// model.addAttribute("loanDetail", list);

			return String.format(basePath, homepage.getFolder()) + "loan/detail";
		} else if ( request.getRequestURI().endsWith("/loan/history.do") ) {

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
				librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
			}
			if ( StringUtils.isEmpty(librarySearch.getSearch_end_date()) ) {
				librarySearch.setSearch_end_date(sdf.format(new Date()));
			}

			librarySearch.setUserkey(member.getRec_key());
			Map<String, Object> result = LibSearchAPI.getBookLoanHistory(librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);

			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

				list = LibSearchAPI.getListData(result);

			}

			model.addAttribute("loanList", list);
			return String.format(basePath, homepage.getFolder()) + "loan/history";
		} else {

			Map<String, Object> result = LibSearchAPI.getBookLoanList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getListData(result);

			}
			model.addAttribute("loanList", list);

			return String.format(basePath, homepage.getFolder()) + "loan/index";
		}

	}

	/**
	 * 반납연기
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/loan/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse renewLoan(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if ( !result.hasErrors() ) {
			if ( librarySearch.getEditMode().equals("ADD") ) {

			} else if ( librarySearch.getEditMode().equals("RENEW") ) {

				ApiResponse apiResult = LibSearchAPI.renewLoan(librarySearch);
				if ( apiResult.getStatus() ) {
					res.setValid(true);
					res.setMessage("반납 연기 되었습니다.");
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
	 * 청구기호 출력
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/print.*"})
	public String print(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		Map<String, Object> result = new HashMap<String, Object>();

		result = LibSearchAPI.getBookInfo(librarySearch);

		model.addAttribute("librarySearch", librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( count > 0 ) {
			list = LibSearchAPI.getListData(result);
			model.addAttribute("detail", list.get(0));
		}

		return String.format(basePath, homepage.getFolder()) + "print_ajax";
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.GET)
	public LibrarySearchView excel(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {


//		if (StringUtils.equals(librarySearch.getExcel_type(), "POUCH")) {
//			model.addAttribute("result", LibSearchAPI.getPouchList("WEB", getSessionUserId(request), "req", librarySearch.getvLoca(), ""));
//			model.addAttribute("librarySearch", librarySearch);
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "HOPE")) {
//
//			Map<String, String> paramMap = new HashMap<String, String>();
//			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
//			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
//			paramMap.put("vSrchDateKey", "INSERT_DATE");
//			paramMap.put("vSortKey", "INSERT_DATE");
//			paramMap.put("vSortDir", "DESC");
//
//
//			model.addAttribute("result", LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "HOPE", null, paramMap));
//			model.addAttribute("librarySearch", librarySearch);
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "NEWBOOK")) {
//
//			// 소장처 코드
//			Homepage homepage = getSessionHomepage(request);
//			if (StringUtils.isEmpty(librarySearch.getvLoca())) {
//				librarySearch.setvLoca(homepage.getHomepage_code());
//			}
//
//			Map<String, Object> newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
//			@SuppressWarnings ("unchecked")
//			List<Map<String, String>> newBookCnt = (List<Map<String, String>>) newBookResult.get("dsNewBookListCnt");
//			int totalCnt = Integer.parseInt(String.valueOf(newBookCnt.get(0).get("CNT")));
//			librarySearch.setEndRowNum(totalCnt);
//			newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
//			@SuppressWarnings ("unchecked")
//			List<Map<String, String>> newBookListTmp = (List<Map<String, String>>) newBookResult.get("dsNewBookList");
//			List<Map<String, Object>> newBookList = new ArrayList<Map<String, Object>>();
//			for ( Map<String, String> map : newBookListTmp ) {
//				LibrarySearch tmp = new LibrarySearch();
//				tmp.setvLoca(map.get("LOCA"));
//				tmp.setvCtrl(map.get("CTRLNO"));
//				Map<String, Object> detailResult = LibSearchAPI.getBookDetail(tmp);
//				@SuppressWarnings ("unchecked")
//				List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailResult.get("dsItemDetail");
//				for ( Map<String, Object> map2 : detailList ) {
//					newBookList.add(map2);
//				}
//			}
//			Map<String, Object> newBook = new HashMap<String, Object>();
//			newBook.put("newBook", newBookList);
//
//			model.addAttribute("result", newBook);
//			model.addAttribute("librarySearch", librarySearch);
//
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "OUT")) {
//			Map<String, String> paramMap = new HashMap<String, String>();
//
//			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
//			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
//		//	paramMap.put("vSrchDateKey", "STATUS_CHANGE_DATE");
//			paramMap.put("vSortKey", "STATUS_CHANGE_DATE");
//			paramMap.put("vSortDir", "DESC");
//
//			model.addAttribute("result", LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "OUT", null, paramMap));
//			model.addAttribute("librarySearch", librarySearch);
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "CLOSE")) {
//			model.addAttribute("result", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "CLOSE", null));
//			model.addAttribute("librarySearch", librarySearch);
//		} else {
//			model.addAttribute("result", LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), librarySearch.getExcel_type(), librarySearch.getExcel_type_detail()));
//			model.addAttribute("librarySearch", librarySearch);
//
//		}

		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.GET)
	public void csv(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = null;

//		if (StringUtils.equals(librarySearch.getExcel_type(), "POUCH")) {
//			result = LibSearchAPI.getPouchList("WEB", getSessionUserId(request), "req", librarySearch.getvLoca(), "");
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "HOPE")) {
//
//			Map<String, String> paramMap = new HashMap<String, String>();
//			paramMap.put("vSrchDateS", librarySearch.getSearch_start_date().replaceAll("-", ""));
//			paramMap.put("vSrchDateE", librarySearch.getSearch_end_date().replaceAll("-", ""));
//			paramMap.put("vSrchDateKey", "INSERT_DATE");
//			paramMap.put("vSortKey", "INSERT_DATE");
//			paramMap.put("vSortDir", "DESC");
//
//			result = LibSearchAPI.getMyLibrarySearchList("WEB", getSessionUserId(request), "HOPE", null, paramMap);
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "NEWBOOK")) {
//
//			// 소장처 코드
//			Homepage homepage = getSessionHomepage(request);
//			if (StringUtils.isEmpty(librarySearch.getvLoca())) {
//				librarySearch.setvLoca(homepage.getHomepage_code());
//			}
//
//			Map<String, Object> newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
//			@SuppressWarnings ("unchecked")
//			List<Map<String, String>> newBookCnt = (List<Map<String, String>>) newBookResult.get("dsNewBookListCnt");
//			int totalCnt = Integer.parseInt(String.valueOf(newBookCnt.get(0).get("CNT")));
//			librarySearch.setEndRowNum(totalCnt);
//			newBookResult = LibSearchAPI.getNewBookList(librarySearch, null);
//			@SuppressWarnings ("unchecked")
//			List<Map<String, String>> newBookListTmp = (List<Map<String, String>>) newBookResult.get("dsNewBookList");
//			List<Map<String, Object>> newBookList = new ArrayList<Map<String, Object>>();
//			for ( Map<String, String> map : newBookListTmp ) {
//				LibrarySearch tmp = new LibrarySearch();
//				tmp.setvLoca(map.get("LOCA"));
//				tmp.setvCtrl(map.get("CTRLNO"));
//				Map<String, Object> detailResult = LibSearchAPI.getBookDetail(tmp);
//				@SuppressWarnings ("unchecked")
//				List<Map<String, Object>> detailList = (List<Map<String, Object>>) detailResult.get("dsItemDetail");
//				for ( Map<String, Object> map2 : detailList ) {
//					newBookList.add(map2);
//				}
//			}
//			Map<String, Object> newBook = new HashMap<String, Object>();
//			newBook.put("newBook", newBookList);
//
//			result = newBook;
//
//		} else if (StringUtils.equals(librarySearch.getExcel_type(), "CLOSE")) {
//
//			result = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "CLOSE", null);
//		}else {
//			result = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), librarySearch.getExcel_type(), librarySearch.getExcel_type_detail());
//		}

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public LibrarySearchView excelDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {

//		Map<String, Object> result	 				= null;
//		result = LibSearchAPI.getSearch(librarySearch, librarySearch.getViewPage()); // API로 Request 보냄
//		model.addAttribute("result", result);
//		model.addAttribute("librarySearch", librarySearch);

		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.POST)
	public void csvDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> result = null;
//		result = LibSearchAPI.getSearch(librarySearch, librarySearch.getViewPage()); // API로 Request 보냄

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}

	@RequestMapping(value = {"/marcView.*"})
	public String marc_view(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		//TODO marc보기
//
//		Map<String, Object> marcView = LibSearchAPI.getMarcView("WEB", "MARC XML", librarySearch);
//		@SuppressWarnings ("unchecked")
//		List<Map<String, String>> marcList = (List<Map<String, String>>) marcView.get("dsMarcView");
//		model.addAttribute("marcList", marcList);

		return String.format(basePath, homepage.getFolder()) + "marcView_ajax";
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
//			member.setCheck_certify_type("WEBID");
//			member.setCheck_certify_data(id);
//			map = MemberAPI.getMemberCertify("WEB", member);
//			member.setUser_id(map.get("USER_ID"));
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
}