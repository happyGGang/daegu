package kr.co.whalesoft.framework.interceptor;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import is.tagomor.woothee.Classifier;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccess;
import kr.co.whalesoft.app.cms.homepageAccess.HomepageAccessService;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.menu.menuAccess.MenuAccess;
import kr.co.whalesoft.app.cms.menu.menuAccess.MenuAccessService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;

public class HomepageBaseInterceptor extends HandlerInterceptorAdapter {

	protected final Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private HomepageAccessService homepageAccessService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private MenuAccessService menuAccessService;

	@Autowired
	private ElibCategoryService elibCategoryService;

	@Autowired
	private ElibCodeService elibCodeService;

	@Autowired
	private RecommendSiteService recommendSiteService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String uri = null;
		String contextPath = null;
		Homepage homepage = null;

		List<Menu> menuTreeList = null;
		Menu menuOne = null;
		List<Menu> menuLeftList = null;
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

			log.debug("contextPath : "+contextPath);
			homepage = homepageService.getHomepageOneInPath(contextPath);

			if(homepage != null) {

				//홈페이지 정보
				request.setAttribute("homepage", homepage);
				request.getSession().setAttribute("homepage", homepage);

				//추천사이트
				if (request.getSession().getAttribute("recommendSiteList") == null) {
					List<RecommendSite> recommendSiteListAll = recommendSiteService.getRecommendSiteListCache(homepage.getHomepage_id());
					request.getSession().setAttribute("recommendSiteList", recommendSiteListAll);
				}

				/**
				 * 접속 통계 + 로그 남기기
				 */
				addStatisticsCount(request, homepage);
				/**
				 *
				 */

				//Menu 구하기
				menuTreeList = menuService.getMenuTreeListCache(homepage.getHomepage_id());
				if(request.getParameter("menu_idx") != null && !request.getParameter("menu_idx").equals("")) {
					menuOne = menuService.getMenuOne(new Menu(homepage.getHomepage_id(), Integer.parseInt(request.getParameter("menu_idx"))));
				}

				int modifyFormMenuIdx = menuService.getMenuIdxByLinkUrl(new Menu(homepage.getHomepage_id(), "/intro/join/modifyForm.do"));

				if(menuOne != null) {
					menuLeftList = menuService.getMenuLeftTreeListCache(menuOne.getHomepage_id(), menuOne.getGroup_idx());
				}

				request.setAttribute("modifyFormMenuIdx", modifyFormMenuIdx);
				request.setAttribute("menuTreeList", menuTreeList);
				request.setAttribute("menuOne", menuOne);
				request.setAttribute("menuLeftList", menuLeftList);

				// 전자도서관 좌측 메뉴
				if("elib".equals(contextPath)) {
					HttpSession session = request.getSession();
					String type = StringUtils.trimToEmpty(request.getParameter("type"));
					ElibCategory elibCategory = new ElibCategory(type, 1);
					ElibCode elibCode = new ElibCode(type);
//					Book book = new Book();
//					book.setType(type);
//					HttpSession session = request.getSession();
					String debug = (String) session.getAttribute("_elib_debug");

					if(StringUtils.equals(debug, "true")) {
//						book.setApproved_yn("N");
						elibCategory.setApproved_yn("N");
						elibCode.setApproved_yn("N");
					} else {
//						book.setApproved_yn("Y");
						elibCategory.setApproved_yn("Y");
						elibCode.setApproved_yn("Y");
					}

					List<ElibCategory> categoryList = elibCategoryService.getCategoryWithCntList(elibCategory);
					request.setAttribute("categoryMenuList", categoryList);

					List<ElibCode> compList = elibCodeService.getCompWithCntList(elibCode);
					request.setAttribute("compMenuList", compList);

//					List<Book> deviceList = bookService.getBookCountByDevice(book);
//					request.setAttribute("deviceMenuList", deviceList);
				}
			} else {
//				return false;
				//그냥 false로 리턴을 하면 빈 페이지가 생성됨.
				//homepage 객체가 없는 경우 404페이지를 띄우기 위해 super 처리
				return super.preHandle(request, response, handler);
			}
		}
		else { //홈페이지 관련 URL 아닐때
			if ( uri.startsWith("/intro/") ) {

				// SSL 적용을 위한 로직
				String requestURL = request.getRequestURL().toString();
				if (!uri.contains("join") && !uri.contains("login")) {

					if (requestURL.startsWith("https://")) {
						// Request Parameter 리다이렉트로 전달.
						List<String> parameters = new ArrayList<String>();
						@SuppressWarnings ("unchecked")
						Enumeration<String> result = request.getParameterNames();
						while (result.hasMoreElements()) {
							String attributeName = (String) result.nextElement();
							parameters.add(String.format("%s=%s", attributeName, request.getParameter(attributeName)));
						}

						String redirectUrl = String.format("http://%s:80%s?%s", request.getServerName(), uri, StringUtils.join(parameters, "&"));
						response.sendRedirect(redirectUrl);
						return false;
					}
				} else {
					if(StringUtils.containsIgnoreCase(request.getServerName(), "library.daegu.go.kr") && requestURL.startsWith("http://")) {
						List<String> parameters = new ArrayList<String>();
						@SuppressWarnings ("unchecked")
						Enumeration<String> result = request.getParameterNames();
						while (result.hasMoreElements()) {
							String attributeName = (String) result.nextElement();
							parameters.add(String.format("%s=%s", attributeName, request.getParameter(attributeName)));
						}

						String redirectUrl = String.format("https://%s:443%s?%s", request.getServerName(), uri, StringUtils.join(parameters, "&"));
						response.sendRedirect(redirectUrl);
						return false;
					}
				}

				//Intro 에서 사용하는 Homepage 정보 가져오기
				uri = uri.replace("/intro/", "");
				uri = uri.substring(0, uri.indexOf("/"));
				if (request.getSession().getAttribute("homepage") == null) {
					homepage = homepageService.getHomepageOneInPath(uri);
					if (homepage != null) {
						request.setAttribute("homepage", homepage);
						request.getSession().setAttribute("homepage", homepage);
					}
				} else {
					Homepage sessionHomepage = (Homepage) request.getSession().getAttribute("homepage");
					if (sessionHomepage.getContext_path().equals(uri)) {
						request.setAttribute("homepage", request.getSession().getAttribute("homepage"));
					} else {
						homepage = homepageService.getHomepageOneInPath(uri);
						if (homepage != null) {
							request.setAttribute("homepage", homepage);
							request.getSession().setAttribute("homepage", homepage);
						}
					}
				}
			}
		}

		return super.preHandle(request, response, handler);
	}

	@Async
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		String uri = request.getRequestURI().substring(request.getContextPath().length());
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		if (homepageUrl(uri)) {
			if (homepage != null && request.getParameter("menu_idx") != null) {
				int menu_idx = Integer.parseInt(request.getParameter("menu_idx"));
				Menu menuOne = menuService.getMenuOne(new Menu(homepage.getHomepage_id(), menu_idx));

				if (menuOne != null) {
					MenuAccess menuAccess = new MenuAccess(homepage.getHomepage_id(), menu_idx);
					menuAccessService.updateMenuAccess(menuAccess);
				}
			}
		}
	}

	public boolean homepageUrl(String uri) {
		return (!uri.equals("") && !uri.startsWith("/cms/") && !uri.startsWith("/board/") && !uri.startsWith("/boardDelete/") && !uri.startsWith("/intro/") && !uri.startsWith("/api/") && !uri.startsWith("/sns/"));
	}

	private static final DateTimeFormatter DTF = DateTimeFormat.forPattern("yyyy-MM-dd");

	/**
	 * 접속 통계 + 로그 남기기
	 *
	 * @param request
	 * @param homepage
	 */
	private void addStatisticsCount(HttpServletRequest request, Homepage homepage) {
		/**
		 * category 조건문을 여러개로 나눈 이유는 속도 때문 자주 발생하는 경우를 위쪽에 배치함
		 */
		try {
			String user_agent = request.getHeader("User-Agent");
			HomepageAccess homepageAccess = new HomepageAccess();
			String homepage_id = homepage.getHomepage_id();

			homepageAccess.setStart_date(DTF.print(new DateTime()));
			homepageAccess.setHomepage_id(homepage_id);
			homepageAccess.setAccess_ip(request.getRemoteAddr());
			homepageAccess.setSession_id(request.getSession().getId());
			homepageAccess.setReferer_url(request.getHeader("referer"));
			homepageAccess.setUser_agent(user_agent);

			Map<String, String> r = Classifier.parse(user_agent);
			// String name = StringUtils.defaultString(r.get("name"));
			// String version = StringUtils.defaultString(r.get("version"));
			String category = StringUtils.defaultString(r.get("category"));
			// String os = StringUtils.defaultString(r.get("os"));
			// String os_version = StringUtils.defaultString(r.get("os_version"));

			// 접속 로그
			if ("pc".equals(category)) {
				// PC
				homepageAccessService.addStatisticsCountLog(homepageAccess);
			} else if ("smartphone".equals(category)) {
				// 모바일
				homepageAccessService.addStatisticsCountLogMobile(homepageAccess);
			} else if ("crawler".equals(category)) {
				// 검색 엔진

			} else if ("mobilephone".equals(category) || "appliance".equals(category)) {
				// 모바일
				homepageAccessService.addStatisticsCountLogMobile(homepageAccess);
			} else {
				// 기타
				homepageAccessService.addStatisticsCountLog(homepageAccess);
			}

			// 접속 통계
			HttpSession session = request.getSession();
			String sessionFlag = homepage_id + "_addStatisticsCount";
			if (session.getAttribute(sessionFlag) == null) {
				session.setAttribute(sessionFlag, true);
				if ("pc".equals(category)) {
					// PC
					homepageAccessService.addStatisticsCount(homepageAccess);
				} else if ("smartphone".equals(category)) {
					// 모바일
					homepageAccessService.addStatisticsCountMobile(homepageAccess);
				} else if ("crawler".equals(category)) {
					// 검색 엔진

				} else if ("mobilephone".equals(category) || "appliance".equals(category)) {
					// 모바일
					homepageAccessService.addStatisticsCountMobile(homepageAccess);
				} else {
					// 기타
					homepageAccessService.addStatisticsCount(homepageAccess);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
