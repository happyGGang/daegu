package kr.co.whalesoft.framework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenuService;
import kr.co.whalesoft.app.cms.authCode.AuthCodeService;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngt;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngtService;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private AdminMenuService adminMenuService;

	@Autowired
	private ModuleMngtService moduleMngtService;

	@Autowired
	private AuthCodeService authCodeService;

	@Autowired
	private BoardManageService boardManageService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String uri = null;
		String contextPath = null;
		Homepage homepage = null;

		Menu menuOne = null;
		AdminMenu adminMenuOne = null;
		ModuleMngt moduleMngt = null;
		
		uri = request.getRequestURI().substring(request.getContextPath().length());

		if(homepageUrl(uri)) { // 홈페이지 관련 URL 일때
			if ( uri.startsWith("/index.do") ) {
				contextPath = "root";
			} else {
				try {
					contextPath = uri.substring(1, uri.indexOf("/", 1));
				} catch (Exception e) {
					//contextPath를 올바르게 가져오지 못하는 경우 404 에러 처리.
					return super.preHandle(request, response, handler);
				}
			}

			Homepage reqHomepage = new Homepage();
			reqHomepage.setContext_path(contextPath);
			homepage = homepageService.getHomepageOneInPath(reqHomepage);
			
			if(request.getParameter("menu_idx") != null && !request.getParameter("menu_idx").equals("")) {
				menuOne = menuService.getMenuOne(new Menu(homepage.getHomepage_id(), Integer.parseInt(request.getParameter("menu_idx"))));
			}

			if (menuOne != null) {
				request.getSession().setAttribute("authInfo", homepage.getHomepage_id()+"_"+request.getParameter("menu_idx")+"_"+menuOne.getManage_idx());
				moduleMngt = moduleMngtService.getModuleMngtOne(new ModuleMngt(menuOne.getManage_idx()));
				if (moduleMngt != null && !StringUtils.isNotEmpty(moduleMngt.getAuth_group_id())) {
					if (StringUtils.equals(menuOne.getMenu_type(), "BOARD")) {
						request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode("B0001"));
					} else {
						request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode(moduleMngt.getAuth_group_id()));
					}
				} else {
					if (StringUtils.equals(menuOne.getMenu_type(), "BOARD")) {
						request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode("B0001"));
					}
				}
			}
			
			uri = request.getRequestURI().substring(contextPath.length() + 1);
			if (uri.startsWith("/board/") || uri.startsWith("/boardDelete/")) {
				request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode("B0001"));
			}
		} else {
			if ( uri.startsWith("/index.do") ) {
				contextPath = "root";
			} else {
				try {
					contextPath = uri.substring(1, uri.indexOf("/", 1));
				} catch (Exception e) {
					//contextPath를 올바르게 가져오지 못하는 경우 404 에러 처리.
					return super.preHandle(request, response, handler);
				}
			}

			Homepage reqHomepage = new Homepage();
			reqHomepage.setContext_path(contextPath);
			homepage = homepageService.getHomepageOneInPath(reqHomepage);

			String siteId = "CMS";
			if (homepage != null && !homepage.getHomepage_id().equals("CMS")) {
				siteId = homepage.getHomepage_id();
			}

			String getUri = request.getRequestURI().substring(request.getContextPath().length());
			if(StringUtils.isNotEmpty(request.getQueryString())) {
				getUri += "?" + request.getQueryString();
			}
			
			AdminMenu adminMenu = new AdminMenu();
			adminMenu.setMenu_url(getUri);

			adminMenuOne = adminMenuService.getAdminMenuOneByUrl(adminMenu);
			if(adminMenuOne == null) {
				if(getUri.startsWith("/wbuilder")) {
					adminMenu.setMenu_url(getUri.replaceFirst("^/wbuilder", "/cms"));
					adminMenuOne = adminMenuService.getAdminMenuOneByUrl(adminMenu);
				} else if(getUri.startsWith("/cms")) {
					adminMenu.setMenu_url(getUri.replaceFirst("^/cms", "/wbuilder"));
					adminMenuOne = adminMenuService.getAdminMenuOneByUrl(adminMenu);
				}
				
				if(adminMenuOne == null) {
					adminMenu.setMenu_url(getUri);
				}
			}

			if (adminMenuOne != null) {
				request.getSession().setAttribute("authInfo", "CMS_"+adminMenuOne.getMenu_idx()+"_"+adminMenuOne.getModule_idx());
				moduleMngt = moduleMngtService.getModuleMngtOne(new ModuleMngt(adminMenuOne.getModule_idx()));
				if (moduleMngt != null && !StringUtils.isNotEmpty(moduleMngt.getAuth_group_id())) {
					request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode(moduleMngt.getAuth_group_id()));
				}
			}
			
			if (uri.startsWith("/board/") || uri.startsWith("/boardDelete/")) {
				request.getSession().setAttribute("exAuthList", authCodeService.getAuthCode("B0001"));
			}
		}
		
		return true;
	}


	public boolean homepageUrl(String uri) {
		return (!uri.equals("") && !uri.startsWith("/cms/") && !uri.startsWith("/wbuilder/") && !uri.startsWith("/board/") && !uri.startsWith("/boardDelete/") && !uri.startsWith("/intro/") && !uri.startsWith("/api/") && !uri.startsWith("/sns/"));
	}
}