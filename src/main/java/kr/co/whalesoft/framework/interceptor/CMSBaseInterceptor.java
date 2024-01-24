package kr.co.whalesoft.framework.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenuService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.framework.utils.JavaScriptUtils;

public class CMSBaseInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private AdminMenuService adminMenuService;

	@Autowired
	private LoginService loginService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String getUri = request.getRequestURI().substring(request.getContextPath().length());
		if (StringUtils.isNotEmpty(request.getQueryString())) {
			getUri += "?" + request.getQueryString();
		}

		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setMenu_url(getUri);

		try {
			if (loginService.getSessionMember(request).isAdmin()) {
				if (getUri.contains("/wbuilder")) {
					request.getSession().setAttribute("asideHomepageId", "CMS");
				}
				if (request.getHeader("referer").contains("/login/")) {
					// wbuilder에서는 선택한 사이트가 없다. CMS로 설정하여 모든 관리가 가능하도록 한다.
					// cms로 이동하게 되면 별도로 asdieHomepageId가 설정된다.
					JavaScriptUtils.redirectUrl("/wbuilder/adminMenu/index.do", request, response);
					return false;
				}
			}

			if (!loginService.getSessionMember(request).isAdmin()) {
				if (getUri.contains("/wbuilder")) {
					JavaScriptUtils.redirectUrl("/cms/index.do", request, response);
					return false;
				}

				String asideHomepageId = String.valueOf(request.getSession().getAttribute("asideHomepageId"));
				if ((getUri.contains("/dms") || getUri.contains("/pms")) && (StringUtils.isEmpty(asideHomepageId) || StringUtils.equalsIgnoreCase(asideHomepageId, "null"))) {
					List<Homepage> homepageList = loginService.getSessionMember(request).getAuthorityHomepageList();

					if (StringUtils.isEmpty(adminMenu.getHomepage_id())) {
						if (homepageList != null && homepageList.size() > 0) {
							adminMenu.setHomepage_id(homepageList.get(0).getHomepage_id());
						}
					}
					// adminMenu.setMember_id(getSessionMemberId(request));
					request.getSession().setAttribute("asideHomepageId", adminMenu.getHomepage_id());
				}
			}

		} catch (Exception e) {}

		int range = adminMenu.getMenu_url().indexOf("?");
		if(range != -1) {
			adminMenu.setMenu_url(adminMenu.getMenu_url().substring(0, range));
		}

		AdminMenu result = adminMenuService.getAdminMenuOneByUrl(adminMenu);
		if (result == null) {
			if (getUri.startsWith("/wbuilder")) {
				adminMenu.setMenu_url(getUri.replaceFirst("^/wbuilder", "/cms"));
				result = adminMenuService.getAdminMenuOneByUrl(adminMenu);
			} else if (getUri.startsWith("/cms")) {
				adminMenu.setMenu_url(getUri.replaceFirst("^/cms", "/wbuilder"));
				result = adminMenuService.getAdminMenuOneByUrl(adminMenu);
			}
		}

		request.getSession().setAttribute("adminMenuInfo", result);
		if (result != null) {
			request.getSession().setAttribute("topMenuName", result.getMenu_name());
			request.getSession().setAttribute("topMenuDesc", result.getMenu_desc());
			request.getSession().setAttribute("topMenuFullPathName", result.getMenu_full_path_name().split(" > "));
		} else {
			if (getUri.startsWith("/wbuilder/adminMenu/index.do")) {
				request.getSession().setAttribute("topMenuName", "CMS관리자 메뉴");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "CMS관리자 메뉴");
			} else if (getUri.startsWith("/wbuilder/accountLock/index.do")) {
				request.getSession().setAttribute("topMenuName", "계정 잠금 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "사용자 관리 > 계정 잠금 관리");
			} else if (getUri.startsWith("/wbuilder/loginLog/index.do")) {
				request.getSession().setAttribute("topMenuName", "로그인 로그 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "WBuilder 관리 > 사용자 관리 > 로그인 로그 관리");
			} else if (getUri.startsWith("/wbuilder/memberGroupAuth/index.do")) {
				request.getSession().setAttribute("topMenuName", "그룹권한 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "권한 관리 > 그룹권한 관리");
			} else if (getUri.startsWith("/wbuilder/accessIp/index.do")) {
				request.getSession().setAttribute("topMenuName", "접근가능 IP 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "CMS 관리 > 접근가능 IP 관리");
			} else if (getUri.startsWith("/wbuilder/limitedIp/index.do")) {
				request.getSession().setAttribute("topMenuName", "홈페이지 접근불가능 IP 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "CMS 관리 > 홈페이지 접근불가능 IP 관리");
			} else if (getUri.startsWith("/wbuilder/code/cms/index.do")) {
				request.getSession().setAttribute("topMenuName", "공통코드 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "CMS 관리 > 공통코드 관리");
			} else if (getUri.startsWith("/wbuilder/moduleMngt/index.do")) {
				request.getSession().setAttribute("topMenuName", "모듈 관리");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "CMS 관리 > 모듈 관리");
			} else {
				request.getSession().setAttribute("topMenuName", "");
				request.getSession().setAttribute("topMenuDesc", "");
				request.getSession().setAttribute("topMenuFullPathName", "");
			}
		}
		return true;
	}

}
