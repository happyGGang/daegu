package kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;

@Controller
@RequestMapping(value="/cms/module/walkingThru/walkingThruBlackList")
public class WalkingThruBlackListController extends BaseController {

private final String basePath = "/cms/module/walkingThru/walkingThruBlackList/";
	
	@Autowired
	private WalkingThruBlackListService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, WalkingThruBlackList walkingThruBlackList, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		walkingThruBlackList.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		walkingThruBlackList.setAdmin_member_id(member.getMember_id());
		
		int count = service.getWalkingThruBlackListCount(walkingThruBlackList);
		service.setPaging(model, count, walkingThruBlackList);
		walkingThruBlackList.setTotalDataCount(count);
		
		model.addAttribute("walkingThruBlackList", walkingThruBlackList);
		model.addAttribute("walkingThruBlackListCount", count);
		model.addAttribute("walkingThruBlackListList", service.getWalkingThruBlackListList(walkingThruBlackList));
		return basePath + "index";
	}
	
	@RequestMapping (value = {"/deleteOne.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		walkingThruBlackList.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.deleteWalkingThruBlackList(walkingThruBlackList);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/deleteAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteAllWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		walkingThruBlackList.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.deleteAllWalkingThruBlackList(walkingThruBlackList);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WalkingThruBlackListSearchView excelDownload(Model model, WalkingThruBlackList walkingThruBlackList, HttpServletRequest request){
		model.addAttribute("walkingThruBlackList", walkingThruBlackList);
		model.addAttribute("walkingThruBlackListList", service.getWalkingThruBlackListExcelList(walkingThruBlackList));
		
		return new WalkingThruBlackListSearchView();
	}
}
