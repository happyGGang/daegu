package kr.go.gbelib.app.intro.search;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.teach.Teach;
import kr.go.gbelib.app.cms.module.teach.TeachService;
import kr.go.gbelib.app.common.api.CommonAPI;
import kr.go.gbelib.app.common.api.LibSearchAPI;

@Controller
@RequestMapping(value = {"/{homepagePath}/intro/totalSearch"})
public class CommonTotalSearchController extends BaseController {
	
	private String basePath = "/homepage/%s/commonIntro/totalSearch/";
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private TeachService teachService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private MenuService menuService;
	
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	@ModelAttribute("liboneApiUrl")
	private String getLiboneApiUrl() {
		return CommonAPI.LIBONE_API_URL;
	}
	
	@ModelAttribute("libraryList")
	private Map<String, Object> getLibraryList() {
		return LibSearchAPI.getLibraryList();
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, TotalSearch totalSearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String search = totalSearch.getSearch_text();
		if ( StringUtils.isNotEmpty(search) || "DETAIL".equals(totalSearch.getTotal_search_type()) || "SUBJECT".equals(totalSearch.getTotal_search_type()) ) {
			
			// 도서검색 시작
			LibrarySearch librarySearch = new LibrarySearch();
			List<String> libraryCodes = new ArrayList<String>();
			
			Board board = new Board();
			Board board2 = new Board();

			Teach teach = new Teach();

			if ( !"ALL".equals(totalSearch.getDate_type()) ) {
				String startDate = "";
				String endDate = "";

				if ( "WEEK".equals(totalSearch.getDate_type()) ) {
					startDate = sf.format(DateUtils.addWeeks(new Date(), -1));
					endDate = sf.format(new Date());
				}
				else if ( "MONTH".equals(totalSearch.getDate_type()) ) {
					startDate = sf.format(DateUtils.addMonths(new Date(), -1));
					endDate = sf.format(new Date());
				}
				else {
					startDate = totalSearch.getStart_date();
					endDate = totalSearch.getEnd_date();
				}
				
				board.setStart_date(startDate);
				board.setEnd_date(endDate);
				board2.setStart_date(startDate);
				board2.setEnd_date(endDate);
				teach.setStart_date(startDate);
				teach.setEnd_date(endDate);
			}
			

			/*
			 * 경상북도교육청 통합공공도서관
			 * 통합 자료검색 도서자료 3개씩
			 * 게시판, 강좌 5개씩
			 */
			if(homepage.getHomepage_id().equals("h1")) {
				// 
				librarySearch.setRowCount(3);
				librarySearch.setViewPage(1);
				
				board.setRowCount(5);
				board.setViewPage(1);
				
				teach.setRowCount(5);
				teach.setViewPage(1);
			}
			
			if ( "TOTAL".equals(totalSearch.getTotal_search_type()) ) {
				libraryCodes.add("ALL");
				librarySearch.setLibraryCodes(libraryCodes);
				librarySearch.setSearch_text(search);
				librarySearch.setSearch_type("L_TITLE");
				librarySearch.setSortField(totalSearch.getSort_type());
				librarySearch.setSortType("ASC");
				model.addAttribute("result", LibSearchAPI.getSearch(librarySearch, 1)); // 검색한 결과	
				
				teach.setSearch_text(search);
			}
			else if ( "DETAIL".equals(totalSearch.getTotal_search_type()) ) {
				librarySearch = totalSearch.copyDetailSearchParam(librarySearch);
				model.addAttribute("result", LibSearchAPI.getDetailSearch(librarySearch));
				board = totalSearch.copyDetailSearchParam(board);
				board2 = totalSearch.copyDetailSearchParam(board2);
				teach = totalSearch.copyDetailSearchParam(teach);
			}
			else if ( "SUBJECT".equals(totalSearch.getTotal_search_type()) ) {
				librarySearch.setKdcSearch(totalSearch.getKdcSearch());
				model.addAttribute("result", LibSearchAPI.getSubjectSearch(librarySearch, totalSearch.getBook_more_count()));
			}
			// 도서검색 끝
			// 게시판 검색 시작
			// 공지사항
			if(!totalSearch.getTotal_search_type().equals("SUBJECT")) {
				board.setSearch_text(search);
				board.setBoard_type("NOTICE");
				int boardCount = boardService.getTotalSearchByTypeCount(board);
				boardService.setPaging(model, boardCount, board);
				
				model.addAttribute("noticeList", boardService.getTotalSearchByType(board));
				model.addAttribute("noticeCount", boardCount);	
				
				// 자주하는 질문
				//board2.setSearch_text(search);
				//board2.setBoard_type("FAQ");
				//model.addAttribute("faqList", boardService.getTotalSearchByType(board2));
				// 게시판 검색 끝
				
				// 강좌 검색 시작
				
				int teachCount = teachService.getTeachListForAllHomepageCount(teach);
				teachService.setPaging(model, teachCount, teach);
				model.addAttribute("teachCount", teachCount);
				model.addAttribute("teachList", teachService.getTeachListForAllHomepage(teach));
				List<Teach> teachListForAllHomepage = teachService.getTeachListForAllHomepage(teach);
				for ( Teach teach2 : teachListForAllHomepage ) {
					teach2.setMenu_idx(menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 13)));
				}
	//			model.addAttribute("myTeachListMenuIdx", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 13)));//수강신청내역 menu_idx
				// 강좌 검색 끝
			}
		}
		
		
		model.addAttribute("totalSearch", totalSearch);
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/more.*"})
	public String more(Model model, TotalSearch totalSearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String search = totalSearch.getSearch_text();
		String more_type = totalSearch.getMore_type();
		
		if ( StringUtils.isNotEmpty(search) || "DETAIL".equals(totalSearch.getTotal_search_type()) || "SUBJECT".equals(totalSearch.getTotal_search_type())) {
			
			// 도서검색 시작
			LibrarySearch librarySearch = new LibrarySearch();
			List<String> libraryCodes = new ArrayList<String>();
			
			Board board = new Board();
			Board board2 = new Board();

			Teach teach = new Teach();

			if ( !"ALL".equals(totalSearch.getDate_type()) ) {
				String startDate = "";
				String endDate = "";

				if ( "WEEK".equals(totalSearch.getDate_type()) ) {
					startDate = sf.format(DateUtils.addWeeks(new Date(), -1));
					endDate = sf.format(new Date());
				}
				else if ( "MONTH".equals(totalSearch.getDate_type()) ) {
					startDate = sf.format(DateUtils.addMonths(new Date(), -1));
					endDate = sf.format(new Date());
				}
				else {
					startDate = totalSearch.getStart_date();
					endDate = totalSearch.getEnd_date();
				}
				
				board.setStart_date(startDate);
				board.setEnd_date(endDate);
				board2.setStart_date(startDate);
				board2.setEnd_date(endDate);
				teach.setStart_date(startDate);
				teach.setEnd_date(endDate);
			}
			
			/*
			 * 경상북도교육청 통합공공도서관
			 * 통합 자료검색 도서자료 3개씩
			 * 게시판, 강좌 5개씩
			 */
			if(homepage.getHomepage_id().equals("h1")) {
				librarySearch.setRowCount(3);
				librarySearch.setViewPage(1);
				
				board.setRowCount(5);
				board.setViewPage(1);
				
				teach.setRowCount(5);
				teach.setViewPage(1);
			}
			
			if ( "TOTAL".equals(totalSearch.getTotal_search_type()) ) {
				libraryCodes.add("ALL");
				librarySearch.setLibraryCodes(libraryCodes);
				librarySearch.setSearch_text(search);
				librarySearch.setSearch_type("L_TITLE");
				librarySearch.setSortField(totalSearch.getSort_type());
				librarySearch.setSortType("ASC");
				
				if ( "BOOK".equals(more_type) ) {
					model.addAttribute("result", LibSearchAPI.getSearch(librarySearch, totalSearch.getBook_more_count())); // 검색한 결과	
				}
				
				teach.setSearch_text(search);
			}
			else if ( "DETAIL".equals(totalSearch.getTotal_search_type()) ) {
				librarySearch = totalSearch.copyDetailSearchParam(librarySearch);
				
				if ( "BOOK".equals(more_type) ) {
					librarySearch.setViewPage(totalSearch.getBook_more_count());
					model.addAttribute("result", LibSearchAPI.getDetailSearch(librarySearch));
					totalSearch.setTotal_search_type("DETAIL");
				}
				
				board = totalSearch.copyDetailSearchParam(board);
				board2 = totalSearch.copyDetailSearchParam(board2);
				teach = totalSearch.copyDetailSearchParam(teach);
			}
			else if ( "SUBJECT".equals(totalSearch.getTotal_search_type()) ) {
				librarySearch.setKdcSearch(totalSearch.getKdcSearch());
				model.addAttribute("result", LibSearchAPI.getSubjectSearch(librarySearch, totalSearch.getBook_more_count()));
			}
			// 도서검색 끝
			// 게시판 검색 시작
			// 공지사항
			board.setSearch_text(search);
			board.setBoard_type("NOTICE");
			
			if ( "NOTICE".equals(more_type) ) {
				board.setViewPage(totalSearch.getNotice_more_count());
				int count = boardService.getTotalSearchByTypeCount(board);
				boardService.setPaging(model, count, board);
				model.addAttribute("noticeList", boardService.getTotalSearchByType(board));
				model.addAttribute("noticeCount", count);	
			}
			
			
			// 자주하는 질문
			//board2.setSearch_text(search);
			//board2.setBoard_type("FAQ");
			//model.addAttribute("faqList", boardService.getTotalSearchByType(board2));
			// 게시판 검색 끝
			
			// 강좌 검색 시작
			if ( "TEACH".equals(more_type) ) {
				teach.setViewPage(totalSearch.getTeach_more_count());
				int count = teachService.getTeachListForAllHomepageCount(teach);
				teachService.setPaging(model, count, teach);
				model.addAttribute("teachCount", count);
    			model.addAttribute("teachList", teachService.getTeachListForAllHomepage(teach));
			}
			// 강좌 검색 끝
		}
		
		model.addAttribute("totalSearch", totalSearch);
		return String.format(basePath, homepage.getFolder()) + "more_ajax";
	}
}