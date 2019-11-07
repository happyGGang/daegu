package kr.co.whalesoft.app.cms.boardAllSearch;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = {"/cms/boardAllSearch"})
public class BoardAllSearchController extends BaseController {

	private final String basePath = "/cms/boardAllSearch/";
	
	@Autowired
	private BoardAllSearchService service;
	
	@Autowired
	private BoardManageService boardManageService;
	
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BoardAllSearch board, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if (!StringUtils.equals(board.getBoard_mode(), "ADMIN")) {
			board.setHomepage_id(getAsideHomepageId(request));
		} else {
			board.setHomepage_id(null);	
		}
		model.addAttribute("board", board);
		
		service.setPaging(model, service.getBoardCount(board), board);
		
		model.addAttribute("boardList", service.getBoard(board));
		
		BoardManage boardManage = new BoardManage();
		boardManage.setHomepage_id(board.getHomepage_id());
		model.addAttribute("boardManageList", boardManageService.getBoardManageAll(boardManage));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"})
	public BoardAllSearchView excel(Model model, BoardAllSearch board, HttpServletRequest request, HttpServletResponse response) throws Exception{
		checkAuth("R", model, request);
		if (!StringUtils.equals(board.getBoard_mode(), "ADMIN")) {
			board.setHomepage_id(getAsideHomepageId(request));
		} else {
			board.setHomepage_id(null);	
		}
		model.addAttribute("board", board);
		
		service.setPaging(model, service.getBoardCount(board), board);
		
		model.addAttribute("boardList", service.getBoard(board));
		
		BoardManage boardManage = new BoardManage();
		boardManage.setHomepage_id(board.getHomepage_id());
		model.addAttribute("boardManageList", boardManageService.getBoardManageAll(boardManage));
		
		return new BoardAllSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"})
	public void csv(Model model, BoardAllSearch board, HttpServletRequest request, HttpServletResponse response) throws Exception{
		checkAuth("R", model, request);
		if (!StringUtils.equals(board.getBoard_mode(), "ADMIN")) {
			board.setHomepage_id(getAsideHomepageId(request));
		} else {
			board.setHomepage_id(null);	
		}
		model.addAttribute("board", board);
		
		service.setPaging(model, service.getBoardCount(board), board);
		
		List<BoardAllSearch> boardList = service.getBoard(board);
		model.addAttribute("boardList", boardList);
		
		BoardManage boardManage = new BoardManage();
		boardManage.setHomepage_id(board.getHomepage_id());
		List<BoardManage> boardManageList = boardManageService.getBoardManageAll(boardManage);
		model.addAttribute("boardManageList", boardManageList);
		
		new BoardAllSearchXlsToCsv(board, boardList, boardManageList, request, response);
	}
	
}
