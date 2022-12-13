package kr.go.gbelib.app.module.myDashBoard;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.module.boardHistory.BoardHistory;
import kr.go.gbelib.app.module.boardHistory.BoardHistoryService;
import kr.go.gbelib.app.module.myItem.MyItem;
import kr.go.gbelib.app.module.myItem.MyItemService;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/myDashBoard"})
public class MyDashBoardController extends BaseController{

	private String basePath = "/homepage/%s/module/myDashBoard/";

	@Autowired
	private TeachService teachService;

	@Autowired
	private BoardHistoryService boardHistoryService;

	@Autowired
	private MyItemService myItemService;

	@Autowired
	private MenuService menuService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MyDashBoard myDashBoard, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
			if ( !isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				myDashBoard.setBefore_url(String.format("/%s/module/myDashBoard/index.do?menu_idx=%s", homepage.getContext_path(), myDashBoard.getMenu_idx()));
				teachService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), myDashBoard.getMenu_idx(), myDashBoard.getBefore_url()), request, response);
				return null;
			}
		} else {
			if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				myDashBoard.setBefore_url(String.format("/%s/module/myDashBoard/index.do?menu_idx=%s", homepage.getContext_path(), myDashBoard.getMenu_idx()));
				teachService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), myDashBoard.getMenu_idx(), myDashBoard.getBefore_url()), request, response);
				return null;
			}
		}

		//대출건수
//		Map<String, Object> myLibraryList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", null);
		Map<String, Object> myLibraryList = null;

		int loanCnt = 0;//소속도서관 대출건수
		int otherLoanCnt = 0;//타도서관 대출건수
		int delayCnt = 0; //연체건수
		String memberLoca = getSessionMemberInfo(request).getLoca();

		if (myLibraryList != null && myLibraryList.containsKey("dsMyLibraryList")) {
			//전체 대출 내역을 가져온다.
			@SuppressWarnings ("unchecked")
			List<Map<String, String>> loanList = (List<Map<String, String>>) myLibraryList.get("dsMyLibraryList");

			if (loanList != null && loanList.size() > 0) {
				for ( Map<String, String> map : loanList ) {
					String mapLoca = map.get("LOCA");
					//점촌땜에 contains로 한다. equals하면 안됨.
					if (memberLoca.contains(mapLoca)) {
						//소속도서관 카운트 증가
						loanCnt++;
					} else {
						//타도서관 카운트 증가
						otherLoanCnt++;
					}

					//대출중인 도서에 한해서 연체 수 증가
					if (StringUtils.equals(map.get("RETURN_TYPE"), "0001")) {
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
						String returnPlanDate = map.get("RETURN_PLAN_DATE");
						Date planDate = sdf.parse(returnPlanDate);
						String toDayStr = sdf.format(new Date());
						Date currentDate = sdf.parse(toDayStr);

						if (planDate.compareTo(currentDate) < 0) {
							//대출 도서관과 상관없이 연체수 증가
							delayCnt++;
						}
					}


				}
			}

		}

		myDashBoard.setLoanCnt(loanCnt);
		myDashBoard.setOtherLoanCnt(otherLoanCnt);
		myDashBoard.setDelayCnt(delayCnt);

		//수강신청건수
		Teach teach = new Teach();
		teach.setHomepage_id(homepage.getHomepage_id());
		if (isLogin(request)) {
			teach.setMember_key(getSessionMemberId(request));
		}
		teach.setSearchStatus("Y");
		teach.setStatus("noCancel");
		List<Teach> applyList = teachService.getApplyList(teach);
		if (applyList != null && applyList.size() > 0) {
			myDashBoard.setTeachApplyCnt(applyList.size());
		}
		int teachMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 13));
		model.addAttribute("teachMenuIdx", teachMenuIdx);


		//게시물, 게시글 수
		BoardHistory boardHistory = new BoardHistory();
		boardHistory.setBoardMember(getSessionMemberInfo(request));
		int boardCount = boardHistoryService.getBoardHistoryCount(boardHistory);
		int replyCount = boardHistoryService.getReplyHistoryCount(boardHistory);
		myDashBoard.setBoardCount(boardCount);
		myDashBoard.setReplyCount(replyCount);
		int boardMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 29));
		model.addAttribute("boardMenuIdx", boardMenuIdx);


		//보관함 갯수
		MyItem myItem = new MyItem();
		myItem.setHomepage_id(homepage.getHomepage_id());
		myItem.setMember_key(getSessionMemberId(request));
		int myItemCount = myItemService.getMyItemCount(myItem);
		myDashBoard.setMyItemCount(myItemCount);


//		//개인공지사항
//		Map<String, Object> myNoticeList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "NOTICE", null);
//
//		if (myNoticeList != null && myNoticeList.containsKey("dsMyLibraryList")) {
//			//전체 대출 내역을 가져온다.
//			@SuppressWarnings ("unchecked")
//			List<Map<String, String>> noticeList = (List<Map<String, String>>) myNoticeList.get("dsMyLibraryList");
//			model.addAttribute("myNoticeList", noticeList);
//		}
//
//		int modifyFormMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/join/modifyForm.do"));
//
//		//대출중인자료
//		Map<String, Object> myLoanList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "LOAN", "0001");
//		model.addAttribute("myLoanList", myLoanList);
//		int loanMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/search/loan/history.do"));
//		model.addAttribute("loanMenuIdx", loanMenuIdx);
//
//		@SuppressWarnings ("unchecked")
//		List<Map<String, String>> myLoanList2 = (List<Map<String, String>>) myLoanList.get("dsMyLibraryList");
//		if (myLoanList2 != null && myLoanList2.size() > 0) {
//			for ( Map<String, String> map : myLoanList2 ) {
//				String isbn = "";
//				String ctrlNo = map.get("CTRLNO");
//				LibrarySearch ls = new LibrarySearch();
//				ls.setvCtrl(ctrlNo);
//				Map<String, Object> marcInfo = LibSearchAPI.getMarcInfo("WEB", ls);
//				@SuppressWarnings ("unchecked")
//				List<Map<String, String>> marcList = (List<Map<String, String>>) marcInfo.get("dsMarcInfo");
//				if (marcList != null && marcList.size() > 0) {
//					isbn = marcList.get(0).get("ISBN");
//					List<Map<String, Object>> naverDetail = LibSearchAPI.getNaverDetail(isbn);
//					if (naverDetail != null && naverDetail.size() > 0) {
//						map.put("image", String.valueOf(naverDetail.get(0).get("image")));
//					}
//				}
//			}
//
//		}
//
//		//희망도서내역
//		Map<String, Object> myHopeList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "HOPE", null);
//		model.addAttribute("myHopeList", myHopeList);
//		int hopeMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 12));
//		model.addAttribute("hopeMenuIdx", hopeMenuIdx);
//
//		//예약중내역
//		Map<String, Object> myReserveList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "RESVE", null);
//		model.addAttribute("myReserveList", myReserveList);
//		int reserveMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/search/resve/index.do"));
//		model.addAttribute("reserveMenuIdx", reserveMenuIdx);
//
//		//상호대차
//		Map<String, Object> myOutList = LibSearchAPI.getMyLibraryList("WEB", getSessionUserId(request), "OUT", null);
//		model.addAttribute("myOutList", myOutList);

		myDashBoard.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("myDashBoard", myDashBoard);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping (value = { "/view.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) {

		String informNo = request.getParameter("informNo");

		if (StringUtils.isNotEmpty(informNo)) {
//			Map<String, Object> noticeDetail = LibSearchAPI.getNoticeDetail("WEB", informNo);
//			model.addAttribute("noticeDetail", noticeDetail);
		}

		return basePath + "view_ajax";
	}

}
