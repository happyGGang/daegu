package kr.co.whalesoft.app.cms.site;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/site"})
public class SiteController extends BaseController {

	private final String basePath = "/cms/site/";

	@Autowired
	private SiteService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Site site, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			site.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		int count = service.getSiteListCount(site);
		service.setPaging(model, count, site);
		site.setTotalDataCount(count);
		model.addAttribute("site", site);
		model.addAttribute("siteListCount", count);
		model.addAttribute("siteList", service.getSiteList(site));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Site site, HttpServletRequest request) throws AuthException {
		if(site.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("site", service.copyObjectPaging(site, service.getSiteOne(site)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("site", site);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Site site, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = site.getEditMode();
	/*	if(!teach.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_name", "홈페이지명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "homepage_type", "홈페이지 유형을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "domain", "도메인명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "folder", "폴더명을 입력하세요.");
		}*/
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				service.addSite(site);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				service.modifySite(site);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteSite(site);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}