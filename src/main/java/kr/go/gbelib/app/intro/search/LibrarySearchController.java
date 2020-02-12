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
import kr.go.gbelib.app.cms.module.smsReception.SmsReceptionService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;

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
	private SmsReceptionService smsReceptionService;

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
		}

		model.addAttribute("homepageList", normalHomepage);
		model.addAttribute("librarySearch", librarySearch);

		return basePath + "index";
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
		Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getManage_code());

		int count = LibSearchAPI.getSearchCount(hotTrendWordList);

		if ( count > 0 ) {
			model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
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
	 * @param index
	 * @return
	 */
	@RequestMapping(value = {"/detail.*"})
	public String detail(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request) {

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

			model.addAttribute("detail", map);
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
		if (StringUtils.isEmpty(librarySearch.getManageCode())) {
			librarySearch.setManageCode(homepage.getManage_code());
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

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
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
		JsonResponse res = new JsonResponse(request);
		if ( !result.hasErrors() ) {
			if ( librarySearch.getEditMode().equals("ADD") ) {

			} else if ( librarySearch.getEditMode().equals("RENEW") ) {

				// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
//				LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0002");
//				if(lasReqConfig != null) {
//					res.setValid(false);
//					res.setMessage(lasReqConfig.getRes_msg());
//					return res;
//				}

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

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		Map<String, Object> result = LibSearchAPI.getReserveList(member.getRec_key());
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( result != null && !result.isEmpty() && result.get("LIST_DATA") != null ) {
			list = LibSearchAPI.getListData(result);
		}

		model.addAttribute("resveList", list);

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

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			return res;
		}

		if ( !result.hasErrors() ) {
			Member member = getSessionMemberInfo(request);
			if ( !StringUtils.equals(member.getMember_class(), "0") ) {// 정회원만 가능
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}

			librarySearch.setUserkey(member.getRec_key());
			if (librarySearch.getEditMode().equals("ADD")) {

				// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
//				LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0001");
//				if(lasReqConfig != null) {
//					res.setValid(false);
//					res.setMessage(lasReqConfig.getRes_msg());
//					return res;
//				}

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
	public String sanghoHistory(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		if ( !StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y") ) {
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
	public String sanghoUsedHistory(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		if ( !StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y") ) {
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
	public String sanghoForm(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("librarySearch", librarySearch);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);
		if ( !StringUtils.equals(member.getKl_member_yn(), "Y") ) {
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

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			result.reject("로그인 후 이용가능합니다.");
		}

		if ( !StringUtils.equals(getSessionMemberInfo(request).getKl_member_yn(), "Y") ) {
			result.reject("책이음회원이 아니므로 상호대차 신청이 불가능합니다");
		}

		if ( !result.hasErrors() ) {

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

				if ( librarySearch.getBooktype() == null ) {
					librarySearch.setBooktype("BOOK");
				}

//				if ( librarySearch.getBooktype().equals("BOOK") ) {
//					bookResult = LibSearchAPI.getBookDetail(librarySearch);
//				} else {
//					bookResult = LibSearchAPI.getNonBookDetail(librarySearch);
//				}

				bookResult = LibSearchAPI.getBookInfo(librarySearch);


				List<Map<String, Object>> list = null;

				int count = LibSearchAPI.getSearchCount(bookResult);

				if ( count > 0 ) {

					list = LibSearchAPI.getListData(bookResult);
					Map<String, Object> map = list.get(0);

					librarySearch.setUserkey(getSessionMemberInfo(request).getUser_no());
					librarySearch.setRegNo(String.valueOf(map.get("REG_NO")));
					librarySearch.setLibCode(String.valueOf(map.get("LIB_CODE")));
					librarySearch.setSpeciesKey(String.valueOf(map.get("SPECIES_KEY")));
//				librarySearch.setUselibcode(String.valueOf(map.get("")));
					librarySearch.setBookkey(String.valueOf(map.get("BOOK_KEY")));

					Map<String, Object> sanghoReq = LibSearchAPI.sanghoReq(librarySearch);
					@SuppressWarnings ("unchecked")
					Map<String, Object> sanghoResult = (Map<String, Object>) sanghoReq.get("ITEM");

					if (sanghoResult.containsKey("RESULT")) {
						if (String.valueOf(sanghoResult.get("RESULT")).equals("OK")) {
							res.setValid(true);
							res.setMessage("신청되었습니다.");
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
		return basePath + "hope/req";
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
						bookSerach.setManageCode(homepage.getManage_code());
						bookSerach.setIsbn(isbn);
						Map<String, Object> sameBook = (Map<String, Object>) LibSearchAPI.getBookDetail(bookSerach);

						int sameBookCount = LibSearchAPI.getSearchCount(sameBook);

						boolean already = false;
						if (sameBookCount > 0) {
							already = true;
						}
						map2.put("already"+isbn.length(), already);

					}

				}
				service.setPaging(model, totalCount, librarySearch);
				model.addAttribute("naverResult", map);
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

//				Homepage homepage = getSessionHomepage(request);
//				HopebookConfig hopebookConfig = hopebookConfigService.getHopebookConfigInfo(homepage.getHomepage_id());
//				if(hopebookConfig != null) {
//					res.setValid(false);
//					res.setMessage(hopebookConfig.getRes_msg());
//					return res;
//				}

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
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
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
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
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

			// 0001:예약, 0002:연기, 0003:야간대출, 0004:무인대출
//			LasReqConfig lasReqConfig = lasReqConfigService.getLasReqConfigInfo(librarySearch, "0003");
//			if(lasReqConfig != null) {
//				res.setValid(false);
//				res.setMessage(lasReqConfig.getRes_msg());
//				return res;
//			}

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
	public String print(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {

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

		return basePath + "print_ajax";
	}



}