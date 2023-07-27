package kr.go.gbelib.app.intro.rfLogin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.whalesoft.app.cms.accountLock.AccountLock;
import kr.co.whalesoft.app.cms.accountLock.AccountLockService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.common.api.PrivateLoginAPI;
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Controller (value = "rfLogin")
@RequestMapping (value = {"/intro/{context_path}/rfLogin"})
public class rfLoginController extends BaseController {

	@Autowired
	private LoginService service;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private AccountLockService accountLockService;

	@Autowired
	private LoginLogService loginLogService;

	@RequestMapping (value = {"/index.*"})
	public String login(@PathVariable String context_path, Model model, Member member, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);

		model.addAttribute("member", member);
		model.addAttribute("homepage", homepage);
		return "/intro/rfLogin/index";
	}

	@RequestMapping (value = {"/rfidLoginProc.*"})
	public String rfidLoginProc(@PathVariable String context_path, Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		String returnUrl = member.getBefore_url();
		if ( StringUtils.isEmpty(returnUrl) ) {
			returnUrl = "/intro/" + homepage.getContext_path() + "/index.do";
		}
		
		if (homepage != null && StringUtils.isNotEmpty(homepage.getManage_code())) {
			member.setManage_code(homepage.getManage_code());
		}
		if (homepage == null) {
			homepage = new Homepage();
			homepage.setHomepage_id("h00");
		}
		
		member.setLoginType("HOMEPAGE");
		Object result = LoginAPI.rfidLogin(member);
		if (result instanceof Member) {
			HttpSession session = request.getSession();
			session.invalidate();
			
			accountLockService.loginSucceeded(new AccountLock(member, request.getRemoteAddr()));
			loginLogService.addLoginLog(new LoginLog(member, request, homepage));

			member = (Member) result;
			member.setLogin(true);
			service.setSessionMember(member, request);
			service.redirectUrl(returnUrl, request, response);
			return null;
		} else {
			Object barcodeResult = LoginAPI.barcodeLogin(member);
			
			if(barcodeResult instanceof Member) {
				HttpSession session = request.getSession();
				session.invalidate();
				
				accountLockService.loginSucceeded(new AccountLock(member, request.getRemoteAddr()));
				loginLogService.addLoginLog(new LoginLog(member, request, homepage));

				member = (Member) barcodeResult;
				member.setLogin(true);
				service.setSessionMember(member, request);
				service.redirectUrl(returnUrl, request, response);
				return null;
			} else {
				if (homepage != null && StringUtils.isNotEmpty(homepage.getHomepage_id())) {
					member.setHomepage_id(homepage.getHomepage_id());
				} else {
					member.setHomepage_id("h00");
				}
				member.setLoginType("HOMEPAGE");
				accountLockService.loginFailed(new AccountLock(member, request.getRemoteAddr()));
				ApiResponse errorResult = (ApiResponse) result;

				if ("해당 정보와 일치하는 이용자가 없습니다.".equals(errorResult.getMessage())) {
					codeService.alertMessage(String.format("해당 정보와 일치하는 이용자가 없습니다."), request, response);
					return null;
				} else {
					codeService.alertMessage(errorResult.getMessage(), request, response);
					return null;
				}
			}
		}
	}

	/**
	 * 로그아웃 처리
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping (value = "/logout.*", method = RequestMethod.GET)
	public String logout(@PathVariable String context_path, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Homepage homepage = getSessionHomepage(request);
		service.logout(request);
		return String.format("redirect:/intro/%s/index.do", context_path);
	}

	/**
	 * 모바일 회원증
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/mobileCard.*"})
	public String mobileCard(@PathVariable String context_path, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		
		Member member = getSessionMemberInfo(request);

		if(member.getPrivateMemberYn(homepage)) {
			if (!isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		} else {
			if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + context_path + "/login/index.do", request, response);
				return null;
			}
		}
		
		if (StringUtils.isBlank(member.getUser_no())) {
			service.alertMessage("대출회원만 가능합니다.", request, response);
			return null;
		}

		return "/intro/login/mobileCard";
	}
}
