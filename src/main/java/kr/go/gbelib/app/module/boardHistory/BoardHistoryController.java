package kr.go.gbelib.app.module.boardHistory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="boardHistory")
@RequestMapping(value = {"/{homepagePath}/module/boardHistory"})
public class BoardHistoryController extends BaseController {

	private String basePath = "/homepage/%s/module/boardHistory/";
	
	@Autowired
	private BoardHistoryService service;
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, BoardHistory boardHistory, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");		
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			boardHistory.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), boardHistory.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), boardHistory.getMenu_idx(), boardHistory.getBefore_url()), request, response);
			return null;
	    }
		boardHistory.setBoardMember(getSessionMemberInfo(request));

		int boardCount = service.getBoardHistoryCount(boardHistory);
		int replyCount = service.getReplyHistoryCount(boardHistory);
		int elibCommentCount = service.getElibCommentHistoryCount(boardHistory);
		
		if ( StringUtils.equals(boardHistory.getHistoryType(), "board") ) {
			service.setPaging(model, boardCount, boardHistory);
			model.addAttribute("boardHistoryList", service.getBoardHistoryList(boardHistory));
		} else if ( StringUtils.equals(boardHistory.getHistoryType(), "reply") ) {
			service.setPaging(model, replyCount, boardHistory);
			model.addAttribute("boardHistoryList", service.getReplyHistoryList(boardHistory));
		} else if ( StringUtils.equals(boardHistory.getHistoryType(), "elib") ) {
			service.setPaging(model, elibCommentCount, boardHistory);
			model.addAttribute("boardHistoryList", service.getElibCommentHistoryList(boardHistory));
		}
		
		model.addAttribute("boardCount", boardCount);
		model.addAttribute("replyCount", replyCount);
		model.addAttribute("elibCommentCount", elibCommentCount);
		model.addAttribute("boardHistory", boardHistory);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
}
