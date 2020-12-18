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

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
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
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfig;
import kr.go.gbelib.app.cms.module.hopebookConfig.HopebookConfigService;
import kr.go.gbelib.app.cms.module.lasReqConfig.LasReqConfig;
import kr.go.gbelib.app.cms.module.lasReqConfig.LasReqConfigService;
import kr.go.gbelib.app.cms.module.newBookConfig.NewBookConfig;
import kr.go.gbelib.app.cms.module.newBookConfig.NewBookConfigService;
import kr.go.gbelib.app.cms.module.smsReception.SmsReception;
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
	private MenuService menuService;

	@Autowired
	private LasReqConfigService lasReqConfigService;

	@Autowired
	private HopebookConfigService hopebookConfigService;

	@Autowired
	private SmsReceptionService smsReceptionService;

	@Autowired
	private NewBookConfigService newBookConfigService;

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
			librarySearch.setManageCode(homepage.getManage_code());
		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( !StringUtils.isEmpty(homepage.getManage_code()) ) {
				libraryCodes.add(homepage.getManage_code());
			} else {
				for (Homepage home : normalHomepage) {
					libraryCodes.add(home.getManage_code());
				}
			}

			Homepage h1 = new Homepage();
			h1.setHomepage_id(homepage.getHomepage_id());
			h1.setHomepage_group(homepage.getHomepage_id());
			h1.setTemp_use_yn(null);
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h1);
			if (CollectionUtils.isNotEmpty(subHomepageList)) {
				for (Homepage homepage1 : subHomepageList) {
					if (StringUtils.isNotEmpty(homepage1.getManage_code())) {
						libraryCodes.add(homepage1.getManage_code());

					}
				}
			}

			librarySearch.setLibraryCodes(libraryCodes);
		}

 		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
    		Map<String, Object> result = new HashMap<String, Object>();
    		
    		// 자료실 제외 코드 : [두류]보존서고(1,2,3)
    		librarySearch.setNotShelfCode("AB08,AB09,AB10");

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
    				}
				}
    		}

    		model.addAttribute("bookSearch", list);
    		model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
		}

		Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("5", homepage.getManage_code());
		List<Map<String, Object>> mediaCodeList = LibSearchAPI.getListData(subLocaInfo);

		Map<String, Object> shelfInfo = LibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());
		List<Map<String, Object>> shelfInfoList = LibSearchAPI.getListData(shelfInfo);

		model.addAttribute("mediaCodeList", mediaCodeList);
		model.addAttribute("shelfCodeList", shelfInfoList);

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/indexAll.*"})
	public String indexAll(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		List<Homepage> normalHomepage = homepageService.getNormalHomepage();
		// 소장처 코드
		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("ALL");
			for (Homepage home : normalHomepage) {
				libraryCodes.add(home.getManage_code());
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
			Map<String, Object> result = new HashMap<String, Object>();
			
			// 자료실 제외 코드 : [두류]보존서고(1,2,3)
			librarySearch.setNotShelfCode("AB08,AB09,AB10");

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
					}
				}
			}

			model.addAttribute("bookSearch", list);
			model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "indexAll";
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

			//알라딘 API 결과 가져오기
			if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
				Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
				if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
					map.put("aladin", aladinData.get("item"));
				}
			}

			librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
			librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
			librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
			librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));

//			Map<String, Object> sanghoReqYn = LibSearchAPI.sanghoReqYn(librarySearch);
//			@SuppressWarnings ("unchecked")
//			Map<String, Object> sanghoReqYnResult = (Map<String, Object>) sanghoReqYn.get("ITEM");

			map.put("SANGHO_REQ_YN", "N");
//			if (sanghoReqYnResult.containsKey("RESULT") && String.valueOf(sanghoReqYnResult.get("RESULT")).equals("OK")) {
//				// 정상 신청가능
//				map.put("SANGHO_REQ_YN", "Y");
//			}

			//도서관정보나루 도서별 이용분석
			Map<String, Object> srchDtlList = LibSearchAPI.getSrchDtlList(librarySearch.getIsbn());
			if (srchDtlList != null && !srchDtlList.isEmpty()) {
				@SuppressWarnings ("unchecked")
				Map<String, Object> data4Response = (Map<String, Object>) srchDtlList.get("response");
				try {
//					log.debug("@@@@@@@@@@@@@@@@@ data4Response.get(\"dfsdf\"): " + data4Response.get("sdfsdf"));
//					log.debug("@@@@@@@@@@@@@@@@@ data4Response.get(\"error\"): " + data4Response.get("error"));
					if(data4Response.get("error") == null) {
						//함께 대출된 도서 - recBooks
						@SuppressWarnings ("unchecked")
						Map<String, Object> data4loanInfo =  (Map<String, Object>) data4Response.get("loanInfo");

						@SuppressWarnings ("unchecked")
						Map<String, Object> data4TotalInfo =  (Map<String, Object>) data4loanInfo.get("Total");

						int data4LoanCnt =  Integer.parseInt(String.valueOf(data4TotalInfo.get("loanCnt")));
						model.addAttribute("data4LoanCnt", data4LoanCnt);


						@SuppressWarnings ("unchecked")
						Map<String, Object> data4ageResult =  (Map<String, Object>) data4loanInfo.get("ageResult");
						@SuppressWarnings ("unchecked")
						List<Map<String, Object>> data4ageList =  (List<Map<String, Object>>) data4ageResult.get("age");
						//연령별
						model.addAttribute("data4ageList", data4ageList);
					}
				}catch ( Exception e ) {
//					log.error("@@@@@@@@@@@@@@@@ srchDtlList : " + srchDtlList);
//					log.error(e.getMessage());
				}

				model.addAttribute("srchDtlList", srchDtlList);
			}

			//도서관정보나루 키워드
			Map<String, Object> keywordList = LibSearchAPI.getKeywordList(librarySearch.getIsbn());
			if (keywordList != null && !keywordList.isEmpty()) {
				@SuppressWarnings ("unchecked")
				Map<String, Object> data4Response = (Map<String, Object>) keywordList.get("response");
				try {
//					log.debug("@@@@@@@@@@@@@@@@@ data4Response.get(\"error\"): " + data4Response.get("error"));
					if(data4Response.get("error") == null) {
						//키워드
						@SuppressWarnings ("unchecked")
						Map<String, Object> data4items =  (Map<String, Object>) data4Response.get("items");
						@SuppressWarnings ("unchecked")
						List<Map<String, Object>> data4ItemList =  (List<Map<String, Object>>) data4items.get("item");
						List<JSONObject> jsonList = new ArrayList<JSONObject>();
						for (Map<String, Object> map4 : data4ItemList) {
							JSONObject jo = new JSONObject();
							String text = String.valueOf(map4.get("word")).trim();

							jo.put("text", text);

							map4.put("text", "\""+text+"\"");
							map4.remove("word");

							String weight = String.valueOf(map4.get("weight")).trim();
							map4.put("weight", weight);

							jo.put("weight", Double.parseDouble(weight));

							jsonList.add(jo);
						}

						model.addAttribute("data4ItemList", data4ItemList);
						model.addAttribute("data4ItemList", jsonList);
					}
				}catch ( Exception e ) {
//					log.error("@@@@@@@@@@@@@@@@ keywordList : " + keywordList);
//					log.error(e.getMessage());
				}

				model.addAttribute("keywordList", keywordList);
			}

			//도서관정보나루 추천도서
			Map<String, Object> recommandList = LibSearchAPI.getRecommandList(librarySearch.getIsbn());
			if (recommandList != null && !recommandList.isEmpty()) {
				@SuppressWarnings ("unchecked")
				Map<String, Object> data4Response = (Map<String, Object>) recommandList.get("response");
				try {
//					log.debug("@@@@@@@@@@@@@@@@@ data4Response.get(\"error\"): " + data4Response.get("error"));
					if(data4Response.get("error") == null) {
						@SuppressWarnings ("unchecked")
						Map<String, Object> docs =  (Map<String, Object>) data4Response.get("docs");
						@SuppressWarnings ("unchecked")
						List<Map<String, Object>> data4recommandList =  (List<Map<String, Object>>) docs.get("book");
						model.addAttribute("data4recommandList", data4recommandList);
					}
				}catch ( Exception e ) {
//					e.printStackTrace();
//					log.error("@@@@@@@@@@@@@@@@ recommandList : " + recommandList);
//					log.error(e.getMessage());
				}

				model.addAttribute("recommandList", recommandList);
			}

			//도서관정보나루 도서별 이용분석
//			Map<String, Object> usageAnalysisList = LibSearchAPI.getRecommandList(librarySearch.getIsbn());
//			if (usageAnalysisList != null && !usageAnalysisList.isEmpty()) {
//				@SuppressWarnings ("unchecked")
//				Map<String, Object> data4Response = (Map<String, Object>) usageAnalysisList.get("response");
//				try {
//					//함께 대출된 도서 - recBooks
//					@SuppressWarnings ("unchecked")
//					Map<String, Object> docs =  (Map<String, Object>) data4Response.get("docs");
//					@SuppressWarnings ("unchecked")
//					List<Map<String, Object>> data4recommandList =  (List<Map<String, Object>>) docs.get("book");
//
////					for ( Map<String, Object> map2 : data4recBooksList ) {
////						Map<String, Object> data4Map = new HashMap<String, Object>();
////						data4Map.put("ISBN", map2.get("isbn13"));
////						Map<String, Object> data4aladinDetail = LibSearchAPI.getAladinDetail(data4Map);
////						map2.put("aladin", data4aladinDetail.get("item"));
////					}
//					//함께 빌려본도서.
//					model.addAttribute("data4recommandList", data4recommandList);
//
//
//				}catch ( Exception e ) {
//					log.error(e.getMessage());
//				}
//
//				try {
//					//연령별선호도 - loanGrps
//					@SuppressWarnings ("unchecked")
//					Map<String, Object> data4loanGrps =  (Map<String, Object>) data4Response.get("loanGrps");
//					@SuppressWarnings ("unchecked")
//					List<Map<String, Object>> data4loanGrpsList =  (List<Map<String, Object>>) data4loanGrps.get("loanGrp");
//					//연령별 선호도
//					model.addAttribute("data4loanGrpsList", data4loanGrpsList);
//				}catch ( Exception e ) {
//					log.error(e.getMessage());
//				}
//
//
//				model.addAttribute("usageAnalysisList", usageAnalysisList);
//			}

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

		List<Homepage> normalHomepage = homepageService.getNormalHomepage();
		// 소장처 코드
		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
			librarySearch.setManageCode(homepage.getManage_code());
		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( !StringUtils.isEmpty(homepage.getManage_code()) ) {
				libraryCodes.add(homepage.getManage_code());
			} else {
				for (Homepage home : normalHomepage) {
					libraryCodes.add(home.getManage_code());
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
    			//알라딘 API 결과 가져오기
    			for (Map<String, Object> map : list) {
    				if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
    					Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
    					if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
    						map.put("aladin", aladinData.get("item"));
    					}
    				}
				}
    		}

    		model.addAttribute("bookSearch", list);
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

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
		Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getManage_code());

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
			librarySearch.setManageCode(homepage.getManage_code());
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
			librarySearch.setManageCode(homepage.getManage_code());
		}


		Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("19", librarySearch.getManageCode());
		if (!"ERROR".equals(subLocaInfo.get("RESULT_INFO"))) {
			List<Map<String, Object>> shelfList = LibSearchAPI.getListData(subLocaInfo, "LIST_DATA");

			List<String> code_arr = newBookConfigService.getShelfCodeList(new NewBookConfig(homepage.getHomepage_id()));
			for (Map<String, Object> map : shelfList) {
				if(code_arr == null) {
					break;
				}

				if(code_arr.contains(map.get("CODE"))) {
					map.put("CHECKED", true);
				}
			}

			model.addAttribute("shelfList", shelfList);
		}


		if (StringUtils.isEmpty(librarySearch.getShelfCode())) {
			librarySearch.setShelfCode("ALL");
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
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
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
			librarySearch.setManageCode(homepage.getManage_code());
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
					//알라딘 API 결과 가져오기
					if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
						Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
						if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
							map.put("aladin", aladinData.get("item"));
						}
					}
				}
			}
		}

		model.addAttribute("bestBookList", list);

		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "bestBook/index";
	}
	
	@RequestMapping(value = {"/publicPopularBook/index.*"})
	public String publicPopularBook(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(librarySearch.getStartDt() == null || librarySearch.getEndDt() == null) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			int beforeDays = -7;
			librarySearch.setStartDt(sf.format(DateUtils.addDays(new Date(), beforeDays)));
			librarySearch.setEndDt(sf.format(new Date()));
		}
		if(librarySearch.getGender() == null) {
			librarySearch.setGender("");
		}
		if(librarySearch.getAge() == null) {
			String[] age= {""};
			librarySearch.setAge(age);
		}
		if(librarySearch.getKdc() == null) {
			String[] kdc = {""};
			librarySearch.setKdc(kdc);
		}
		if(librarySearch.getRegion() == null) {
			String[] region = {""};
			librarySearch.setRegion(region);
		}
		if(librarySearch.getLibCode() == null) {
			librarySearch.setLibCode("");
		}
		
		Map<String, Object> result = LibSearchAPI.getPopularBookList(librarySearch);
		Map<String, Object> resultMap = null;
		List<Map<String, Object>> list = null;
		
		if(result != null) {
			resultMap = (Map<String, Object>)result.get("response");
		}
		if(resultMap != null) {
			resultMap = (Map<String, Object>)resultMap.get("docs");
		}
		if(result != null && !result.isEmpty() && resultMap != null) {
			list = (ArrayList<Map<String, Object>>)resultMap.get("doc");
		}
		
		List<Integer> countList = new ArrayList<Integer>();
		if (list != null) {
			for(int i = 0; i < list.size(); i++) {
				countList.add(i + 1);
			}

		}
		model.addAttribute("popularBookList", list);
		model.addAttribute("countList", countList);
		model.addAttribute("librarySearch", librarySearch);
		return String.format(basePath, homepage.getFolder()) + "publicPopularBook/index";
	}
	
	@RequestMapping(value = {"/publicPopularBook/detail.*"})
	public String detail(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		Map<String, Object> result = LibSearchAPI.getPopularBook(librarySearch);
		Map<String, Object> resultMap = null;
		Map<String, Object> detailMap = null;
		Map<String, Object> loanInfoMap = null;
		if(result != null) {
			resultMap = (Map<String, Object>)result.get("response");
		}
		if(resultMap != null) {
			loanInfoMap = (Map<String, Object>)resultMap.get("loanInfo");
			if(loanInfoMap != null) {
				loanInfoMap = (Map<String, Object>)loanInfoMap.get("Total");
			}
			detailMap = (Map<String, Object>)resultMap.get("detail");
			if(detailMap != null) {
				detailMap = (Map<String, Object>)detailMap.get("book");
			}
		}
		
		model.addAttribute("loanInfo", loanInfoMap);
		model.addAttribute("detailBook", detailMap);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "publicPopularBook/detail";
	}


	/**
	 * 희망도서 신청내역
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

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
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

		return String.format(basePath, homepage.getFolder()) + "hope/index";
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
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (!StringUtils.equals(member.getMember_class(), "0")) {
			service.alertMessage("희망도서 신청 가능한 회원이 아닙니다.", request, response);
			return null;
		}

		String homepageId = homepage.getHomepage_id();
		if (StringUtils.isNotEmpty(librarySearch.getHomepage_id())) {
			homepageId = librarySearch.getHomepage_id();
		}
		HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepageId);
		if(hopebookConfig != null) {
			String hope_msg = hopebookConfig.getRes_msg();
			hope_msg = hope_msg.replaceAll("\r\n", "\\\\n");
			service.alertMessage(hope_msg, request, response);
			return null;
		}

//		if ( !homepage.getHomepage_code().contains(member.getLoca())) {
//			service.alertMessage("희망도서 신청은 소속도서관에서만 가능합니다.", request, response);
//			return null;
//		}

		Homepage h = new Homepage();
		h.setHomepage_id(homepage.getHomepage_id());
		h.setHomepage_group(homepage.getHomepage_id());
		h.setTemp_use_yn(null);
		List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);

		model.addAttribute("subHomepageList", subHomepageList);
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
						bookSerach.setManageCode(librarySearch.getManageCode());
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

	/**
	 * 희망도서 신청/취소
	 * @author whalesoft YONGJU 2019. 12. 3.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {

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

				Homepage homepage = getSessionHomepage(request);
				String homepageId = homepage.getHomepage_id();
				if (StringUtils.isNotEmpty(librarySearch.getHomepage_id())) {
					homepageId = librarySearch.getHomepage_id();
				}
				HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepageId);
				if(hopebookConfig != null) {
					res.setValid(false);
					res.setMessage(hopebookConfig.getRes_msg());
					return res;
				}

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
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
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

				// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
				LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0001");
				if(lasReqConfig != null) {
					res.setValid(false);
					res.setMessage(lasReqConfig.getRes_msg());
					return res;
				}

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
	@RequestMapping(value = {"/loan/index.*", "/loan/history.*"})
	public String myLoan(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		if (request.getRequestURI().endsWith("/loan/history.do")) {

			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
				librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
			}
			if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
				librarySearch.setSearch_end_date(sdf.format(new Date()));
			}

			librarySearch.setUserkey(member.getRec_key());
			Map<String, Object> result = LibSearchAPI.getBookLoanHistory(librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getListData(result);
			}

			model.addAttribute("loanList", list);
			return String.format(basePath, homepage.getFolder()) + "loan/history";

		} else {

			Map<String, Object> result = LibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode());
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
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

		if (!result.hasErrors()) {

			if (librarySearch.getEditMode().equals("RENEW")) {

				// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
				LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0002");
				if(lasReqConfig != null) {
					res.setValid(false);
					res.setMessage(lasReqConfig.getRes_msg());
					return res;
				}

				ApiResponse apiResult = LibSearchAPI.renewLoan(librarySearch);
				if (apiResult.getStatus()) {
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
	 * 상호대차 신청 내역
	 * @author YONGJU 2018. 4. 3.
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = {"/sangho/index.*"}, method = RequestMethod.GET)
	public String sanghoHistory(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청내역 조회가 불가능합니다", request, response);
			return null;
		}

		model.addAttribute("librarySearch", librarySearch);

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());

		Map<String, Object> sanghoHistory = LibSearchAPI.getSanghoHistory(librarySearch);
		List<Map<String, Object>> returnList = LibSearchAPI.getSanghoListData(sanghoHistory);

		if (returnList != null && !returnList.isEmpty() && !returnList.get(0).containsKey("ERROR")) {
			int count = LibSearchAPI.getSanghoSearchCount(sanghoHistory);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			model.addAttribute("librarySearch", librarySearch);
			model.addAttribute("sanghoHistory", returnList);
		}

		return String.format(basePath, homepage.getFolder()) + "sangho/index";
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
	@RequestMapping (value = {"/sangho/history.*"}, method = RequestMethod.GET)
	public String sanghoUsedHistory(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
			service.alertMessage("책이음회원이 아니므로 상호대차 이용내역 조회가 불가능합니다", request, response);
			return null;
		}

		model.addAttribute("librarySearch", librarySearch);

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());

		Map<String, Object> sanghoHistory = LibSearchAPI.getSanghoUsedHistory(librarySearch);
		List<Map<String, Object>> returnList = LibSearchAPI.getSanghoListData(sanghoHistory);

		if (returnList != null && !returnList.isEmpty() && !returnList.get(0).containsKey("ERROR")) {
			int count = LibSearchAPI.getSanghoSearchCount(sanghoHistory);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			model.addAttribute("librarySearch", librarySearch);
			model.addAttribute("sanghoHistory", returnList);
		}

		return String.format(basePath, homepage.getFolder()) + "sangho/history";
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
	public String sanghoForm(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("librarySearch", librarySearch);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if (!StringUtils.equals(member.getKl_member_yn(), "Y")) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청이 불가능합니다", request, response);
			return null;
		}

		/**/
		{
			if (librarySearch.getBooktype() == null) {
				librarySearch.setBooktype("BOOK");
			}

			Map<String, Object> bookResult = LibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;
			int count = LibSearchAPI.getSearchCount(bookResult);

			if (count > 0) {
				list = LibSearchAPI.getListData(bookResult);
				Map<String, Object> map = list.get(0);

				librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
				librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
				librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
				librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));

				Map<String, Object> sanghoReqYn = LibSearchAPI.sanghoReqYn(librarySearch);
				@SuppressWarnings ("unchecked")
				Map<String, Object> sanghoReqYnResult = (Map<String, Object>) sanghoReqYn.get("ITEM");

				if (sanghoReqYnResult.containsKey("RESULT") && String.valueOf(sanghoReqYnResult.get("RESULT")).equals("OK")) {
					// 정상 신청가능
				} else {
					if (sanghoReqYnResult.containsKey("ERROR")) {
						service.alertMessage("해당 자료는 상호대차 신청이 불가능합니다", request, response);
						return null;
					}
				}
			}
		}
		/**/

		String overdueCnt = member.getOverdue_cnt();
		try {
			if (Integer.parseInt(overdueCnt) > 0) {
				service.alertMessage("현재 연체도서가 존재하여 상호대차 신청이 불가능합니다. 연체도서를 반납해주세요.", request, response);
				return null;
			}
		} catch (NumberFormatException e) {
		}

		String loanStopDate = member.getLoan_stop_date();
		if (StringUtils.isNotEmpty(loanStopDate) && StringUtils.length(loanStopDate) >= 10) {
			service.alertMessage("현재 "+loanStopDate+"까지 대출정지상태입니다. 상호대차 신청은 이후에 가능합니다.", request, response);
			return null;
		}

		librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
		Map<String, Object> sanghoHistory = LibSearchAPI.getSanghoHistory(librarySearch);
		List<Map<String, Object>> returnList = LibSearchAPI.getSanghoListData(sanghoHistory);

		if (CollectionUtils.isNotEmpty(returnList) && returnList.size() >= 3) {
			service.alertMessage("상호대차 신청권수는 3권까지입니다.", request, response);
			return null;
		}

		Map<String, Object> result = new HashMap<String, Object>();

		if ( librarySearch.getBooktype() == null ) {
			librarySearch.setBooktype("BOOK");
		}

//		if ( librarySearch.getBooktype().equals("BOOK") ) {
//			result = LibSearchAPI.getBookDetail(librarySearch);
//		} else {
//			result = LibSearchAPI.getNonBookDetail(librarySearch);
//		}

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
//			Map<String, Object> aladinDetail =  aladinApiService.getAladinApiOne(String.valueOf(map.get("ISBN")), homepage.getContext_path());
//			if (aladinDetail != null && !aladinDetail.isEmpty() && aladinDetail.containsKey("item")) {
//				list.get(0).put("aladinDetail", aladinDetail.get("item"));
//			}
			model.addAttribute("detail", list.get(0));
		}

		return String.format(basePath, homepage.getFolder()) + "sangho/form";
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

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			result.reject("로그인 후 이용가능합니다.");
		}

		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
			result.reject("책이음회원이 아니므로 상호대차 신청이 불가능합니다");
		}

		if (!result.hasErrors()) {

			Homepage homepage = getSessionHomepage(request);
			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage.getHomepage_id());
			smsReception.setWork_code("0001");	// 상호대차:0001, 무인대출:0002, 야간대출:0003
			List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			if (StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {
				Map<String, Object> sanghoReqCancel = LibSearchAPI.sanghoReqCancel(librarySearch);
				@SuppressWarnings ("unchecked")
				Map<String, Object> sanghoResult = (Map<String, Object>) sanghoReqCancel.get("ITEM");

				if (sanghoResult.containsKey("RESULT")) {
					if (String.valueOf(sanghoResult.get("RESULT")).equals("OK")) {
						res.setValid(true);
						res.setMessage("취소되었습니다.");
					}
				} else {
					if (sanghoResult.containsKey("ERROR")) {
						res.setValid(true);
						res.setMessage(String.valueOf(sanghoResult.get("ERROR")));
					}
				}
			} else {
				Map<String, Object> bookResult = new HashMap<String, Object>();

				if (librarySearch.getBooktype() == null) {
					librarySearch.setBooktype("BOOK");
				}

				// if ( librarySearch.getBooktype().equals("BOOK") ) {
				// bookResult = LibSearchAPI.getBookDetail(librarySearch);
				// } else {
				// bookResult = LibSearchAPI.getNonBookDetail(librarySearch);
				// }

				bookResult = LibSearchAPI.getBookInfo(librarySearch);

				List<Map<String, Object>> list = null;

				int count = LibSearchAPI.getSearchCount(bookResult);

				if (count > 0) {

					list = LibSearchAPI.getListData(bookResult);
					Map<String, Object> map = list.get(0);

					librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
					librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
					librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
					librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));
					// librarySearch.setUselibcode(String.valueOf(map.get("")));
					librarySearch.setBookkey(String.valueOf(map.get("BOOK_KEY")));

					Map<String, Object> sanghoReq = LibSearchAPI.sanghoReq(librarySearch);
					@SuppressWarnings ("unchecked")
					Map<String, Object> sanghoResult = (Map<String, Object>) sanghoReq.get("ITEM");

					if (sanghoResult.containsKey("RESULT")) {
						if (String.valueOf(sanghoResult.get("RESULT")).equals("OK")) {
							res.setValid(true);
							res.setMessage("신청되었습니다.");
						}

						// 신청자에게 SMS 전송
						String message = "상호대차 신청이 완료 되었습니다.[" + librarySearch.getTitle() + "]";
//						if (isSmsReceive("WEBID", getSessionMemberId(request))) {
//							PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), message, homepage.getHomepage_send_tell(), true);
//						}

						// 관리자에게 SMS 전송
						String adminMessage = "상호대차 신청건이 발생하였습니다. 수령:"+String.valueOf(map.get("SHELF_LOC_NAME"))+" 도서명:"+librarySearch.getTitle();
						for(SmsReception one : receptionsList) {
							//TODO 테스트 후 sysout 삭제 및 주석 취소
							System.out.println("@@@@@@@@@@ sms homepage : " + homepage.getHomepage_name() + "/" + homepage.getHomepage_id());
							System.out.println("@@@@@@@@@@ sms reception : " + one.getReception_phone());
							System.out.println("@@@@@@@@@@ sms homepage tel : " + homepage.getHomepage_send_tell());
							System.out.println("@@@@@@@@@@ sms message : " + adminMessage);
//							PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), adminMessage, homepage.getHomepage_send_tell(), true);
						}
					} else {
						if (sanghoResult.containsKey("ERROR")) {
							res.setValid(true);
							res.setMessage(String.valueOf(sanghoResult.get("ERROR")));
						}
					}
				} else {
					res.setValid(true);
					res.setMessage("잘못된 접근입니다. 다시 신청하여 주시기 바랍니다.");
				}

			}

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
	public String unmannedForm(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}

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

		return String.format(basePath, homepage.getFolder()) + "unmanned/form";
	}

	/**
	 * 무인대출예약
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/unmanned/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUnmanned(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
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

			Homepage homepage = getSessionHomepage(request);
			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage.getHomepage_id());
			smsReception.setWork_code("0002");	// 상호대차:0001, 무인대출:0002, 야간대출:0003
			List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
			LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0004");
			if(lasReqConfig != null) {
				res.setValid(false);
				res.setMessage(lasReqConfig.getRes_msg());
				return res;
			}

			librarySearch.setUserkey(member.getRec_key());



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

				// 신청자에게 SMS 전송
				String message = "무인대출 신청이 완료 되었습니다.[" + librarySearch.getTitle() + "]";
//				if (isSmsReceive("WEBID", getSessionMemberId(request))) {
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), message, homepage.getHomepage_send_tell(), true);
//				}

				// 관리자에게 SMS 전송
				String adminMessage = "무인대출 신청건이 발생하였습니다. 수령: 도서명:"+librarySearch.getTitle();
				for(SmsReception one : receptionsList) {
					//TODO 테스트 후 sysout 삭제 및 주석 취소
					System.out.println("@@@@@@@@@@ sms homepage : " + homepage.getHomepage_name() + "/" + homepage.getHomepage_id());
					System.out.println("@@@@@@@@@@ sms reception : " + one.getReception_phone());
					System.out.println("@@@@@@@@@@ sms homepage tel : " + homepage.getHomepage_send_tell());
					System.out.println("@@@@@@@@@@ sms message : " + adminMessage);
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), adminMessage, homepage.getHomepage_send_tell(), true);
				}
			} else {
				res.setValid(false);
				res.setMessage(apiResult.getMessage());
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
	public String nightForm(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}

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

		return String.format(basePath, homepage.getFolder()) + "night/form";
	}

	/**
	 * 야간대출예약
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/night/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveNight(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
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

			Homepage homepage = getSessionHomepage(request);
			SmsReception smsReception = new SmsReception();
			smsReception.setHomepage_id(homepage.getHomepage_id());
			smsReception.setWork_code("0003");	// 상호대차:0001, 무인대출:0002, 야간대출:0003
			List<SmsReception> receptionsList =  smsReceptionService.getSmsReceptionMembers(smsReception);

			// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
			LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0003");
			if(lasReqConfig != null) {
				res.setValid(false);
				res.setMessage(lasReqConfig.getRes_msg());
				return res;
			}

//			Map<String, Object> nightLoanReserveCnt = LibSearchAPI.getNightLoanReserveCnt(librarySearch, "DATA");
//			String nightLoanResult = String.valueOf(nightLoanReserveCnt.get("RESULT_INFO"));
//			if (StringUtils.equals(nightLoanResult, "SUCCESS")) {
//				String limit_cnt = String.valueOf(nightLoanReserveCnt.get("TOTAL"));
//				try {
//					int limit_count = Integer.parseInt(limit_cnt);
//					if (limit_count >= 250) {
//						res.setValid(false);
//						res.setMessage("해당 도서관의 금일 워킹스루 예약가능 인원이 모두 찼습니다. 내일 다시 신청해주세요");
//						return res;
//					}
//				} catch (Exception e) {
//					res.setValid(false);
//					res.setMessage("해당 도서관의 금일 워킹스루 예약가능 인원이 모두 찼습니다. 에러코드 060");
//					return res;
//				}
//			} else {
//				res.setValid(false);
//				res.setMessage(String.valueOf(nightLoanReserveCnt.get("RESULT_MESSAGE")));
//				return res;
//			}



			librarySearch.setUserkey(member.getRec_key());
			ApiResponse apiResult = LibSearchAPI.nightloanreserve(librarySearch);
			if (apiResult.getStatus()) {
				res.setValid(true);
				res.setMessage("예약 되었습니다.");

				// 신청자에게 SMS 전송
//				String message = "야간대출 신청이 완료 되었습니다.[" + librarySearch.getTitle() + "]";
//				if (isSmsReceive("WEBID", getSessionMemberId(request))) {
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getMobile_no(), message, homepage.getHomepage_send_tell(), true);
//				}

				// 관리자에게 SMS 전송
//				String adminMessage = "야간대출 신청건이 발생하였습니다. 수령: 도서명:"+librarySearch.getTitle();
//				for(SmsReception one : receptionsList) {
//					//TODO 테스트 후 sysout 삭제 및 주석 취소
//					System.out.println("@@@@@@@@@@ sms homepage : " + homepage.getHomepage_name() + "/" + homepage.getHomepage_id());
//					System.out.println("@@@@@@@@@@ sms reception : " + one.getReception_phone());
//					System.out.println("@@@@@@@@@@ sms homepage tel : " + homepage.getHomepage_send_tell());
//					System.out.println("@@@@@@@@@@ sms message : " + adminMessage);
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, one.getReception_phone(), adminMessage, homepage.getHomepage_send_tell(), true);
//				}
			} else {
				res.setValid(false);
				res.setMessage(apiResult.getMessage());
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
		LibSearchAPI.getMarc(librarySearch.getRegNo());
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