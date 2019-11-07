package kr.co.whalesoft.app.cms.module.boardAccess;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = {"/cms/boardAccess"})
public class BoardAccessController extends BaseController {

	private final String basePath = "/cms/boardAccess/";
	
	@Autowired
	private BoardAccessService service;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request, BoardAccess boardAccess) throws AuthException {
//		checkAuth("R", model, request);
		 
//		if ( !getSessionIsAdmin(request) ) {
		if(boardAccess.getHomepage_id() == null) {
			boardAccess.setHomepage_id(getAsideHomepageId(request));	
		}
			Homepage homepage = getSessionHomepageInfo(request);
			boardAccess.setHomepage_name(homepage.getHomepage_name());
//		}
		
		if (StringUtils.isEmpty(boardAccess.getDate_type())) {
			boardAccess.setDate_type("DAY");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			boardAccess.setStart_date(sdf.format(new Date()));
			boardAccess.setEnd_date(sdf.format(new Date()));
		}
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("boardAccess", boardAccess);
		model.addAttribute("boardTypes", codeService.getCode(getAsideHomepageId(request), "C0000"));
		model.addAttribute("boardList", service.getBoardAccessCount(boardAccess));
		model.addAttribute("total_count", service.getBoardAccessTotalCount(boardAccess));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BoardAccessSearchView excelDownload(Model model, BoardAccess boardAccess, HttpServletRequest request){
		model.addAttribute("boardAccess", boardAccess);
		model.addAttribute("boardList", service.getBoardAccessCount(boardAccess));
		model.addAttribute("total_count", service.getBoardAccessTotalCount(boardAccess));
		return new BoardAccessSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, BoardAccess boardAccess, HttpServletRequest request, HttpServletResponse response){
		List<BoardAccess> boardList = service.getBoardAccessCount(boardAccess);
		int total_count = service.getBoardAccessTotalCount(boardAccess);
		
		new BoardAccessXlsToCsv(boardAccess, boardList, total_count, request, response);
	}
	
}