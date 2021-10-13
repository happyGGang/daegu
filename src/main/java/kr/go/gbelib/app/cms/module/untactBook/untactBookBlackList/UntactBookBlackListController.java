package kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value="/cms/module/untactBook/untactBookBlackList")
public class UntactBookBlackListController extends BaseController {
	                                                          
	private final String basePath = "/cms/module/untactBook/untactBookBlackList/";
	
	@Autowired
	private UntactBookBlackListService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookBlackList untactBookBlackList, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookBlackList.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getUntactBookBlackListCount(untactBookBlackList);
		service.setPaging(model, count, untactBookBlackList);
		untactBookBlackList.setTotalDataCount(count);
		
		model.addAttribute("untactBookBlackList", untactBookBlackList);
		model.addAttribute("untactBookBlackListCount", count);
		model.addAttribute("untactBookBlackListList", service.getUntactBookBlackListList(untactBookBlackList));
		return basePath + "index";
	}
	
	@RequestMapping (value = {"/deleteOne.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteUntactBookBlackList(UntactBookBlackList untactBookBlackList, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookBlackList.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.deleteUntactBookBlackList(untactBookBlackList);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/deleteAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteAllUntactBookBlackList(UntactBookBlackList untactBookBlackList, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookBlackList.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.deleteAllUntactBookBlackList(untactBookBlackList);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookBlackListSearchView excelDownload(Model model, UntactBookBlackList untactBookBlackList, HttpServletRequest request){
		model.addAttribute("untactBookBlackList", untactBookBlackList);
		model.addAttribute("untactBookBlackListList", service.getUntactBookBlackListExcelList(untactBookBlackList));
		
		return new UntactBookBlackListSearchView();
	}
	
	
}
