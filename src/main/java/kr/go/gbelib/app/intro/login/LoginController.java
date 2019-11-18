package kr.go.gbelib.app.intro.login;

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
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Controller (value = "introLogin")
@RequestMapping (value = {"/intro/{context_path}/login"})
public class LoginController extends BaseController {

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
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		model.addAttribute("member", member);
		model.addAttribute("homepage", homepage);
		return "/intro/login/index";
	}

	@RequestMapping (value = {"/loginProc.*"})
	public String loginProc(Model model, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		// 아이디, 비번, 이름 복호화
		if (memberService.decryptMember(member) == false) {
			codeService.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
			return null;
		}

		String returnUrl = member.getBefore_url();
		if (StringUtils.isEmpty(returnUrl)) {
			returnUrl = "/intro/" + homepage.getContext_path() + "/index.do";
		}

		// 비번 틀려서 계정이 잠김
		if ("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
			codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
			return null;
		}

		member.setLoginType("HOMEPAGE");
		Object result = LoginAPI.login(member);
		if (result instanceof Member) {
			accountLockService.loginSucceeded(new AccountLock(member, request.getRemoteAddr()));
			loginLogService.addLoginLog(new LoginLog(member, request, homepage));

			member = (Member) result;
			member.setLogin(true);
			service.setSessionMember(member, request);
			service.redirectUrl(returnUrl.replaceAll("^http://(www\\.)?gbelib\\.kr", "https://www.gbelib.kr"), request, response);

			return null;
		} else {
			member.setHomepage_id(homepage.getHomepage_id());
			member.setLoginType("HOMEPAGE");
			accountLockService.loginFailed(new AccountLock(member, request.getRemoteAddr()));
			ApiResponse errorResult = (ApiResponse) result;

			if ("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
				codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
				return null;
			} else if ("아이디 또는 비밀번호를 다시 확인하세요".equals(errorResult.getMessage())) {
				AccountLock accountLock = accountLockService.getAccountLock(new AccountLock(member, request.getRemoteAddr()));
				codeService.alertMessage(String.format("로그인 5회 중 %d회 실패\\n아이디 또는 비밀번호를 다시 확인하세요", accountLock.getCount()), request, response);
				return null;
			} else {
				codeService.alertMessage(errorResult.getMessage(), request, response);
				return null;
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
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		service.logout(request);
		return String.format("redirect:/intro/%s/index.do", homepage.getContext_path());
	}

	/**
	 * 모바일 회원증
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param context_path
	 * @param model
	 * @param member
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping (value = {"/mobileCard.*"})
	public String mobileCard(@PathVariable String context_path, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		if (StringUtils.isBlank(member.getUser_no())) {
			service.alertMessage("대출회원만 가능합니다.", request, response);
			return null;
		}

		return "/intro/login/mobileCard";
	}
}
