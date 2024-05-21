package kr.go.gbelib.app.intro.search;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.Set;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.gbelib.app.cms.module.drone.deviceSetting.DeviceSetting;
import kr.go.gbelib.app.cms.module.drone.deviceSetting.DeviceSettingService;
import kr.go.gbelib.app.cms.module.drone.loanRequest.LoanRequest;
import kr.go.gbelib.app.cms.module.drone.loanRequest.LoanRequestService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
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
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLibService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice.NearbyLibDevice;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice.NearbyLibDeviceService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker.NearbyLibLockerService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManageService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig.NearbyLibReserveConfig;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig.NearbyLibReserveConfigService;
import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibrary;
import kr.go.gbelib.app.cms.module.newBookConfig.NewBookConfig;
import kr.go.gbelib.app.cms.module.newBookConfig.NewBookConfigService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PrivateLibSearchAPI;

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
	private HopebookConfigService hopebookConfigService;

	@Autowired
	private NewBookConfigService newBookConfigService;
	
	@Autowired
	private UntactLockerSettingService untactLockerSettingService;

	@Autowired
	private DeviceSettingService deviceSettingService;

	@Autowired
	private LoanRequestService loanRequestService;
	
	@Autowired
	private NearbyLibDeviceService neighborhoodLibraryDeviceService;
	
	@Autowired
	private NearbyLibService neighborhoodLibraryService; 
	
	@Autowired
	private NearbyLibReserveConfigService neighborhoodLibraryReserveConfigService;
	
	@Autowired
	private NearbyLibLockerService neighborhoodLibraryLockerService;
	
	@Autowired
	private NearbyLibManageService nearbyLibManageService; 
	
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
		
		if("h90".equals(homepage.getHomepage_id())){
			if ( librarySearch.getLibraryCodes() == null ) {
				List<String> libraryCodes = new ArrayList<String>();
				libraryCodes.add("AA");
				libraryCodes.add("AH");
				libraryCodes.add("CA");
				libraryCodes.add("CB");
				libraryCodes.add("BA");
				librarySearch.setLibraryCodes(libraryCodes);
			}
		} else {
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
		}
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> shelfInfo = PrivateLibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());
			List<Map<String, Object>> shelfInfoList = PrivateLibSearchAPI.getListData(shelfInfo);
			
			if(!(StringUtils.isNotEmpty(librarySearch.getShelfCode())) && "h45".equals(homepage.getHomepage_id())) {
				List<String> shelfCodes = new ArrayList<String>();
				List<Map<String, Object>> libraryCodes = PrivateLibSearchAPI.getListData(shelfInfo);
				
				for(int i=0; i < libraryCodes.size(); i++) {
					shelfCodes.add(i, (String) libraryCodes.get(i).get("CODE"));
				}
				
				librarySearch.setShelfCodes(shelfCodes);
			}

	 		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
	    		Map<String, Object> result = new HashMap<String, Object>();
	    		
	    		// 자료실 제외 코드 : [두류]보존서고(1,2,3)
	    		librarySearch.setNotShelfCode("AB08,AB09,AB10");

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
						map.put("droneLoanYn", loanRequestService.getBookLoanYn(LoanRequest.ofManageCodeAndMemberIdAndRegNo(homepage.getManage_code(), "" , (String) map.get("REG_NO"))));
	    				map.put("marc", private_marc_view(model, String.valueOf(map.get("REG_NO")), request));
					}
	    		}

	    		model.addAttribute("bookSearch", list);
	    		model.addAttribute("facetGroup", PrivateLibSearchAPI.getFacetGroup(result));
			}

			Map<String, Object> subLocaInfo = PrivateLibSearchAPI.getSubLocaInfo("5", homepage.getManage_code());
			List<Map<String, Object>> mediaCodeList = PrivateLibSearchAPI.getListData(subLocaInfo);

			model.addAttribute("mediaCodeList", mediaCodeList);
			model.addAttribute("shelfCodeList", shelfInfoList);
		} else {
			try {
				String manage_code = homepage.getManage_code();

				if("BL".equals(librarySearch.getManageCode()) && librarySearch.getMenu_idx() == 131){
					manage_code = "BQ";
				}

				Map<String, Object> shelfInfo = LibSearchAPI.getSubLocaInfo("19", manage_code);

				if (!"h90".equals(homepage.getHomepage_id())) {
					List<Map<String, Object>> shelfInfoList = getShelfInfoList(shelfInfo);
					model.addAttribute("shelfCodeList", shelfInfoList);
				}

				if (!(StringUtils.isNotEmpty(librarySearch.getShelfCode())) && "h45".equals(homepage.getHomepage_id())) {
					List<String> shelfCodes = new ArrayList<String>();
					List<Map<String, Object>> libraryCodes = LibSearchAPI.getListData(shelfInfo);

					for (int i = 0; i < libraryCodes.size(); i++) {
						shelfCodes.add(i, (String) libraryCodes.get(i).get("CODE"));
					}

					librarySearch.setShelfCodes(shelfCodes);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

	 		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
	    		Map<String, Object> result = new HashMap<String, Object>();
				librarySearch.setHomepage_id(homepage.getHomepage_id());
	    		// 자료실 제외 코드 : [두류]보존서고(1,2,3)
	    		librarySearch.setNotShelfCode(NotShelfCodes.getNotShelfCode());
	    		
	    		if("h90".equals(homepage.getHomepage_id())) {
	    			librarySearch.setNotShelfCode("AA02,AA03,AA05,AA07,AA09,AA10,AA11,AA14,AA15,AA16,AA17,AA18,AA19,AA20,AA21,AA22,AA23,AA29,AA30,AA31,AA36,AA37,AA39,AA40,AA41,AA51,AA52,AA53,AA56,AA58,AA59,AA60,AA62,AA65,AA66,AH14,AH16,AH17,AH26,AH33,AH60,BA08,AA51,CA08,CB08,CB10,BA23,BA22,CB11,FM05,GU04,FP05,GX05,GR06,GW03");
	    		}

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
						map.put("droneLoanYn", loanRequestService.getBookLoanYn(LoanRequest.ofManageCodeAndMemberIdAndRegNo(homepage.getManage_code(), "" , (String) map.get("REG_NO"))));
	    				map.put("marc", marc_view(model, String.valueOf(map.get("REG_NO")), request));
					}
	    		}

	    		model.addAttribute("bookSearch", list);
	    		model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
			}

			String manage_code = homepage.getManage_code();

			if("BL".equals(librarySearch.getManageCode()) && librarySearch.getMenu_idx() == 131){
				manage_code = "BQ";
			}

			Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("5", manage_code);
			List<Map<String, Object>> mediaCodeList = LibSearchAPI.getListData(subLocaInfo);

			model.addAttribute("mediaCodeList", mediaCodeList);
		}


		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	private List<Map<String, Object>> getShelfInfoList(Map<String, Object> shelfInfo) {
		List<Map<String, Object>> shelfInfoList = LibSearchAPI.getShelfInfoList(shelfInfo);
		String[] noUseShelfCodes = {"BW06", "BW08", "BW11", "BW12", "BW16", "BW18", "BW19", "BW20", "BW21", "BW22", "BW23", "BW24", "BW25", "BW26", "AB38", "CB17", "FM05"};
		shelfInfoList.removeIf(map -> Arrays.asList(noUseShelfCodes)
											.contains(map.get("CODE")));
		return shelfInfoList;
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
				if (StringUtils.isNotEmpty(home.getManage_code())) {
					libraryCodes.add(home.getManage_code());
				}
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
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
				}
			}

			model.addAttribute("bookSearch", list);
			model.addAttribute("facetGroup", LibSearchAPI.getFacetGroup(result));
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "indexAll";
	}
	
	@RequestMapping(value = {"/index_All.*"})
	public String index_All(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		// 소장처 코드
		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			libraryCodes.add("ALL");
			libraryCodes.add("NA");
			libraryCodes.add("NB");
			libraryCodes.add("NC");
			libraryCodes.add("ND");
			libraryCodes.add("NE");
			libraryCodes.add("NF");
			libraryCodes.add("NG");
			libraryCodes.add("NH");
			libraryCodes.add("NJ");
			libraryCodes.add("NK");
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
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
				}
			}

			model.addAttribute("bookSearch", list);
			model.addAttribute("facetGroup", PrivateLibSearchAPI.getFacetGroup(result));
		}

		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "index_All";
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
	public String detail(@PathVariable("homepagePath") String homepagePath, Model model, UntactLockerSetting untactLockerSetting, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(librarySearch.getPrivateLibraryYn(homepage) || "Y".equals(librarySearch.getPrivateYn())) {
			result = PrivateLibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);
			
			untactLockerSetting.setHomepage_id(homepage.getHomepage_id());
			
			model.addAttribute("untactLockerSetting", untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()));

			if ( count > 0 ) {
				list = PrivateLibSearchAPI.getListData(result);
				Map<String, Object> map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
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

				//도서관정보나루 도서별 이용분석
				Map<String, Object> srchDtlList = PrivateLibSearchAPI.getSrchDtlList(librarySearch.getIsbn());
				if (srchDtlList != null && !srchDtlList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) srchDtlList.get("response");
					try {
						if(data4Response.get("error") == null) {
							//함께 대출된 도서 - recBooks
							@SuppressWarnings ("unchecked")
							Map<String, Object> data4loanInfo = (Map<String, Object>) data4Response.get("loanInfo");

							@SuppressWarnings ("unchecked")
							Map<String, Object> data4TotalInfo = (Map<String, Object>) data4loanInfo.get("Total");

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
						e.printStackTrace();
					}
					model.addAttribute("srchDtlList", srchDtlList);
				}

				//도서관정보나루 키워드
				Map<String, Object> keywordList = PrivateLibSearchAPI.getKeywordList(librarySearch.getIsbn());
				if (keywordList != null && !keywordList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) keywordList.get("response");
					try {
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
						e.printStackTrace();
					}

					model.addAttribute("keywordList", keywordList);
				}

				//도서관정보나루 추천도서
				Map<String, Object> recommandList = PrivateLibSearchAPI.getRecommandList(librarySearch.getIsbn());
				if (recommandList != null && !recommandList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) recommandList.get("response");
					try {
						if(data4Response.get("error") == null) {
							@SuppressWarnings ("unchecked")
							Map<String, Object> docs =  (Map<String, Object>) data4Response.get("docs");
							@SuppressWarnings ("unchecked")
							List<Map<String, Object>> data4recommandList =  (List<Map<String, Object>>) docs.get("book");
							model.addAttribute("data4recommandList", data4recommandList);
						}
					}catch ( Exception e ) {
						e.printStackTrace();
					}

					model.addAttribute("recommandList", recommandList);
				}

				model.addAttribute("detail", map);
				model.addAttribute("droneDeviceUsedCount", deviceSettingService.getDeviceUsedCount(new DeviceSetting()));
				model.addAttribute("droneLoanYn", loanRequestService.getBookLoanYn(LoanRequest.ofManageCodeAndMemberIdAndRegNo(homepage.getManage_code(), "" , (String) map.get("REG_NO"))));
				model.addAttribute("droneDayLoanCount", loanRequestService.getDayLoanCount(LoanRequest.fromManageCode(homepage.getManage_code())));
				model.addAttribute("dronePersonalLoanCount", loanRequestService.getPersonalLoanCount(LoanRequest.ofManageCodeAndMemberId(homepage.getManage_code(), getSessionMemberId(request))));
			}
		} else {
			result = LibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);
			
			untactLockerSetting.setHomepage_id(homepage.getHomepage_id());
			
			model.addAttribute("untactLockerSetting", untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()));

			if ( count > 0 ) {
				list = LibSearchAPI.getListData(result);
				Map<String, Object> map = list.get(0);

				//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
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

//				Map<String, Object> sanghoReqYn = LibSearchAPI.sanghoReqYn(librarySearch);
//				@SuppressWarnings ("unchecked")
//				Map<String, Object> sanghoReqYnResult = (Map<String, Object>) sanghoReqYn.get("ITEM");

				map.put("SANGHO_REQ_YN", "N");
//				if (sanghoReqYnResult.containsKey("RESULT") && String.valueOf(sanghoReqYnResult.get("RESULT")).equals("OK")) {
//					// 정상 신청가능
//					map.put("SANGHO_REQ_YN", "Y");
//				}

				//도서관정보나루 도서별 이용분석
				Map<String, Object> srchDtlList = LibSearchAPI.getSrchDtlList(librarySearch.getIsbn());
				if (srchDtlList != null && !srchDtlList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) srchDtlList.get("response");
					try {
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
						e.printStackTrace();
					}

					model.addAttribute("srchDtlList", srchDtlList);
				}

				//도서관정보나루 키워드
				Map<String, Object> keywordList = LibSearchAPI.getKeywordList(librarySearch.getIsbn());
				if (keywordList != null && !keywordList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) keywordList.get("response");
					try {
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
						e.printStackTrace();
					}

					model.addAttribute("keywordList", keywordList);
				}

				//도서관정보나루 추천도서
				Map<String, Object> recommandList = LibSearchAPI.getRecommandList(librarySearch.getIsbn());
				if (recommandList != null && !recommandList.isEmpty()) {
					@SuppressWarnings ("unchecked")
					Map<String, Object> data4Response = (Map<String, Object>) recommandList.get("response");
					try {
						if(data4Response.get("error") == null) {
							@SuppressWarnings ("unchecked")
							Map<String, Object> docs =  (Map<String, Object>) data4Response.get("docs");
							@SuppressWarnings ("unchecked")
							List<Map<String, Object>> data4recommandList =  (List<Map<String, Object>>) docs.get("book");
							model.addAttribute("data4recommandList", data4recommandList);
						}
					}catch ( Exception e ) {
						e.printStackTrace();
					}

					model.addAttribute("recommandList", recommandList);
				}
				
				//내집앞도서관 예약설정
				String reserveAvailability = "N";
				try {
					if(StringUtils.isNotEmpty(String.valueOf(map.get("MANAGE_CODE")))) {
						reserveAvailability = "Y";
						
						//예약 불가능 설정이 되어있다면 예약 불가
						if(nearbyLibManageService.checkUseYn(String.valueOf(map.get("MANAGE_CODE"))) > 0) {
							reserveAvailability = "N";
						} else {
							//예약가능시간 확인(count가 true이면 예약 가능)
							boolean reserveTimeCheck = neighborhoodLibraryReserveConfigService.checkReserveTime(String.valueOf(map.get("MANAGE_CODE")));
							
							if(!reserveTimeCheck) {
								reserveAvailability = "N";
							}
						}
						
						NearbyLib searchBookOne = new NearbyLib();
						searchBookOne.setBook_key(librarySearch.getBookkey());
						
						NearbyLib neighborhoodLibraryOne = neighborhoodLibraryService.getNeighborhoodLibraryBookOne(searchBookOne);
						int reserveData = 0;
						if(neighborhoodLibraryOne != null) {
							reserveData = 1;
						}
						
						Member member = getSessionMemberInfo(request);
						member.setManage_code(String.valueOf(map.get("MANAGE_CODE")));
						
						String nearbylibRejectMessage = "";
						
						if("017".equals(member.getUser_class_code())) {
							nearbylibRejectMessage = "이용자님은 비대면인증회원으로 서비스 이용을 위해 신분증을 지참하여 도서관으로 방문하여 주시기 바랍니다.";
						} else {
							try {
								Object data = LoginAPI.login2(member);
								
								Member memberInfo = (Member) data;
								
								//통합대출권수
								int unityLoanaleCnt = Integer.parseInt(memberInfo.getUnity_loanable_cnt());
								int unityLoanCnt = Integer.parseInt(memberInfo.getUnity_loan_cnt());
								//자관대출권수
								int localLoanaleCnt = Integer.parseInt(memberInfo.getLocal_loanable_cnt());
								int localLoanCnt = Integer.parseInt(memberInfo.getLocal_loan_cnt());
								
								//자관대출가능권수(자관대출가능권수 - (자관대출권수 + 내집앞도서예약권수))
								int tongCnt = unityLoanaleCnt - (unityLoanCnt + 1);
								//통합대출가능권수(통합대출가능권수 - (통합대출권수 + 내집앞도서예약권수))
								int jagwanCnt = localLoanaleCnt - (localLoanCnt + 1);
								
								if(jagwanCnt <= 0) {
									nearbylibRejectMessage = "현재 자관에서 대출할수 있는 대출권수를 초과하여 신청이 불가능 합니다.\\n해당 도서관에 기존에 대출한 자료를 반납 후 다시 이용 바랍니다";
								}
								if (tongCnt <= 0) {
									nearbylibRejectMessage = "현재 통합 대출권수를 초과하여 신청이 불가능 합니다.\\n대출중인 자료를 반납 후 다시 이용 바랍니다.";
								}

							} catch (Exception e) {
								e.printStackTrace();
								log.error("내집앞 도서관 자관,통합대출가능 권수 조회 오류" + e.getMessage());
							}
						}
						
						model.addAttribute("reserveAvailability", reserveAvailability);
						model.addAttribute("reserveData", reserveData);
						model.addAttribute("nearbylibRejectMessage", nearbylibRejectMessage);
					}
				} catch (Exception e) {
					log.error("내집앞 도서관 예약시간 설정 오류");
				}

				if ("CA".equals(map.get("MANAGE_CODE"))) {
					boolean walkingThroughTime = false;
					walkingThroughTime = service.isWalkingThroughTime();
					map.put("walkingThroughTime", walkingThroughTime);
				}
				model.addAttribute("detail", map);
				
				model.addAttribute("droneDeviceUsedCount", deviceSettingService.getDeviceUsedCount(new DeviceSetting()));
				model.addAttribute("droneLoanYn", loanRequestService.getBookLoanYn(LoanRequest.ofManageCodeAndMemberIdAndRegNo(homepage.getManage_code(), "" , (String) map.get("REG_NO"))));
				model.addAttribute("droneDayLoanCount", loanRequestService.getDayLoanCount(LoanRequest.fromManageCode(homepage.getManage_code())));
				model.addAttribute("dronePersonalLoanCount", loanRequestService.getPersonalLoanCount(LoanRequest.ofManageCodeAndMemberId(homepage.getManage_code(), getSessionMemberId(request))));
			}
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (StringUtils.isNotEmpty(librarySearch.getBooktype())) {
	    		Map<String, Object> result = new HashMap<String, Object>();

	    		if ( librarySearch.getBooktype().equals("BOOK") ) {
	    			result = PrivateLibSearchAPI.getBookDetail(librarySearch);
	    		} else if (librarySearch.getBooktype().equals("NONBOOK")) {
	    			result = PrivateLibSearchAPI.getNonBookDetail(librarySearch);
	    		} else if (librarySearch.getBooktype().equals("SERIAL")) {
	    			result = PrivateLibSearchAPI.getSerialDetail(librarySearch);
	    		}

	    		List<Map<String, Object>> list = null;

	    		int count = PrivateLibSearchAPI.getSearchCount(result);

	    		librarySearch.setTotalDataCount(count);
	    		service.setPaging(model, count, librarySearch);

	    		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
	    			list = LibSearchAPI.getListData(result);
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
					}
	    		}    		    	
	    		model.addAttribute("bookSearch", list);
			}
		} else {
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
					}
	    		}    		    	
	    		model.addAttribute("bookSearch", list);
			}
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
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> hotTrendWordList = PrivateLibSearchAPI.getHotTrendWordList(homepage.getManage_code());

			int count = PrivateLibSearchAPI.getSearchCount(hotTrendWordList);

			if ( count > 0 ) {
				model.addAttribute("hotTrendList", PrivateLibSearchAPI.getListData(hotTrendWordList));
			}
		} else {
			Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getManage_code());

			int count = LibSearchAPI.getSearchCount(hotTrendWordList);

			if ( count > 0 ) {
				model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
			}
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
						LibrarySearch book = new LibrarySearch();
						book.setIsbn(String.valueOf(map.get("ISBN")));
						book.setManageCode(librarySearch.getManageCode());
						book.setRowCount(1);
						Map<String, Object> bookDetail = null;
						if (librarySearch.getBooktype().equals("0")) {
							//도서 상세정보
							bookDetail = PrivateLibSearchAPI.getBookDetail(book);
						} else if (librarySearch.getBooktype().equals("1")) {
							//간행물 상세정보
							bookDetail = PrivateLibSearchAPI.getSerialDetail(book);
						} else if (librarySearch.getBooktype().equals("2")) {
							//비도서 상세정보
							bookDetail = PrivateLibSearchAPI.getNonBookDetail(book);
						}
						List<Map<String, Object>> detailList = PrivateLibSearchAPI.getListData(bookDetail);
						if ( detailList != null && detailList.size() > 0 ) {
							map.put("IMAGE", detailList.get(0).get("IMAGE"));
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
		}

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

		if(librarySearch.getManageCode().equals("BX")) {
			Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("19", librarySearch.getManageCode());
			if (!"ERROR".equals(subLocaInfo.get("RESULT_INFO"))) {
				List<Map<String, Object>> shelfList = LibSearchAPI.getListData(subLocaInfo, "LIST_DATA");

				List<String> code_arr = newBookConfigService.getShelfCodeList(new NewBookConfig("h68"));
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

			//기본값 '2달 전'
			if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
				librarySearch.setSearch_type("4");
			}

			//검색기간 설정
			if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

				int beforeDays = -60;
				if (librarySearch.getSearch_type().equals("1")) {
					//1주전
					beforeDays = -7;
				} else if (librarySearch.getSearch_type().equals("2")) {
					//2주전
					beforeDays = -14;
				} else if (librarySearch.getSearch_type().equals("3")) {
					//1달전
					beforeDays = -30;
				} else if (librarySearch.getSearch_type().equals("4")) {
					//2달전
					beforeDays = -60;
				} else if (librarySearch.getSearch_type().equals("5")) {
					//2달전
					beforeDays = -180;
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
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				Map<String, Object> subLocaInfo = PrivateLibSearchAPI.getSubLocaInfo("19", librarySearch.getManageCode());
				if (!"ERROR".equals(subLocaInfo.get("RESULT_INFO"))) {
					List<Map<String, Object>> shelfList = PrivateLibSearchAPI.getListData(subLocaInfo, "LIST_DATA");

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

				//기본값 '2달 전'
				if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
					librarySearch.setSearch_type("4");
				}

				//검색기간 설정
				if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

					int beforeDays = -60;
					if (librarySearch.getSearch_type().equals("1")) {
						//1주전
						beforeDays = -7;
					} else if (librarySearch.getSearch_type().equals("2")) {
						//2주전
						beforeDays = -14;
					} else if (librarySearch.getSearch_type().equals("3")) {
						//1달전
						beforeDays = -30;
					} else if (librarySearch.getSearch_type().equals("4")) {
						//2달전
						beforeDays = -60;
					} else if (librarySearch.getSearch_type().equals("5")) {
						//2달전
						beforeDays = -180;
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
								if (map.get("aladin") == null && "h84".equals(homepage.getHomepage_id())) {
									map.put("imageUrl", "/resources/homepage/libculture/img/book_noimg2.png");
								}
								if (map.get("aladin") == null && !"h84".equals(homepage.getHomepage_id())) {
									map.put("imageUrl", service.getImageUrl(map));
								}
							}
						}
					}
				}
				model.addAttribute("newBookList", list);
				model.addAttribute("librarySearch", librarySearch);
			} else {
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

				//기본값 '2달 전'
				if (StringUtils.isEmpty(librarySearch.getSearch_type())) {
					librarySearch.setSearch_type("4");
				}

				//검색기간 설정
				if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
					SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

					int beforeDays = -60;
					if (librarySearch.getSearch_type().equals("1")) {
						//1주전
						beforeDays = -7;
					} else if (librarySearch.getSearch_type().equals("2")) {
						//2주전
						beforeDays = -14;
					} else if (librarySearch.getSearch_type().equals("3")) {
						//1달전
						beforeDays = -30;
					} else if (librarySearch.getSearch_type().equals("4")) {
						//2달전
						beforeDays = -60;
					} else if (librarySearch.getSearch_type().equals("5")) {
						//2달전
						beforeDays = -180;
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

				if("AD50".equals(librarySearch.getShelfCode())) {
					librarySearch.setBooktype("2");
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
		}

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
		
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMdd");
		Date now  = new Date();
		String nowDate = sdf.format(now);
		
		if(StringUtils.isNotEmpty(librarySearch.getSearch_type())) {
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			
			if(librarySearch.getSearch_type().equals("1")) {
				cal.add(Calendar.DATE, -7);
				String calDate = sdf.format(cal.getTime());
				librarySearch.setSearch_start_date(calDate);
				librarySearch.setSearch_end_date(nowDate);
			} else if(librarySearch.getSearch_type().equals("2")) {
				cal.add(Calendar.DATE, -14);
				String calDate = sdf.format(cal.getTime());
				librarySearch.setSearch_start_date(calDate);
				librarySearch.setSearch_end_date(nowDate);
			} else if (librarySearch.getSearch_type().equals("3")){
				cal.add(Calendar.MONTH, -1);
				String calDate = sdf.format(cal.getTime());
				librarySearch.setSearch_start_date(calDate);
				librarySearch.setSearch_end_date(nowDate);
			} else if (librarySearch.getSearch_type().equals("4")){
				cal.add(Calendar.MONTH, -2);
				String calDate = sdf.format(cal.getTime());
				librarySearch.setSearch_start_date(calDate);
				librarySearch.setSearch_end_date(nowDate);
			}
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
			
			Map<String, Object> subLocaInfo = PrivateLibSearchAPI.getSubLocaInfo("19", librarySearch.getManageCode());
			if (!"ERROR".equals(subLocaInfo.get("RESULT_INFO"))) {
				List<Map<String, Object>> shelfList = PrivateLibSearchAPI.getListData(subLocaInfo, "LIST_DATA");

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

			model.addAttribute("bestBookList", list);
			model.addAttribute("librarySearch", librarySearch);
		}
		
		return String.format(basePath, homepage.getFolder()) + "bestBook/index";
	}
	
	@SuppressWarnings("unchecked")
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
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			// 정보나루 인기도서 전체 50개 제한
			librarySearch.setRowCount(50);
			
			Map<String, Object> result = PrivateLibSearchAPI.getPopularBookList(librarySearch);
			Map<String, Object> resultMap = null;
			List<Map<String, Object>> list = null;
			
			if(result != null) {
				resultMap = (Map<String, Object>)result.get("response");
			}
			
			if(resultMap != null) {
				if(resultMap.get("docs") != null && !resultMap.get("docs").equals("")) {
					resultMap = (Map<String, Object>)resultMap.get("docs");
				}
			}

			if(result != null && !result.isEmpty() && resultMap != null) {
				list = (ArrayList<Map<String, Object>>)resultMap.get("doc");
			}
			
			// 페이징을 위한 처리 
			librarySearch.setRowCount(10);
			service.setPaging(model, 50, librarySearch);
			List<Map<String, Object>> countList = new ArrayList<Map<String, Object>>();
			if (list != null) {
				int startNum = ( librarySearch.getViewPage() - 1 ) * 10;
				for(int i = startNum; i < (startNum + 10); i++) {
					countList.add(list.get(i));
				}

			}
			
			model.addAttribute("popularBookList", countList);
			model.addAttribute("librarySearch", librarySearch);
		} else {
			// 정보나루 인기도서 전체 50개 제한
			librarySearch.setRowCount(50);
			
			Map<String, Object> result = LibSearchAPI.getPopularBookList(librarySearch);
			Map<String, Object> resultMap = null;
			List<Map<String, Object>> list = null;
			
			if(result != null) {
				resultMap = (Map<String, Object>)result.get("response");
			}
			
			if(resultMap != null) {
				if(resultMap.get("docs") != null && !resultMap.get("docs").equals("")) {
					resultMap = (Map<String, Object>)resultMap.get("docs");
				}
			}

			if(result != null && !result.isEmpty() && resultMap != null) {
				list = (ArrayList<Map<String, Object>>)resultMap.get("doc");
			}
			
			// 페이징을 위한 처리 
			librarySearch.setRowCount(10);
			service.setPaging(model, 50, librarySearch);
			List<Map<String, Object>> countList = new ArrayList<Map<String, Object>>();
			if (list != null) {
				int startNum = ( librarySearch.getViewPage() - 1 ) * 10;
				for(int i = startNum; i < (startNum + 10); i++) {
					countList.add(list.get(i));
				}

			}
			
			model.addAttribute("popularBookList", countList);
			model.addAttribute("librarySearch", librarySearch);
		}
		
		return String.format(basePath, homepage.getFolder()) + "publicPopularBook/index";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = {"/publicPopularBook/detail.*"})
	public String detail(Model model, LibrarySearch librarySearch, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getPopularBook(librarySearch);
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
		} else {
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
		}

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
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}
		
		Member member = getSessionMemberInfo(request);
		librarySearch.setUserkey(member.getRec_key());
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
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
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
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
	
	@RequestMapping (value = { "/hope/allHistory.*" })
	public String hopeHistoryLib(@PathVariable ("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
			
		if(librarySearch.getLibraryCodes() == null) {
			List<String> libraryCodes = new ArrayList<String>();
			
			if(homepagePath.equals("yonghak") && librarySearch.getLibraryCodes() == null) {
				libraryCodes.add("BE");
				libraryCodes.add("BG");
				libraryCodes.add("BH");
				librarySearch.setLibraryCodes(libraryCodes);
			} else {
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
		}
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if ( StringUtils.isEmpty(librarySearch.getSearch_start_date()) ) {
			librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
		}
		if ( StringUtils.isEmpty(librarySearch.getSearch_end_date()) ) {
			librarySearch.setSearch_end_date(sdf.format(new Date()));
		}
		librarySearch.setManageCode(homepage.getManage_code());
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getAllBookFurnishList(librarySearch);

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
			Map<String, Object> result = LibSearchAPI.getAllBookFurnishList(librarySearch);

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
		
		return String.format(basePath, homepage.getFolder()) + "hope/allHistory";
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
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

		Map<String, Object> map = null;
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
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
	@SuppressWarnings({"unchecked"})
	@RequestMapping(value = {"/hope/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveHope(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) {

		JsonResponse res = new JsonResponse(request);

		Homepage h = getSessionHomepage(request);
		
		if(librarySearch.getEditMode().equals("ADD")) {
			if("bukgs".equals(h.getContext_path()) || "bukdh".equals(h.getContext_path()) || "buktj".equals(h.getContext_path())) {
				ValidationUtils.rejectIfEmpty(result, "publer_year", "연도를 입력하세요.");
			} else {
				ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "author", "저자를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "publer", "출판사를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "publer_year", "연도를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "price", "가격을 입력하세요.");
				ValidationUtils.rejectExceptNumber(result, "price", "가격은 숫자만 입력가능합니다.");
			}
		}

		if(!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if (!StringUtils.equals(member.getMember_class(), "0")) {
				res.setValid(false);
				res.setMessage("희망도서 신청 가능한 회원이 아닙니다.");
				return res;
			}

			if ( librarySearch.getEditMode().equals("ADD") ) {
				String homepageId = h.getHomepage_id();
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

				if(librarySearch.getPrivateLibraryYn(h)) {
					Map<String, Object> map = PrivateLibSearchAPI.getLibSettingInfoView(librarySearch.getManageCode());
					
					if(map.get("RESULT_INFO").equals("SUCCESS")) {
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
							res.setMessage("KAPI오류 : 사립도서관 설정정보 조회에 실패하였습니다. 관리자에게 문의해 주세요.");
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
				} else {
					Map<String, Object> map = LibSearchAPI.getLibSettingInfoView(librarySearch.getManageCode());
					
					if(map.get("RESULT_INFO").equals("SUCCESS")) {
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
				}
				
			} else if (librarySearch.getEditMode().equals("CANCEL")) {
				if(librarySearch.getPrivateLibraryYn(h)) {
					ApiResponse apiResult = PrivateLibSearchAPI.modHope(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
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
	 * 내집앞도서 신청내역
	 * @author whalesoft SeongHyeon and YONGJU♡ 2022. 11. 23.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/resve/nearby_index.*"})
	public String myNearbyList(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		NearbyLibDevice neighborhoodLibraryDevice = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = neighborhoodLibraryDeviceService.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = PrivateLibSearchAPI.getListData(result);
			}
			model.addAttribute("deviceList", deviceList);
			model.addAttribute("resveList", list);
		} else {
			Map<String, Object> result = LibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getListData(result);

				//무인예약 API를 사용해서 DB랑 비교 후 내집앞 무인예약만 보여지도록 처리
				Set<String> deviceCodes = deviceList.stream()
													.map(NearbyLibDevice::getDevice_code)
													.collect(Collectors.toSet());

				list = list.stream()
						   .filter(item -> deviceCodes.contains(String.valueOf(item.get("L_WORKER"))))
						   .collect(Collectors.toList());

				boolean isReserveCancelButton = true;
				for (Map<String, Object> getNearbyApiList : list) {
					String nearbyBookKey = Long.toString((Long) getNearbyApiList.get("PK"));
					int reserveStatus = neighborhoodLibraryService.getNearbyOneBookReserveData(nearbyBookKey);
					if (reserveStatus != 1) {
						isReserveCancelButton = false;
					}
					getNearbyApiList.put("isReserveCancelButton", isReserveCancelButton);
				}
			}

			int count = list.size();
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			model.addAttribute("deviceList", deviceList);
			model.addAttribute("resveList", list);
		}

		return String.format(basePath, homepage.getFolder()) + "resve/nearby_index";
	}

	/**
	 * 내집앞도서 신청 취소
	 * @author whalesoft SeongHyeon 2022. 11. 24.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = {"/resve/nearby_save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse nearby_save(Model model,LibrarySearch librarySearch, NearbyLib neighborhoodLibrary, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);
		Member member = getSessionMemberInfo(request);
		int resultData = 0;
		
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
			NearbyLib neighborhoodLibraryDelete = new NearbyLib();
			neighborhoodLibraryDelete.setCancel_id(member.getMember_id());
			neighborhoodLibraryDelete.setCancel_ip(request.getRemoteAddr());
			neighborhoodLibraryDelete.setCancel_yn("Y");
			neighborhoodLibraryDelete.setEditMode(neighborhoodLibrary.getEditMode());
			neighborhoodLibraryDelete.setPk(neighborhoodLibrary.getPk());
			neighborhoodLibraryDelete.setReserve_status(neighborhoodLibrary.getReserve_status());
			
			NearbyLib searchOne = new NearbyLib();
			searchOne.setPk(neighborhoodLibrary.getPk());
			NearbyLib reserveOne = neighborhoodLibraryService.getSameNeighborhoodLibraryPkData(searchOne); //해당 건 데이터 가져오기		
			if(reserveOne == null) { //KLAS에는 데이터가 존재하지만 내집앞도서관예약 TABLE에서 조회 결과가 없는 경우, 쿼리 SELECT ID -> getSameNeighborhoodLibraryPkData
				res.setValid(false);
				res.setMessage("홈페이지 데이터에 내역이 존재하지 않습니다. 관리자에게 문의하여 현재 메세지를 전달 해주세요. ERROR CODE: 7512"); 
				return res;
			}
			
			LibrarySearch library_search1 = new LibrarySearch();			
			library_search1.setUserkey(member.getRec_key());
			library_search1.setBookkey(reserveOne.getPk());
			ApiResponse apiResult = null;
			try {
				/*예약취소 API 호출*/
				apiResult = LibSearchAPI.cancelResve(library_search1);
				if (apiResult.getStatus()) { //취소 API 성공					
					/*홈페이지DB 예약취소 */
					resultData = neighborhoodLibraryService.updateNeighborhoodLibrary(neighborhoodLibraryDelete);
					if(resultData == 0) {
						System.out.println("@@@@@@@@@@@@@@@ updateNeighborhoodLibrary : Fail");						
					}
				} else { //취소 API 실패
					res.setValid(false);
					res.setMessage(apiResult.getMessage());
					return res;
				}
			}catch (Exception e) { //API 호출에 오류가 나서 실패
				e.printStackTrace();
				res.setValid(false);
				res.setMessage(apiResult.getMessage());
				return res;
			}
						
			librarySearch.setManageCode(reserveOne.getManage_code());
			librarySearch.setUserkey(reserveOne.getUser_key());
			String userIp = reserveOne.getAdd_ip();
			String book_name = reserveOne.getBook_name();
			String lockerIdx = String.valueOf(reserveOne.getLocker_idx());
			if(lockerIdx.length() == 1 ) {
				lockerIdx = "00" + lockerIdx;
			}else if(lockerIdx.length() == 2) {
				lockerIdx = "0" + lockerIdx;
			}

			String data1 = reserveOne.getLib_name();
			String data2 = reserveOne.getMember_name();
			String data3 = book_name;
			String data4 = "이용자 취소";
			try {
				LibSearchAPI.sendalimtalkReserve(librarySearch, "A12", "SJT_086006", userIp, data1, data2, data3, data4);
			} catch (UnsupportedEncodingException e) {
				throw new RuntimeException(e);
			}

			NearbyLib sms_send = new NearbyLib();
			sms_send.setSms_send_yn("Y");
			sms_send.setReserve_idx(reserveOne.getReserve_idx());
			neighborhoodLibraryService.updateNeighborhoodLibrarySms(sms_send);

			res.setValid(true);
			res.setMessage("취소 되었습니다.");
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		NearbyLibDevice neighborhoodLibraryDevice = new NearbyLibDevice();
		List<NearbyLibDevice> deviceList = neighborhoodLibraryDeviceService.getNeighborhoodLibraryDeviceList(neighborhoodLibraryDevice);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			Map<String, Object> result = PrivateLibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = PrivateLibSearchAPI.getListData(result);
			}
			model.addAttribute("deviceList", deviceList);
			model.addAttribute("resveList", list);
		} else {
			Map<String, Object> result = LibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result);
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getListData(result);
			}
			
			model.addAttribute("deviceList", deviceList);
			model.addAttribute("resveList", list);
		}

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
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			if (!StringUtils.equals(member.getMember_class(), "0")) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}
			
			if(homepage.getContext_path().equals("dgportal")) {
				//BA 구수산, BR 달성군립, AE 수성도서관, BL 서구통합도서관, BM 비원도서관
				if("BR".equals(librarySearch.getManageCode()) && librarySearch.getEditMode().equals("ADD")) {
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
				
				if("BA".equals(librarySearch.getManageCode()) && librarySearch.getEditMode().equals("ADD")) {
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
				
				if("AE".equals(librarySearch.getManageCode()) && librarySearch.getEditMode().equals("ADD")) {
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
					
					if(reserveCount >= 5) {
						res.setValid(false);
						res.setMessage("예약 가능 권수를 초과 하셨습니다.");
						return res;
					}
					
					if(count - reserveCount >= 2) {
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
			}
			
			//달성군립, 북구구수산, 수성도서관 일반예약2권 무인예약5권 처리를 위해 예약 2권으로 제한 
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
												 .filter(data -> data.get("UNMANNED_RESERVATION_LOAN").equals("N"))
												 .count();

					if (reserveCount >= 3) {
						res.setValid(false);
						res.setMessage("예약 가능 권수를 초과 하셨습니다.");
						return res;
					}
				}
			}


			
			librarySearch.setUserkey(member.getRec_key());
			if (librarySearch.getEditMode().equals("ADD")) {
				if(librarySearch.getPrivateLibraryYn(homepage)) {
					ApiResponse apiResult = PrivateLibSearchAPI.reqResve(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("예약되었습니다. 단, 대출 가능일은 자료반납 여부에 따라 변동될 수 있습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
					ApiResponse apiResult = LibSearchAPI.reqResve(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("예약되었습니다. 단, 대출 가능일은 자료반납 여부에 따라 변동될 수 있습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
			} else if (librarySearch.getEditMode().equals("CANCEL")) {
				if(librarySearch.getPrivateLibraryYn(homepage)) {
					ApiResponse apiResult = PrivateLibSearchAPI.cancelResve(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}

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
			
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				Map<String, Object> result = PrivateLibSearchAPI.getBookLoanHistory(librarySearch);

				List<Map<String, Object>> list = null;

				int count = PrivateLibSearchAPI.getSearchCount(result);
				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);
				
				if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
					list = PrivateLibSearchAPI.getListData(result);
				}
				
				model.addAttribute("loanList", list);
			} else {
				Map<String, Object> result = LibSearchAPI.getBookLoanHistory(librarySearch);

				List<Map<String, Object>> list = null;

				int count = LibSearchAPI.getSearchCount(result);
				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);
				
				if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
					list = LibSearchAPI.getListData(result);
				}
				
				model.addAttribute("loanList", list);
			}
			
			int noteMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 170));
			
			model.addAttribute("noteMenuIdx", noteMenuIdx);
			return String.format(basePath, homepage.getFolder()) + "loan/history";

		} else {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				Map<String, Object> result = PrivateLibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode(), librarySearch.getViewPage(), librarySearch.getRowCount());
				List<Map<String, Object>> list = null;

				int count = PrivateLibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);

				if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
					list = PrivateLibSearchAPI.getListData(result);
				}

				model.addAttribute("loanList", list);
			} else {
				Map<String, Object> result = LibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode(), librarySearch.getViewPage(), librarySearch.getRowCount());
				List<Map<String, Object>> list = null;

				int count = LibSearchAPI.getSearchCount(result);

				librarySearch.setTotalDataCount(count);
				service.setPaging(model, count, librarySearch);

				if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
					list = LibSearchAPI.getListData(result);
				}

				model.addAttribute("loanList", list);
			}
			
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
		Homepage homepage = getSessionHomepage(request);
		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			if (librarySearch.getEditMode().equals("RENEW")) {

				if(librarySearch.getPrivateLibraryYn(homepage)) {
					ApiResponse apiResult = PrivateLibSearchAPI.renewLoan(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("반납 연기 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
					ApiResponse apiResult = LibSearchAPI.renewLoan(librarySearch);
					if (apiResult.getStatus()) {
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}
		
		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청내역 조회가 불가능합니다", request, response);
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
			Map<String, Object> result = PrivateLibSearchAPI.lillRequestList(librarySearch, "0");

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = PrivateLibSearchAPI.getListData(result);
			}

			model.addAttribute("sanghoHistory", list);
		} else {
			Map<String, Object> result = LibSearchAPI.lillRequestList(librarySearch, "0");

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSanghoSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getSanghoListDataTotal(result);
			}

			model.addAttribute("sanghoHistory", list);
		}
		
		model.addAttribute("librarySearch", librarySearch);

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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		if (!StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y")) {
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
		} else {
			Map<String, Object> result = LibSearchAPI.lillRequestList(librarySearch, "1");

			List<Map<String, Object>> list = null;

			int count = LibSearchAPI.getSearchCount(result, "LIST_DATA", "TOTAL");
			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
				list = LibSearchAPI.getSanghoListDataTotal(result);
			}

			model.addAttribute("sanghoHistory", list);
		}
		
		model.addAttribute("librarySearch", librarySearch);

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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		Member member = getSessionMemberInfo(request);
		if (!StringUtils.equals(member.getKl_member_yn(), "Y")) {
			service.alertMessage("책이음회원이 아니므로 상호대차 신청이 불가능합니다", request, response);
			return null;
		}

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

			// 달서구립도서관, 중구, 서구어린이, 비원, 비산, 서구영어, 원고개 상호대차 3권
			String[] sangho3cnt = {"dalseolib", "kids", "seongseo", "bolli", "family", "english", "dssmalllib", "junggu", "seogulib", "biwon", "bisan", "seoguenglish", "wongogae"};
			for (String libOne : sangho3cnt) {
				if(homepage.getContext_path().equals(libOne)) {
					sanghoPossiCnt = 3;
					break;
				}
			}

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
				//			Map<String, Object> aladinDetail =  aladinApiService.getAladinApiOne(String.valueOf(map.get("ISBN")), homepage.getContext_path());
				//			if (aladinDetail != null && !aladinDetail.isEmpty() && aladinDetail.containsKey("item")) {
				//				list.get(0).put("aladinDetail", aladinDetail.get("item"));
				//			}
				model.addAttribute("detail", list.get(0));
			}
		} else {
			Map<String, Object> lillRequestList = LibSearchAPI.lillRequestList(librarySearch, "0");
			int lillRequestListCount = LibSearchAPI.getSearchCount(lillRequestList, "LIST_DATA", "TOTAL");
			int sanghoPossiCnt = 5;

			if("dgportal".equals(homepage.getContext_path())) {
				if("BV".equals(librarySearch.getManageCode()) || "BU".equals(librarySearch.getManageCode()) || "BW".equals(librarySearch.getManageCode()) || "BX".equals(librarySearch.getManageCode()) || "BY".equals(librarySearch.getManageCode()) ||
				   "BZ".equals(librarySearch.getManageCode()) || "FA".equals(librarySearch.getManageCode()) || "FB".equals(librarySearch.getManageCode()) || "FC".equals(librarySearch.getManageCode()) || "FX".equals(librarySearch.getManageCode()) ||
				   "GK".equals(librarySearch.getManageCode()) || "BL".equals(librarySearch.getManageCode()) || "BQ".equals(librarySearch.getManageCode()) || "BP".equals(librarySearch.getManageCode()) || "BM".equals(librarySearch.getManageCode()) ||
				   "BN".equals(librarySearch.getManageCode()) || "BS".equals(librarySearch.getManageCode()) || "BT".equals(librarySearch.getManageCode()) || "FE".equals(librarySearch.getManageCode())) {
					sanghoPossiCnt = 3;
				}
			}

			if("BS".equals(librarySearch.getManageCode()) || "BT".equals(librarySearch.getManageCode()) || "FE".equals(librarySearch.getManageCode())) {
				sanghoPossiCnt = 3;
			}

			if("BA".equals(librarySearch.getManageCode()) || "BB".equals(librarySearch.getManageCode()) || "BC".equals(librarySearch.getManageCode()) ||
			   "GL".equals(librarySearch.getManageCode()) || "GM".equals(librarySearch.getManageCode()) || "GN".equals(librarySearch.getManageCode()) ||
			   "HB".equals(librarySearch.getManageCode()) || "HD".equals(librarySearch.getManageCode()) || "HE".equals(librarySearch.getManageCode())) {
				sanghoPossiCnt = 10;
			}
			
			// 달서구립도서관, 중구 상호대차 3권
			String[] sangho3cnt = {"dalseolib", "kids", "seongseo", "bolli", "family", "english", "dssmalllib", "junggu", "seogulib", "biwon", "bisan", "seoguenglish", "wongogae"};
			for (String libOne : sangho3cnt) {
				if(homepage.getContext_path().equals(libOne)) {
					sanghoPossiCnt = 3;
					break;
				}
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
				//			Map<String, Object> aladinDetail =  aladinApiService.getAladinApiOne(String.valueOf(map.get("ISBN")), homepage.getContext_path());
				//			if (aladinDetail != null && !aladinDetail.isEmpty() && aladinDetail.containsKey("item")) {
				//				list.get(0).put("aladinDetail", aladinDetail.get("item"));
				//			}
				model.addAttribute("detail", list.get(0));
			}
		}

		Menu m = new Menu();
		m.setHomepage_id(homepage.getHomepage_id());
		m.setMenu_idx(18);
		int sanghoMenuIdx = menuService.getMenuIdxByProgramIdx(m);
		if (sanghoMenuIdx == 0) {
			sanghoMenuIdx = librarySearch.getMenu_idx();
		}
		model.addAttribute("sanghoMenuIdx", sanghoMenuIdx);

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

		Homepage homepage = getSessionHomepage(request);
		
		if (!StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {
			ValidationUtils.rejectIfEmpty(result, "uselibcode", "제공받을 도서관을 선택해주세요.");
			if (StringUtils.isEmpty(librarySearch.getManageCode()) || StringUtils.isEmpty(librarySearch.getUselibcode())) {
				result.reject("잘못된 접근입니다.");
			}
		}

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

			if (StringUtils.equals(librarySearch.getEditMode(), "CANCEL")) {
				if(librarySearch.getPrivateLibraryYn(homepage)) {
					ApiResponse apiResult = PrivateLibSearchAPI.lillRequestCancel(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				} else {
					ApiResponse apiResult = LibSearchAPI.lillRequestCancel(librarySearch);
					if (apiResult.getStatus()) {
						res.setValid(true);
						res.setMessage("취소되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage(apiResult.getMessage());
					}
				}
			} else {
				if(librarySearch.getPrivateLibraryYn(homepage)) {
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
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
	 * @throws ParseException 
	 */
	@RequestMapping(value = {"/unmanned/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUnmanned(Model model, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) throws ParseException {
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


			librarySearch.setUserkey(member.getRec_key());
			
			if (StringUtils.equals(librarySearch.getWorker(), "DSSUB01") || StringUtils.equals(librarySearch.getWorker(), "DSSUB02") ||
				StringUtils.equals(librarySearch.getWorker(), "SSSUBCO01") || StringUtils.equals(librarySearch.getWorker(), "BRSUBCO01")) {
				LibrarySearch l = new LibrarySearch();
				l.setWorker("DSSUB01");
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String sdate = sf.format(DateUtils.addDays(new Date(), -90));
				l.setSearch_start_date(sdate + "000000");

				//무인예약 기기 총 신청권수 제한
				Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
				int searchCount = LibSearchAPI.getSearchCount(unmannedLoanReserveList);
				if (searchCount >= 50) {
					res.setValid(false);
					res.setMessage("현재 예약 신청자 초과로 추가 예약불가. 내일 재신청해주세요.");
					return res;
				}
				l.setWorker("DSSUB02");
				unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
				searchCount += LibSearchAPI.getSearchCount(unmannedLoanReserveList);
				if (searchCount >= 50) {
					res.setValid(false);
					res.setMessage("현재 예약 신청자 초과로 추가 예약불가. 내일 재신청해주세요.");
					return res;
				}
				
				l.setWorker("SSSUBCO01");
				unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
				searchCount += LibSearchAPI.getSearchCount(unmannedLoanReserveList);
				if (searchCount >= 50) {
					res.setValid(false);
					res.setMessage("현재 예약 신청자 초과로 추가 예약불가. 내일 재신청해주세요.");
					return res;
				}
				l.setWorker("BRSUBCO01");
				unmannedLoanReserveList = LibSearchAPI.getUnmannedLoanReserveList(l, null);
				searchCount += LibSearchAPI.getSearchCount(unmannedLoanReserveList);
				if (searchCount >= 50) {
					res.setValid(false);
					res.setMessage("현재 예약 신청자 초과로 추가 예약불가. 내일 재신청해주세요.");
					return res;
				}
				
				//무인예약 인당 제한
				LibrarySearch l2 = new LibrarySearch();
				l2.setWorker("DSSUB01");
				l2.setUserkey(librarySearch.getUserkey());
				l2.setSearch_start_date(sdate + "000000");
				Map<String, Object> unmannedLoanReserveListDalseolib = LibSearchAPI.getUnmannedLoanReserveList(l2, null);
				int searchCountDalseolib = LibSearchAPI.getSearchCount(unmannedLoanReserveListDalseolib);
				if (searchCountDalseolib >= 2) {
					res.setValid(false);
					res.setMessage("무인예약 신청건수를 초과하였습니다.\n무인 예약은 2권까지만 가능합니다.");
					return res;
				}
				l2.setWorker("DSSUB02");
				unmannedLoanReserveListDalseolib = LibSearchAPI.getUnmannedLoanReserveList(l2, null);
				searchCountDalseolib += LibSearchAPI.getSearchCount(unmannedLoanReserveListDalseolib);
				if (searchCountDalseolib >= 2) {
					res.setValid(false);
					res.setMessage("무인예약 신청건수를 초과하였습니다.\n무인 예약은 2권까지만 가능합니다.");
					return res;
				}
				
				l2.setWorker("SSSUBCO01");
				unmannedLoanReserveListDalseolib = LibSearchAPI.getUnmannedLoanReserveList(l2, null);
				searchCountDalseolib += LibSearchAPI.getSearchCount(unmannedLoanReserveListDalseolib);
				if (searchCountDalseolib >= 2) {
					res.setValid(false);
					res.setMessage("무인예약 신청건수를 초과하였습니다.\n무인 예약은 2권까지만 가능합니다.");
					return res;
				}
				l2.setWorker("BRSUBCO01");
				unmannedLoanReserveListDalseolib = LibSearchAPI.getUnmannedLoanReserveList(l2, null);
				searchCountDalseolib += LibSearchAPI.getSearchCount(unmannedLoanReserveListDalseolib);
				if (searchCountDalseolib >= 2) {
					res.setValid(false);
					res.setMessage("무인예약 신청건수를 초과하였습니다.\n무인 예약은 2권까지만 가능합니다.");
					return res;
				}
				Map<String, Object> unmannedLoanReserveCnt = LibSearchAPI.getUnmannedLoanReserveCnt(librarySearch, "DATA");
				String nightLoanResult = String.valueOf(unmannedLoanReserveCnt.get("RESULT_INFO"));
				if (StringUtils.equals(nightLoanResult, "SUCCESS")) {
					
					/*if (!StringUtils.equals(librarySearch.getManageCode(), "BU") && !StringUtils.equals(librarySearch.getManageCode(), "BV") && !StringUtils.equals(librarySearch.getManageCode(), "BW") && !StringUtils.equals(librarySearch.getManageCode(), "BY") && !StringUtils.equals(librarySearch.getManageCode(), "BZ")){
    					String limit_cnt = String.valueOf(unmannedLoanReserveCnt.get("COUNT"));
    					try {
    						int limit_count = Integer.parseInt(limit_cnt);
    						if (limit_count >= 30) {
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
					}// 20210826 무인예약 하루 권수 제한해제*/
				} else {
					res.setValid(false);
					res.setMessage(String.valueOf(unmannedLoanReserveCnt.get("RESULT_MESSAGE")));
					return res;
				}
			}

			if(StringUtils.equals(librarySearch.getWorker(), "DSGLIB01")) {
				LibrarySearch ls = new LibrarySearch();
				ls.setWorker("DSGLIB01");
				ls.setUserkey(librarySearch.getUserkey());

				Map<String, Object> unmannedLoanReserveListForOne = LibSearchAPI.getUnmannedLoanReserveList(ls, null);
				int searchCountForOne = LibSearchAPI.getSearchCount(unmannedLoanReserveListForOne);

				if (searchCountForOne >= 5) {
					res.setValid(false);
					res.setMessage("무인 예약은 하루에 5권까지만 가능합니다.");
					return res;
				}
				
				LibrarySearch ls2 = new LibrarySearch();
				ls2.setWorker("DSGLIB01");

				Map<String, Object> unmannedLoanReserveListForDalseung = LibSearchAPI.getUnmannedLoanReserveList(ls2, null);
				int searchCountForDalseung = LibSearchAPI.getSearchCount(unmannedLoanReserveListForDalseung);
				
				if (searchCountForDalseung >= 40) {
					res.setValid(false);
					res.setMessage("금일 무인예약은 마감되었습니다.\n1일 40명 까지 예약이 가능합니다.");
					return res;
				}
				
				Map<String, Object> loanList = LibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode(), librarySearch.getViewPage(), librarySearch.getRowCount());
				int loanListCount = LibSearchAPI.getSearchCount(loanList);
				if(searchCountForOne + loanListCount >= 10) {
					res.setValid(false);
					res.setMessage("대출가능 횟수를 초과하셨습니다.");
					return res;
				}
				
				Date dt = new Date();
				Calendar cal = Calendar.getInstance();
				cal.setTime(dt);
				ls.setSearch_start_date(DateFormatUtils.format(cal.getTime(), "yyyyMMdd"));
				ls.setManageCode(homepage.getManage_code());
				Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(ls);
				if(holiDays.get("RESULT_CODE").equals("1")) {
					res.setValid(false);
					res.setMessage("휴관일에는 무인예약 신청이 불가능합니다.");
					return res;
				}
				
				Date now = new Date();
				String start = "09:00:00";
				String end = "12:00:00";
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
				Date start_time = sdf.parse(start);
				Date end_time = sdf.parse(end);
				
				if (now.getTime() < start_time.getTime() && now.getTime() > end_time.getTime()) {
					res.setValid(false);
					res.setMessage("금일 무인예약은 마감되었습니다.\n예약 가능 시간은 09:00~12:00 입니다.");
					return res;
				}
			}
			
			if(StringUtils.equals(librarySearch.getWorker(), "BMSUB01")) {
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String sdate = sf.format(DateUtils.addDays(new Date(), -90));
				
				LibrarySearch ls = new LibrarySearch();
				ls.setWorker("BMSUB01");
				ls.setUserkey(librarySearch.getUserkey());
				ls.setSearch_start_date(sdate + "000000");
				Map<String, Object> unmannedLoanReserveListBiwon = LibSearchAPI.getUnmannedLoanReserveList(ls, null);
				int searchCountBiwon = LibSearchAPI.getSearchCount(unmannedLoanReserveListBiwon);
				if (searchCountBiwon >= 5) {
					res.setValid(false);
					res.setMessage("무인예약 신청건수를 초과하였습니다.\n무인 예약은 5권까지만 가능합니다.");
					return res;
				}
				
				librarySearch.setExprire_date_cnt("2");
			}

			ApiResponse apiResult = LibSearchAPI.unmannedloanreserve(librarySearch);
			if (apiResult.getStatus()) {
				/*내집앞 도서관 사물함 테스트용(내집앞 도서관 사물함 시스템 구축 지연으로 무인예약으로 바코드 테스트, 2022.12.19일 테스트 종료 후 제거할 것)*/
				if("BA".equals(librarySearch.getManageCode()) || "AH".equals(librarySearch.getManageCode()) || "CB".equals(librarySearch.getManageCode())
						|| "AA".equals(librarySearch.getManageCode()) || "CA".equals(librarySearch.getManageCode())) {
					try {
						List<Map<String, Object>> checkDupUser = MemberAPI.checkDupUser("0", member);
						if(CollectionUtils.isEmpty(checkDupUser)) {
							
						} else {
							Map<String, Object> userMap = checkDupUser.get(0);
							LibrarySearch librarySearchSms = new LibrarySearch();
							librarySearchSms.setManageCode(librarySearch.getManageCode());
							librarySearchSms.setUserkey(member.getRec_key());
							String userIp = "0:0:0:0:0:0:0:1";
							String user_no = String.valueOf(userMap.get("USER_NO"));
							String mes = "http://library.daegu.go.kr/" + homepage.getContext_path() + "/module/nearLib/bacode.do?pass=" + user_no 
									+ "\n[" + librarySearch.getShelf_loc_name() + "]\n" + member.getMember_name() + "님 예약이 완료 되었습니다.."
									+ "\n도서 정보 : " + librarySearch.getBook_name();
							LibSearchAPI.sendSms(librarySearchSms, mes, userIp);	 
						
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
				}
				res.setValid(true);
				res.setMessage("예약 되었습니다.");
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

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
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

			Map<String, Object> reserveList = LibSearchAPI.getReserveList(member.getRec_key());

			List<Map<String, Object>> dataList = (List<Map<String, Object>>) reserveList.getOrDefault("LIST_DATA", new ArrayList<>());

			if (!dataList.isEmpty() && dataList.get(0).containsKey("SEARCH_COUNT")) {
				dataList.remove(0);
			}

			int nightReservationCount = (int) dataList.stream()
                                                       .filter(nightData -> "CA".equals(nightData.get("MANAGE_CODE")) && "Y".equals(nightData.get("NIGHT_RESERVATION_LOAN")))
                                                       .count();
			if (nightReservationCount >= 5) {
				res.setValid(false);
				res.setMessage("대출 권수는 1인당 5권으로 제한 되었습니다.");
				return res;
			}

			Map<String, Object> nightLoanReserveCnt = LibSearchAPI.getNightLoanReserveCnt(librarySearch, "DATA");
			String nightLoanResult = String.valueOf(nightLoanReserveCnt.get("RESULT_INFO"));
			if (StringUtils.equals(nightLoanResult, "SUCCESS")) {
				String limit_cnt = String.valueOf(nightLoanReserveCnt.get("TOTAL"));
				try {
					int limit_count = Integer.parseInt(limit_cnt);
						if (limit_count >= 250) {
							res.setValid(false);
							res.setMessage("해당 도서관의 금일 워킹스루 예약가능 인원이 모두 찼습니다. 내일 다시 신청해주세요");
							return res;
						}
				} catch (Exception e) {
					res.setValid(false);
					res.setMessage("해당 도서관의 금일 워킹스루 예약가능 인원이 모두 찼습니다. 에러코드 060");
					return res;
				}
			} else {
				res.setValid(false);
				res.setMessage(String.valueOf(nightLoanReserveCnt.get("RESULT_MESSAGE")));
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
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	/**
	 * 내집앞도서관 예약 신청 폼
	 * @author whalesoft SEONGHYEON 2022. 11. 09.
	 * @param model
	 * @param neighborhoodLibrary
	 * @param request
	 * @param response
	 * @return
	 * @throws Throwable
	 */
	@RequestMapping (value = {"/neighborhoodLibrary/edit.*"}, method = RequestMethod.POST)
	public String neigborhoodLibraryEdit(Model model, NeighborhoodLibrary neighborhoodLibrary, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (neighborhoodLibrary.getBooktype() == null) {
			neighborhoodLibrary.setBooktype("BO");
		}			
		
		Member member = getSessionMemberInfo(request);
		
		if(!"null".equals(member.getMember_id()) && StringUtils.isNotEmpty(member.getMember_id())) {
			neighborhoodLibrary.setMember_id(member.getMember_id());
			
			//회원의 예약건수
			int member_reserve_count = neighborhoodLibraryService.getMemberReserveCount(neighborhoodLibrary);
			
			if(member_reserve_count >= 2) {
				service.alertMessage("현재 내집앞 도서관 신청건수 및 대출건수를 초과 하였습니다. 내집앞 도서관 신청 중인 도서를 취소하시거나 현재 내집앞도서관을 통해 대출한 도서를 반납하시고 다시 신청 바랍니다.", request, response);
				return null;
			}
		} else {
			service.alertMessage("회원정보를 불러오는데 오류가 발생하였습니다.관리자에게 문의해주세요.", request, response);
			return null;
		}

		List<NearbyLibDevice> deviceList = neighborhoodLibraryDeviceService.getNeighborhoodLibraryDeviceList(new NearbyLibDevice());

		model.addAttribute("deviceList", deviceList);
		model.addAttribute("neighborhoodLibrary", neighborhoodLibrary);

		for(int i = 0; i < deviceList.size(); i++){
			String device_name = deviceList.get(i).getDevice_name();
			Map<String,Object> nowLockerList = neighborhoodLibraryService.getNearByLibUseDevice(deviceList.get(i).getDevice_idx());

			model.addAttribute("currentDeviceCount" + deviceList.get(i).getDevice_idx(), nowLockerList.get("CURRENTDEVICECOUNT"));
			model.addAttribute("totalDeviceCount" + deviceList.get(i).getDevice_idx(), nowLockerList.get("TOTALDEVICECOUNT"));
		}

		return String.format(basePath, homepage.getFolder()) + "neighborhoodLibrary/edit";
	}
	
	/**
	 * 내집앞도서관 대출예약
	 * @author whalesoft SEONGHYEON 2022. 11. 09.
	 * @param model
	 * @param librarySearch
	 * @param result
	 * @param request
	 * @return
	 */
	
	@RequestMapping(value = {"/neighborhoodLibrary/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse neighborhoodLibrarySave(Model model, NearbyLib neighborhoodLibrary, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		Member member = getSessionMemberInfo(request);
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			return res;
		} else {
			if (!StringUtils.equals(member.getMember_class(), "0")) {
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}
		}
		
		LibrarySearch nearbySearch = new LibrarySearch();
		nearbySearch.setEditMode("nearbySave");
		nearbySearch.setManageCode(neighborhoodLibrary.getManage_code());
		nearbySearch.setUserkey(member.getRec_key());
		nearbySearch.setReg_no(neighborhoodLibrary.getReg_no());
		
		String device_code = neighborhoodLibraryDeviceService.getNearbyLibDeviceOne(neighborhoodLibrary.getDevice_idx());
		nearbySearch.setDevice_code(device_code);
		
		if("AA".equals(neighborhoodLibrary.getManage_code())) {
			neighborhoodLibrary.setHomepage_id("h1");
		} else if("AH".equals(neighborhoodLibrary.getManage_code())) {
			neighborhoodLibrary.setHomepage_id("h5");
		} else if("CA".equals(neighborhoodLibrary.getManage_code())) {
			neighborhoodLibrary.setHomepage_id("h45");
		} else if("CB".equals(neighborhoodLibrary.getManage_code())) {
			neighborhoodLibrary.setHomepage_id("h45");
		} else if("BA".equals(neighborhoodLibrary.getManage_code())) {
			neighborhoodLibrary.setHomepage_id("h46");
		}
		
		/*예약 가능 여부 확인*/
		if(neighborhoodLibrary.getDevice_idx() > 0) {
			NearbyLibReserveConfig nearbyLibReserveConfig = neighborhoodLibraryReserveConfigService.getReserveConfigToday(neighborhoodLibrary.getManage_code());
			nearbyLibReserveConfig.setMember_id(member.getMember_id());
			
			member.setManage_code(neighborhoodLibrary.getManage_code());
			
			String nearbylibRejectMessage = "";
			
			try {
				Object data = LoginAPI.login2(member);
				
				member = (Member) data;
				
				//통합대출권수
				int unityLoanaleCnt = Integer.parseInt(member.getUnity_loanable_cnt());
				int unityLoanCnt = Integer.parseInt(member.getUnity_loan_cnt());
				//자관대출권수
				int localLoanaleCnt = Integer.parseInt(member.getLocal_loanable_cnt());
				int localLoanCnt = Integer.parseInt(member.getLocal_loan_cnt());
				
				//자관대출가능권수(자관대출가능권수 - (자관대출권수 + 내집앞도서예약권수))
				int tongCnt = unityLoanaleCnt - (unityLoanCnt + 1);
				//통합대출가능권수(통합대출가능권수 - (통합대출권수 + 내집앞도서예약권수))
				int jagwanCnt = localLoanaleCnt - (localLoanCnt + 1);
				
				if(jagwanCnt == 0 || tongCnt == 0) {
					if(jagwanCnt == 0) {
						nearbylibRejectMessage = "현재 자관에서 대출할수 있는 대출권수를 초과하여 신청이 불가능 합니다.\n해당 도서관에 기존에 대출한 자료를 반납 후 다시 이용 바랍니다";
						
						res.setValid(false);
						res.setMessage(nearbylibRejectMessage);
						return res;
					} else {
						nearbylibRejectMessage = "현재 통합 대출권수를 초과하여 신청이 불가능 합니다.\n대출중인 자료를 반납 후 다시 이용 바랍니다.";
						
						res.setValid(false);
						res.setMessage(nearbylibRejectMessage);
						return res;
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
				
				res.setValid(false);
				res.setMessage("자관, 통합 대출권수 확인에 오류가 생겼습니다.\n관리자에게 문의해주세요.");
				return res;
			}
			
			if(nearbyLibManageService.checkUseYn(neighborhoodLibrary.getManage_code()) > 0) {
				res.setValid(false);
				res.setMessage("현재 예약 불가능일이므로 예약이 불가능하십니다.\n관리자에게 문의해주세요.");
				return res;
			} else {
				//예약가능시간 확인(count가 true이면 예약 가능)
				boolean reserveTimeCheck = neighborhoodLibraryReserveConfigService.checkReserveTime(neighborhoodLibrary.getManage_code());
				
				if(!reserveTimeCheck) {
					res.setValid(false);
					res.setMessage("현재 예약 가능한 시간이 아닙니다.");
					return res;
				}
			}
			
			int device_idx = neighborhoodLibrary.getDevice_idx();
			nearbyLibReserveConfig.setDevice_idx(device_idx);
			nearbyLibReserveConfig.setManage_code(neighborhoodLibrary.getManage_code());
			
			//사물함 갯수
			int locker_count = neighborhoodLibraryLockerService.getNeighborhoodLibraryLockerCount(device_idx);
			//전체예약 건수
			int reserve_locker_count = neighborhoodLibraryService.getReservedLockerCountNow(nearbyLibReserveConfig);
			//회원의 예약건수
			int member_reserve_count = neighborhoodLibraryService.getReserveCountNow(nearbyLibReserveConfig);
			
			int lockerBookCheck = neighborhoodLibraryService.getReserveCountNowLockerIn(nearbyLibReserveConfig);
			
			if(locker_count > 0) {
				if(member_reserve_count >= 2) {
					res.setValid(false);
					res.setMessage("현재 내집앞 도서관 신청건수 및 대출건수를 초과 하였습니다. \n내집앞 도서관 신청 중인 도서를 취소하시거나 현재 내집앞도서관을 통해 대출한 도서를 반납하시고 다시 신청 바랍니다.");
					return res;
					
				} else if(lockerBookCheck == 0){
					if(locker_count <= reserve_locker_count) {
						res.setValid(false);
						res.setMessage("현재 사용가능한 사물함이 없습니다.");
						return res;
					}
				}
			} else {
				res.setValid(false);
				res.setMessage("선택하신 사물함 기기는 등록된 사물함이 없습니다.");
				return res;
			}
		} else {
			res.setValid(false);
			res.setMessage("선택하신 사물함 조회에 오류가 발생하였습니다.\n관리자에게 연락해주세요.");
			return res;
		}
			
		if (!result.hasErrors()) {
			neighborhoodLibrary.setMember_id(member.getMember_id());
			List<NearbyLib> reserveDataList = neighborhoodLibraryService.getNeighborhoodLibraryUseList(neighborhoodLibrary);
			
			if(reserveDataList.size() > 0) { //현재 신청내역이 있다면	
				if(reserveDataList.size() == 1 ) { //신청내역이 1건일때(1건 더 신청 가능)
					//동일한 도서일때
					if(reserveDataList.get(0).getReg_no().equals(neighborhoodLibrary.getReg_no())) {
						res.setValid(false);
						res.setMessage("이미 신청한 도서입니다.");
						return res;
					}
					
					//신청되어 있는 내역과 현재 신청 장비idx가 다르다면
					if(reserveDataList.get(0).getDevice_idx() != neighborhoodLibrary.getDevice_idx()) {
						int bundleIdx = neighborhoodLibraryService.getNeighborhoodLibraryBundleIdx(neighborhoodLibrary); 
						neighborhoodLibrary.setReserve_bundle_idx(bundleIdx); //신청장비가 다르면 다른 건으로 idx 배정
					} else {
						neighborhoodLibrary.setReserve_bundle_idx(reserveDataList.get(0).getReserve_bundle_idx()); // 신청내역 하나로 묶기(reserve_bundle_idx를 같은 값으로 준다)
					}
				} else {
					res.setValid(false);
					res.setMessage("현재 내집앞 도서관 신청건수 및 대출건수를 초과 하였습니다. \n내집앞 도서관 신청 중인 도서를 취소하시거나 현재 내집앞도서관을 통해 대출한 도서를 반납하시고 다시 신청 바랍니다.");
					return res;
				}
			} else {
				 //bundle_idx 값 max+1 값 추출
				int bundleIdx = neighborhoodLibraryService.getNeighborhoodLibraryBundleIdx(neighborhoodLibrary);//예약idx처럼 +1씩 쌓이지만 1건에 두권이면 bundle_idx를 동일하게 준다
				neighborhoodLibrary.setReserve_bundle_idx(bundleIdx);
			}
			
			
			NearbyLibDevice neighborhoodLibraryDevice = new NearbyLibDevice();
			neighborhoodLibraryDevice.setDevice_idx(neighborhoodLibrary.getDevice_idx());
			NearbyLibDevice deviceOne = neighborhoodLibraryDeviceService.getNeighborhoodLibraryDeviceOne(neighborhoodLibraryDevice);	//장비정보 가져오기		

			neighborhoodLibrary.setDevice_code(deviceOne.getDevice_code());
			neighborhoodLibrary.setDevice_name(deviceOne.getDevice_name());			
			neighborhoodLibrary.setAdd_id(member.getMember_id());
			neighborhoodLibrary.setMember_name(member.getMember_name());
			neighborhoodLibrary.setUser_key(member.getRec_key());
			neighborhoodLibrary.setAdd_ip(request.getRemoteAddr());
			neighborhoodLibrary.setTake_term(3);
			
			neighborhoodLibrary.setApplicant_cell_phone(member.getCell_phone());
			
			LibrarySearch librarySearch = new LibrarySearch();
			librarySearch.setUserkey(member.getRec_key());
			librarySearch.setBookkey(neighborhoodLibrary.getBook_key());
			librarySearch.setBooktype(neighborhoodLibrary.getBooktype());
			librarySearch.setExprire_date_cnt("3");
			librarySearch.setWorker(String.valueOf(deviceOne.getDevice_code()));
			
			
			ApiResponse apiResult = null;
			/*무인대출 예약 api 호출*/
			try {
				apiResult = LibSearchAPI.unmannedloanreserve(librarySearch);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(apiResult.getStatus()) {							
				if(neighborhoodLibraryService.insertNeighborhoodLibrary(neighborhoodLibrary) > 0) {
					System.out.println("@@@@@@@@@@@@ NeighborhoodLibrary Reserve API : Success, insertNeighborhoodLibrary : Success");
					res.setValid(true);
					res.setMessage("예약 되었습니다.");
				} else {
					System.out.println("@@@@@@@@@@@@ NeighborhoodLibrary Reserve API : Success, insertNeighborhoodLibrary : Fail");
					res.setValid(false);
					res.setMessage("내집앞도서관 예약 insert 실패");
					return res;
				}
			} else {
				res.setValid(false);
				res.setMessage("KLAS 무인대출 예약 api 호출 실패." + apiResult.getMessage());
				return res;
			}
			
			String PK = "";
			String USER_NO = "";
			Map<String, Object>  reserveList = null;
			try {
				//KLAS에서 예약리스트 불러온다	
				reserveList = LibSearchAPI.getReserveList(member.getRec_key()); 			
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			if(reserveList != null) {
				List<Map<String,Object>> listData = (List<Map<String,Object>>)reserveList.get("LIST_DATA");
				for(int i = 0; i < listData.size(); i++) {
					if(i == 0) {
						continue;
					}else {
						if(String.valueOf(listData.get(i).get("BOOK_KEY")).equals(neighborhoodLibrary.getBook_key())) { //예약리스트에서 홈페이지DB에 INSERT한 책 정보랑 같은 건수 있으면 KLAS 예약키 가져오기
							PK = String.valueOf(listData.get(i).get("PK")); //KLAS 예약KEY
							USER_NO = String.valueOf(listData.get(i).get("USER_NO")); //KLAS 대출자번호
							
						}
					}
				}
			}
			//홈페이지DB에 방금 INSERT한 예약 IDX값 가져오기
			int reserveIdx = neighborhoodLibraryService.getSameNeighborhoodLibraryReserveCallIdx(neighborhoodLibrary); 
			if(reserveIdx > 0) {
				System.out.println("@@@@@@@@@@@@ getSameNeighborhoodLibraryReserveCallIdx : Success");
			} else {			
				System.out.println("@@@@@@@@@@@@ getSameNeighborhoodLibraryReserveCallIdx : Fail");
			}
			NearbyLib pk_reserve = new NearbyLib();
			pk_reserve.setReserve_idx(reserveIdx);
			pk_reserve.setPk(PK);
			pk_reserve.setUser_no(USER_NO);
			//KLAS 예약키를 가져와서 홈페이지DB 방금 INSERT한 데이터에 UPDATE하기
			
			if(neighborhoodLibraryService.updateNeighborhoodLibraryPK(pk_reserve) > 0) {
				System.out.println("@@@@@@@@@@@@ updateNeighborhoodLibraryPK : Success");
			} else {
				System.out.println("@@@@@@@@@@@@ updateNeighborhoodLibraryPK : Fail");
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
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			result = PrivateLibSearchAPI.getBookInfo(librarySearch);

			model.addAttribute("librarySearch", librarySearch);

			List<Map<String, Object>> list = null;

			int count = PrivateLibSearchAPI.getSearchCount(result);

			librarySearch.setTotalDataCount(count);
			service.setPaging(model, count, librarySearch);

			if ( count > 0 ) {
				list = PrivateLibSearchAPI.getListData(result);
				model.addAttribute("detail", list.get(0));
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
				model.addAttribute("detail", list.get(0));
			}
		}
		
		return String.format(basePath, homepage.getFolder()) + "print_ajax";
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.GET)
	public LibrarySearchView excel(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);
		Map<String, Object> result = null;
		List<Map<String, Object>> list = null;
		
		String excel_type = librarySearch.getExcel_type();
		if(excel_type.equals("LOAN")) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				result = PrivateLibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode(), librarySearch.getViewPage(), librarySearch.getRowCount());
			} else {
				result = LibSearchAPI.getBookLoanList(member.getRec_key(), librarySearch.getManageCode(), librarySearch.getViewPage(), librarySearch.getRowCount());
			}
		} else if(excel_type.equals("HISTORY")) {
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.YEAR, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
				librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
			}
			if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
				librarySearch.setSearch_end_date(sdf.format(new Date()));
			}
			librarySearch.setViewPage(1);
			librarySearch.setRowCount(99999);

			librarySearch.setUserkey(member.getRec_key());
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				result = PrivateLibSearchAPI.getBookLoanHistory(librarySearch);
			} else {
				result = LibSearchAPI.getBookLoanHistory(librarySearch);
			}
		} else if(excel_type.equals("RESVE")) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				result = PrivateLibSearchAPI.getReserveList(member.getRec_key());
			} else {
				result = LibSearchAPI.getReserveList(member.getRec_key());
			}
		} else if(excel_type.equals("HOPE")) {
			librarySearch.setUserkey(member.getRec_key());
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				result = PrivateLibSearchAPI.getBookFurnishList(librarySearch);
			} else {
				result = LibSearchAPI.getBookFurnishList(librarySearch);
			}
		}
		
		if (result != null && !result.isEmpty() && result.get("LIST_DATA") != null) {
			if(librarySearch.getPrivateLibraryYn(homepage)) {
				list = PrivateLibSearchAPI.getListData(result);
			} else {
				list = LibSearchAPI.getListData(result);
			}
		}
		
		model.addAttribute("resultList", list);
		model.addAttribute("librarySearch", librarySearch);

		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.GET)
	public void csv(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> result = null;

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}

	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public LibrarySearchView excelDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {


		return new LibrarySearchView();
	}

	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.POST)
	public void csvDownload(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> result = null;

		new LibrarySearchXlsToCsv(librarySearch, result, request, response);
	}
	
	@SuppressWarnings("unchecked")
	public String marc_view(Model model, String regno, HttpServletRequest request) {
		List<Map<String, Object>> list = null;
		String content = "";
		//marc보기
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
	
	@SuppressWarnings("unchecked")
	public String private_marc_view(Model model, String regno, HttpServletRequest request) {
		List<Map<String, Object>> list = null;
		String content = "";
		//marc보기
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

	@RequestMapping(value = { "/popup.*" })
	public String popup(Model model, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		
		return String.format(basePath, homepage.getFolder()) + "popup_ajax";
	}

	/**
	 * 드론 대출 신청 페이지
	 */
	@RequestMapping (value = { "/drone/req.*" }, method = RequestMethod.POST)
	public String droneReq(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		
		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		if ("Y".equals(loanRequestService.getReqeustBookYn(LoanRequest.ofManageCodeAndMemberIdAndRegNo(homepage.getManage_code(), getSessionMemberId(request), librarySearch.getRegNo())))) {
			service.alertMessage("이미 드론대출 신청이 완료된 책입니다.", request, response);
			return null;
		}

		if (deviceSettingService.getDeviceUsedCount(new DeviceSetting()) <= 0) {
			service.alertMessage("드론대출 신청 기간이 아닙니다.", request, response);
			return null;
		}

		int personalLoanCount = loanRequestService.getPersonalLoanCount(LoanRequest.ofManageCodeAndMemberId(homepage.getManage_code(), getSessionMemberId(request)));
		int dayLoanCount = loanRequestService.getDayLoanCount(LoanRequest.fromManageCode(homepage.getManage_code()));

		if (personalLoanCount >= 2) {
			service.alertMessage("드론대출은 하루에 개인 2권 까지만 신청이 가능합니다.", request, response);
			return null;
		}

		if (dayLoanCount >= 20) {
			service.alertMessage("드론대출은 하루에 20권 까지만 신청이 가능합니다.", request, response);
			return null;
		}

		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("deviceList", deviceSettingService.getDeviceList(new DeviceSetting(homepage.getManage_code())));

		return String.format(basePath, homepage.getFolder()) + "drone/req";
	}

	/**
	 * 드론 대출 현황
	 */
	@RequestMapping (value = { "/drone/loan.*" })
	public String droneLoan(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);

		model.addAttribute("librarySearch", librarySearch);

		if(librarySearch.getPrivateLibraryYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
				return null;
			}
		}

		LoanRequest loanRequest = LoanRequest.ofHomepageRequest(homepage.getManage_code(),member.getMember_id(), librarySearch.getSearch_start_date(), librarySearch.getSearch_end_date());

		service.setPaging(model, loanRequestService.getHomepageLoneReqeustCount(loanRequest), loanRequest);
		model.addAttribute("loanList", loanRequestService.getHomepageLoneReqeustList(loanRequest));
		model.addAttribute("loanRequest",loanRequest);

		return String.format(basePath, homepage.getFolder()) + "drone/loan";
	}

	/**
	 * 드론 대출 신청
	 */
	@RequestMapping (value = { "/drone/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse droneSave(LibrarySearch librarySearch, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
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

		if (deviceSettingService.getDeviceUsedCount(new DeviceSetting()) <= 0) {
			result.reject("드론대출 신청 기간이 아닙니다.");
		}

		if (!"CANCEL".equals(librarySearch.getEditMode())) {
			Map<String, Object> bookInfo = new HashMap<String, Object>();
			bookInfo = LibSearchAPI.getBookInfo(librarySearch);
			List<Map<String, Object>> list = null;
			int count = LibSearchAPI.getSearchCount(bookInfo);
			if ( count > 0 ) {
				list = LibSearchAPI.getListData(bookInfo);
			}

			if (!"OK".equals(list.get(0).get("LOAN_CODE"))){
				result.reject("이미 대출이 되었거나, 대출 불가 책입니다. 다시 한번 확인해주세요.");
			};
		}

		if (!result.hasErrors()) {
			Member member = getSessionMemberInfo(request);
			if ("ADD".equals(librarySearch.getEditMode())) {
				int insertCount = 0;

				insertCount = loanRequestService.insertLoanRequest(LoanRequest.ofCreate(librarySearch.getManageCode(),member.getRec_key(),member.getMember_id(),member.getMember_name(),librarySearch.getRegNo(),librarySearch.getBook_name(),librarySearch.getAuthor(),librarySearch.getDevice_code(),request.getRemoteAddr()));

				if (insertCount > 0) {
					res.setValid(true);
					res.setMessage("드론대출 신청이 되었습니다.");
				}
			} else if ("CANCEL".equals(librarySearch.getEditMode())) {
				String message = loanRequestService.updateStatus(LoanRequest.ofUpdateStatus(librarySearch.getRequest_idx(), librarySearch.getManageCode(),librarySearch.getUserkey(), member.getMember_id(), request.getRemoteAddr(), "0000"));
				res.setValid(true);
				if ("success".equals(message)) {
					res.setMessage("드론대출 신청이 취소되었습니다.");
				} else {
					res.setMessage("드론대출 취소에 실패 하였습니다. 관리자에게문의 해주세요. \nAPI 오류 : "+message);
				}
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	/**
	 * 게시판 형식의 자료검색
	 * @author whalesoft HWAN
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @param homepagePath
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/recommandIndex.*"})
	public String recommandIndex(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response, @PathVariable("homepagePath") String homepagePath) throws Exception {
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
		
		Map<String, Object> shelfInfo = LibSearchAPI.getSubLocaInfo("19", homepage.getManage_code());
		List<Map<String, Object>> shelfInfoList = getShelfInfoList(shelfInfo);
		model.addAttribute("shelfCodeList", shelfInfoList);

		if(!(StringUtils.isNotEmpty(librarySearch.getShelfCode())) && "h45".equals(homepage.getHomepage_id())) {
			List<String> shelfCodes = new ArrayList<String>();
			List<Map<String, Object>> libraryCodes = LibSearchAPI.getListData(shelfInfo);
			
			for(int i=0; i < libraryCodes.size(); i++) {
				shelfCodes.add(i, (String) libraryCodes.get(i).get("CODE"));
			}
			
			librarySearch.setShelfCodes(shelfCodes);
		}

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

		Map<String, Object> subLocaInfo = LibSearchAPI.getSubLocaInfo("5", homepage.getManage_code());
		List<Map<String, Object>> mediaCodeList = LibSearchAPI.getListData(subLocaInfo);

		model.addAttribute("mediaCodeList", mediaCodeList);
		model.addAttribute("librarySearch", librarySearch);

		return String.format(basePath, homepage.getFolder()) + "recommandIndex";
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
	@RequestMapping(value = {"/recommandDetail.*"})
	public String recommandDetail(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request) {
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

			//알라딘 API 결과 가져오기, 알라딘 API 결과 못 가져올 시 서버에서 이미지 가져오기
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
		
		return String.format(basePath, homepage.getFolder()) + "recommandDetail";
	}
	
	/**
	 * 희망도서 대출내역 조회
	 * @author whalesoft HWAN 2023. 05. 15.
	 * @param homepagePath
	 * @param model
	 * @param librarySearch
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = {"/baro/index.*"})
	public String baroMyLoan(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, +3);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		if (StringUtils.isEmpty(librarySearch.getSearch_start_date())) {
			librarySearch.setSearch_start_date(sdf.format(new Date()));
		}
		if (StringUtils.isEmpty(librarySearch.getSearch_end_date())) {
			librarySearch.setSearch_end_date(sdf.format(cal.getTime()));
		}

		librarySearch.setUserkey(member.getUser_no());
		
		Map<String, Object> result = LibSearchAPI.getBaroLoanHistory(librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCountBaro(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);
		
		if (result != null && !result.isEmpty() && result.get("search_list") != null) {
			list = LibSearchAPI.getListDataBaro(result);
		}
		
		model.addAttribute("hopeList", list);
		
		return String.format(basePath, homepage.getFolder()) + "baro/index";
	}

}
