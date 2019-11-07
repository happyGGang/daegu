package kr.go.gbelib.app.intro.rfLogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LoginAPI;

@Controller
@RequestMapping(value = {"/intro/{context_path}/rfLogin"})
public class rfLoginController extends BaseController {

	private final String basePath = "/intro/rfLogin/";

	@Autowired
	private LoginService service;

	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("homepage", homepage);

		return basePath + "index";
	}

	@RequestMapping(value = {"/loginProc.*"})
	public String loginProc(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		// 아이디, 비번, 이름 복호화

		String returnUrl = member.getBefore_url();
		if ( StringUtils.isEmpty(returnUrl) ) {
			returnUrl = "/intro/" + homepage.getContext_path() + "/search/index.do";
		}
		member.setLoca(homepage.getHomepage_codeList()[0]);
		Object result = LoginAPI.rfidLogin(member);
		if ( result instanceof Member ) {
			member = (Member) result;
			member.setLogin(true);
			service.setSessionMember(member, request);
			service.redirectUrl(returnUrl, request, response);
			return null;
		}
		else {
			ApiResponse errorResult = (ApiResponse) result;
			service.alertMessage(errorResult.getMessage(), request, response);
			return null;
		}
	}
}
