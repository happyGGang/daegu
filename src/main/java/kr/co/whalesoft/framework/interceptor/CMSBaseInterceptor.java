package kr.co.whalesoft.framework.interceptor;

import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenuService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.utils.JavaScriptUtils;
import kr.co.whalesoft.framework.utils.StaticVariables;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class CMSBaseInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private AdminMenuService adminMenuService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private LoginService loginService;

	@Autowired
	private MemberGroupAuthService memberGroupAuthService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String getUri = request.getRequestURI().substring(request.getContextPath().length());
		if (StringUtils.isNotEmpty(request.getQueryString())) {
			getUri += "?" + request.getQueryString();
		}

		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setMenu_url(getUri);

		Member sessionMember = loginService.getSessionMember(request);
		List<Homepage> homepageList = sessionMember.getAuthorityHomepageList();

		try {
			adminMenu.setHomepage_id((String) request.getSession().getAttribute("asideHomepageId"));
			adminMenu.setMember_id(sessionMember.getMember_id());

			if (homepageList != null && homepageList.size() > 0) {
				if (StringUtils.isEmpty(homepageList.get(0).getHomepage_id())) {
					sessionMember.setAuthorityHomepageList(homepageService.getMySiteList(sessionMember));
					homepageList = sessionMember.getAuthorityHomepageList();
					HttpSession session = request.getSession();
					session.setAttribute(StaticVariables.MEMBER, sessionMember);
				}
			}

			if (StringUtils.isEmpty(adminMenu.getHomepage_id())) {
				if (homepageList != null && homepageList.size() > 0) {
					adminMenu.setHomepage_id(homepageList.get(0).getHomepage_id());
				}
			}

			if (sessionMember.isAdmin()) {
				if (getUri.contains("/sjs")) {
					request.getSession().setAttribute("asideHomepageId", "CMS");
				}
				if (request.getHeader("referer").contains("/login/")) {
					// sjs에서는 선택한 사이트가 없다. CMS로 설정하여 모든 관리가 가능하도록 한다.
					// cms로 이동하게 되면 별도로 asdieHomepageId가 설정된다.
					JavaScriptUtils.redirectUrl("/sjs/adminMenu/index.do", request, response);
					return false;
				}

				request.getSession().setAttribute("asideHomepageId", adminMenu.getHomepage_id());
			}

			if (!sessionMember.isAdmin()) {
				if (getUri.contains("/sjs")) {
					JavaScriptUtils.redirectUrl("/cms/index.do", request, response);
					return false;
				}

				String asideHomepageId = String.valueOf(request.getSession().getAttribute("asideHomepageId"));
				if ((getUri.contains("/dms") || getUri.contains("/pms")) && (StringUtils.isEmpty(asideHomepageId) || StringUtils.equalsIgnoreCase(asideHomepageId, "null"))) {
					homepageList = sessionMember.getAuthorityHomepageList();

					if (StringUtils.isEmpty(adminMenu.getHomepage_id())) {
						if (homepageList != null && homepageList.size() > 0) {
							adminMenu.setHomepage_id(homepageList.get(0).getHomepage_id());
						}
					}
				}
			}

			if (sessionMember.isAdmin()) {
				adminMenu.setAdmin_access_yn("Y");
				request.getSession().setAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
			} else {
				String homepageId = adminMenu.getHomepage_id();
				if (sessionMember.getAuthMap().containsKey(homepageId + "_A")) {
					adminMenu.setAdmin_access_yn("Y");
					request.getSession().setAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
				} else {
					adminMenu.setAuthgroupIdxList(memberGroupAuthService.getAuthGroupIdxList(adminMenu));

					if (adminMenu.getAuthgroupIdxList() != null && !adminMenu.getAuthgroupIdxList().isEmpty()) {
						request.getSession().setAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
					}
				}
			}

			request.getSession().setAttribute("adminMenu", adminMenu);
			request.setAttribute("adminMenu", adminMenu);

		} catch (Exception e) {

		}

		return true;
	}


	public String aside(Model model, AdminMenu adminMenu, HttpServletRequest request) {

		model.addAttribute("adminMenu", adminMenu);

		return "";
	}
}