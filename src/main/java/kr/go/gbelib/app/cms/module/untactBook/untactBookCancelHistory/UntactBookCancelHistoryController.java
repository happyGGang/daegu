package kr.go.gbelib.app.cms.module.untactBook.untactBookCancelHistory;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value="/cms/module/untactBook/untactBookCancelHistory")
public class UntactBookCancelHistoryController extends BaseController {
	                                                          
	private final String basepath = "/cms/module/untactBook/untactBookCancelHistory/";
	
	@Autowired
	private UntactBookCancelHistoryService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookCancelHistory untactBookCancelHistory, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookCancelHistory.setHomepage_id(getAsideHomepageId(request));

		int count = service.getUntactBookCancelHistoryCount(untactBookCancelHistory);
		service.setPaging(model, count, untactBookCancelHistory);
		untactBookCancelHistory.setTotalDataCount(count);
		
		model.addAttribute("untactBookCancelHistory", untactBookCancelHistory);
		model.addAttribute("untactBookCancelHistoryCount", count);
		model.addAttribute("untactBookCancelHistoryList", service.getUntactBookCancelHistoryList(untactBookCancelHistory));
		
		return basepath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookCancelHistorySearchView excelDownload(Model model, UntactBookCancelHistory untactBookCancelHistory, HttpServletRequest request){
		model.addAttribute("untactBookCancelHistory", untactBookCancelHistory);
		model.addAttribute("untactBookCancelHistoryList", service.getUntactBookCancelHistoryExcelList(untactBookCancelHistory));
		
		return new UntactBookCancelHistorySearchView();
	}
	
}
