package kr.go.gbelib.app.module.portalMember;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.cms.module.portalMember.PortalMemberService;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Controller(value = "userPortalMember")
@RequestMapping(value = {"/{homepagePath}/module/portalMember"})
public class PortalMemberController extends BaseController {
	
	private String basePath = "/homepage/%s/module/portalMember/";
	
	@Autowired
	private PortalMemberService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String loginForm(Model model, PortalMember portalMember, HttpServletRequest request, @PathVariable ("homepagePath") String homepagePath) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		PortalMember loginPortal = sessionLoginPortal(request);
		if (loginPortal != null) {
			if("gw".equals(homepage.getContext_path())){
				return "redirect:" + String.format("/%s/intro/search/indexAll.do?menu_idx=13", homepagePath);
			} else {
				return "redirect:" + String.format("/%s/intro/search/indexAll.do?menu_idx=7", homepagePath);
			}
		}
		
		model.addAttribute("portalMember", portalMember);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/loginProc.*"}, method = RequestMethod.POST)
	public String loginProc(Model model, PortalMember portalMember, HttpServletRequest request, HttpServletResponse response, @PathVariable ("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		String returnUrl = portalMember.getBefore_url();
		
		PortalMember loginPortal = service.getPortalMemberLogin(portalMember);
    	if(loginPortal == null) {
    		service.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
    	} else {
    		loginPortal.setLogin(true);
			service.addLastLogin(loginPortal);
			request.getSession().removeAttribute("member");
			request.getSession().removeAttribute("loginSupport");
			request.getSession().setAttribute("loginPortal", loginPortal);
		}
    	
		if (StringUtils.isEmpty(returnUrl) || returnUrl.indexOf("/login/") > -1) {
			int menu_idx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 11));
			returnUrl = String.format("%s/%s/module/portalMember/index.do?menu_idx=%s", homepage.getDomain(), homepagePath, menu_idx);
			if (request.getRequestURL().toString().contains("localhost")) {
				returnUrl = String.format("%s/%s/module/portalMember/index.do?menu_idx=%s", "http://localhost", homepagePath, menu_idx);
			}
		}
		
		model.addAttribute("portalMember", portalMember);

		return "redirect:" + returnUrl.replaceAll("^http://(www\\.)?library\\.daegu\\.go\\.kr", "https://library.daegu.go.kr");
	}
	
	@RequestMapping (value = "/logout.*", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		request.getSession().invalidate();
		String redirectURL = (request.isSecure() ? "https://" : "http://") + request.getServerName() + "/" + homepage.getContext_path();
		
		return "redirect:" + redirectURL + "/index.do";
	}

}
