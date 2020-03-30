package kr.co.whalesoft.framework.base;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.co.whalesoft.app.cms.authCode.AuthCode;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.MessageResolver;
import kr.go.gbelib.app.cms.module.portalMember.PortalMember;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

public abstract class BaseController {

	protected final Logger log = LoggerFactory.getLogger(getClass());

	//Message 처리를 위한 기본 Class
	@Autowired
	protected MessageResolver msg;


	/**
	 * context path를 정보를 반환
	 * @param request
	 * @return
	 */
	@ModelAttribute("getContextPath")
	public String getContextPath(HttpServletRequest request) {
		return request.getContextPath();
	}

	@ModelAttribute("isMobile")
	public boolean isMobile(HttpServletRequest request) {
		Device device = DeviceUtils.getCurrentDevice(request);
		return device.isMobile() || device.isTablet();
	}

	@Autowired
	private LoginService loginServiceBase;

	@Autowired
	private HomepageService homepageService;

	public String getSessionMemberId(HttpServletRequest request) {
		return loginServiceBase.getSessionMember(request).getMember_id();
	}

//	public String getSessionHomepageId(HttpServletRequest request) {
//		return loginServiceBase.getSessionMember(request).getHomepage_id();
//	}

	public Homepage getSessionHomepageInfo(HttpServletRequest request) {
		return homepageService.getHomepageOne(new Homepage(getAsideHomepageId(request)));
	}

	public boolean getSessionIsAdmin(HttpServletRequest request) {
		Member member = (Member) loginServiceBase.getSessionMember(request);
		if (member == null) {
			return false;
		}
		return member.isAdmin();
	}

	public String getSessionMemberLoginType(HttpServletRequest request) {
		Member member = (Member) loginServiceBase.getSessionMember(request);
		return member.getLoginType();
	}

	public Member getSessionMemberInfo(HttpServletRequest request) {
		Member member = (Member) loginServiceBase.getSessionMember(request);
		return member;
	}

	public boolean isLogin(HttpServletRequest request) {
		Member member = (Member) loginServiceBase.getSessionMember(request);
		if (member == null) {
			return false;
		}
		return member.isLogin();
	}

	public Homepage getSessionHomepage(HttpServletRequest request) {
		return (Homepage) request.getSession().getAttribute("homepage");
	}

	public int getMenuIdxByLinkUrl(Homepage homepage, String homepage_id, String link_url) {
		return homepageService.getMenuIdxByLinkUrl(homepage.getHomepage_id(), link_url);
	}

	public Homepage getHomepageOne(String homepage_id) {
		Homepage homepage = new Homepage(homepage_id);
		return homepageService.getHomepageOne(homepage);
	}

	/**
	 * 현재 관리중인 홈페이지 ID를 가져온다.
	 * @param request
	 * @return
	 */
	public String getAsideHomepageId(HttpServletRequest request) {
		String asideHomepageId = String.valueOf(request.getSession().getAttribute("asideHomepageId"));
		if (StringUtils.isEmpty(asideHomepageId) || StringUtils.equalsIgnoreCase(asideHomepageId, "null")) {
			return null;
		}
		return String.valueOf(request.getSession().getAttribute("asideHomepageId"));
	}

	/**
	 * 권한체크. 기본메시지 : '권한이 없습니다.'
	 * @param authCode  R : 조회권한, C : 쓰기권한, U : 수정권한, D : 삭제권한
	 * @param model
	 * @param request
	 * @throws AuthException
	 */
	public void checkAuth(String authCode, Model model, HttpServletRequest request) throws AuthException{
		checkAuth(authCode, model, request, null);
	}

	/**
	 *
	 * @param authCode  R : 조회권한, C : 쓰기권한, U : 수정권한, D : 삭제권한
	 * @param model
	 * @param request
	 * @param msg
	 * @throws AuthException
	 */
	@SuppressWarnings ("unchecked")
	public void checkAuth(String authCode, Model model, HttpServletRequest request, String msg) throws AuthException{
		String authInfo = String.valueOf(request.getSession().getAttribute("authInfo"));//h1_1_6 홈페이지ID_메뉴IDX_모듈IDX
		List<AuthCode> exAuthList = null;
		if (StringUtils.isEmpty(msg)) {
			msg = "권한이 없습니다.";
		}
		try {
			exAuthList = (List<AuthCode>) request.getSession().getAttribute("exAuthList");
		} catch ( Exception e ) {
		}

		if (getSessionIsAdmin(request)) {
			//최고관리자는 통과
			model.addAttribute("authC", true);
			model.addAttribute("authR", true);
			model.addAttribute("authU", true);
			model.addAttribute("authD", true);

			//추가 권한 체크
			if (exAuthList != null && exAuthList.size() > 0) {
				for ( AuthCode ac : exAuthList ) {
					model.addAttribute("auth"+ac.getAuth_code_id(), true);
				}
			}
		} else if (getSessionMemberInfo(request) != null && getSessionMemberInfo(request).getAuthMap() != null && !getSessionMemberInfo(request).getAuthMap().isEmpty()) {
//			System.out.println("@@@@@@@@@@@@@@@@ authMap : " + getSessionMemberInfo(request).getAuthMap());
			boolean isSiteAdmin = false;
			//사이트최고관리자 여부 확인
			if (getSessionHomepageInfo(request) != null && getSessionHomepageInfo(request).getHomepage_id() != null) {
				if (getSessionHomepageInfo(request).getHomepage_id().equals(authInfo.split("_")[0])) {
					isSiteAdmin = getSessionMemberInfo(request).getAuthMap().containsKey(getSessionHomepageInfo(request).getHomepage_id() + "_A");
				}
//				isSiteAdmin = getSessionMemberInfo(request).getAuthMap().containsKey(getSessionHomepage Info(request).getHomepage_id() + "_A");
			}

			//권한확인
			if (!isSiteAdmin) {
				if (!getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_" + authCode)) {
					if ("CMS".equals(authInfo.split("_")[0]) && getSessionMemberInfo(request).getAuthMap().containsKey(getSessionHomepageInfo(request).getHomepage_id() + "_A")) {
						isSiteAdmin = true;
					} else {
						throw new AuthException(msg);
					}
				}
			}

			// view에서 버튼활성화를 위해 전달되는값
			model.addAttribute("authC", isSiteAdmin || getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_C"));
			model.addAttribute("authR", isSiteAdmin || getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_R"));
			model.addAttribute("authU", isSiteAdmin || getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_U"));
			model.addAttribute("authD", isSiteAdmin || getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_D"));

			//추가 권한 체크
			if (exAuthList != null && exAuthList.size() > 0) {
				for ( AuthCode ac : exAuthList ) {
					model.addAttribute("auth"+ac.getAuth_code_id(), isSiteAdmin || getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_"+ac.getAuth_code_id()));
				}
			}

			// CMS - 게시판 관리: 게시판 관리 팝업창, 게시글 검색에서 게시판 관리자가 비밀글을 읽을 수 있도록 권한 부여
			String uri = request.getRequestURI();
			if ( uri.startsWith("/index.do") ) {
			} else if( uri.startsWith("/board") ) {
			} else {
				try {
					String contextPath = uri.substring(1, uri.indexOf("/", 1));
					uri = request.getRequestURI().substring(contextPath.length() + 1);
				} catch (Exception e) {
				}
			}
			String manage_idx = request.getParameter("manage_idx");
			String menu_idx = request.getParameter("menu_idx");
			if((uri.startsWith("/board/") || uri.startsWith("/boardDelete/"))
					&& !uri.startsWith("/board/boardComment/")
					&& StringUtils.isNotEmpty(manage_idx)
					&& (StringUtils.equals(menu_idx, "0") || StringUtils.isEmpty(menu_idx))
					&& (exAuthList != null && exAuthList.size() > 0)) {
				Map<String, Object> authMap = getSessionMemberInfo(request).getAuthMap();
				Set<Map.Entry<String, Object>> entrySet = authMap.entrySet();
				OUTER: for(Map.Entry<String, Object> entry: entrySet) {
					for ( AuthCode ac : exAuthList ) {
						String auth_code_id = ac.getAuth_code_id();
						if(entry.getKey().endsWith(manage_idx + "_" + auth_code_id) && (Boolean) entry.getValue()) {
							model.addAttribute("auth" + auth_code_id, true);
							break OUTER;
						}
					}
				}
			}
		} else if ("R".equals(authCode) && getSessionMemberInfo(request).isAnonymous()) {

		} else {
			throw new AuthException(msg);
		}
	}
	
	public SupportMember sessionLoginSupport(HttpServletRequest request) {
		SupportMember supportMember = (SupportMember)request.getSession().getAttribute("loginSupport");
		return supportMember;
	}
	
	public PortalMember sessionLoginPortal(HttpServletRequest request) {
		PortalMember portalMember = (PortalMember)request.getSession().getAttribute("loginPortal");
		return portalMember;
	}
	
//	/**
//	 *
//	 * @param authCode
//	 * @param request
//	 * @return
//	 */
//	public void checkAuth(Model model, HttpServletRequest request) {
//		String authInfo = String.valueOf(request.getSession().getAttribute("authInfo"));
//		if (getSessionMemberInfo(request) != null && getSessionMemberInfo(request).getAuthMap() != null && !getSessionMemberInfo(request).getAuthMap().isEmpty()) {
//			model.addAttribute("authC", getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_C") || getSessionIsAdmin(request));
//			model.addAttribute("authR", getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_R") || getSessionIsAdmin(request));
//			model.addAttribute("authU", getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_U") || getSessionIsAdmin(request));
//			model.addAttribute("authD", getSessionMemberInfo(request).getAuthMap().containsKey(authInfo + "_D") || getSessionIsAdmin(request));
//		}
//	}

	/**
	 * 로그인 여부( 비로그인 상태인 ANONYMOUS 권한이 아닐 시 로그인으로 처리 )
	 * @return
	 */
	/*@ModelAttribute("isLogin")
	public Boolean isLogin() {
		return !AuthUtils.hasAuthority("ANONYMOUS");
	}

	*//**
	 * 관리자 여부
	 * @return
	 *//*
	@ModelAttribute("isAdmin")
	public Boolean isAdmin() {
		return AuthUtils.hasAuthority("ADMIN");
	}

	*//**
	 * 현재 로그인한 사용자의 권한 목록을 가져온다.
	 * @return
	 *//*
	@ModelAttribute("getAuthorities")
	public String[] getAuthorities() {
		return AuthUtils.getAuthorities();
	}*/

	/*@ExceptionHandler(AccessDeniedException.class)
	public ModelAndView accessDeniedExceptionHandler(AccessDeniedException ex, HttpServletRequest request) {
		if (RequestUtils.isAjaxRequest(request)) {
			logger.error("##ERROR", ex);
			throw ex;
		}
		return new ModelAndView("exceptionView/error").addObject("exception", ex.getMessage());
	}

	@ExceptionHandler(RuntimeException.class)
	public ModelAndView runtimeExceptionHandler(RuntimeException ex, HttpServletRequest request) {
		if (RequestUtils.isAjaxRequest(request)) {
			logger.error("##ERROR", ex);
			throw ex;
		}
		return new ModelAndView("exceptionView/error").addObject("exception", ex.getMessage());
	}

	@ExceptionHandler(SQLException.class)
	public ModelAndView sqlExceptionHandler(SQLException ex, HttpServletRequest request) throws SQLException {
		if (RequestUtils.isAjaxRequest(request)) {
			logger.error("##ERROR", ex);
			throw ex;
		}
		return new ModelAndView("exceptionView/error").addObject("exception", ex.getMessage().replaceAll("\n", "."));
	}

	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionHandler(Exception ex, HttpServletRequest request) throws Exception {
		Throwable throwable = ex;
		while ( (throwable = throwable.getCause()) != null ) {
			if ( SQLException.class.isAssignableFrom(throwable.getClass()) ) {
				return this.sqlExceptionHandler((SQLException)throwable, request);
			}
		}
		if (RequestUtils.isAjaxRequest(request)) {
			logger.error("##ERROR", ex);
			throw ex;
		}
		return new ModelAndView("exceptionView/error").addObject("exception", ex.getMessage());
	}*/
}