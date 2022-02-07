package kr.go.gbelib.app.cms.module.walkingThru.walkingThruCancelHistory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.StaticVariables;

@Controller
@RequestMapping(value="/cms/module/walkingThru/walkingThruCancelHistory")
public class WalkingThruCancelHistoryController extends BaseController {

private final String basepath = "/cms/module/walkingThru/walkingThruCancelHistory/";
	
	@Autowired
	private WalkingThruCancelHistoryService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, WalkingThruCancelHistory walkingThruCancelHistory, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		walkingThruCancelHistory.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		walkingThruCancelHistory.setAdmin_member_id(member.getMember_id());

		int count = service.getWalkingThruCancelHistoryCount(walkingThruCancelHistory);
		service.setPaging(model, count, walkingThruCancelHistory);
		walkingThruCancelHistory.setTotalDataCount(count);
		
		model.addAttribute("walkingThruCancelHistory", walkingThruCancelHistory);
		model.addAttribute("walkingThruCancelHistoryCount", count);
		model.addAttribute("walkingThruCancelHistoryList", service.getWalkingThruCancelHistoryList(walkingThruCancelHistory));
		
		return basepath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WalkingThruCancelHistorySearchView excelDownload(Model model, WalkingThruCancelHistory walkingThruCancelHistory, HttpServletRequest request){
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		walkingThruCancelHistory.setAdmin_member_id(member.getMember_id());
		
		model.addAttribute("walkingThruCancelHistory", walkingThruCancelHistory);
		model.addAttribute("walkingThruCancelHistoryList", service.getWalkingThruCancelHistoryExcelList(walkingThruCancelHistory));
		
		return new WalkingThruCancelHistorySearchView();
	}
	
}
