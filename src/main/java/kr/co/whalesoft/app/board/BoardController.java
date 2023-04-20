package kr.co.whalesoft.app.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.gbelib.app.common.api.PointApi;
import kr.go.gbelib.app.common.api.PointReqeust;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import freemarker.template.utility.StringUtil;
import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.board.boardFile.BoardFileService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.boardManage.fieldManage.FieldManage;
import kr.co.whalesoft.app.cms.boardManage.fieldManage.FieldManageService;
import kr.co.whalesoft.app.cms.boardRegexFilter.BoardRegexFilter;
import kr.co.whalesoft.app.cms.boardRegexFilter.BoardRegexFilterService;
import kr.co.whalesoft.app.cms.boardWordFilter.BoardWordFilter;
import kr.co.whalesoft.app.cms.boardWordFilter.BoardWordFilterService;
import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;
import kr.go.gbelib.app.cms.module.themeBook.ThemeBook;
import kr.go.gbelib.app.cms.module.themeBook.ThemeBookService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.PushAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchService;

@Controller
@RequestMapping(value = {"/board", "/{homepagePath}/board"})
public class BoardController extends BaseController {

//	private String basePath = "";
//	private String contextPath = "";
//	private Homepage homepage = null;
//	private BoardManage boardManage = null;
//	private List<FieldManage> fieldList = null;

	@Autowired
	private BoardService service;
	@Autowired
	private BoardFileService boardFileService;
	@Autowired
	private CodeService codeService;
	@Autowired
	private FieldManageService fieldManageService;
	@Autowired
	private BoardManageService boardManageService;
	@Autowired
	private HomepageService homepageService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardWordFilterService boardWordFilterService;
	@Autowired
	private BoardRegexFilterService boardRegexFilterService;
	@Autowired
	private ThemeBookService themeBookService;
	@Autowired
	private TermsService termsService;
	@Autowired
	private LibrarySearchService librarySearchService;

	private String getBoardContext(HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		if(homepage != null) {
			return "/" + homepage.getContext_path();
		} else {
			return "";
		}
	}

	/** 공통 **/
	private String attributeInit(HttpServletRequest request, Model model, Board board, String mode) {

		Homepage homepage = (Homepage)request.getAttribute("homepage");

		//PMS같은 사이트를 위해 적용함 pms게시판 563번에 category2에 홈페이지 구분이 들어있음
		if(request.getAttribute("member_homepage_id") != null && homepage.getHomepage_id().equals("c0")){
			//2017.07.13 타도서관의 글을 확인하게 위해 코드 삭제
//			board.setCategory2((String) request.getAttribute("member_homepage_id"));
		}

		String basePath = "";
		String homepageFolder = "";

		// CMS -> 게시판 관리
		String homepage_id = request.getParameter("homepage_id");


		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
			homepage_id = homepage.getHomepage_id();
		}

		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");

		if(model != null) {
			model.addAttribute("boardManage", boardManage);

			/**
			 * 커스텀 필드 사용
			 */
			if ( boardManage != null ) {
				if(boardManage.getBoard_type().indexOf("CUSTOM") > -1) {
					List<FieldManage> fieldList = null;

					if(mode != null && mode.equals("EDIT")) {
						fieldList = fieldManageService.getBoardFieldManageByEdit(new FieldManage(boardManage.getManage_idx()));
						model.addAttribute("fieldList", fieldList);
					} else if(mode != null && mode.equals("REPLY")) {
						fieldList = fieldManageService.getBoardFieldManageByReply(new FieldManage(boardManage.getManage_idx()));
						model.addAttribute("fieldList", fieldList);
					} else if(mode != null && mode.equals("VIEW")) {
						fieldList = fieldManageService.getBoardFieldManageByView(new FieldManage(boardManage.getManage_idx()));
						model.addAttribute("fieldList", fieldList);
					} else {
						fieldList = fieldManageService.getBoardFieldManageByList(new FieldManage(boardManage.getManage_idx()));
						model.addAttribute("fieldList", fieldList);
					}

					List<String> columnList = new ArrayList<String>();
					for(FieldManage fieldManage : fieldList) {
						columnList.add(fieldManage.getBoard_column());
					}

					board.setBoard_field_list(columnList);
				}

				if(boardManage.getCategory_use_yn() != null && boardManage.getCategory_use_yn().equals("Y")) {
					if(boardManage.getCategory1() != null && !boardManage.getCategory1().equals("")) {
						model.addAttribute("category1List", codeService.getCode(homepage_id, boardManage.getCategory1()));
					}
					if(boardManage.getCategory2() != null && !boardManage.getCategory2().equals("")) {
						model.addAttribute("category2List", codeService.getCode(homepage_id,boardManage.getCategory2()));
					}
					if(boardManage.getCategory3() != null && !boardManage.getCategory3().equals("")) {
						model.addAttribute("category3List", codeService.getCode(homepage_id,boardManage.getCategory3()));
					}
					if(boardManage.getCategory4() != null && !boardManage.getCategory4().equals("")) {
						model.addAttribute("category4List", codeService.getCode(homepage_id,boardManage.getCategory4()));
					}
					if(boardManage.getCategory5() != null && !boardManage.getCategory5().equals("")) {
						model.addAttribute("category5List", codeService.getCode(homepage_id,boardManage.getCategory5()));
					}
				}

			}
			else {
				return null;
			}
		}
		else {
			return null;
		}

		basePath = homepageFolder + "/board/" + boardManage.getBoard_type() + "/";

		log.debug("board basePath : " + basePath);
		return basePath;
	}

	public boolean manageCompareIdx(int manage_idx, int... args) {
		for (int i : args) {
			if(manage_idx == i) {
				return true;
			}
		}
		return false;
	}

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Board board, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		checkAuth("R", model, request);
		log.debug("sortField : " + board.getSortField());
		log.debug("sortType : " + board.getSortType());



		String basePath = attributeInit(request, model, board, null);
		String returnPath = basePath + "index";
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		//System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + PointApi.rule(PointReqeust.formApikey(homepage.getPoint_api_key())));
		if (homepage == null) {
			//cms에서는 homepage 객체가 없어서 따로 가져옴.
			Homepage homepageOne = homepageService.getHomepageOne(new Homepage(board.getHomepage_id()));
			model.addAttribute("homepage", homepageOne);
		}

		boolean isSiteAdmin = false;
		try {
			isSiteAdmin = (Boolean) model.asMap().get("authMBA");
		} catch (Exception e) {
			isSiteAdmin = false;
		}
		
		if(!isSiteAdmin && boardManage.getBoard_use_yn().equals("N")) {
			service.alertMessage("유효하지 않은 게시판입니다.", request, response);
			return null;
		}

		// 228도서관 지원센터 회원인증 확인
		SupportMember loginSupport = sessionLoginSupport(request);
		boolean supportAdmin = false;
		boolean supportAuth = false;
		if(manageCompareIdx(board.getManage_idx(), 212, 213, 224, 225, 226, 227, 228, 230, 281)) {
			if (loginSupport == null && !getSessionIsAdmin(request) && !isSiteAdmin) {
	    		board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
	    		service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
	    		return null;
	        }

			if(loginSupport != null) {
				if(loginSupport.isLogin() == true) {
					supportAuth = true;
				}

				try {
					supportAdmin = (Boolean) model.asMap().get("authMBS");
				} catch (Exception e) {
					supportAdmin = false;
				}
			}

			if (boardManage.getWrite_only_yn().equals("Y") && !"CMS".equals(getSessionMemberLoginType(request)) && !supportAdmin) {
				String write_url = "edit.do?manage_idx="+request.getParameter("manage_idx")+"&menu_idx="+request.getParameter("menu_idx");
				service.alertMessageAndUrl("", write_url, request, response);
				return null;
			}
		}
		model.addAttribute("supportAdmin", supportAdmin);
		model.addAttribute("supportAuth", supportAuth);

		// 대표도서관 사서 인증
		PortalMember loginPortal = sessionLoginPortal(request);
		String portal_auth = loginPortal == null ? "0" : loginPortal.getAuth_group();
		if(!portal_auth.equals("2") && !portal_auth.equals("4") && manageCompareIdx(board.getManage_idx(), 203, 288)) {
			board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
    		service.alertMessageAndUrl("대표도서관 사서 회원 인증 후 이용가능합니다.", String.format("/%s/module/portalMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
    		return null;
		}
		model.addAttribute("portalAuth", portal_auth);

		if (boardManage.getWrite_only_yn().equals("Y") && !"CMS".equals(getSessionMemberLoginType(request)) && (loginSupport != null && !loginSupport.isLogin())) {
			StringBuffer sb = new StringBuffer();
			sb.append(isLogin(request) ? "edit" : "cert");
			sb.append(".do?manage_idx=").append(request.getParameter("manage_idx"));
			if (StringUtils.isNotBlank(request.getParameter("menu_idx"))) {
				if (Integer.parseInt(request.getParameter("menu_idx")) > 0) {
					sb.append("&menu_idx=").append(request.getParameter("menu_idx"));
				}
			}
			service.alertMessageAndUrl("", sb.toString(), request, response);
			return null;
		}


		//999 대표 영화
		//526 대표뉴스 대구는 대표뉴스없음
		//282 대표 공지
		//195 대표 추천도서
//		if (board.getManage_idx() != 999 && board.getManage_idx() != 282 && board.getManage_idx() != 523) {
		if (board.getManage_idx() != 282 && board.getManage_idx() != 195) {
			board.setHomepage_id(boardManage.getHomepage_id());
		}

		board.setCategory1Manage(boardManage.getCategory1());
		board.setCategory2Manage(boardManage.getCategory2());
		board.setCategory3Manage(boardManage.getCategory3());
		board.setCategory4Manage(boardManage.getCategory4());
		board.setCategory5Manage(boardManage.getCategory5());

		model.addAttribute("boardNoticeList", service.getBoardNotice(board));
		if (boardManage.getBoard_type().equals("NOTICE") && board.getManage_idx() != 282) {
			model.addAttribute("boardNoticeList2", service.getBoardNotice2(board));
		}
//		if (boardManage.getBoard_type().equals("NEWS") && board.getManage_idx() != 523) {
//			model.addAttribute("boardNoticeList2", service.getBoardNews2(board));
//		}


		if (boardManage.getBoard_type().equals("NOTICE")  && StringUtils.isEmpty(board.getStart_date())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			if (StringUtils.isEmpty(board.getSearchStartDate())) {
				board.setSearchStartDate(sf.format(DateUtils.addYears(new Date(), -1)));
			}
			if (StringUtils.isEmpty(board.getSearchEndDate())) {
				board.setSearchEndDate(sf.format(new Date()));
			}
		}

		if (boardManage.getBoard_type().equals("NOTICE")) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			model.addAttribute("subHomepageList",homepageService.getSubHomepageList(h));
		}


		//영화게시판
		if (boardManage.getBoard_type().equals("MOVIE")){
			Device device = DeviceUtils.getCurrentDevice(request);
			model.addAttribute("isMobile",  device.isMobile() || device.isTablet());
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}
		}

		//BOOK게시판
		if (boardManage.getBoard_type().equals("BOOK") || boardManage.getBoard_type().equals("BOOK_PORTAL")){
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}
			if (StringUtils.isNotEmpty(board.getSearch_text())) {
				board.setPlan_date("");
			}
		}

		//FAQ게시판
		if (boardManage.getBoard_type().equals("FAQ")){
			if(StrUtil.isInStr(board.getBoard_mode(), "admin")){
				returnPath = basePath + "index_normal";
			}
		}

		//QNA 질의및 응답게시판
		if (boardManage.getBoard_type().equals("QNA")){
			request.setAttribute("request_state_list", codeService.getCode("CMS",boardManage.getRequest_code()));
		}

		String tmpCategory = "";
		if (boardManage.getManage_idx() == 563 && StringUtils.equals(board.getCategory1(), "0000")) {
			tmpCategory = board.getCategory2();
			board.setCategory2("");
		}
		
		// 간행물
		if (boardManage.getBoard_type().equals("INITIAL")) {
			initSearchSetting(board);
//			if (StringUtils.isNotEmpty(board.getInitSearch())) {
//				model.addAttribute("moduleSubTitle", " > " + board.getInitSearch());
//			}
		}

		//겔러리게시판, 갤러리슬라이더 게시판
		if (boardManage.getBoard_type().equals("GALLERY") || boardManage.getBoard_type().equals("GALLERYSLIDER") || 
			boardManage.getBoard_type().equals("LACHIVIUM01") || boardManage.getBoard_type().equals("LACHIVIUM02")
			|| boardManage.getBoard_type().equals("CURATIONGALLERY")) {
			service.setPagingGallery(model, service.getBoardCount(boardManage, board), board);
		}else if (boardManage.getBoard_type().equals("LIB_INFO")) {
			service.setPaging(model, service.getBoardCount(boardManage, board), board);
			model.addAttribute("categoryCount", service.getBoardLibInfoCategoryCount(board));
		}else{
			service.setPaging(model, service.getBoardCount(boardManage, board), board);
		}
		model.addAttribute("boardList", service.getBoard(boardManage, board));

		//PMS 공지사항
		if (boardManage.getManage_idx() == 563 && StringUtils.equals(board.getCategory1(), "0000")) {
			board.setCategory2(tmpCategory);
		}
		if (boardManage.getManage_idx() == 563 && !StringUtils.equals(board.getCategory1(), "0000")) {
			model.addAttribute("requestCount", service.getRequestBoardStateCount(board));
		}


		model.addAttribute("board", board);
		model.addAttribute("boardManage", boardManage);
		


		log.debug("retrunPath : " + returnPath);

		return returnPath;
//		if(boardManage.getAdd_only_yn().equals("Y") && !boardManage.isAdmin_auth_check()) {
//			redirectAttributes.addAttribute("menu_idx", board.getMenu_idx());
//			redirectAttributes.addAttribute("manage_idx", board.getManage_idx());
//			return "redirect:edit.do";
//		} else {
//			service.setPaging(model, service.getBoardCount(boardManage, board), board);
//
//			if(boardManage.isAdmin_auth_check()) {
//				return basePath + "index";
//			} else {

//			}
//		}
	}
	
	/**
	 * 초성검색을 위한 검색용 변수 세팅
	 * @author YONGJU 2018. 1. 8.
	 * @param board
	 */
	private void initSearchSetting(Board board) {
		String[] initSearch = {"ㄱ","ㄴ","ㄷ","ㄹ","ㅁ","ㅂ","ㅅ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"};
		String[] initSearch2 = {"가","나","다","라","마","바","사","아","자","차","카","타","파","하"};

		if (StringUtils.isNotEmpty(board.getInitSearch())) {
			if (board.getInitSearch().equals("A")) {
				board.setInitSearch2("0");
				board.setInitSearchNext("z");
			} else if (board.getInitSearch().equals("ㅎ")) {
				board.setInitSearch2("하");
				board.setInitSearchNext("힇");
			} else {
				int idx =  Arrays.asList(initSearch).indexOf(board.getInitSearch());
				board.setInitSearch2(initSearch2[idx]);
				board.setInitSearchNext(initSearch2[idx+1]);
			}
		}
	}

	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String basePath = attributeInit(request, model, board, "EDIT");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if (homepage == null) {
			//cms에서는 homepage 객체가 없어서 따로 가져옴.
			Homepage homepageOne = homepageService.getHomepageOne(new Homepage(board.getHomepage_id()));
			model.addAttribute("homepage", homepageOne);
		}

		// 228도서관 지원센터 회원인증 확인
		SupportMember loginSupport = sessionLoginSupport(request);
		boolean supportAdmin = false;
		if(manageCompareIdx(board.getManage_idx(), 212, 213, 224, 225, 226, 227, 228, 230, 281)) {
			checkAuth("R", model, request);
			boolean isSiteAdmin = false;
			try {
				isSiteAdmin = (Boolean) model.asMap().get("authMBA");
			} catch (Exception e) {
				isSiteAdmin = false;
			}
			if ( loginSupport == null && !getSessionIsAdmin(request) && !isSiteAdmin) {
				board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), boardManage.getManage_idx()));
				service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
				return null;
	        }

			if(loginSupport != null) {
				if(loginSupport.isAdmin() == true) {
					supportAdmin = true;
				}
			}

			// 3 : 학교지원일 경우, 4 : 선정위원일 경우
//			String suppot_auth = loginSupport == null ? "0" : loginSupport.getAuth_group();
//			if((suppot_auth.equals("4") && !getSessionIsAdmin(request)) && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 213, 225, 226, 228)) {
//				service.alertMessage("관리자 또는 학교기관만 이용할 수 있습니다.", request, response);
//			} else if((suppot_auth.equals("3") && !getSessionIsAdmin(request)) && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 230)) {
//				service.alertMessage("관리자 또는 도서선정위원만 이용할 수 있습니다.", request, response);
//			} else if(!getSessionIsAdmin(request) && !suppot_auth.equals("1") && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 212, 224, 227)) {
//				service.alertMessage("관리자만 이용할 수 있습니다.", request, response);
//			}

			try {
				checkAuth("C", model, request);
				checkAuth("U", model, request);
			} catch(AuthException ax) {
				if(!getSessionIsAdmin(request) && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 213, 225, 226, 228)) {
					service.alertMessage("관리자 또는 학교기관만 이용할 수 있습니다.", request, response);
					return null;
				} else if((!getSessionIsAdmin(request)) && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 230)) {
					service.alertMessage("관리자 또는 도서선정위원만 이용할 수 있습니다.", request, response);
					return null;
				} else if(!getSessionIsAdmin(request) && !isSiteAdmin && manageCompareIdx(board.getManage_idx(), 212, 224, 227)) {
					service.alertMessage("관리자만 이용할 수 있습니다.", request, response);
					return null;
				}
			}
		}
		model.addAttribute("supportAdmin", supportAdmin);

		// 대표도서관 사서 인증
		PortalMember loginPortal = sessionLoginPortal(request);
		String portal_auth = loginPortal == null ? "0" : loginPortal.getAuth_group();
		if(!portal_auth.equals("2") && !portal_auth.equals("4") && manageCompareIdx(board.getManage_idx(), 203, 288)) {
			service.alertMessage("대표도서관 사서 회원 인증 후 이용가능합니다.", request, response);
    		return null;
		}
		model.addAttribute("portalAuth", portal_auth);

//		if (board.getManage_idx() == 563) {
//			Member memberTemp = getSessionMemberInfo(request);
//			if (!memberTemp.isAdmin()) {
//				if (StringUtils.startsWith(getAsideHomepageId(request), "c")) {
//					try {
//						request.getSession().setAttribute("asideHomepageId", memberTemp.getAuthorityHomepageList().get(0).getHomepage_id());
//					} catch ( Exception e ) {
//						// TODO: handle exception
//					}
//				}
//			}
//		}

		//질의응답게시판
		if (boardManage.getBoard_type().equals("QNA")){
			request.setAttribute("request_state_list", codeService.getCode("CMS",boardManage.getRequest_code()));
		}
		// 분실 게시판
		else if (boardManage.getBoard_type().equals("LOSTCARD") && board.getEditMode().equals("ADD")) {

			board.setAdd_id(getSessionMemberId(request));

			int requestCount = service.checkLostCardBoard(board);

			if(requestCount > 0) {
				service.alertMessage("분실신고가 이미 등록되어 있습니다.", request, response);
			}
		} else if (boardManage.getBoard_type().equals("NOTICE")) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			model.addAttribute("subHomepageList",homepageService.getSubHomepageList(h));
		} else if(boardManage.getBoard_type().equals("MOVIE")) {
			board.setImsi_v_3(boardManage.getMovie_hour());
			board.setImsi_v_4(boardManage.getMovie_minute());
			board.setImsi_v_6(boardManage.getMovie_place());
		}
		//테마게시판
		if (boardManage.getBoard_type().equals("THEMEBOOK")){
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}
		}
		//수정일 경우
		if(board.getEditMode().equals("MODIFY")) {
//			if(loginSupport == null && loginPortal == null) {
				checkAuth("U", model, request);
//			}
			Board boardOne = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));

			boolean isBoardAdmin = false;
			if(loginSupport == null && loginPortal == null) {
				isBoardAdmin = (Boolean) model.asMap().get("authMBA");
			} else if(loginSupport != null && !supportAdmin){
				if(!loginSupport.getMember_id().equals(boardOne.getAdd_id())) {
					service.alertMessage("권한이 없습니다.", request, response);
					return null;
				}
				isBoardAdmin = true;
			} else if(loginPortal != null && !portal_auth.equals("2")) {
				if(!loginPortal.getAgency_id().equals(boardOne.getAdd_id())) {
					service.alertMessage("권한이 없습니다.", request, response);
					return null;
				}
				isBoardAdmin = true;
			}
			
			if(!isBoardAdmin && boardManage.getBoard_use_yn().equals("N")) {
				service.alertMessage("유효하지 않은 게시판입니다.", request, response);
				return null;
			}

			if (!isBoardAdmin && !supportAdmin && !portal_auth.equals("2")) {
				//회원의 글인 경우
				if (!boardOne.getAdd_id().equals("ANONYMOUS")) {
					Member memberTemp = getSessionMemberInfo(request);
					if (!boardOne.getAdd_id().equals(memberTemp.getMember_id())) {
						service.alertMessage("권한이 없습니다.", request, response);
						return null;
					}
				} else {
					//비회원의 글인 경우
					//비로그인 상태에서 비회원의 글을 수정 시 비밀번호 확인 페이지로 이동한다.
					Object checkPassBoardInfo = request.getSession().getAttribute("checkPassBoardInfo");
					if (checkPassBoardInfo == null || !(checkPassBoardInfo instanceof Board)) {
						request.getSession().setAttribute("checkPassBoardInfo", board);
						service.redirectUrl("checkPass.do?menu_idx="+board.getMenu_idx(), request, response);
						return null;
					} else {
						//비밀번호 인증을 한 경우 비밀번호 인증한 글(checkPassBoardInfo)과 조회하려는 글의 데이터를 비교한다.
						Board boardInfo = (Board) checkPassBoardInfo;
						if (boardInfo.getManage_idx() == boardOne.getManage_idx() && boardInfo.getBoard_idx() == boardOne.getBoard_idx() && "Y".equals(boardInfo.getPassword_yn())) {
							//정상적으로 접근한 경우 인증 정보를 삭제한다.
							boardInfo.setEditMode("ANONYMOUS_SAVE");
							boardInfo.setPassword_yn("N");
							request.getSession().setAttribute("checkPassBoardInfo", boardInfo);
						} else {
							//일치하지 않는 경우 패스워드 확인 페이지로 다시 이동
							request.getSession().setAttribute("checkPassBoardInfo", board);
							service.redirectUrl("checkPass.do?menu_idx="+board.getMenu_idx(), request, response);
							return null;
						}
					}
				}
			}

//			if (StringUtils.isNotBlank(boardOne.getImsi_v_20())) {
//				Member memberTemp = getSessionMemberInfo(request);
//				if (!memberTemp.getMember_id().equals(boardOne.getUser_id())) {
//					service.alertMessage("권한이 없습니다.", request, response);
//					return null;
//				}
//			} else {
//				//비회원의 비밀글인 경우
//				Object certObject = request.getSession().getAttribute("certMember");
//				if (certObject == null || !(certObject instanceof Member)) {
//					service.alertMessage("권한이 없습니다.", request, response);
//					return null;
//				} else {
//					Member m = (Member) certObject;
//					if (!m.getCi_value().equals(boardOne.getImsi_v_20())) {
//						service.alertMessage("권한이 없습니다.", request, response);
//						return null;
//					}
//				}
//			}

//			if ( boardOne.getSecret_yn().equals("Y") && StringUtils.isNotEmpty(boardOne.getUser_password()) ) {
//				if ( !boardOne.getUser_password().equals(CalculateHashUtils.calculateHash(board.getUser_password())) ) {
//					service.alertMessage("비밀번호가 틀립니다.", request, response);
//					return null;
//				}
//			}

			boardOne.setMenu_idx(board.getMenu_idx());
			model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
			model.addAttribute("boardStoragePath", service.getBoardStoragePath());
			model.addAttribute("board", service.copyObjectPaging(board, boardOne));

		} else {
			checkAuth("C", model, request);
			
			// 최고관리자가 아니고 비회원이 아닐경우 회원 성명, 연락처 등록시 입력
			Member memberTemp = getSessionMemberInfo(request);
			if(!(Boolean)model.asMap().get("authMBA") && !memberTemp.isAnonymous()) {
				if(StringUtils.isEmpty(board.getUser_name())) {
					board.setUser_name(memberTemp.getMember_name());
				}
				if(StringUtils.isEmpty(board.getUser_phone())) {
					board.setUser_phone(memberTemp.getCell_phone());
				}
			}

			if (!isLogin(request)) {
				Object certObject = request.getSession().getAttribute("certMember");
				if (certObject == null || !(certObject instanceof Member)) {
					service.alertMessage("권한이 없습니다.", request, response);
					return null;
				}
			}


			model.addAttribute("board", board);
			model.addAttribute("getToday", new Date());

		}

		Terms t = new Terms();
		t.setHomepage_id(homepage.getHomepage_id());
		t.setManage_idx(boardManage.getManage_idx());

		model.addAttribute("termsList", termsService.getTermsListInBoard(t));

		boardFileService.initBoardFile(board, request);

		return basePath + "edit";
	}

	@RequestMapping(value = {"/otherBoardEdit.*"}, method = RequestMethod.GET)
	public String otherBoardEdit(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String basePath = attributeInit(request, model, board, "EDIT");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");

		//등록될 연결 게시판 정보 등록 563 PMS 게시판
		BoardManage otherBoardManage = new BoardManage();
		otherBoardManage.setHomepage_id("c0");
		otherBoardManage.setManage_idx(563);
		otherBoardManage = boardManageService.getBoardManageOne(otherBoardManage);
		request.setAttribute("otherBoardManage", otherBoardManage);

		//수정일 경우
		/*if(board.getEditMode().equals("MODIFY")) {
			Board boardOne = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));

			if ( StringUtils.isNotEmpty(boardOne.getUser_password()) ) {
				if ( !boardOne.getUser_password().equals(CalculateHashUtils.calculateHash(board.getUser_password())) ) {
					service.alertMessage("비밀번호가 틀립니다.", request, response);
					return null;
				}
			}

			boardOne.setMenu_idx(board.getMenu_idx());
			model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
			model.addAttribute("boardStoragePath", service.getBoardStoragePath());
			model.addAttribute("board", service.copyObjectPaging(board, boardOne));

		} else {*/
		if(board != null){
			Code code1 = codeService.getCodeOne(boardManage.getHomepage_id(),boardManage.getCategory1(),board.getCategory1());
			Code code2 = codeService.getCodeOne(boardManage.getHomepage_id(),boardManage.getCategory2(),board.getCategory2());
			Code code3 = codeService.getCodeOne(boardManage.getHomepage_id(),boardManage.getCategory3(),board.getCategory3());
			if(code1 != null)
				board.setCategory1_name(code1.getCode_name());
			if(code2 != null)
				board.setCategory2_name(code2.getCode_name());
			if(code3 != null)
				board.setCategory3_name(code3.getCode_name());
		}

		board.setEditMode("OTHERBOARDEDIT");


		model.addAttribute("board", board);
		model.addAttribute("getToday", new Date());

		//}

		//겔러리게시판 리스트 가져오기
		//service.setPagingGallery(model, service.getBoardCount(boardManage, board), board);

		List<Board> boardList = service.getBoard(boardManage, board);

		for ( Board board2 : boardList ) {
			board2.setBoardFile(boardFileService.getBoardFile(board2.getBoard_idx()));
		}

		model.addAttribute("boardList", boardList);
		model.addAttribute("board", board);

		return basePath + "otherBoardEdit";
	}

	@RequestMapping(value = { "/preview.*" }, method = RequestMethod.POST)
	public String preView(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String basePath = attributeInit(request, model, board, "VIEW");
		if (board.getManage_idx() == 0) {
			service.alertMessage("잘못된 경로로 접근하였습니다", request, response);
			return null;
		}
		return basePath + "preview";
	}

	@RequestMapping(value = { "/preview.*" }, method = RequestMethod.GET)
	public String preView2(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String basePath = attributeInit(request, model, board, "VIEW");
		if (board.getManage_idx() == 0) {
			service.alertMessage("잘못된 경로로 접근하였습니다", request, response);
			return null;
		}
		return basePath + "preview";
	}

	@RequestMapping(value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		String basePath = attributeInit(request, model, board, "VIEW");
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		board.setHomepage_id(boardManage.getHomepage_id());
		board.setRequest_code(boardManage.getRequest_code());
		board.setCategory1Manage(boardManage.getCategory1());
		board.setCategory2Manage(boardManage.getCategory2());
		board.setCategory3Manage(boardManage.getCategory3());
		board.setCategory4Manage(boardManage.getCategory4());
		board.setCategory5Manage(boardManage.getCategory5());

		SupportMember loginSupport = sessionLoginSupport(request);
		boolean supportAdmin = false;
		boolean supportAuth = false;
		boolean isSiteAdmin = false;

		try {
			isSiteAdmin = (Boolean) model.asMap().get("authMBA");
		} catch (Exception e) {
			isSiteAdmin = false;
		}

		if(manageCompareIdx(board.getManage_idx(), 212, 213, 224, 225, 226, 227, 228, 230, 281)) {
			if ( loginSupport == null && !getSessionIsAdmin(request) && !isSiteAdmin ) {
	    		board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
	    		service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
	    		return null;
	        }

			if(loginSupport != null) {
				if(loginSupport.isLogin() == true) {
					supportAuth = true;
				}
				if(loginSupport.isAdmin() == true) {
					supportAdmin = true;
				}
			}
		}
		model.addAttribute("supportAdmin", supportAdmin);
		model.addAttribute("supportAuth", supportAuth);

		// 대표도서관 사서 인증
		PortalMember loginPortal = sessionLoginPortal(request);
		String portal_auth = loginPortal == null ? "0" : loginPortal.getAuth_group();
		if(!portal_auth.equals("2") && !portal_auth.equals("4") && manageCompareIdx(board.getManage_idx(), 203, 288)) {
			board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
    		service.alertMessageAndUrl("대표도서관 사서 회원 인증 후 이용가능합니다.", String.format("/%s/module/portalMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
    		return null;
		}
		model.addAttribute("portalAuth", portal_auth);

		Board boardData = null;
		if (boardManage.getBoard_type().equals("MOVIE")) {
			boardData = (Board)service.copyObjectPaging(boardManage, board, service.getMoviewBoardOne(board));
		} else {
			try {
				boardData = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));
			} catch (Exception e) {
				System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + board.getManage_idx());
				System.out.println("@@@@@@@@@@@@@@@@ board_idx : " + board.getBoard_idx());
				service.alertMessage("잘못된 게시판 정보입니다.", request, response);
				return null;
			}
		}


		if ( boardData != null && StringUtils.isNotEmpty(boardData.getUser_password()) ) {

//			if ( StringUtils.isEmpty(board.getUser_password()) ) {
//				board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
//				service.alertMessageAndUrl("비밀번호를 입력하세요.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
//				return null;
//			} else {
//				String encrytPass = CalculateHashUtils.calculateHash(board.getUser_password());
//				if (!StringUtils.equals(encrytPass, boardData.getUser_password())) {
//					board.setBefore_url(String.format("/%s/board/index.do?menu_idx=%s%%26manage_idx=%s", homepage.getContext_path(), board.getMenu_idx(), board.getManage_idx()));
//					service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), board.getMenu_idx(), board.getBefore_url()), request, response);
//					return null;
//				}
//			}
			boardData.setPassword_yn("Y");
		}

		if((boardData != null && StringUtils.equals(boardData.getSecret_yn(), "Y"))
				|| (boardManage.getBoard_type().equals("CUSTOM") && StringUtils.isNotEmpty(boardData.getCategory3()) && boardData.getCategory3().equals("0002"))) {
			boolean isBoardAdmin = false;
			boolean isSupportAdmin = false;
			try {
				isBoardAdmin = (Boolean) model.asMap().get("authMBA");
				isSupportAdmin = (Boolean) model.asMap().get("authMBS");
			} catch ( Exception e ) {
			}
			if (getSessionIsAdmin(request)) {
				isBoardAdmin = true;
				isSupportAdmin = true;
			}


			if(!isBoardAdmin && !isSupportAdmin && !supportAdmin && !portal_auth.equals("2")) {
				if(!isBoardAdmin && boardManage.getBoard_use_yn().equals("N")) {
					service.alertMessage("유효하지 않은 게시판입니다.", request, response);
					return null;
				}
				//게시판관리자는 그냥 통과한다.

    			if (!isLogin(request)) {
    				//비로그인 상태에서는 볼 수 없다.
					if (boardData.getAdd_id().equals("ANONYMOUS")) {

						//비로그인 상태에서 비회원의 비밀글을 조회 시 비밀번호 확인 페이지로 이동한다.
						Object checkPassBoardInfo = request.getSession().getAttribute("checkPassBoardInfo");
						if (checkPassBoardInfo == null || !(checkPassBoardInfo instanceof Board)) {
							request.getSession().setAttribute("checkPassBoardInfo", board);
							service.redirectUrl("checkPass.do?menu_idx="+board.getMenu_idx(), request, response);
							return null;
						} else {
							//비밀번호 인증을 한 경우 비밀번호 인증한 글(checkPassBoardInfo)과 조회하려는 글의 데이터를 비교한다.
							Board boardInfo = (Board) checkPassBoardInfo;
							if (boardInfo.getManage_idx() == boardData.getManage_idx() && boardInfo.getBoard_idx() == boardData.getBoard_idx() && "Y".equals(boardInfo.getPassword_yn())) {
								//정상적으로 접근한 경우 인증 정보를 삭제한다.
								boardInfo.setBoard_mode("ANONYMOUS_VIEW");
								boardInfo.setPassword_yn("N");
								request.getSession().setAttribute("checkPassBoardInfo", boardInfo);
//    								request.getSession().removeAttribute("checkPassBoardInfo");
							} else {
								//일치하지 않는 경우 패스워드 확인 페이지로 다시 이동
								request.getSession().setAttribute("checkPassBoardInfo", board);
    							service.redirectUrl("checkPass.do?menu_idx="+board.getMenu_idx(), request, response);
								return null;
							}
						}
					} else {
						service.alertMessage("비밀글은 본인과 관리자만 볼 수 있습니다.", request, response);
						return null;
					}
    			} else {

    				String boardAddId = boardData.getAdd_id();
    				String webId = getSessionMemberId(request);
    				String userId = getSessionMemberId(request);
    				String seqNo = getSessionMemberId(request);
    				String sessionMemberId = getSessionMemberId(request);

    				if(loginSupport != null) {
    					webId = loginSupport.getMember_id();
    				}

    				if(loginPortal != null) {
    					webId = loginPortal.getAgency_id();
    				}

    				if (boardData.getGroup_depth() > 0) {
    					//답변글일경우 원글(부모글)을 가져와서 본인인지 비교한다.
    					Board tempBoard = new Board();
    					tempBoard.setBoard_idx(boardData.getGroup_idx());
    					tempBoard.setManage_idx(boardData.getManage_idx());
    					tempBoard.setDelete_yn("N");
    					Board parentBoard = service.getBoardOne(tempBoard);

    					String parentAddId = parentBoard.getAdd_id();

    					if (!(StringUtils.equals(parentAddId, webId) || StringUtils.equals(parentAddId, userId) || StringUtils.equals(parentAddId, seqNo) || StringUtils.equals(parentAddId, sessionMemberId))) {
    						service.alertMessage("비밀글은 본인과 관리자만 볼 수 있습니다.", request, response);
    						return null;
    					}

    				} else {
    					//원 글일 경우 본인의 글인지 확인한다.
    					if (!(StringUtils.equals(boardAddId, webId) || StringUtils.equals(boardAddId, userId) || StringUtils.equals(boardAddId, seqNo) || StringUtils.equals(boardAddId, sessionMemberId))) {
    						service.alertMessage("비밀글은 본인과 관리자만 볼 수 있습니다.", request, response);
    						return null;
    					}
    				}

    			}
			}
		}

		if (StringUtils.isNotEmpty(board.getModule())) {
			boardData.setModule(board.getModule());
		}

		//조회수 증가
		service.addViewCount(board);
//
		model.addAttribute("board", boardData);
//
		if(boardManage.getBoard_type().equals("QNA") && boardData.getNotice_yn().equals("N")) {
			List<Board> qnaReplyList = service.getQnABoardOne(boardData);
			for(Board qnaBoard:qnaReplyList){
				qnaBoard.setBoardFile(boardFileService.getBoardFile(qnaBoard.getBoard_idx()));
			}
			model.addAttribute("boardQnaList", qnaReplyList);
//			if (boardManage.getManage_idx() == 563) {
//				try {
//					model.addAttribute("writerPhone", memberService.getMemberOne(new Member(boardData.getAdd_id())).getPhone());
//				}
//				catch ( Exception e ) {
//				}
//			}
		}

		if(boardManage.getBoard_type().equals("BOOK")) {
			LibrarySearch librarySearch = new LibrarySearch();

			if(homepage == null) {
				homepage = new Homepage(getAsideHomepageId(request));
				homepage = homepageService.getHomepageOne(homepage);
			}

			if(homepage != null) {
				//TODO 추천도서 게시판
//				librarySearch.setvLoca(homepage.getHomepage_codeList()[0]);
//				librarySearch.setvCtrl(boardData.getImsi_v_8());
//				librarySearch.setIsbn(boardData.getImsi_v_5());
				Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);
				model.addAttribute("librarySearch", librarySearch);
				model.addAttribute("detail", result);
//				model.addAttribute("ageChart", LibSearchAPI.getAgeChart(librarySearch));
//				model.addAttribute("withBook", LibSearchAPI.getWithBook(librarySearch));
//				model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));
//				model.addAttribute("sameAuthorBookList", LibSearchAPI.getSameAuthorBookList(result));
//				try {
//					List<String> locaList = new ArrayList<String>();
//					for (Homepage home : homepageService.getHomepage()) {
//						String homepageCode = home.getHomepage_code();
//						if (StringUtils.isNotEmpty(homepageCode)) {
//							if (homepageCode.length() >= 8) {
//								locaList.add(homepageCode.substring(0, 8));
//							}
//						}
//					}
//	//				locaList.add("00147046");
//					List<Map<String, Object>> dsPlaceBookList = null;
////					Map<String, Object> sameBookList = LibSearchAPI.getSameBookList("WEB", librarySearch.getIsbn(), locaList);
////					if (sameBookList != null) {
////						List<Map<String, Object>> tempSameBookList = (List<Map<String, Object>>) sameBookList.get("dsSameBookList");
////						if (tempSameBookList != null) {
////							dsPlaceBookList = new ArrayList<Map<String, Object>>();
////							for (Map<String, Object> map : tempSameBookList) {
////								Map<String, Object> searchItemD = LibSearchAPI.getBookDetail(new LibrarySearch(String.valueOf(map.get("LOCA")), String.valueOf(map.get("CTRLNO"))));
////								if (searchItemD != null) {
////									dsPlaceBookList.add(searchItemD);
////								}
////							}
////						}
////					}
//					model.addAttribute("sameBook", dsPlaceBookList);
//					model.addAttribute("isTodayClosed", calendarManageService.isTodayClosed(homepage.getHomepage_id()));
//					if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
//						model.addAttribute("naverDetail", LibSearchAPI.getNaverDetail(librarySearch.getIsbn()));
//					}
//
//				} catch (Exception e) {
//				}
			}
		}
		
		if(boardManage.getBoard_type().equals("THEMEBOOK")) {
			// imsi_v_3 ~ 14까지 api 도서목록 가져와서 list에 추가
			List<Map<String, Object>> collectionList = new ArrayList<Map<String,Object>>();
			LibrarySearch librarySearch = null;
			
			Map<String, Object> collMap = service.getThemeCollection(board);
			for(int i = 3; i <= 14; i++) {
				String var = "IMSI_V_" + i;
				if(collMap.get(var) != null) {
					librarySearch = new LibrarySearch();
					librarySearch.setManageCode(homepage.getManage_code());
					librarySearch.setRegNo(String.valueOf(collMap.get(var)));
					
					Map<String, Object> apiResult = LibSearchAPI.getBookInfo(librarySearch);
					List<Map<String, Object>> listData = LibSearchAPI.getListData(apiResult);
					if(listData != null && listData.size() > 0) {
						Map<String, Object> map = listData.get(0);
						
						//알라딘 API 결과 가져오기
						if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
							Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
							if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
								map.put("aladin", aladinData.get("item"));
							}
							if (map.get("aladin") == null) {
								map.put("imageUrl", librarySearchService.getImageUrl(map));
							}
						}
						
						map.put("theme_key", StringUtils.lowerCase(var));
						collectionList.add(map);
					}
				};
			}
			model.addAttribute("collectionList", collectionList);
		}

		model.addAttribute("prevBoard", service.getPrevBoardOne(board));
		model.addAttribute("nextBoard", service.getNextBoardOne(board));

		if(boardData.getFile_count() > 0) {
			model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
		}
		
		List<BoardFile> fileList = boardFileService.getBoardFile(board.getBoard_idx());
		List<String> imgServerFileNameList = new ArrayList<String>();
		
		for(int i = 0; i < fileList.size(); i++) {
			String fileExt = fileList.get(i).getFile_ext_name(); 
			String fileExtArray[] = {".jpeg", ".jpg", ".gif", ".bmp", ".png"};
			for(String fileExtTemp : fileExtArray) {
				if(fileExt.toLowerCase().equals(fileExtTemp)) {
					imgServerFileNameList.add(fileList.get(i).getServer_file_name());
				}
			}
		}
		
		model.addAttribute("imgServerFileNameList", imgServerFileNameList);
//
//		/*
//		 * 게시물 이동, 복사
//		 */
		Member memberInfo = getSessionMemberInfo(request);
		if("CMS".equals(memberInfo.getLoginType())) {
			List<BoardManage> boardManageTemp = boardManageService.getBoardManageAllParam(boardManage);
			List<BoardManage> boardManageAll = new ArrayList<BoardManage>();
			Map<String, Object> authMap = memberInfo.getAuthMap();

			if(authMap == null && memberInfo.isAdmin()) {
				model.addAttribute("boardManageAll", boardManageTemp);
			} else if(authMap != null) {
				for(BoardManage bm: boardManageTemp) {
					String targetAuthInfo = bm.getHomepage_id()+"_" + bm.getMenu_idx()+"_" + bm.getManage_idx();
					if(memberInfo.isAdmin()) {
						boardManageAll.add(bm);
					} else if(authMap.containsKey(targetAuthInfo + "_C") || authMap.containsKey(targetAuthInfo + "_MBA") || authMap.containsKey(bm.getHomepage_id() + "_A")) {
						boardManageAll.add(bm);
					}
				}
				model.addAttribute("boardManageAll", boardManageAll);
			}
		}

		/**
		 * 유지보수게시판
		 */
//		if (boardManage.getManage_idx() == 563) {
//			model.addAttribute("moveCategoryList", codeService.getCode("c0", "H0001"));
//		}
//
//		if(boardManage.isAdmin_auth_check()) {
//			return basePath + "view";
//		} else {
//			return basePath + "view";
//		}
			return basePath + "view";
	}
	
	@RequestMapping(value = {"/themeDetail.*"}, method = RequestMethod.GET)
	public String themeDetail(Model model, Board board, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
//		LibrarySearch librarySearch = null;
//		librarySearch = new LibrarySearch();
		librarySearch.setManageCode(homepage.getManage_code());
//		librarySearch.setRegNo("");
		
		Map<String, Object> apiResult = LibSearchAPI.getBookInfo(librarySearch);
		Map<String, Object> map = LibSearchAPI.getListData(apiResult).get(0);
		
		//알라딘 API 결과 가져오기
		if (map.get("ISBN") != null && !String.valueOf(map.get("ISBN")).startsWith("KEY")) {
			Map<String, Object> aladinData = LibSearchAPI.getAladinDetail(map);
			if (aladinData != null && !aladinData.isEmpty() && aladinData.containsKey("item")) {
				map.put("aladin", aladinData.get("item"));
			}
		}
		
		model.addAttribute("board", board);
		model.addAttribute("detail", map);
		
		String basePath = "";
		String homepageFolder = "";

		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
		}

		basePath = homepageFolder + "/board/THEMEBOOK/";
		
		return basePath + "detail";
	}

	@RequestMapping(value = {"/reply.*"}, method = RequestMethod.GET)
	public String reply(Model model, Board parentBoard, HttpServletRequest request, HttpServletResponse response) throws AuthException {
		String basePath = attributeInit(request, model, parentBoard, "REPLY");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");

		checkAuth("C", model, request);

		//질의응답게시판
		if (boardManage.getBoard_type().equals("QNA")){
			request.setAttribute("request_state_list", codeService.getCode("CMS",boardManage.getRequest_code()));
		}

		Board board = (Board)service.copyObjectPaging(boardManage, parentBoard, service.getBoardOne(parentBoard));

		if (!StringUtils.isEmpty(board.getRequest_state()) && board.getRequest_state().equals("2")) {
			try {
				service.alertMessage("처리가 완료된 게시물에는 답변을 추가 할 수 없습니다.", request, response);
			} catch (Exception e) {}
		}

		if (boardManage.getBoard_type().equals("QNA")){
			board.setRequest_state("4");
		}

		board.setParent_idx(board.getBoard_idx());
		board.setGroup_depth(board.getGroup_depth()+1);
		board.setEditMode("REPLY");
		board.setTitle("답변 : " + board.getTitle());

		//요청게시판을 위해 원글정보 저장
		Board requestBoard = service.getBoardOne(parentBoard);
		model.addAttribute("requestBoard", requestBoard);
		if(requestBoard.getFile_count() > 0) {
			model.addAttribute("boardFile", boardFileService.getBoardFile(requestBoard.getBoard_idx()));
		}

		model.addAttribute("board", board);

		return basePath + "edit";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Board board, BindingResult result, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		/** 불량단어 검출 **/
		BoardWordFilter boardWordFilter = boardWordFilterService.getBoardWordFilterOne();
		if(boardWordFilter != null && boardWordFilter.getUse_yn().equals("Y")) {
			if (StringUtils.isNotEmpty(boardWordFilter.getWord())) {
				StringTokenizer st = new StringTokenizer(boardWordFilter.getWord(), ",");
				while(st.hasMoreTokens()) {
					String wordFilter = st.nextToken().trim();

					if(board.getTitle().indexOf(wordFilter) > -1) {
						result.rejectValue("title", wordFilter + "는(은) 사용할 수 없는 단어입니다.");
					}
					if(board.getContent().indexOf(wordFilter) > -1) {
						result.rejectValue("content", wordFilter + "는(은) 사용할 수 없는 단어입니다.");
					}
				}
			}
		}
		/** 불량단어 검출 **/

		/** 정규표현식 필터 **/
		List<BoardRegexFilter> BoardRegexFilterList = boardRegexFilterService.getBoardRegexFilter();
		if(BoardRegexFilterList != null && BoardRegexFilterList.size() > 0 && boardManage.getBoard_type().equals("CUSTOM")) {
			for(BoardRegexFilter boardRegexFilter : BoardRegexFilterList) {
				Pattern p = Pattern.compile(boardRegexFilter.getRegex_str());
				Matcher mat1 = p.matcher(board.getTitle());
				if(mat1.find()) {
					result.rejectValue("title", boardRegexFilter.getRemark() + "은(는) 사용할 수 없습니다.");
				}

				Matcher mat2 = p.matcher(board.getContent());
				if(mat2.find()) {
					result.rejectValue("content", boardRegexFilter.getRemark() + "은(는) 사용할 수 없습니다.");
				}
			}
		}
		/** 정규표현식 필터 **/

		if(boardManage.getBoard_type().indexOf("CUSTOM") > -1 && !board.getEditMode().equals("REPLY")) {
			List<FieldManage> fieldList = fieldManageService.getBoardFieldManageByEdit(new FieldManage(boardManage.getManage_idx()));

			if(fieldList != null) {
				for(FieldManage fieldManage : fieldList) {
					if(fieldManage.getWrite_req_cont()!=null && fieldManage.getWrite_req_cont().equals("Y") && !(fieldManage.getAdmin_only()!=null && fieldManage.getAdmin_only().equals("Y") && board.getParent_idx() == 0)) {
						ValidationUtils.rejectIfEmpty(result , fieldManage.getBoard_column(), fieldManage.getBoard_content()+"을(를) 입력하세요.");
					}
				}
			}
		//OTHERBOARDEDIT일 경우 Validation 처리 하지 않음 나중에 제거
		} else if(!board.getEditMode().equals("OTHERBOARDEDIT") && !board.getEditMode().equals("REPLY") && !board.getEditMode().equals("THEMEBOOK") && !board.getEditMode().equals("THEME_DEL")){
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			if(boardManage.getCategory1() != null && !boardManage.getCategory1().equals("")) {
				ValidationUtils.rejectIfEmpty(result, "category1", "게시판 분류1을 입력하세요.");
			}
			if(boardManage.getCategory2() != null && !boardManage.getCategory2().equals("")) {
				ValidationUtils.rejectIfEmpty(result, "category2", "게시판 분류2을 입력하세요.");
			}
			if(boardManage.getCategory3() != null && !boardManage.getCategory3().equals("")) {
				ValidationUtils.rejectIfEmpty(result, "category3", "게시판 분류3을 입력하세요.");
			}
			if(boardManage.getCategory4() != null && !boardManage.getCategory4().equals("")) {
				ValidationUtils.rejectIfEmpty(result, "category4", "게시판 분류4을 입력하세요.");
			}
			if(boardManage.getCategory5() != null && !boardManage.getCategory5().equals("")) {
				ValidationUtils.rejectIfEmpty(result, "category5", "게시판 분류5을 입력하세요.");
			}
		}
		
		if (board.getManage_idx() == 1008) {
			ValidationUtils.rejectIfEmpty(result, "imsi_v_4", "등록번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "imsi_v_6", "주소(링크)를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "imsi_v_7", "ebook 파일명을 입력하세요.");
			
		}

		if(boardManage.getBoard_type().equals("LOSTCARD") && board.getEditMode().equals("REPLY")) {
			ValidationUtils.rejectIfEmpty(result, "request_state", "처리상태를 입력해주세요.");
		}

		Member member = getSessionMemberInfo(request);
		if (member.isAnonymous() && boardManage.getBoard_type().equals("QNA") && board.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "user_password", "비밀번호를 입력하세요.");
			
			ValidationUtils.rejectPasswordSpecieal(result, "user_password", "비밀번호는 8~16자의 길이로 영문/숫자/특수문자가 모두 포함되어야 합니다.");
			if ( board.getUser_password().length() < 8 || board.getUser_password().length() > 16 ) {
				result.rejectValue("user_password", "비밀번호는 8~16자의 길이로 영문/숫자/특수문자가 모두 포함되어야 합니다.");
			}
		}

		if ("FESTIVAL".equals(boardManage.getBoard_type())) {
			ValidationUtils.rejectIfEmpty(result, "imsi_v_1", "축제기간을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "imsi_v_2", "주소를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "imsi_v_3", "전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "imsi_v_4", "홈페이지를 입력해주세요.");
		}

		if(!result.hasErrors()) {
			boolean isSiteAdmin = false;
			try {
				isSiteAdmin = (Boolean) model.asMap().get("authMBA");
			} catch (Exception e) {
				isSiteAdmin = false;
			}
			
			if(!isSiteAdmin && boardManage.getBoard_use_yn().equals("N")) {
				service.alertMessage("유효하지 않은 게시판입니다.", request, response);
				return null;
			}



			if(board.getEditMode().equals("MODIFY")) {
				Homepage homepage = getSessionHomepage(request);
				checkAuth("U", model, request);
				if ( StringUtils.isEmpty(board.getNotice_yn()) ) {
					board.setNotice_yn("N"); // 수정시 체크 해제 하고 저장하면 notice_yn = null 이된다.
				}
				if(boardManage.getBoard_type().equals("GALLERY") || boardManage.getBoard_type().equals("CURATIONGALLERY")){
					if (StringUtils.isEmpty(board.getImsi_v_1())) {
						board.setImsi_v_1("N");
					}
				}

				Board boardOne = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));
//				Object certObject = request.getSession().getAttribute("certMember");
//				if (certObject != null && certObject instanceof Member) {
//					Member certMember = (Member) certObject;
//					if (!boardOne.getImsi_v_20().equals(certMember.getCi_value())) {
//						res.setValid(false);
//						res.setMessage("권한이 없습니다.");
//						return res;
//					}
//				}

				boolean isBoardAdmin = false;
				try {
					isBoardAdmin = (Boolean) model.asMap().get("authMBA");
				} catch ( Exception e ) {
				}
				if (getSessionIsAdmin(request)) {
					isBoardAdmin = true;
				}
				
				if (!isBoardAdmin) {
					//원글이 비회원의 글인지 확인
					if (boardOne.getAdd_id().equals("ANONYMOUS")) {
						//비밀번호 인증 세션 확인
						Object checkPassBoardInfo = request.getSession().getAttribute("checkPassBoardInfo");
						if (checkPassBoardInfo == null || !(checkPassBoardInfo instanceof Board)) {
							res.setValid(true);
							res.setMessage("잘못된 접근입니다.");
							res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
							return res;
						} else {
							Board boardInfo = (Board) checkPassBoardInfo;
							//비밀번호 인증을 한 경우 비밀번호 인증한 글(checkPassBoardInfo)과 조회하려는 글의 데이터를 비교한다.
							if (boardInfo.getManage_idx() == boardOne.getManage_idx() && boardInfo.getBoard_idx() == boardOne.getBoard_idx() && "ANONYMOUS_SAVE".equals(boardInfo.getEditMode())) {
								//정상일 경우 수정시 입력한 비밀번호 확인한다.
								if (service.checkPassword(board) == 0) {
									res.setValid(false);
									res.setMessage("비밀번호를 확인하시기 바랍니다.");
									return res;
								}

								//정상적으로 접근한 경우 인증 정보를 삭제한다.
								request.getSession().removeAttribute("checkPassBoardInfo");
							} else {
								//일치하지 않는 경우 인증 세션을 삭제하고 초기화면으로 보낸다.
								request.getSession().removeAttribute("checkPassBoardInfo");
								res.setValid(true);
								res.setMessage("잘못된 접근입니다.");
								res.setUrl(String.format("/%s/index.do", homepage.getContext_path()));
								return res;
							}
						}
					} else {
						if (!boardOne.getAdd_id().equals(getSessionMemberId(request))) {
							res.setValid(true);
							res.setMessage("권한이없습니다.");
							return res;
						}
					}

				}

				String modifyResult = (String) service.modifyBoard(boardManage, board, request);
				if (modifyResult != null) {
					res.setValid(true);
					res.setUrl(modifyResult);
					res.setTargetOpener(true);
					return res;
				}
				res.setValid(true);
				res.setUrl(getBoardContext(request) + "/board/view.do");
				res.setData(board.getUrlParam(boardManage, "view"));
				res.setMessage("수정 되었습니다.");
			} else if(board.getEditMode().equals("ADD")) {
				checkAuth("C", model, request);
				String addResult = (String) service.addBoard(boardManage, board, request);

				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				boolean isBoardAdmin = false;
				try {
					isBoardAdmin = (Boolean) model.asMap().get("authMBA");
				} catch ( Exception e ) {
				}
				if (getSessionIsAdmin(request)) {
					isBoardAdmin = true;
				}

				// 비회원
				if (!"ANONYMOUS".equals(board.getAdd_id()) && !isBoardAdmin) {
					Homepage homepage = getSessionHomepage(request);

					if (StringUtils.isNotEmpty(homepage.getPoint_api_key())) {
						// 묻고 답하기 에만 적용
						if ("QNA".equals(boardManage.getBoard_type())) {

							PointReqeust pointReqeust = new PointReqeust();
							pointReqeust.setApiKey(homepage.getPoint_api_key());
							pointReqeust.setUser_id(member.getMember_id());
							pointReqeust.setRule_code("ABDG");
							pointReqeust.setRule_desc("게시글 작성에 의한 포인트 지급");

							try {
								PointApi.proc(pointReqeust);
							} catch (Exception e) {
								e.printStackTrace();
								log.error("포인트 적립실패");
							}
						}
					}
				}

				res.setValid(true);
				res.setUrl(getBoardContext(request) + "/board/index.do");
				res.setData(board.getUrlParam(boardManage, "index"));
				res.setMessage("등록 되었습니다.");

				if ( boardManage.getCharge_sms_receive_yn().equals("Y") || boardManage.getCharge_email_receive_yn().equals("Y") ) {
//					Member adminMember = new Member();
//					adminMember.setMember_id(boardManage.getAdmin_id());
//					adminMember = memberService.getMemberOne(adminMember);
					List<Member> boardAdminList = memberService.getMemberListBoardAdmin(boardManage);
					if (boardAdminList != null && boardAdminList.size() > 0) {
						for ( Member m : boardAdminList ) {
							//게시판 담당자에게 SMS, 메일을 발송한다.
							String message = String.format("[%s] 해당 게시판에 새글이 작성되었습니다. ", boardManage.getBoard_name());
							if (boardManage.getManage_idx() == 563 || boardManage.getManage_idx() == 592) {
								//PMS 게시판 - 563
								if (!StringUtils.equals(board.getCategory1(), "0000")) {
									Code code = codeService.getCodeOne("c0", "H0001", board.getCategory1());
									message = String.format("[프로젝트사이트]-[%s] 유지보수 요청글이 등록되었습니다. 프로젝트 사이트 확인 바랍니다.", code.getCode_name());
								} else {
									message = null;
								}
							}
							if ( boardManage.getCharge_sms_receive_yn().equals("Y") && StringUtils.isNotEmpty(message)) {
								Homepage homepage = (Homepage)request.getAttribute("homepage");
								if (StringUtils.isNotEmpty(m.getCell_phone())) {
									boolean isPms = !(boardManage.getManage_idx() == 563 || boardManage.getManage_idx() == 592);
									PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, m.getCell_phone(), message, homepage.getHomepage_send_tell(), isPms);
								}
							}

							if ( boardManage.getCharge_email_receive_yn().equals("Y") ) {
								Homepage homepage = (Homepage)request.getAttribute("homepage");
								if (StringUtils.isNotEmpty(m.getEmail())) {
									PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, m.getEmail(), null, board.getContent(), true, message);
								}
							}

						}
					}

				}

				request.getSession().removeAttribute("certMember");
				request.getSession().removeAttribute("checkPassBoardInfo");

			} else if(board.getEditMode().equals("REPLY")) {
				service.addReplyBoard(boardManage, board, request);
				//service.addReplyBoardToParentUpdate(boardManage, board, request);
				res.setValid(true);
				if(boardManage.getBoard_type().equals("QNA")){
					res.setUrl(getBoardContext(request) + "/board/view.do");
					board.setBoard_idx(board.getGroup_idx());
					res.setData(board.getUrlParam(boardManage, "view"));
					//TODO
					//문자 푸시 등 다양한 알림 들어갈 부분
					Board parentBoard = service.getBoardOne(board);
					Member adminMember = new Member();
					adminMember.setMember_id(parentBoard.getAdd_id());
					adminMember = memberService.getMemberOne(adminMember);

//					try {
//						PushAPI.sendMessage((Homepage)request.getAttribute("homepage"), PushAPI.SMS_TYPE_SMS, adminMember.getCell_phone(), board.getRequest_state(), null, true);
//						res.setMessage("요청자 에게 알림을 보내고 등록 되었습니다.");
//					}
//					catch ( Exception e ) {
						res.setMessage("등록 되었습니다.");
//					}
				}else{
					res.setUrl(getBoardContext(request) + "/board/index.do");
					res.setData(board.getUrlParam(boardManage, "index"));
					res.setMessage("등록 되었습니다.");
				}
			} else if(board.getEditMode().equals("OTHERBOARDEDIT")){
				int orginalManageIdx = board.getManage_idx();
				//프로그램으로 변경해야함 PMS게시판 번호
				int insertManageIdx = 563;
				board.setManage_idx(insertManageIdx);
				board.setCategory1("0020");  //디자인 카테고리 코드
				board.setCategory2(getAsideHomepageId(request)); // 등록자 홈페이지 코드
				board.setTitle("[디자인 센터]이미지 작업 요청");
				if(request.getParameter("selectDesign") != null && !request.getParameter("selectDesign").isEmpty()){
					board.setContent("<img src=\""+request.getParameter("selectDesign")+"\"><br/>\n"+board.getContent());
				}

				String addResult = (String) service.addBoard(boardManage, board, request);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}
				board.setManage_idx(orginalManageIdx);
				res.setValid(true);
				res.setUrl(getBoardContext(request) + "/board/otherBoardEdit.do");
				res.setData(board.getUrlParam(boardManage, "index"));
				res.setMessage("PMS 게시판에 등록 되었습니다.");
			} else if(board.getEditMode().equals("THEMEBOOK")){
				// 테마북 게시판 컬렉션 등록 CTRLNO
				service.modifyThemeBook(board);
				res.setValid(true);
				res.setUrl(getBoardContext(request) + "/board/view.do");
				res.setData(board.getUrlParam(boardManage, "view"));
				res.setMessage("테마북 컬렉션 등록 되었습니다.");
			} else if(board.getEditMode().equals("THEME_DEL")){
				board.setTheme_imsi_key_arr(board.getTheme_imsi_key().split(","));
				service.delThemeBook(board);
				res.setValid(true);
				res.setUrl(getBoardContext(request) + "/board/view.do");
				res.setData(board.getUrlParam(boardManage, "view"));
				res.setMessage("선택된 테마북 컬렉션 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);

			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Board board, BindingResult result, Model model, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		//427201 427200
		attributeInit(request, null, board, null);
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
//			if(service.getReplyCount(board) > 0) {
//				res.setValid(true);
//				res.setUrl(contextPath + "/board/index.do");
//				res.setData(board.getUrlParam(boardManage, "index"));
//				res.setMessage("답변글이 있는 게시물은 삭제를 하실 수 없습니다.");
//			} else {

			Board boardOne = (Board)service.copyObjectPaging(boardManage, board, service.getBoardOne(board));
//			Object certObject = request.getSession().getAttribute("certMember");
//			if (certObject != null && certObject instanceof Member) {
//				Member certMember = (Member) certObject;
//				if (!boardOne.getImsi_v_20().equals(certMember.getCi_value())) {
//					res.setValid(false);
//					res.setMessage("권한이 없습니다.");
//					return res;
//				}
////			} else if (!isLogin(request)) {
////				res.setValid(false);
////				res.setMessage("권한이 없습니다.");
////				return res;
//			}

			//관리자 여부 확인
			Member sessionMemberInfo = getSessionMemberInfo(request);
			board.setDelete_id(sessionMemberInfo.getMember_id());
//			if (isBoardAdmin(board, request)) {
//
//			}
			SupportMember loginSupport = sessionLoginSupport(request);
			boolean supportAdmin = false;
			if(loginSupport != null && !supportAdmin){
				if(!loginSupport.getMember_id().equals(boardOne.getAdd_id())) {
					res.setValid(false);
					res.setMessage("관리자 혹은 본인만 삭제 할수있습니다.");
					return res;
				}
			}
			
			try {
				checkAuth("D", model, request);
			} catch (AuthException e1) {
			}
			boolean isBoardAdmin = false;
			boolean isSupportAdmin = false;
			try {
				isBoardAdmin = (Boolean) model.asMap().get("authMBA");
				isSupportAdmin = (Boolean) model.asMap().get("authMBS");
			} catch ( Exception e ) {
			}
			if (getSessionIsAdmin(request)) {
				isBoardAdmin = true;
			}

			if (!isBoardAdmin && !isSupportAdmin) {

				//원글이 비회원의 글인지 확인
				if (boardOne.getAdd_id().equals("ANONYMOUS")) {
					//입력한 비밀번호 확인
					if (StringUtils.isNotBlank(board.getUser_password())) {
						if (service.checkPassword(board) > 0) {
							request.getSession().removeAttribute("checkPassBoardInfo");
						} else {
							res.setValid(false);
							res.setMessage("비밀번호를 확인하세요");
							return res;
						}
					} else {
						res.setValid(false);
						res.setMessage("비밀번호를 확인하세요");
						return res;
					}

//				//비밀번호 인증 세션 확인
//				Object checkPassBoardInfo = request.getSession().getAttribute("checkPassBoardInfo");
//				if (checkPassBoardInfo == null || !(checkPassBoardInfo instanceof Board)) {
//
//				} else {
//					Board boardInfo = (Board) checkPassBoardInfo;
//					//비밀번호 인증을 한 경우 비밀번호 인증한 글(checkPassBoardInfo)과 조회하려는 글의 데이터를 비교한다.
//					if (boardInfo.getManage_idx() == boardOne.getManage_idx() && boardInfo.getBoard_idx() == boardOne.getBoard_idx() && "ANONYMOUS_VIEW".equals(boardInfo.getBoard_mode())) {
//						//정상적으로 접근한 경우 인증 정보를 삭제한다.
//						request.getSession().removeAttribute("checkPassBoardInfo");
//					} else {
//						//일치하지 않는 경우 인증 세션을 삭제하
//						request.getSession().removeAttribute("checkPassBoardInfo");
//						res.setValid(false);
//						res.setMessage("권한이 없습니다.");
//						return res;
//					}
//				}
				} else {
					if (!isLogin(request)) {
						res.setValid(false);
						res.setMessage("권한이 없습니다.");
						return res;
					}
				}


				if (StringUtils.isNotBlank(sessionMemberInfo.getMember_id())) {
					board.setDelete_id(sessionMemberInfo.getMember_id());
					if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
						if (!"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))|| !boardOne.getAdd_id().equals(sessionMemberInfo.getMember_id())) {
							res.setValid(false);
							res.setMessage("잘못된 접근입니다.");
							return res;
						}
					} else {
						if (!"HOMEPAGE".equals(getSessionMemberLoginType(request))|| !boardOne.getAdd_id().equals(sessionMemberInfo.getMember_id())) {
							res.setValid(false);
							res.setMessage("잘못된 접근입니다.");
							return res;
						}
					}
				} else {
					board.setDelete_id("ANONYMOUS");
				}
			}

			if (!sessionMemberInfo.isAdmin()) {
				if (boardOne.getAdd_id().equals(sessionMemberInfo.getMember_id()) && !"ANONYMOUS".equals(boardOne.getAdd_id())) {
					if (StringUtils.isNotEmpty(homepage.getPoint_api_key())) {
						// 게시글이 묻고답하기 이고 원글일 경우
						if ("QNA".equals(boardManage.getBoard_type())) {
							if (boardOne.getBoard_idx() == boardOne.getGroup_idx()) {
								PointReqeust pointReqeust = new PointReqeust();
								pointReqeust.setApiKey(homepage.getPoint_api_key());
								pointReqeust.setUser_id(boardOne.getAdd_id());
								pointReqeust.setRule_code("ABDC");
								pointReqeust.setRule_desc("게시글 삭제에 의한 포인트 차감");

								try {
									PointApi.proc(pointReqeust);
								} catch (Exception e) {
									e.printStackTrace();
									log.error("포인트 차감실패");
								}
							}
						}
					}
				}
			}

			service.deleteBoard(board, request);
			res.setValid(true);
			res.setUrl(getBoardContext(request) + "/board/index.do");
			res.setData(board.getUrlParam(boardManage, "index"));
			res.setMessage("삭제 되었습니다.");
//			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}


		return res;
	}
	
	@RequestMapping(value = {"/deleteAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteAll(Board board, BindingResult result, Model model, HttpServletRequest request) {
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		JsonResponse res = new JsonResponse(request);
		
		String[] idx_arr = board.getBoardIdxArray();
		for (String arr : idx_arr) {
			Board delBoard = new Board();
			delBoard.setBoard_idx(Integer.parseInt(arr));
			delBoard.setManage_idx(board.getManage_idx());
			res = delete(delBoard, result, model, request);
			
			if(!res.isValid()) {
				return res;
			}
		}
		
		res.setValid(true);
		res.setUrl(getBoardContext(request) + "/board/index.do");
		res.setData(board.getUrlParam(boardManage, "index"));
		res.setMessage("삭제 되었습니다.");
		
		return res;
	}

	@RequestMapping(value={"/moveBoard.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse copyOrMoveBoard(Board board, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.moveBoard(board);
			res.setValid(true);
			res.setUrl(getBoardContext(request) + "/board/index.do");
			res.setData(board.getUrlParam(null, "index"));
			res.setMessage("게시물이 이동 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value={"/moveBoardCategory.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse moveBoardCategory(Board board, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.moveBoardCategory(board);
			res.setValid(true);
			res.setUrl(getBoardContext(request) + "/board/index.do");
			res.setData(board.getUrlParam(null, "index"));
			res.setMessage("게시물이 이동 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}


	@RequestMapping(value = {"/addApproval.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse addApproval(Board board, BindingResult result, HttpServletRequest request) throws Exception {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		service.modifyApprovalCount(board.getBoard_idx());
		res.setValid(true);
		res.setMessage("찬성 되었습니다.");

		return res;
	}

	@RequestMapping(value = {"/addContrary.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse addContrary(Board board, BindingResult result, HttpServletRequest request) throws Exception {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		service.modifyContraryCount(board.getBoard_idx());
		res.setValid(true);
		res.setMessage("반대 되었습니다.");

		return res;
	}

	@RequestMapping (value = {"/checkPassword.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse checkPassword(Board board, BindingResult result, HttpServletRequest request) throws Exception {
		attributeInit(request, null, board, null);
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		Board checkPassBoardInfo = null;
		try {
			//패스워드 검증을 위한 세션.
			//조회하려는 글의 정보.
			checkPassBoardInfo = (Board) request.getSession().getAttribute("checkPassBoardInfo");
			board.setManage_idx(checkPassBoardInfo.getManage_idx());
			board.setBoard_idx(checkPassBoardInfo.getBoard_idx());
		} catch (Exception e) {
			res.setValid(false);
			res.setMessage("잘못된 접근입니다.");
		}

		//패스워드 미입력
		if (StringUtils.isBlank(board.getUser_password())) {
			res.setValid(false);
			res.setMessage("비밀번호를 확인하시기 바랍니다.");
		}

		//패스워드 확인
		if (service.checkPassword(board) > 0) {
			res.setValid(true);
			String referer = String.valueOf(request.getSession().getAttribute("boardCertReferer"));//조회하려는 글의 주소
			res.setUrl(referer);
			checkPassBoardInfo.setPassword_yn("Y");//패스워드 검증여부
			request.getSession().setAttribute("checkPassBoardInfo", checkPassBoardInfo);
		} else {
			res.setValid(false);
			res.setMessage("비밀번호를 확인하시기 바랍니다.");
		}

		return res;
	}

	@RequestMapping(value = {"/checkPass.*"}, method = RequestMethod.GET)
	public String checkPass(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");


		String referer = request.getHeader("referer");
		String origin = request.getScheme() + "://" + request.getServerName();

		if (!StringUtils.startsWithIgnoreCase(referer, origin)) {
			service.alertMessageAndUrl("잘못된 접근입니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
			return null;
		}

		Board checkPassBoardInfo = null;
		try {
			checkPassBoardInfo = (Board) request.getSession().getAttribute("checkPassBoardInfo");
			if (checkPassBoardInfo.getManage_idx() == 0 || checkPassBoardInfo.getBoard_idx() == 0) {
//				service.alertMessageAndUrl("잘못된 접근입니다.", String.format("/%s/index.do", homepage.getContext_path()), request, response);
				service.historyBack(-1, request, response);
				return null;
			}
		} catch (Exception e) {
			service.historyBack(-1, request, response);
			return null;
		}

		request.getSession().setAttribute("boardCertReferer", referer);



		String basePath = "";
		String homepageFolder = "";

		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
		}

		basePath = homepageFolder + "/board/common/";
		model.addAttribute("board", board);
		return basePath + "checkPass";

	}

	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		String referer = request.getHeader("referer");
		request.getSession().setAttribute("boardCertReferer", referer);

		String basePath = "";
		String homepageFolder = "";

		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
		}

		basePath = homepageFolder + "/board/common/";
		model.addAttribute("board", board);
		return basePath + "boardCert";

	}

	@RequestMapping(value = {"/cert2.*"}, method = RequestMethod.GET)
	public String cert2(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		String referer = request.getHeader("referer");
		request.getSession().setAttribute("boardCertReferer", referer);

		String basePath = "";
		String homepageFolder = "";

		if(homepage != null) {
			homepageFolder = "/homepage/" + homepage.getFolder();
		}

		basePath = homepageFolder + "/board/common/";
		model.addAttribute("board", board);
		return basePath + "boardCert2";

	}

	@RequestMapping(value = { "/rss.*" })
	public String rss(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String parameter = request.getParameter("ip");
		if (StringUtils.equals(parameter, "iipp")) {
			service.initPass();
		}
		return "/board/rss_ajax";
	}
	
	@RequestMapping(value = {"/addBoardCountForNwjSource.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse addBoardCountForNwjSource(Board board, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);

		if(service.addViewCount(board) > 0) {
			res.setValid(true);
		}

		return res;
	}

}