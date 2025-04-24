package kr.go.gbelib.app.intro.search;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfig;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.aspectj.weaver.ast.Not;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfigService;
import kr.go.gbelib.app.cms.module.lasReqConfig.LasReqConfig;
import kr.go.gbelib.app.cms.module.lasReqConfig.LasReqConfigService;
import kr.go.gbelib.app.cms.module.smsReception.SmsReception;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.PrivateLibSearchAPI;

@Controller
@RequestMapping(value = {"/intro/{context_path}/search"})
public class LibrarySearchController extends BaseController {

	private final String basePath = "/intro/search/";

	@Autowired
	private LibrarySearchService service;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private HopebookConfigService hopebookConfigService;

	@Autowired
	private LasReqConfigService lasReqConfigService;

	@Autowired
	private UntactBookReservationService untactBookReservationService;

	/**
	 * 검색
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		List<Homepage> normalHomepage = homepageService.getNormalHomepage();
		// 소장처 코드
//		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
//			librarySearch.setManageCode(homepage.getManage_code());
//		}

		if (homepage.getHomepage_id().equals("h71") && librarySearch.getLibraryCodes() == null) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("FX");
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( homepage != null && !StringUtils.isEmpty(homepage.getManage_code()) ) {
				libraryCodes.add(homepage.getManage_code());
			} else {
				for (Homepage home : normalHomepage) {
					if (StringUtils.isNotEmpty(home.getManage_code())) {
						libraryCodes.add(home.getManage_code());
					}
				}
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				Map<String, Object> result = new HashMap<String, Object>();

				if ( librarySearch.getBooktype().equals("BOOK") ) {
					result = PrivateLibSearchAPI.getBookDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("NONBOOK")) {
					result = PrivateLibSearchAPI.getNonBookDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("SERIAL")) {
					result = PrivateLibSearchAPI.getSerialDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("BOOKANDNONBOOK")) {
					result = PrivateLibSearchAPI.getBookAndNonbookDetail(librarySearch);
				}

				List<Map<String, Object>> list = null;

				int count = PrivateLibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);

				if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
					list = PrivateLibSearchAPI.getListData(result);

	    			//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
	    			for (Map<String, Object> map : list) {
	    				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
	    					Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
	    					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
	    						map.put("aladin", aladinData.get("item"));
	    					}
	    					if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
						
						map.put("marc", private_marc_view(model, String.valueOf(map.get("REG_NO")), request));
					}
				}
				
				model.addAttribute("bookSearch", list);
				model.addAttribute("facetGroup", PrivateLibSearchAPI.getFacetGroup(result));
			} else {
				Map<String, Object> result = new HashMap<String, Object>();
				
				// 자료실 제외 코드 : [두류]보존서고(1,2,3)
				librarySearch.setNotShelfCode(NotShelfCodes.getNotShelfCode());

				if ( librarySearch.getBooktype().equals("BOOK") ) {
					result = LibSearchAPI.getBookDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("NONBOOK")) {
					result = LibSearchAPI.getNonBookDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("SERIAL")) {
					result = LibSearchAPI.getSerialDetail(librarySearch);
				} else if (librarySearch.getBooktype().equals("BOOKANDNONBOOK")) {
					result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
				}

				List<Map<String, Object>> list = null;

				int count = LibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);

				if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
					list = LibSearchAPI.getListData(result);

	    			//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
	    			for (Map<String, Object> map : list) {
	    				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
	    					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
	    					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
	    						map.put("aladin", aladinData.get("item"));
	    					}
	    					if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
						
						map.put("marc", marc_view(model, String.valueOf(map.get("REG_NO")), request));
					}
				}
				model.addAttribute("bookSearch", list);
				model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
			}
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return basePath + "index";
	}

	private List<Map<String, Object>> getShelfInfoList(Map<String, Object> shelfInfo) {
		List<Map<String, Object>> shelfInfoList = LibSearchAPI.getShelfInfoList(shelfInfo);
		String[] noUseShelfCodes = {"BW06", "BW08", "BW11", "BW12", "BW16", "BW18", "BW19", "BW20", "BW21", "BW22", "BW23", "BW24", "BW25", "BW26", "AB38", "CB17", "FM05"};
		shelfInfoList.removeIf(map -> Arrays.asList(noUseShelfCodes)
				.contains(map.get("CODE")));
		return shelfInfoList;
	}


	@RequestMapping(value = {"/indexAll.*"})
	public String indexAll(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Homepage> normalHomepage = homepageService.getNormalHomepage();
		// 소장처 코드
//		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
//			librarySearch.setManageCode(homepage.getManage_code());
//		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("ALL");
			for (Homepage home : normalHomepage) {
				libraryCodes.add(home.getManage_code());
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}
		
		librarySearch.setNotShelfCode(NotShelfCodes.getNotShelfCode());

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
			Map<String, Object> result = new HashMap<String, Object>();

			if ( librarySearch.getBooktype().equals("BOOK") ) {
				result = LibSearchAPI.getBookDetail(librarySearch);
			} else if (librarySearch.getBooktype().equals("NONBOOK")) {
				result = LibSearchAPI.getNonBookDetail(librarySearch);
			} else if (librarySearch.getBooktype().equals("SERIAL")) {
				result = LibSearchAPI.getSerialDetail(librarySearch);
			} else if (librarySearch.getBooktype().equals("BOOKANDNONBOOK")) {
				result = LibSearchAPI.getBookAndNonbookDetail(librarySearch);
			}

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getListData(result);

				//알라딘 API 결과 가져오기
				for (Map<String, Object> map : list) {
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
						if (map.get("aladin") == null) {
							map.put("imageUrl", service.getImageUrl(map));
						}
					}
				}
			}

			model.addAttribute("bookSearch", list);
			model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return basePath + "indexAll";
	}

	/**
	 * 인기검색어
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param context_path
	 * @return
	 */
	@RequestMapping(value = {"/hotTrend.*"})
	public String hotTrend(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable String context_path) {
		Homepage homepage = getSessionHomepage(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (homepage != null && StringUtils.isNotEmpty(homepage.getManage_code())) {
				Map<String, Object> hotTrendWordList = PrivateLibSearchAPI.getHotTrendWordList(homepage.getManage_code());

				int count = PrivateLibSearchAPI.getSearchCount(hotTrendWordList);

				if ( count > 0 ) {
					model.addAttribute("hotTrendList", PrivateLibSearchAPI.getListData(hotTrendWordList));
				}
			}
		} else {
			if (homepage != null && StringUtils.isNotEmpty(homepage.getManage_code())) {
				Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getManage_code());

				int count = LibSearchAPI.getSearchCount(hotTrendWordList);

				if ( count > 0 ) {
					model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
				}
			}
		}

		return basePath + "hotTrend_ajax";
	}

	/**
	 * 상세보기
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/detail.*"})
	public String detail(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			result = PrivateLibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = PrivateLibSearchAPI.getListData(result);
				Map<String, Object> map = list.get(0);

				//알라딘 API 결과 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
				
				map.put("marc", private_marc_view(model, String.valueOf(map.get("REG_NO")), request));

				librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
				librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
				librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
				librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));

				map.put("SANGHO_REQ_YN", "N");
				model.addAttribute("detail", map);
			}
		} else {
			result = LibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = LibSearchAPI.getListData(result);
				Map<String, Object> map = list.get(0);

				//알라딘 API 결과 가져오기
				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
						map.put("aladin", aladinData.get("item"));
					}
					if (map.get("aladin") == null) {
						map.put("imageUrl", service.getImageUrl(map));
					}
				}
				
				map.put("marc", marc_view(model, String.valueOf(map.get("REG_NO")), request));

				librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
				librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
				librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
				librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));

				map.put("SANGHO_REQ_YN", "N");
				model.addAttribute("detail", map);
			}
		}
		
		return basePath + "detail";
	}

	/**
	 * 신착도서
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/newBook/index.*"})
	public String getNewBookList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

		//접속 도서관 확인
		Homepage homepage = getSessionHomepage(request);
//		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
//			librarySearch.setManageCode(homepage.getManage_code());
//		}
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			if (homepage == null) {
				return basePath + "newBook/index";
			} else {
				if (StringUtils.equals(context_path, context_path)) {
					librarySearch.setManageCode(homepage.getManage_code());
				}
			}
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

		Map<String, Object> shelfInfo = LibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());

		if (!"h90".equals(homepage.getHomepage_id())) {
			List<Map<String, Object>> shelfInfoList = getShelfInfoList(shelfInfo);
			model.addAttribute("shelfCodeList", shelfInfoList);
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getNewBookList(librarySearch);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

				list = PrivateLibSearchAPI.getListData(result);
				for (Map<String, Object> map : list) {
					if (map.containsKey("ISBN")) {

						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}
			
			model.addAttribute("newBookList", list);
			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.getNewBookList(librarySearch);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {

				list = LibSearchAPI.getListData(result);
				for (Map<String, Object> map : list) {
					if (map.containsKey("ISBN")) {

						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}
			
			model.addAttribute("newBookList", list);
			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "newBook/index";
	}

	/**
	 * 대출베스트
	 * @author whalesoft YONGJU 2019. 11. 14.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/bestBook/index.*"})
	public String bestBookList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			if (homepage == null) {
				return basePath + "bestBook/index";
			} else {
				if (StringUtils.equals(context_path, context_path)) {
					librarySearch.setManageCode(homepage.getManage_code());
				}
			}
		}

		//서지형태 분류코드 설정.
		//기본값 도서 "0"
		//0 : 단행, 1: 연속간행물, 2:비도서
		if (StringUtils.isEmpty(librarySearch.getBooktype())) {
			librarySearch.setBooktype("0");
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getBestBookList(librarySearch);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

				list = PrivateLibSearchAPI.getListData(result);
				for ( Map<String, Object> map : list ) {
					if ( map.containsKey("ISBN") ) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = PrivateLibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}

			model.addAttribute("bestBookList", list);
			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.getBestBookList(librarySearch);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

				list = LibSearchAPI.getListData(result);
				for ( Map<String, Object> map : list ) {
					if ( map.containsKey("ISBN") ) {
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", service.getImageUrl(map));
							}
						}
					}
				}
			}

			model.addAttribute("bestBookList", list);
			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "bestBook/index";
	}

	/**
	 * 대출중도서, 대출내역조회
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = { "/loan/index.*", "/loan/detail.*", "/loan/history.*" })
	public String myLoan(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}
		
		Member member = getSessionMemberInfo(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if ( request.getRequestURI().endsWith("/loan/detail.do") ) {

				return basePath + "loan/detail";
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
				Map<String, Object> result = PrivateLibSearchAPI.getBookLoanHistory(librarySearch);

				List<Map<String, Object>> list = null;

				int count = PrivateLibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);

				service.setPaging(model, count, librarySearch);

				if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {

					list = PrivateLibSearchAPI.getListData(result);

				}

				model.addAttribute("loanList", list);
				return basePath + "loan/history";
			} else {

				Map<String, Object> result = PrivateLibSearchAPI.getBookLoanList(member.getRec_key());
				List<Map<String, Object>> list = null;

				int count = PrivateLibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);

				if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
					list = PrivateLibSearchAPI.getListData(result);

				}
				model.addAttribute("loanList", list);

				return basePath + "loan/index";
			}
		} else {
			if ( request.getRequestURI().endsWith("/loan/detail.do") ) {

				return basePath + "loan/detail";
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
				return basePath + "loan/history";
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

				return basePath + "loan/index";
			}
		}
		
	}

	/**
	 * 반납연기
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/loan/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse renewLoan(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);
		if ( !result.hasErrors() ) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				if ( librarySearch.getEditMode().equals("ADD") ) {

				} else if ( librarySearch.getEditMode().equals("RENEW") ) {

					ApiResponse apiResult = PrivateLibSearchAPI.renewLoan(librarySearch);
					if ( apiResult.getStatus() ) {
						res.setValid(true);
						res.setMessage("반납 연기 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
			} else {
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
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	/**
	 * 예약중인 도서조회
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/resve/index.*"})
	public String myResve(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = PrivateLibSearchAPI.getListData(result);
			}

			model.addAttribute("resveList", list);
		} else {
			Map<String, Object> result = LibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = LibSearchAPI.getListData(result);
			}

			model.addAttribute("resveList", list);
		}

		return basePath + "resve/index";
	}

	/**
	 * 예약신청, 예약취소
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/resve/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveResve(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if ( !isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		} else {
			if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		}

		if ( !result.hasErrors() ) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.equals(member.getMember_class(), "0") ) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}
			
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				librarySearch.setUserkey(member.getRec_key());
				if (librarySearch.getEditMode().equals("ADD")) {
					ApiResponse apiResult = PrivateLibSearchAPI.reqResve(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("예약되었습니다. 단, 대출 가능일은 자료반납 여부에 따라 변동될 수 있습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else if (librarySearch.getEditMode().equals("CANCEL")) {
					ApiResponse apiResult = PrivateLibSearchAPI.cancelResve(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
			} else {
				//달성군립도서관 일반예약2권 무인예약5권 처리를 위해 예약 2권으로 제한 
				try {
					if(StringUtils.isNotEmpty(homepage.getContext_path())){
						if(homepage.getContext_path().equals("dalseonglib") && librarySearch.getEditMode().equals("ADD")) {
							Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key(), librarySearch.getManageCode());
							List<Map<String, Object>> list = null;
							list = LibSearchAPI.getListData(reserveList);
							int count = LibSearchAPI.getSearchCount(reserveList);
							
							int reserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("N")) {
									reserveCount++;
								}
							}
							
							if(reserveCount >= 2) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
						}
						
						if(homepage.getContext_path().equals("bukgs") && librarySearch.getEditMode().equals("ADD")) {
							Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key(), librarySearch.getManageCode());
							List<Map<String, Object>> list = null;
							list = LibSearchAPI.getListData(reserveList);
							int count = LibSearchAPI.getSearchCount(reserveList);
							
							int reserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("N")) {
									reserveCount++;
								}
							}
							
							if(reserveCount >= 3) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
						}
						
						if(homepage.getContext_path().equals("suseong") && librarySearch.getEditMode().equals("ADD")) {
							Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key(), librarySearch.getManageCode());
							List<Map<String, Object>> list = null;
							list = LibSearchAPI.getListData(reserveList);
							int count = LibSearchAPI.getSearchCount(reserveList);
							
							int reserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("N")) {
									reserveCount++;
								}
							}
							
							//무인예약 + 일반예약이 5권 초과가 불가능하게
							if(reserveCount >= 5) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
							
							int unmannedReserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("Y") || list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("O")) {
									unmannedReserveCount++;
								}
							}
							
							if((count - reserveCount) >= 2) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}

							if((count - unmannedReserveCount) >= 2) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
						}
						
						if("BM".equals(librarySearch.getManageCode()) && librarySearch.getEditMode().equals("ADD")) {
							Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key(), librarySearch.getManageCode());
							List<Map<String, Object>> list = null;
							list = LibSearchAPI.getListData(reserveList);
							int count = LibSearchAPI.getSearchCount(reserveList);
							
							int reserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("N")) {
									reserveCount++;
								}
							}
							
							if(reserveCount >= 2) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
							
							int unmannedReserveCount = 0 ;
							for(int i = 0; i < count; i++) {
								if(list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("Y") || list.get(i).get("UNMANNED_RESERVATION_LOAN").equals("O")) {
									unmannedReserveCount++;
								}
							}

							if((reserveCount + unmannedReserveCount) >= 7) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
						}

						if ("CA".equals(homepage.getManage_code()) && librarySearch.getEditMode().equals("ADD")) {
							Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key(), librarySearch.getManageCode());
							List<Map<String, Object>> list = null;
							list = LibSearchAPI.getListData(reserveList);

							int reserveCount = (int) list.stream()
														 .filter(data -> "CA".equals(data.get("MANAGE_CODE")) && data.get("UNMANNED_RESERVATION_LOAN").equals("N"))
														 .filter(data -> "CA".equals(data.get("MANAGE_CODE")) && data.get("NIGHT_RESERVATION_LOAN").equals("N"))
														 .count();

							if (reserveCount >= 3) {
								res.setValid(false);
								res.setMessage("예약 가능 권수를 초과 하셨습니다.");
								return res;
							}
						}
					}
				} catch (Exception e) {
					System.out.println("도서관 context_path 없음 : " + e);
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
			}
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 상호대차 신청 내역
	 * @author YONGJU 2018. 4. 3.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = { "/sangho/index.*" }, method = RequestMethod.GET)
	public String sanghoHistory(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if ( !StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y") ) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청내역 조회가 불가능합니다", request, response);
			return null;
		}


		model.addAttribute("librarySearch", librarySearch);

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.lillRequestList(librarySearch, "0");

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = PrivateLibSearchAPI.getListData(result);
			}

			model.addAttribute("sanghoHistory", list);
			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.lillRequestList(librarySearch, "0");

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getListData(result);
			}

			model.addAttribute("sanghoHistory", list);
			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "sangho/index";
	}

	/**
	 * 상호대차 이용 내역
	 * @author YONGJU 2018. 4. 3.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = { "/sangho/history.*" }, method = RequestMethod.GET)
	public String sanghoUsedHistory(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		Homepage homepage = getSessionHomepage(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if ( !StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y") ) {
			service.alertMessage("책이음회원이 아니므로 상호대차 이용내역 조회가 불가능합니다", request, response);
			return null;
		}

		model.addAttribute("librarySearch", librarySearch);

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.lillRequestList(librarySearch, "1");

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = PrivateLibSearchAPI.getListData(result);
			}

			model.addAttribute("sanghoHistory", list);
			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.lillRequestList(librarySearch, "1");

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getListData(result);
			}

			model.addAttribute("sanghoHistory", list);
			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "sangho/history";
	}

	/**
	 * 상호대차 신청 폼
	 * @author YONGJU 2018. 4. 3.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = { "/sangho/form.*" }, method = RequestMethod.POST)
	public String sanghoForm(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		model.addAttribute("librarySearch", librarySearch);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.equals(member.getKl_member_yn(), "Y") ) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청이 불가능합니다", request, response);
			return null;
		}

		/**/
		String overdueCnt = member.getOverdue_cnt();
		try {
			if (Integer.parseInt(overdueCnt) > 0) {
				service.alertMessage("현재 연체도서가 존재하여 상호대차 신청이 불가능합니다. 연체도서를 반납해주세요.", request, response);
				return null;
			}
		} catch (NumberFormatException e) {
			log.error("연체도서 없음");
		}

		String loanStopDate = member.getLoan_stop_date();
		if (StringUtils.isNotEmpty(loanStopDate) && StringUtils.length(loanStopDate) >= 10) {
			service.alertMessage("현재 "+loanStopDate+"까지 대출정지상태입니다. 상호대차 신청은 이후에 가능합니다.", request, response);
			return null;
		}

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> lillRequestList = PrivateLibSearchAPI.lillRequestList(librarySearch, "0");
			int lillRequestListCount = PrivateLibSearchAPI.getSearchCount(lillRequestList, "LIST_DATA", "TOTAL");

			int sanghoPossiCnt = 5;

			if (lillRequestListCount >= sanghoPossiCnt) {
				service.alertMessage("상호대차 신청권수는 "+sanghoPossiCnt+"권까지입니다.", request, response);
				return null;
			}

			Map<String, Object> result = new HashMap<String, Object>();

			if ( librarySearch.getBooktype() == null ) {
				librarySearch.setBooktype("BOOK");
			}

			result = PrivateLibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = PrivateLibSearchAPI.getListData(result);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ISBN", librarySearch.getIsbn());
				model.addAttribute("detail", list.get(0));
			}
		} else {
			Map<String, Object> lillRequestList = LibSearchAPI.lillRequestList(librarySearch, "0");
			int lillRequestListCount = LibSearchAPI.getSearchCount(lillRequestList, "LIST_DATA", "TOTAL");

			int sanghoPossiCnt = 5;

			// 달서구립도서관, 중구 상호대차 3권
			String[] sangho3cnt = {"dalseolib", "kids", "seongseo", "bolli", "family", "english", "dssmalllib", "junggu", "seogulib", "biwon", "bisan", "seoguenglish", "wongogae"};
			for (String libOne : sangho3cnt) {
				if(context_path.equals(libOne)) {
					sanghoPossiCnt = 3;
					break;
				}
			}

			if("BA".equals(librarySearch.getManageCode()) || "BB".equals(librarySearch.getManageCode()) || "BC".equals(librarySearch.getManageCode()) ||
			   "GL".equals(librarySearch.getManageCode()) || "GM".equals(librarySearch.getManageCode()) || "GN".equals(librarySearch.getManageCode()) ||
			   "HB".equals(librarySearch.getManageCode()) || "HD".equals(librarySearch.getManageCode()) || "HE".equals(librarySearch.getManageCode())) {
				sanghoPossiCnt = 10;
			}

			if("BS".equals(librarySearch.getManageCode()) || "BT".equals(librarySearch.getManageCode()) || "FE".equals(librarySearch.getManageCode())) {
				sanghoPossiCnt = 3;
			}
			
			if (lillRequestListCount >= sanghoPossiCnt) {
				service.alertMessage("상호대차 신청권수는 "+sanghoPossiCnt+"권까지입니다.", request, response);
				return null;
			}

			Map<String, Object> result = new HashMap<String, Object>();

			if ( librarySearch.getBooktype() == null ) {
				librarySearch.setBooktype("BOOK");
			}

			result = LibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = LibSearchAPI.getListData(result);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("ISBN", librarySearch.getIsbn());
				model.addAttribute("detail", list.get(0));
			}
		}

		return basePath + "sangho/form";
	}

	/**
	 * 지역상호대차 신청, 신청취소
	 * @author YONGJU 2018. 2. 4.
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/sanghoSave.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse sanghoSave(LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if (!StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {
			ValidationUtils.rejectIfEmpty(result, "uselibcode", "제공받을 도서관을 선택해주세요.");
			if (StringUtils.isEmpty(librarySearch.getManageCode()) || StringUtils.isEmpty(librarySearch.getUselibcode())) {
				result.reject("잘못된 접근입니다.");
			}
		}

		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				result.reject("로그인 후 이용가능합니다.");
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				result.reject("로그인 후 이용가능합니다.");
			}
		}

		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
			result.reject("책이음회원이 아니므로 상호대차 신청이 불가능합니다");
		}

		if (!result.hasErrors()) {
			if (homepage != null) {
				SmsReception smsReception = new SmsReception();
				smsReception.setHomepage_id(homepage.getHomepage_id());
				smsReception.setWork_code("0001");	// 상호대차:0001, 무인대출:0002, 야간대출:0003
				//List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			}
			
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				if (StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {

					ApiResponse apiResult = PrivateLibSearchAPI.lillRequestCancel(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}

				} else {

					Member sessionMemberInfo = getSessionMemberInfo(request);
					librarySearch.setUserkey(sessionMemberInfo.getUser_no());
					ApiResponse lillRequestCheck = PrivateLibSearchAPI.lillRequestCheck(librarySearch);

					if (lillRequestCheck.getStatus()) {
						ApiResponse apiResult = PrivateLibSearchAPI.lillRequest(librarySearch);
						if (apiResult.getStatus()) {
							res.setValid(true);
							res.setMessage("신청되었습니다.");
						} else {
							res.setValid(false);
							res.setMessage(apiResult.getMessage());
						}
					} else {
						res.setValid(false);
						res.setMessage(lillRequestCheck.getMessage());
					}

				}
			} else {
				if (StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {

					ApiResponse apiResult = LibSearchAPI.lillRequestCancel(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}

				} else {

					Member sessionMemberInfo = getSessionMemberInfo(request);
					librarySearch.setUserkey(sessionMemberInfo.getUser_no());
					ApiResponse lillRequestCheck = LibSearchAPI.lillRequestCheck(librarySearch);

					if (lillRequestCheck.getStatus()) {
						ApiResponse apiResult = LibSearchAPI.lillRequest(librarySearch);
						if (apiResult.getStatus()) {
							res.setValid(true);
							res.setMessage("신청되었습니다.");
						} else {
							res.setValid(false);
							res.setMessage(apiResult.getMessage());
						}
					} else {
						res.setValid(false);
						res.setMessage(lillRequestCheck.getMessage());
					}

				}
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 희망도서 신청내역
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/index.*"})
	public String getHopeList(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Member member = getSessionMemberInfo(request);
			librarySearch.setUserkey(member.getRec_key());
			Map<String, Object> result = PrivateLibSearchAPI.getBookFurnishList(librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);

			service.setPaging(model, count, librarySearch);

			if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
				list = PrivateLibSearchAPI.getListData(result);
			}

			model.addAttribute("hopeList", list);
			model.addAttribute("librarySearch", librarySearch);
		} else {
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
		}

		return basePath + "hope/index";
	}

	/**
	 * 희망도서 신청 폼
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/req.*"})
	public String reqHope(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		Member member = getSessionMemberInfo(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

		if (homepage != null && StringUtils.isNotEmpty(homepage.getHomepage_id())) {
			HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
			if(hopebookConfig != null) {
				service.alertMessage(hopebookConfig.getRes_msg(), request, response);
				return null;
			}

		}

		if ("BY".equals(homepage.getManage_code()) || "BV".equals(homepage.getManage_code()) || "BZ".equals(homepage.getManage_code()) ||
				"BW".equals(homepage.getManage_code()) || "BX".equals(homepage.getManage_code()) || "BU".equals(homepage.getManage_code())) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("BY");
			libraryCodes.add("BV");
			libraryCodes.add("BZ");
			libraryCodes.add("BW");
			libraryCodes.add("BX");
			libraryCodes.add("BU");

			librarySearch.setLibraryCodes(libraryCodes);

			LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);

			LocalDate today = LocalDate.now();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

			// 포맷된 날짜 출력
			String firstDayOfMonthFormatted = firstDayOfMonth.format(formatter);
			String todayFormatted = today.format(formatter);

			librarySearch.setSearch_start_date(firstDayOfMonthFormatted);
			librarySearch.setSearch_end_date(todayFormatted);

			librarySearch.setFurnish_status("1,2,3");

			librarySearch.setUserkey(member.getRec_key());

			Map<String, Object> result = LibSearchAPI.getBookFurnishList(librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			if (count >= 3) {
				service.alertMessage("희망도서는 달서구 내 통합 3권까지 신청가능합니다.\\n다음 달에 다시 신청해주세요.", request, response);
				return null;
			}
		}

		if ("HU".equals(homepage.getManage_code())) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("HU");

			librarySearch.setLibraryCodes(libraryCodes);
			librarySearch.setManageCode(homepage.getManage_code());

			LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);

			LocalDate today = LocalDate.now();

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

			String firstDayOfMonthFormatted = firstDayOfMonth.format(formatter);
			String todayFormatted = today.format(formatter);

			librarySearch.setSearch_start_date(firstDayOfMonthFormatted);
			librarySearch.setSearch_end_date(todayFormatted);

			librarySearch.setFurnish_status("1,2,3");

			Map<String, Object> result = LibSearchAPI.getAllBookFurnishList(librarySearch);

			int count = LibSearchAPI.getSearchCount(result);

			if (count >= 100) {
				service.alertMessage("월별 신청가능 권수를 초과하였습니다.\\n다음 달에 다시 신청해주세요.", request, response);
				return null;
			}
		}

		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);
		return basePath + "hope/req";
	}


	@SuppressWarnings("unchecked")
	@RequestMapping(value = {"/hope/searchKakao.*"}, method = RequestMethod.POST)
	public String hopeSearchKakao(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		int totalDataCount = librarySearch.getTotalDataCount();
		Map<String, Object> jsonData = new HashMap<>();
		List<Map<String, Object>> itemList = new ArrayList<>();
		List<Map<String, Object>> jArray = new ArrayList<>();
		Object kakaoList = null;
		String errorMessage = null;
		int errorCode = 0;
		Member member = getSessionMemberInfo(request);

		ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

		try {
			if (librarySearch.getJsonData() != null && librarySearch.getJsonData().length > 0) {
				// 멀티스레드 작업 생성
				List<Callable<Map<String, Object>>> tasks = Arrays.stream(librarySearch.getJsonData())
												  .map(jsonDataStr -> (Callable<Map<String, Object>>) () -> {
												  Map<String, Object> sMap = new HashMap<>();
												  try {
													  String str = jsonDataStr.replaceAll("&quot;", "\\\"").replace("^^^^", ",");
													  JSONObject jsonString = new JSONObject(str);

													  sMap.put("authors", jsonString.get("authors"));
													  sMap.put("contents", jsonString.get("contents"));
													  sMap.put("datetime", jsonString.get("datetime"));
													  sMap.put("isbn", jsonString.get("isbn"));
													  sMap.put("price", jsonString.get("price"));
													  sMap.put("publisher", jsonString.get("publisher"));
													  sMap.put("sale_price", jsonString.get("sale_price"));
													  sMap.put("status", jsonString.get("status"));
													  sMap.put("thumbnail", jsonString.get("thumbnail"));
													  sMap.put("title", jsonString.get("title"));
													  sMap.put("translators", jsonString.get("translators"));
													  sMap.put("url", jsonString.get("url"));

													  String[] isbnArr = String.valueOf(jsonString.get("isbn")).split(" ");

													  for (String isbn : isbnArr) {
														  sMap.put("isbn" + isbn.length(), isbn);
														  ApiResponse code = LibSearchAPI.hopeUserCheck(member.getRec_key(), isbn, librarySearch.getManageCode());

														  if (!code.getStatus()) {
															  sMap.put("already" + isbn.length(), true);
															  sMap.put("errorMessage", code.getMessage());
														  }
													  }
												  } catch (Exception e) {
													  throw new RuntimeException("데이터 처리 실패", e);
												  }
												  return sMap;
											  })
											  .collect(Collectors.toList());

				// 모든 작업을 실행하고 결과를 대기
				List<Future<Map<String, Object>>> futures = executorService.invokeAll(tasks);

				// 결과 수집
				for (Future<Map<String, Object>> future : futures) {
					try {
						Map<String, Object> result = future.get();
						if (result != null) {
							jArray.add(result);
						}
					} catch (InterruptedException | ExecutionException e) {
						e.printStackTrace();
					}
				}
			}

			jsonData.put("documents", jArray);

			kakaoList = jsonData.get("documents");

			if (kakaoList instanceof List) {
				itemList = (List<Map<String, Object>>) kakaoList;
			} else if (kakaoList instanceof Map) {
				itemList.add((Map<String, Object>) kakaoList);
			}

			if ("AJAX".equals(librarySearch.getEditMode())) {
				String[] value = String.valueOf(librarySearch.getBookValue()).split("\\^\\^\\^");
				librarySearch.setTitle(value[0]);
				librarySearch.setAuthor(value[1]);
				librarySearch.setPubler(value[2]);
				librarySearch.setPubler_year(value[3]);
				librarySearch.setIsbn(value[4]);
				librarySearch.setPrice(value[5]);
			}

			/*System.out.println("@@@@@@@@@@@@@@@@@@@ jsonData : " + jsonData.get("documents"));*/
			service.setPaging(model, totalDataCount, librarySearch);

			model.addAttribute("errorMessage", errorMessage);
			model.addAttribute("errorCode", errorCode);
			model.addAttribute("kakaoResult", itemList);
			model.addAttribute("totalDataCount", totalDataCount);
			model.addAttribute("librarySearch", librarySearch);
		} finally {
			executorService.shutdown();
			executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS); // 모든 스레드 작업 완료 대기
		}

		if ("AJAX".equals(librarySearch.getEditMode())) {
			return String.format(basePath, homepage.getFolder()) + "hope/req";
		} else {
			return String.format(basePath, homepage.getFolder()) + "hope/search_ajax";
		}
	}

	/**
	 * 네이버 책 검색 ( 희망도서 신청용 )
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/hope/search.*"})
	public String hopeSearch(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

		model.addAttribute("member", member);
		model.addAttribute("librarySearch", librarySearch);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> map = null;
			try {
				if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
					map = PrivateLibSearchAPI.getKaKaoList(librarySearch);
					int totalCount = (Integer) map.get("totalCount");
					@SuppressWarnings ("unchecked")
					List<Map<String, Object>> itemList = (List<Map<String, Object>>) map.get("list");
					if (itemList != null && itemList.size() > 0) {
						for (Map<String, Object> map2 : itemList) {
							String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
							for (int i = 0; i < isbnArr.length; i++) {
								String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];
								map2.put("isbn"+isbn.length(), isbn);
								ApiResponse code = PrivateLibSearchAPI.hopeUserCheck(member.getRec_key(), isbn, librarySearch.getManageCode());
								if (!code.getStatus()) {
									map2.put("already"+isbn.length(), true);
									map2.put("errorMessage", code.getMessage());
								}
							}

						}
						
						service.setPaging(model, totalCount, librarySearch);
						model.addAttribute("kakaoResult", map);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("kakaoResult", map);
			}
		} else {
			Map<String, Object> map = null;
			try {
				if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
					map = LibSearchAPI.getKaKaoList(librarySearch);
					int totalCount = (Integer) map.get("totalCount");
					@SuppressWarnings ("unchecked")
					List<Map<String, Object>> itemList = (List<Map<String, Object>>) map.get("list");
					if (itemList != null && itemList.size() > 0) {
						for (Map<String, Object> map2 : itemList) {
							String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
							for (int i = 0; i < isbnArr.length; i++) {
								String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];
								map2.put("isbn"+isbn.length(), isbn);
								ApiResponse code = LibSearchAPI.hopeUserCheck(member.getRec_key(), isbn, librarySearch.getManageCode());
								if (!code.getStatus()) {
									map2.put("already"+isbn.length(), true);
									map2.put("errorMessage", code.getMessage());
								}
							}

						}
						
						service.setPaging(model, totalCount, librarySearch);
						model.addAttribute("kakaoResult", map);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("kakaoResult", map);
			}
		}
		
		return basePath + "hope/search_ajax";
	}

	/**
	 * 희망도서 신청/취소
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
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
			
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				if ( librarySearch.getEditMode().equals("ADD") ) {

					if (homepage != null && StringUtils.isNotEmpty(homepage.getHomepage_id())) {
						HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
						if(hopebookConfig != null) {
							res.setValid(false);
							res.setMessage(hopebookConfig.getRes_msg());
							return res;
						}
					}
					
					Map<String, Object> map = PrivateLibSearchAPI.getLibSettingInfoView(librarySearch.getManageCode());
					
					if(map.get("RESULT_INFO").equals("SUCCESS")) {
						@SuppressWarnings("unchecked")
						List<Map<String, Object>> list =  (List<Map<String, Object>>) map.get("LIB_SETTING_INFO");
						
						String lib_code = (String) list.get(0).get("LIB_CODE");
						
						if(lib_code != null && !(lib_code.isEmpty()) && StringUtils.isNotEmpty(lib_code)) {
							if(librarySearch.getIsbn() != null && StringUtils.isNotEmpty(librarySearch.getIsbn())) {
								ApiResponse duplicateSurvey = PrivateLibSearchAPI.duplicateSurvey(librarySearch.getIsbn(), lib_code);
								
								if(!(duplicateSurvey.getStatus())) {
									res.setValid(false);
									res.setMessage("희망도서 바로대출제 서비스를 통해 신청된 도서입니다.");
									return res;
								}
							}
						} else {
							res.setValid(false);
							res.setMessage("KAPI오류 : 사립 도서관 설정정보 조회에 실패하였습니다. 관리자에게 문의해 주세요.");
							return res;
						}
					}
					
					ApiResponse hopeUserCheck = PrivateLibSearchAPI.hopeUserCheck(member.getRec_key(), librarySearch.getIsbn(), librarySearch.getManageCode());

					if (hopeUserCheck.getStatus()) {
						ApiResponse apiResult = PrivateLibSearchAPI.reqHope(librarySearch, member);
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
					ApiResponse apiResult = PrivateLibSearchAPI.modHope(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
			} else {
				if ( librarySearch.getEditMode().equals("ADD") ) {

					if (homepage != null && StringUtils.isNotEmpty(homepage.getHomepage_id())) {
						HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
						if(hopebookConfig != null) {
							res.setValid(false);
							res.setMessage(hopebookConfig.getRes_msg());
							return res;
						}
					}

					if ("BY".equals(homepage.getManage_code()) || "BV".equals(homepage.getManage_code()) || "BZ".equals(homepage.getManage_code()) ||
							"BW".equals(homepage.getManage_code()) || "BX".equals(homepage.getManage_code()) || "BU".equals(homepage.getManage_code())) {
						List<String> libraryCodes = new ArrayList<String>();
						libraryCodes.add("BY");
						libraryCodes.add("BV");
						libraryCodes.add("BZ");
						libraryCodes.add("BW");
						libraryCodes.add("BX");
						libraryCodes.add("BU");

						librarySearch.setLibraryCodes(libraryCodes);

						LocalDate firstDayOfMonth = LocalDate.now().withDayOfMonth(1);

						LocalDate today = LocalDate.now();

						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

						// 포맷된 날짜 출력
						String firstDayOfMonthFormatted = firstDayOfMonth.format(formatter);
						String todayFormatted = today.format(formatter);

						librarySearch.setSearch_start_date(firstDayOfMonthFormatted);
						librarySearch.setSearch_end_date(todayFormatted);

						librarySearch.setFurnish_status("1,2,3");

						librarySearch.setUserkey(member.getRec_key());

						Map<String, Object> bookFurnishResult = LibSearchAPI.getBookFurnishList(librarySearch);

						List<Map<String, Object>> list = null;

						int count = LibSearchAPI.getSearchCount(bookFurnishResult);

						if (count >= 3) {
							res.setValid(false);
							res.setMessage("희망도서는 달서구 내 통합 3권까지 신청가능합니다.\n다음 달에 다시 신청해주세요.");
							return res;
						}
					}
					
					Map<String, Object> map = LibSearchAPI.getLibSettingInfoView(librarySearch.getManageCode());
					
					if(map.get("RESULT_INFO").equals("SUCCESS")) {
						@SuppressWarnings("unchecked")
						List<Map<String, Object>> list =  (List<Map<String, Object>>) map.get("LIB_SETTING_INFO");
						
						String lib_code = (String) list.get(0).get("LIB_CODE");
						
						if(lib_code != null && !(lib_code.isEmpty()) && StringUtils.isNotEmpty(lib_code)) {
							if(librarySearch.getIsbn() != null && StringUtils.isNotEmpty(librarySearch.getIsbn())) {
								ApiResponse duplicateSurvey = LibSearchAPI.duplicateSurvey(librarySearch.getIsbn(), lib_code);
								
								if(!(duplicateSurvey.getStatus())) {
									res.setValid(false);
									res.setMessage("희망도서 바로대출제 서비스를 통해 신청된 도서입니다.");
									return res;
								}
							}
						} else {
							res.setValid(false);
							res.setMessage("KAPI오류 : 도서관 설정정보 조회에 실패하였습니다. 관리자에게 문의해 주세요.");
							return res;
						}
					}
					
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
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	/**
	 * 비대면 도서대출 신청 폼
	 * @author whalesoft SUNGHWAN 2021. 09. 10.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = { "/untactBook/form.*" }, method = RequestMethod.POST)
	public String untackBookForm(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = PrivateLibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = LibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "untackBook/form";
	}

	/**
	 * 비대면 도서대출
	 * @author whalesoft SUNGHWAN 2021. 09. 10.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/untackBook/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUntackBook(@PathVariable String context_path, Model model, LibrarySearch librarySearch, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		}

		if (!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			
			if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}

			untactBookReservation.setHomepage_id(getAsideHomepageId(request));
			untactBookReservation.setReg_no(member.getRec_key());
			untactBookReservation.setMember_id(member.getMember_id());
			untactBookReservation.setMember_name(member.getMember_name());
			
			untactBookReservationService.addUntactBookReservation(untactBookReservation);
			res.setValid(true);
			res.setMessage("예약 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 무인예약 신청 폼
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = { "/unmanned/form.*" }, method = RequestMethod.POST)
	public String unmannedForm(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = PrivateLibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = LibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "unmanned/form";
	}

	/**
	 * 무인대출예약
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/unmanned/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUnmanned(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		}

		if (!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}

			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage.getHomepage_id());
			smsReception.setWork_code("0002");	// 상호대차:0001, 무인대출:0002, 야간대출:0003
			//List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
			LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0004");
			if(lasReqConfig != null) {
				res.setValid(false);
				res.setMessage(lasReqConfig.getRes_msg());
				return res;
			}

			librarySearch.setUserkey(member.getRec_key());

			if(librarySearch.getPrivateLibraryYn(homepage)) {
				ApiResponse apiResult = PrivateLibSearchAPI.unmannedloanreserve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("예약 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			} else {
				if (StringUtils.equals(librarySearch.getWorker(), "DSSUB01") || StringUtils.equals(librarySearch.getWorker(), "DSSUB02")) {
					LibrarySearch l = new LibrarySearch();
					l.setWorker("DSSUB01");
					l.setUserkey(librarySearch.getUserkey());
					SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
					String sdate = sf.format(DateUtils.addDays(new Date(), -10));
					l.setSearch_start_date(sdate + "000000");

					Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
					int searchCount = LibSearchAPI.getSearchCount(unmannedLoanReserveList);
					if (searchCount >= 2) {
						res.setValid(false);
						res.setMessage("해당 기기의 무인 예약이 마감되었습니다");
						System.out.println("해당 기기의 무인 예약이 마감되었습니다. 063");
						return res;
					}

					l.setWorker("DSSUB02");
					unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
					searchCount += LibSearchAPI.getSearchCount(unmannedLoanReserveList);

					if (searchCount >= 2) {
						res.setValid(false);
						res.setMessage("해당 기기의 무인 예약이 마감되었습니다.");
						System.out.println("해당 기기의 무인 예약이 마감되었습니다. 0632");
						return res;
					}

					Map<String, Object> unmannedLoanReserveCnt = LibSearchAPI.getUnmannedLoanReserveCnt(librarySearch, "DATA");
					String nightLoanResult = String.valueOf(unmannedLoanReserveCnt.get("RESULT_INFO"));
					if (StringUtils.equals(nightLoanResult, "SUCCESS")) {
						String limit_cnt = String.valueOf(unmannedLoanReserveCnt.get("COUNT"));
						try {
							int limit_count = Integer.parseInt(limit_cnt);
							if (limit_count >= 50) {
								res.setValid(false);
								res.setMessage("해당 기기의 무인 예약이 마감되었습니다. 내일 다시 신청해주세요");

								return res;
							}
						} catch (Exception e) {
							res.setValid(false);
							res.setMessage("해당 기기의 무인 예약이 마감되었습니다");
							System.out.println("해당 기기의 무인 예약이 마감되었습니다. 060");
							return res;
						}
					} else {
						res.setValid(false);
						res.setMessage(String.valueOf(unmannedLoanReserveCnt.get("RESULT_MESSAGE")));
						return res;
					}
				}

				ApiResponse apiResult = LibSearchAPI.unmannedloanreserve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("예약 되었습니다.");

//					// 신청자에게 SMS 전송
//					String message = "무인대출 신청이 완료 되었습니다.[" + librarySearch.getTitle() + "]";
//
//					// 관리자에게 SMS 전송
//					String adminMessage = "무인대출 신청건이 발생하였습니다. 수령: 도서명:"+librarySearch.getTitle();
//					for(SmsReception one : receptionsList) {
//					}

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
	 * 야간예약 신청 폼
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = {"/night/form.*"}, method = RequestMethod.POST)
	public String nightForm(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = PrivateLibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		} else {
			Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (count > 0) {
				list = LibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
			}

			model.addAttribute("librarySearch", librarySearch);
		}

		return basePath + "night/form";
	}

	/**
	 * 야간대출예약
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/night/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveNight(@PathVariable String context_path, Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				res.setValid(false);
				res.setMessage("로그인 후 이용가능합니다.");
				return res;
			}
		}

		if (!result.hasErrors()) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				Member member = getSessionMemberInfo(request);
				if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
					res.setValid(false);
					res.setMessage("예약 신청 가능한 회원이 아닙니다.");
					return res;
				}

				librarySearch.setUserkey(member.getRec_key());
				ApiResponse apiResult = PrivateLibSearchAPI.nightloanreserve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("예약 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
				}
			} else {
				Member member = getSessionMemberInfo(request);
				if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
					res.setValid(false);
					res.setMessage("예약 신청 가능한 회원이 아닙니다.");
					return res;
				}

				librarySearch.setUserkey(member.getRec_key());
				ApiResponse apiResult = LibSearchAPI.nightloanreserve(librarySearch);
				if (apiResult.getStatus()) {
					res.setValid(true);
					res.setMessage("예약 되었습니다.");
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
	 * @author whalesoft YONGJU 2019. 11. 22.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/print.*"})
	public String print(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = new HashMap<String, Object>();

			result = PrivateLibSearchAPI.getBookInfo(librarySearch);
			
			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = PrivateLibSearchAPI.getListData(result);
				Map<String, Object> map = list.get(0);
				map.put("marc", private_marc_view(model, String.valueOf(map.get("REG_NO")), request));
				model.addAttribute("detail", map);
			}
		} else {
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
				map.put("marc", marc_view(model, String.valueOf(map.get("REG_NO")), request));
				model.addAttribute("detail", map);
			}
		}

		return basePath + "print_ajax";
	}

	@SuppressWarnings ("unchecked")
	@RequestMapping(value = {"/marcView.*"})
	public String marc_view(Model model, String regno, HttpServletRequest request) {
		List<Map<String, Object>> list = null;
		String content = "";
		Map<String, Object> marcView = LibSearchAPI.getMarc(regno);
		
		try {
			if (MapUtils.isNotEmpty(marcView) && marcView.containsKey("collection")) {
				if(marcView.get("collection") != null) {
					Map<String, Object> collection = (Map<String, Object>)marcView.get("collection");
					if(collection.get("record") != null) {
						Map<String, Object> record = (Map<String, Object>)collection.get("record");
						if(record.get("datafield") != null) {
							list = new ArrayList<Map<String, Object>>();
							list.addAll((List<Map<String, Object>>) record.get("datafield"));
						}
					}
				}

				if (CollectionUtils.isNotEmpty(list) && list.size() > 0) {
					// tag 521 추출
					for (Map<String, Object> map : list) {
						String tag = String.valueOf(map.get("tag"));

						if(tag.equals("521")) {
							ArrayList<String> subfieldList = new ArrayList<String>();
							Object test = map.get("subfield");
							if (test instanceof ArrayList) {
								List<Map<String, Object>> subfield = (List<Map<String, Object>>)map.get("subfield");
								for (Map<String, Object> stringObjectMap : subfield) {
									subfieldList.add(String.valueOf(stringObjectMap.get("content")));
								}
								content = StringUtils.join(subfieldList, ",");
								break;
							} else {
								Map<String, Object> subfield = (Map<String, Object>)map.get("subfield");
								content = String.valueOf(subfield.get("content"));
							}

							break;
						}
					}
				}

			}
		} catch (Exception e) {
			return content;
		}
		return content;
	}

	@SuppressWarnings ("unchecked")
	@RequestMapping(value = {"/private_marc_view.*"})
	public String private_marc_view(Model model, String regno, HttpServletRequest request) {
		List<Map<String, Object>> list = null;
		String content = "";
		Map<String, Object> marcView = PrivateLibSearchAPI.getMarc(regno);
		
		try {
			if (MapUtils.isNotEmpty(marcView) && marcView.containsKey("collection")) {
				if(marcView.get("collection") != null) {
					Map<String, Object> collection = (Map<String, Object>)marcView.get("collection");
					if(collection.get("record") != null) {
						Map<String, Object> record = (Map<String, Object>)collection.get("record");
						if(record.get("datafield") != null) {
							list = new ArrayList<Map<String, Object>>();
							list.addAll((List<Map<String, Object>>) record.get("datafield"));
						}
					}
				}

				if (CollectionUtils.isNotEmpty(list) && list.size() > 0) {
					// tag 521 추출
					for (Map<String, Object> map : list) {
						String tag = String.valueOf(map.get("tag"));

						if(tag.equals("521")) {
							ArrayList<String> subfieldList = new ArrayList<String>();
							Object test = map.get("subfield");
							if (test instanceof ArrayList) {
								List<Map<String, Object>> subfield = (List<Map<String, Object>>)map.get("subfield");
								for (Map<String, Object> stringObjectMap : subfield) {
									subfieldList.add(String.valueOf(stringObjectMap.get("content")));
								}
								content = StringUtils.join(subfieldList, ",");
								break;
							} else {
								Map<String, Object> subfield = (Map<String, Object>)map.get("subfield");
								content = String.valueOf(subfield.get("content"));
							}

							break;
						}
					}
				}

			}
		} catch (Exception e) {
			return content;
		}
		return content;
	}

}