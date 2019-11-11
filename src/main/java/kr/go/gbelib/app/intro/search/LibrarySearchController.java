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
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
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
	private CalendarManageService calendarManageService;

	@ModelAttribute
	public void introMenu(Model model) {
		model.addAttribute("introMenu", "자료검색");//임시
	}

	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		// 소장처 코드
		if ( StringUtils.isEmpty(librarySearch.getManageCode()) ) {
			librarySearch.setManageCode(homepage.getHomepage_code());
		}

		if ( librarySearch.getLibraryCodes() == null ) {
			List<String> libraryCodes = new ArrayList<String>();
			if ( !StringUtils.isEmpty(homepage.getHomepage_code()) ) {
				libraryCodes.add(homepage.getHomepage_code());
			} else {
				libraryCodes.add("ALL");
			}
			librarySearch.setLibraryCodes(libraryCodes);
		}

		if ( StringUtils.isNotEmpty(librarySearch.getBooktype()) ) {
			Map<String, Object> result = new HashMap<String, Object>();
			if (StringUtils.equals(librarySearch.getSearch_type(), "L_TITLE")) {
				librarySearch.setTitle(librarySearch.getSearch_text());
			} else if (StringUtils.equals(librarySearch.getSearch_type(), "L_AUTHOR")) {
				librarySearch.setAuthor(librarySearch.getSearch_text());
			} else if (StringUtils.equals(librarySearch.getSearch_type(), "L_PUBLISHER")) {
				librarySearch.setPubler(librarySearch.getSearch_text());
			} else if (StringUtils.equals(librarySearch.getSearch_type(), "L_KEYWORD")) {
				librarySearch.setKeyword(librarySearch.getSearch_text());
			}
			if ( librarySearch.getBooktype().equals("BOOK") ) {
				result = LibSearchAPI.getBookDetail(librarySearch);
			} else if (librarySearch.getBooktype().equals("NONBOOK")) {
				result = LibSearchAPI.getNonBookDetail(librarySearch);
			} else {
//				result = LibSearchAPI.getSerialDetail(librarySearch);
				//TODO 연속간행물 검색 추가
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




		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("homepage", homepage);
		return basePath + "index";
	}


	@RequestMapping(value = {"/hotTrend.*"})
	public String hotTrend(Model model, LibrarySearch librarySearch, HttpServletRequest request, @PathVariable String context_path) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		Map<String, Object> hotTrendWordList = LibSearchAPI.getHotTrendWordList(homepage.getHomepage_code());

		int count = LibSearchAPI.getSearchCount(hotTrendWordList);

		if ( count > 0 ) {
			model.addAttribute("hotTrendList", LibSearchAPI.getListData(hotTrendWordList));
		}

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
		String returnPage = "detail";

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

		// Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);

		model.addAttribute("librarySearch", librarySearch);

		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);

		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if ( count > 0 ) {

			list = LibSearchAPI.getListData(result);
			model.addAttribute("detail", list.get(0));


		}
		model.addAttribute("homepage", homepage);
		return basePath + returnPage;
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