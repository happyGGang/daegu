package kr.go.gbelib.app.module.sdi;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/{homepagePath}/module/sdi"})
public class SdiController extends BaseController {

	private String basePath = "/homepage/%s/module/sdi/";
	
	@Autowired
	private SdiService sdiService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CodeService codeService;
	
	
	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Sdi sdi, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		sdi.setHomepage_id(homepage.getHomepage_id());
		sdi.setMember_key(getSessionMemberInfo(request).getSeq_no());
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			sdi.setBefore_url(String.format("http://www.gbelib.kr/%s/module/sdi/index.do?menu_idx=%s", homepage.getContext_path(), sdi.getMenu_idx()));
			sdiService.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), sdi.getMenu_idx(), sdi.getBefore_url()), request, response);
			return null;
	    }
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("sdi", sdi);
		model.addAttribute("sdiList", sdiService.getSdi(sdi));
		model.addAttribute("keyword_type", codeService.getCode("CMS", "C0011"));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Sdi sdi, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(sdi.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "keyword", "키워드를 입력하세요.");
		}
						
		sdi.setMember_key(getSessionMemberInfo(request).getSeq_no());
		sdi.setAdd_id(getSessionMemberInfo(request).getSeq_no());
		sdi.setModify_id(getSessionMemberInfo(request).getSeq_no());
		
		if(!result.hasErrors()) {			
			if(sdi.getEditMode().equals("ADD")) {
				sdiService.insertSdi(sdi);
				res.setValid(true);
				res.setUrl("index.do?menu_idx="+sdi.getMenu_idx());
				res.setMessage("등록되었습니다.");
				
			} else if(sdi.getEditMode().equals("MODIFY")) {
				sdiService.modifySdi(sdi);
				res.setValid(true);
				res.setUrl("index.do?menu_idx="+sdi.getMenu_idx());
				res.setMessage("수정 되었습니다.");
			} else if(sdi.getEditMode().equals("DELETE")) {
				sdiService.deleteSdi(sdi);
				res.setValid(true);
				res.setUrl("index.do?menu_idx="+sdi.getMenu_idx());
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
}
