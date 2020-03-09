package kr.go.gbelib.app.intro.login;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
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
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccessService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubordService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LoginAPI;
import kr.go.gbelib.app.module.loginLog.LoginLog;
import kr.go.gbelib.app.module.loginLog.LoginLogService;

@Controller
@RequestMapping (value = {"/{homepagePath}/intro/login"})
public class CommonLoginController extends BaseController {

	private String basePath = "/homepage/%s/commonIntro/login/";

	@Autowired
	private LoginService service;

	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private HomepageAccessService homepageAccessService;

	@Autowired
	private MemberGroupSubordService memberGroupSubordService;

	@Autowired
	private AccountLockService accountLockService;

	@Autowired
	private LoginLogService loginLogService;

	@RequestMapping (value = {"/index.*"})
	public String login(Model model, Member member, HttpServletRequest request, @PathVariable ("homepagePath") String homepagePath) {
		Homepage homepage = getSessionHomepage(request);

		String beforeUrl = member.getBefore_url();
		if (StringUtils.isEmpty(beforeUrl)) {
			member.setBefore_url(request.getHeader("referer"));
		}
		int idmenuIdx = homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 7);
		int pwmenuIdx = homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 8);
		int joinmenuIdx = homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 4);
		int menuIdxBookConn = homepageService.getMenuIdxByProgramIdx(homepage.getHomepage_id(), 165);

		model.addAttribute("menuIdxId", idmenuIdx);
		model.addAttribute("menuIdxPw", pwmenuIdx);
		model.addAttribute("menuIdxJoin", joinmenuIdx);
		model.addAttribute("menuIdxBookConn", menuIdxBookConn);
		model.addAttribute("homepageName", homepage.getHomepage_name());
		model.addAttribute("member", member);
		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping (value = {"/loginProc.*"})
	public String loginProc(Model model, Member member, HttpServletRequest request, HttpServletResponse response, @PathVariable ("homepagePath") String homepagePath, RedirectAttributes redirectAttributes) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		request.getSession().removeAttribute("loginSupport");

		// 아이디, 비번, 이름 복호화
		if (memberService.decryptMember(member) == false) {
			codeService.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
			return null;
		}

		String returnUrl = member.getBefore_url();
		if (StringUtils.isEmpty(returnUrl) || returnUrl.indexOf("/login/") > -1) {
			returnUrl = String.format("%s/%s/index.do", homepage.getDomain(), homepagePath);
			if (request.getRequestURL().toString().contains("localhost")) {
				returnUrl = String.format("%s/%s/index.do", "http://localhost", homepagePath);
			}
		}

		// 비번 틀려서 계정이 잠김
		if ("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
			codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
			return null;
		}

		member.setManage_code(homepage.getManage_code());
		member.setLoginType("HOMEPAGE");
		Object result = LoginAPI.login(member);
		if (result instanceof Member) {
			accountLockService.loginSucceeded(new AccountLock(member, request.getRemoteAddr()));
			loginLogService.addLoginLog(new LoginLog(member, request, homepage));

			try {

				member = (Member) result;
				member.setLogin(true);

				member.setLast_login_ip(homepageAccessService.getLastHomepageAccess(member));
				memberService.addMemberLastLogin(member, request);

				// 관리자확인
				Member adminMember = memberService.getMemberOne(member);
				if (adminMember != null) {
					member.setAdmin(adminMember.isAdmin());
					member.setAuthorityHomepageList(adminMember.getAuthorityHomepageList());
				}

				if ((member.getAuthMap() == null || member.getAuthMap().isEmpty()) && !member.isAdmin()) {

					if (member.getAuthGroupIdxList() == null || member.getAuthGroupIdxList().size() < 1) {
						member.setAuthGroupIdxList(new ArrayList<Integer>());

						//통합회원그룹에 속하게 한다. 도서관은 하드코딩한다...
						member.getAuthGroupIdxList().add(3);

						MemberGroup memberGroup = new MemberGroup();
						memberGroup.setSite_id(homepage.getHomepage_id());

						//내 소속도서관의 사용자 그룹에만 지정한다.
//						member.getAuthGroupIdxList().add(memberGroupService.getSiteUserGroupOne(memberGroup).getMember_group_idx());

						//그룹-멤버 관계 테이블에 넣는다.
						memberGroupSubordService.addAuthGroupMember(member);
						//권한맵을 새로 불러온다.
						member.setAuthMap(memberService.getMemberAuth(member));

					} else {
						//그룹-회원 관계테이블에 넣는다.
						memberGroupSubordService.addAuthGroupMember(member);
//					//권한정보를 다시 가져온다.
						member.setAuthMap(memberService.getMemberAuth(member));

					}

				}
			} catch (Exception e) {
				System.out.println("@@@@@@@@@@@@@@@@ loginProcFailed : " + e.getMessage());
			}

			service.setSessionMember(member, request);

			Device device = DeviceUtils.getCurrentDevice(request);
			model.addAttribute("isMobile", device.isMobile() || device.isTablet());
			boolean isMobile = device.isMobile() || device.isTablet();
			if (!isMobile) {
				request.getSession().setAttribute("showUserInfo", true);
			}
			request.getSession().removeAttribute("certMember");

			/**
			 * 비밀번호 만료일자가 지난 경우 패스워드 변경유도 페이지로 이동.
			 */
			// try {
			// if (!StringUtils.isEmpty(member.getPassword_update_date()) && !StringUtils.equalsIgnoreCase(member.getPassword_update_date(), "null")) {
			// DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyyMMdd");
			//
			// DateTime updateDate = fmt.parseDateTime(member.getPassword_update_date());
			// DateTime currentDate = DateTime.now();
			//
			// Days daysBetween = Days.daysBetween(updateDate, currentDate);
			//
			// int expiryDay = Integer.parseInt(member.getPassword_expiry_day());
			// if (daysBetween.getDays() > expiryDay) {
			// int menuIdx = homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), "/intro/join/changePwForm.do");
			// returnUrl = String.format("https://%s/%s/intro/join/passwordExpiry.do?menu_idx=%s", homepage.getDomainWithoutProtocol(), homepagePath, menuIdx);
			// }
			// }
			// } catch (Exception e) {
			// e.printStackTrace();
			// }

			return "redirect:" + returnUrl;

		} else {
			member.setHomepage_id(homepage.getHomepage_id());
			member.setLoginType("HOMEPAGE");
			accountLockService.loginFailed(new AccountLock(member, request.getRemoteAddr()));
			ApiResponse errorResult = (ApiResponse) result;

			if ("Y".equals(accountLockService.isLocked(new AccountLock(member, request.getRemoteAddr())))) {
				codeService.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
				return null;
			} else if ("해당 정보와 일치하는 이용자가 없습니다.".equals(errorResult.getMessage())) {
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
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Homepage homepage = getSessionHomepage(request);
		String redirectURL = request.isSecure() ? "https://" : "http://";
		redirectURL +=  request.getServerName() + "/" + homepage.getContext_path();

		String relogin = request.getParameter("relogin");
		if (StringUtils.equals(relogin, "true")) {
			int menu_idx = 0;
			try {
				menu_idx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/login/index.do"));
			} catch (Exception e) {}
			if (menu_idx == 0) {
				service.logout(request);
				return "redirect:" + redirectURL + "/index.do";
			}
			redirectURL += "/intro/login/index.do?menu_idx=" + menu_idx;
			service.logout(request);
			return "redirect:" + redirectURL;
		}
		service.logout(request);
		return "redirect:" + redirectURL + "/index.do";
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
	public String mobileCard(@PathVariable ("homepagePath") String homepagePath, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/" + homepage.getContext_path() + "/intro/login/index.do?menu_idx="+loginMenuIdx, request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		if (StringUtils.isBlank(member.getUser_no())) {
			service.alertMessage("대출회원만 가능합니다.", request, response);
			return null;
		}

		return String.format(basePath, homepage.getFolder()) + "mobileCard";
	}

}
