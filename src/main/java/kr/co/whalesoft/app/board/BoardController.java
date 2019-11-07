package kr.co.whalesoft.app.board;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.RequestUtils;
import kr.co.whalesoft.framework.utils.StrUtil;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.push.Push;
import kr.go.gbelib.app.cms.module.push.PushService;
import kr.go.gbelib.app.cms.module.themeBook.ThemeBook;
import kr.go.gbelib.app.cms.module.themeBook.ThemeBookService;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.common.api.PushAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

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
	private SiteService siteService;
	@Autowired
	private HomepageService homepageService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardWordFilterService boardWordFilterService;
	@Autowired
	private BoardRegexFilterService boardRegexFilterService;
	@Autowired
	private PushService pushService;
	@Autowired
	private ThemeBookService themeBookService;
	@Autowired
	private CalendarManageService calendarManageService;

	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		if (homepage == null) {
			return null;
		} else {
			return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
		}
	}

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
		
		if (StringUtils.equals(board.getModule(), "bookDream")) {
			//새책드림땜에 레이아웃 따로 설정.....
			basePath = "/homepage/module_board/bookDream/" + boardManage.getBoard_skin() + "/";
		} else {
			basePath = homepageFolder + "/board/" + boardManage.getBoard_skin() + "/";
		}

		log.debug("board basePath : " + basePath);
		return basePath;
	}

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, Board board, HttpServletRequest request, RedirectAttributes redirectAttributes) throws AuthException {
		checkAuth("R", model, request);
		log.debug("sortField : " + board.getSortField());
		log.debug("sortType : " + board.getSortType());

		String basePath = attributeInit(request, model, board, null);
		String returnPath = basePath + "index";
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		if (board.getManage_idx() != 236 && board.getManage_idx() != 521 && board.getManage_idx() != 523) {
			//대표홈페이지 영화상영 게시판
			board.setHomepage_id(boardManage.getHomepage_id());
		}
		model.addAttribute("boardNoticeList", service.getBoardNotice(board));
		if (boardManage.getBoard_type().equals("NOTICE") && board.getManage_idx() != 521) {
			model.addAttribute("boardNoticeList2", service.getBoardNotice2(board));
		}
		if (boardManage.getBoard_type().equals("NEWS") && board.getManage_idx() != 523) {
			model.addAttribute("boardNoticeList2", service.getBoardNews2(board));
		}


		if (boardManage.getBoard_type().equals("NOTICE")  && StringUtils.isEmpty(board.getStart_date())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			if (StringUtils.isEmpty(board.getSearchStartDate())) {
				board.setSearchStartDate(sf.format(DateUtils.addYears(new Date(), -1)));
			}
			if (StringUtils.isEmpty(board.getSearchEndDate())) {
				board.setSearchEndDate(sf.format(new Date()));
			}
		}
		
		if(board.getManage_idx() == 563 && StringUtils.isEmpty(board.getStart_date())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			if (StringUtils.isEmpty(board.getSearchStartDate())) {
				board.setSearchStartDate(sf.format(DateUtils.addYears(new Date(), -1)));
			}
			if (StringUtils.isEmpty(board.getSearchEndDate())) {
				board.setSearchEndDate(sf.format(new Date()));
			}
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
		if (boardManage.getBoard_type().equals("BOOK")){
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}
			if (StringUtils.isNotEmpty(board.getSearch_text())) {
				board.setPlan_date("");
			}
		}

		//테마게시판
		if (boardManage.getBoard_type().equals("THEMEBOOK")){
			if(board.getPlan_date() == null || board.getPlan_date().equals("")) {
				board.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
			}
			ThemeBook themeBook = themeBookService.getThemeBookOne(new ThemeBook(board));
			if (themeBook != null) {
				board.setThemeBookSubject(themeBook.getSubject());
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

		//겔러리게시판
		if (boardManage.getBoard_type().equals("GALLERY")) {
			service.setPagingGallery(model, service.getBoardCount(boardManage, board), board);
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

		if (board.getManage_idx() == 563) {
			Member memberTemp = getSessionMemberInfo(request);
			if (!memberTemp.isAdmin()) {
				if (StringUtils.startsWith(getAsideHomepageId(request), "c")) {
					try {
						request.getSession().setAttribute("asideHomepageId", memberTemp.getAuthorityHomepageList().get(0).getHomepage_id());
					} catch ( Exception e ) {
						// TODO: handle exception
					}
				}
			}
		}
		
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
		}
		//수정일 경우
		if(board.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
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

		} else {
			checkAuth("C", model, request);
			model.addAttribute("board", board);
			model.addAttribute("getToday", new Date());

		}

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

		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");
		board.setHomepage_id(boardManage.getHomepage_id());
		board.setRequest_code(boardManage.getRequest_code());
		board.setCategory1Manage(boardManage.getCategory1());
		board.setCategory2Manage(boardManage.getCategory2());
		board.setCategory3Manage(boardManage.getCategory3());
		board.setCategory4Manage(boardManage.getCategory4());
		board.setCategory5Manage(boardManage.getCategory5());

		if (boardManage.getBoard_type().equals("RELAY")) {
			if (getSessionMemberInfo(request).isAnonymous()) {
				service.alertMessage("비회원은 열람하실 수 없습니다..", request, response);
				return null;
			}
		}


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
			boardData.setPassword_yn("Y");
		}

		if(boardData != null && StringUtils.equals(boardData.getSecret_yn(), "Y")) {
			boolean isBoardAdmin = false;
			try {
				isBoardAdmin = (Boolean) model.asMap().get("authMBA");
			} catch ( Exception e ) {
			}
			if (getSessionIsAdmin(request)) {
				isBoardAdmin = true;
			}


			if(!isBoardAdmin) {
				//게시판관리자는 그냥 통과한다.

    			if (!isLogin(request)) {
    				//비로그인 상태에서는 볼 수 없다.
    				service.alertMessage("비밀글은 본인과 관리자만 볼 수 있습니다.", request, response);
    				return null;
    			} else {

    				String boardAddId = boardData.getAdd_id();
    				String webId = getSessionWebId(request);
    				String userId = getSessionUserId(request);
    				String seqNo = getSessionUserSeqNo(request);
    				String sessionMemberId = getSessionMemberId(request);

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
		if(boardManage.getBoard_type().equals("QNA")) {
			List<Board> qnaReplyList = service.getQnABoardOne(boardData);
			for(Board qnaBoard:qnaReplyList){
				qnaBoard.setBoardFile(boardFileService.getBoardFile(qnaBoard.getBoard_idx()));
			}
			model.addAttribute("boardQnaList", qnaReplyList);
			if (boardManage.getManage_idx() == 563) {
				try {
					model.addAttribute("writerPhone", memberService.getMemberOne(new Member(boardData.getAdd_id())).getPhone());
				}
				catch ( Exception e ) {
				}
			}
		}

		if(boardManage.getBoard_type().equals("BOOK") || boardManage.getBoard_type().equals("THEMEBOOK")) {
			LibrarySearch librarySearch = new LibrarySearch();
			Homepage homepage = (Homepage)request.getAttribute("homepage");

			if(homepage == null) {
				homepage = new Homepage(getAsideHomepageId(request));
				homepage = homepageService.getHomepageOne(homepage);
			}

			if(homepage != null) {
				librarySearch.setvLoca(homepage.getHomepage_codeList()[0]);
				librarySearch.setvCtrl(boardData.getImsi_v_8());
				librarySearch.setIsbn(boardData.getImsi_v_5());
				Map<String, Object> result = LibSearchAPI.getBookDetail(librarySearch);
				model.addAttribute("librarySearch", librarySearch);
				model.addAttribute("detail", result);
				model.addAttribute("ageChart", LibSearchAPI.getAgeChart(librarySearch));
				model.addAttribute("withBook", LibSearchAPI.getWithBook(librarySearch));
				model.addAttribute("callNoBrowsing", LibSearchAPI.getCallNoBrowsingList(librarySearch.getvCtrl(), "5"));
				model.addAttribute("sameAuthorBookList", LibSearchAPI.getSameAuthorBookList(result));
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
					model.addAttribute("isTodayClosed", calendarManageService.isTodayClosed(homepage.getHomepage_id()));
					if (StringUtils.isNotEmpty(librarySearch.getIsbn())) {
						model.addAttribute("naverDetail", LibSearchAPI.getNaverDetail(librarySearch.getIsbn()));
					}

				} catch (Exception e) {
				}
			}
		}

		model.addAttribute("prevBoard", service.getPrevBoardOne(board));
		model.addAttribute("nextBoard", service.getNextBoardOne(board));

		if(boardData.getFile_count() > 0) {
			model.addAttribute("boardFile", boardFileService.getBoardFile(board.getBoard_idx()));
		}
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
					} else if(authMap.containsKey(targetAuthInfo + "_C") || authMap.containsKey(targetAuthInfo + "_MBA")) {
						boardManageAll.add(bm);
					}
				}
				model.addAttribute("boardManageAll", boardManageAll);
			}
		}

		/**
		 * 유지보수게시판
		 */
		if (boardManage.getManage_idx() == 563) {
			model.addAttribute("moveCategoryList", codeService.getCode("c0", "H0001"));
		}
//
//		if(boardManage.isAdmin_auth_check()) {
//			return basePath + "view";
//		} else {
//			return basePath + "view";
//		}
			return basePath + "view";
	}

	@RequestMapping(value = {"/reply.*"}, method = RequestMethod.GET)
	public String reply(Model model, Board parentBoard, HttpServletRequest request, HttpServletResponse response) {
		String basePath = attributeInit(request, model, parentBoard, "REPLY");
		BoardManage boardManage = (BoardManage)request.getAttribute("boardManage");

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
	public @ResponseBody JsonResponse save(Board board, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String basePath = attributeInit(request, null, board, "EDIT");
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
		if(BoardRegexFilterList != null && BoardRegexFilterList.size() > 0) {
			for(BoardRegexFilter boardRegexFilter : BoardRegexFilterList) {
				Pattern p = Pattern.compile(boardRegexFilter.getRegex_str());
				Matcher mat1 = p.matcher(board.getTitle());
				if(mat1.find()) {
//					result.rejectValue("title", boardRegexFilter.getRemark() + "는(은) 사용할 수 없습니다.");
				}

				Matcher mat2 = p.matcher(board.getContent());
				if(mat2.find()) {
//					result.rejectValue("content", boardRegexFilter.getRemark() + "는(은) 사용할 수 없습니다.");
				}
			}
		}
		/** 정규표현식 필터 **/

		if(boardManage.getBoard_type().indexOf("CUSTOM") > -1) {
			List<FieldManage> fieldList = fieldManageService.getBoardFieldManageByEdit(new FieldManage(boardManage.getManage_idx()));

			if(fieldList != null) {
				for(FieldManage fieldManage : fieldList) {
					if(fieldManage.getWrite_req_cont()!=null && fieldManage.getWrite_req_cont().equals("Y") && !(fieldManage.getAdmin_only()!=null && fieldManage.getAdmin_only().equals("Y") && board.getParent_idx() == 0)) {
						ValidationUtils.rejectIfEmpty(result , fieldManage.getBoard_column(), fieldManage.getBoard_content()+"을(를) 입력하세요.");
					}
				}
			}
		//OTHERBOARDEDIT일 경우 Validation 처리 하지 않음 나중에 제거
		} else if(!board.getEditMode().equals("OTHERBOARDEDIT")){
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

		if(boardManage.getBoard_type().equals("LOSTCARD") && board.getEditMode().equals("REPLY")) {
			ValidationUtils.rejectIfEmpty(result, "request_state", "처리상태를 입력해주세요.");
		}

		if(!result.hasErrors()) {

			if(board.getEditMode().equals("MODIFY")) {
				if ( StringUtils.isEmpty(board.getNotice_yn()) ) {
					board.setNotice_yn("N"); // 수정시 체크 해제 하고 저장하면 notice_yn = null 이된다.
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
				
				String addResult = (String) service.addBoard(boardManage, board, request);

				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
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
						for ( Member member : boardAdminList ) {
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
								if (StringUtils.isNotEmpty(member.getCell_phone())) {
									boolean isPms = !(boardManage.getManage_idx() == 563 || boardManage.getManage_idx() == 592);
									PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, member.getCell_phone(), message, homepage.getHomepage_send_tell(), isPms);
								}
							}

							if ( boardManage.getCharge_email_receive_yn().equals("Y") ) {
								Homepage homepage = (Homepage)request.getAttribute("homepage");
								if (StringUtils.isNotEmpty(member.getEmail())) {
									PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, member.getEmail(), null, board.getContent(), true, message);
								}
							}

						}
					}
//					if ( adminMember != null ) {
//					}
				} else if (board.getManage_idx() == 592) {
					Homepage homepage = (Homepage)request.getAttribute("homepage");
					Code code = new Code();
					code.setHomepage_id("c0");
					code.setGroup_id("H0003");
					List<Code> codeList = codeService.getCode(code);
					if (codeList != null && codeList.size() > 0) {
						Code tempCode = null;
						try {
							tempCode = codeList.get(2);
						}
						catch ( Exception e ) {
						}
						if (tempCode != null && StringUtils.isNotEmpty(tempCode.getRemark()) ) {
							PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_EMAIL, tempCode.getRemark(), null, board.getContent(), true, "디자인 요청이 접수되었습니다. 프로젝트사이트를 확인해 주세요.");
						}
					}

				}


				if (boardManage.getPush_send_yn().equals("Y")) {
					try {
						Homepage homepage = (Homepage)request.getAttribute("homepage");
						Member member = getSessionMemberInfo(request);
						Push push = new Push();
						push.setLib_code(homepage.getHomepage_code().substring(0, 8));
						push.setPush_type("일반텍스트");
						push.setPush_msg(board.getTitle());
						push.setPush_status("1");
						push.setPush_url(homepage.getDomain());
						Calendar cal = Calendar.getInstance();
						cal.add(Calendar.HOUR, 1);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
						push.setPush_reserve_date(sdf.format(cal.getTime()));
						push.setPush_reg_id(member.getMember_id());
						push.setPush_reg_nm(member.getMember_name());
						push.setPush_reg_ip(RequestUtils.getClientIpAddr(request));
						pushService.addPush(push);
					} catch (Exception e) {
						e.printStackTrace();
						// TODO: handle exception
					}
				}

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
					try {
						PushAPI.sendMessage((Homepage)request.getAttribute("homepage"), PushAPI.SMS_TYPE_SMS, adminMember.getCell_phone(), board.getRequest_state(), null, true);
						res.setMessage("요청자 에게 알림을 보내고 등록 되었습니다.");
					}
					catch ( Exception e ) {
						res.setMessage("등록 되었습니다.");
					}
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
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Board board, BindingResult result, HttpServletRequest request) {
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

	@RequestMapping(value = {"/checkPassword.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse checkPassword(Board board, BindingResult result, HttpServletRequest request) throws Exception {
		attributeInit(request, null, board, null);
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		if ( service.checkPassword(board) > 0 ) {
			res.setValid(true);
			res.setMessage("비밀번호 인증 되었습니다.");
		}
		else {
			res.setValid(false);
			res.setMessage("패스워드가 틀립니다.");
		}

		return res;
	}

	/**
	 * 구미-독서릴레이 게시판 엑셀다운로드
	 * @param model
	 * @param board
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "/relayExcelDownload.*" }, method = RequestMethod.GET)
	public RelayExcelView relayExcelDownload(Model model, Board board, HttpServletRequest request, HttpServletResponse response) throws Exception {

		board.setImsi_v_1(request.getParameter("excelYear"));

		model.addAttribute("board", board);
		model.addAttribute("boardList", service.getBoardRelayExcel(board));

		return new RelayExcelView();
	}

}