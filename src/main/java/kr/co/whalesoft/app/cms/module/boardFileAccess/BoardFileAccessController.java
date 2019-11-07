package kr.co.whalesoft.app.cms.module.boardFileAccess;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/boardFileAccess" })
public class BoardFileAccessController extends BaseController {
	
	private final String basePath = "/cms/boardFileAccess/";
	
	@Autowired
	private BoardService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request, BoardFileAccess boardFileAccess) throws AuthException {
		checkAuth("R", model, request);
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("boardFileAccess", boardFileAccess);
		model.addAttribute("boardList", service.getBoardFileAccess(boardFileAccess));
		return basePath + "index";
	}
	

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BoardFileAccessSearchView excelDownload(Model model, BoardFileAccess boardFileAccess, HttpServletRequest request){
		model.addAttribute("boardFileAccess", boardFileAccess);
		model.addAttribute("boardList", service.getBoardFileAccess(boardFileAccess));
		
		return new BoardFileAccessSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, BoardFileAccess boardFileAccess, HttpServletRequest request, HttpServletResponse response){
		List<BoardFileAccess> boardList = service.getBoardFileAccess(boardFileAccess);
		
		new BoardFileAccessXlsToCsv(boardFileAccess, boardList, request, response);
	}

}
