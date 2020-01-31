package kr.go.gbelib.app.module.supportMember;

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
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;
import kr.go.gbelib.app.cms.module.supportMember.SupportMemberService;

@Controller(value = "userSupportMember")
@RequestMapping(value = {"/{homepagePath}/module/supportMember"})
public class SupportMemberController {
	
	private String basePath = "/homepage/%s/module/supportMember/";
	
	@Autowired
	private SupportMemberService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String loginForm(Model model, SupportMember supportMember, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("supportMember", supportMember);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/loginProc.*"}, method = RequestMethod.POST)
	public String loginProc(Model model, SupportMember supportMember, HttpServletRequest request, HttpServletResponse response, @PathVariable ("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		String returnUrl = supportMember.getBefore_url();
		
		SupportMember loginSupport = service.getSupportMemberLogin(supportMember);
    	if(loginSupport == null) {
    		service.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
    	} else {
    		loginSupport.setLogin(true);
			service.addLastLogin(loginSupport);
			request.getSession().removeAttribute("member");
			request.getSession().setAttribute("loginSupport", loginSupport);
//			request.getSession().setAttribute("authGroup", loginSupport.getAuth_group());
		}
    	
		if (StringUtils.isEmpty(returnUrl) || returnUrl.indexOf("/login/") > -1) {
			returnUrl = String.format("%s/%s/index.do", homepage.getDomain(), homepagePath);
			if (request.getRequestURL().toString().contains("localhost")) {
				returnUrl = String.format("%s/%s/index.do", "http://localhost", homepagePath);
			}
		}
		
		model.addAttribute("supportMember", supportMember);

		return "redirect:" + returnUrl.replaceAll("^http://(www\\.)?library\\.daegu\\.go\\.kr", "https://library.daegu.go.kr");
	}
	
	@RequestMapping (value = "/logout.*", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		request.getSession().invalidate();
		String redirectURL = request.isSecure() ? "https://" : "http://" + request.getServerName() + "/" + homepage.getContext_path();
		return "redirect:" + redirectURL + "/index.do";
	}


}
