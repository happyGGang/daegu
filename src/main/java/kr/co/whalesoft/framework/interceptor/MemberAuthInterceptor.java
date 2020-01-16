package kr.co.whalesoft.framework.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.whalesoft.app.cms.accessIp.AccessIpController;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JavaScriptUtils;
import kr.co.whalesoft.framework.utils.MessageResolver;


public class MemberAuthInterceptor extends HandlerInterceptorAdapter {

	protected final Logger log = LoggerFactory.getLogger(getClass());

	//Message 처리를 위한 기본 Class
	@Autowired
	protected MessageResolver msg;

	//관리자페이지 체크 접속 제한 예외 페이지
	private String freePathUris[] = { "/cms/login/", "/pms/login/", "/dms/login/"  };

	@Autowired
	private LoginService loginService;

	@Autowired
	private AccessIpController accessIpController;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MemberGroupAuthService memberGroupAuthService;


	@Autowired
	private MemberService memberService;

	/**
	 * 회원기본 권한 체크 인터셉터 함수
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


		//접속 URI 가져오기
		String getUri = request.getRequestURI().substring(request.getContextPath().length());

		//로그인하지 않은 회원경우 처리
		Member member = loginService.getSessionMember(request);
		if(member==null) member = anonymousMemberCreate(member,request);

		//Session의 사용자 이던 anonymous사용자이던 화면단에서 사용하기위해 추가
		request.setAttribute("member", member);

		//홈페이지 전체 리스트를 가지고 다녀야함
		if(request.getSession().getAttribute("homepageList") == null){
			request.getSession().setAttribute("homepageList", homepageService.getNormalHomepage());
		}

		//관리자는 신규정보를 위해 계속해서 DB에서 정보를 가져옴
		if(member.isAdmin()){
			request.getSession().setAttribute("homepageList", homepageService.getHomepage());
		}


		//관리자페이지 접속에 대한 처리
		if ((getUri.startsWith("/cms/") || getUri.startsWith("/pms/") || getUri.startsWith("/dms/") || getUri.startsWith("/wbuilder/"))){

			//관리자 페이지에 접속가능한 IP인지 확인
			if (!accessIpController.isUserCMSAccessIp(request)) {
				return alertMessage("접속 불가한 IP입니다.", request, response);
			}

			//권한 확인
			if(!cmsAuth(getUri, member, request, response)) {
				return alertMessage("권한이 없습니다.", request, response);
			}
		}



		return true;
	}

	/**
	 * 로그인안한 사용자를 익명사용자료 등록
	 * @param member
	 * @param request
	 */
	private Member anonymousMemberCreate(Member member, HttpServletRequest request){
		// 최초 접속시 login 되어 있지 않다면 임시 권한 부여
		member = new Member();
//		List<String> authList = new ArrayList<String>();
		//익명권한 부여
		member.setAnonymous(true);
		member.setAuthMap(memberService.getAnonymousAuth(member));
		//authList.add(AuthUtils.anonymous);
		//member.setMember_auth(authList);
		/** 임시 아이디 부여 **/
		loginService.setSessionMember(member, request);
		return member;
	}

	/**
	 * 관리자 페이지 접속 처리
	 * @param getUri
	 * @param member
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private boolean cmsAuth(String getUri, Member member, HttpServletRequest request, HttpServletResponse response) throws Exception{
		//CMS 인지 PMS 인지 확인
		String siteType = "/cms";
		if(getUri.startsWith("/pms/")){
			siteType = "/pms";
		}else if(getUri.startsWith("/dms/")){
			siteType = "/dms";
		}else if(getUri.startsWith("/wbuilder/")){
			siteType = "/cms";
		}

		//관리자 접속 제한 예외 URL인지 확인
		boolean freePath = false;
		for (String freePathUri:freePathUris){
			if (getUri.startsWith(freePathUri)) {
				freePath = true;
				break;
			}
		}


		//관리자 페이지 중 모두허용페이지가 아니라면
		if (!freePath) {

			//로그인을 하지 않았거나 loginType이 CMS 즉 관리자 계정이 아니라면 로그인 페이지 로 이동
			if (member != null && !member.isLogin() ) {
				JavaScriptUtils.parentRedirect(siteType+"/login/index.do", request, response);
				return false;
			} else {

				//권한정보 가져오기
//				int memberAuthId = Integer.parseInt(member.getAuth_id());
//				String memberAuthList = member.getAuth_id_list();

				//관리자 메뉴에 대한 접근권한 확인 로직
				if (!member.isAdmin()) {
					if (!memberGroupAuthService.hasAdminAuth(member)) {
						if (!memberGroupAuthService.hasPmsAuth(member)) {
							loginService.logout(request);
							throw new AuthException();
						} else {
							//PMS 권한만 가졌다면 cms로는 못가게 한다.
							if (!StringUtils.equals(siteType, "/pms")) {
								return JavaScriptUtils.redirectUrl("/pms/index.do", request, response);
							}
						}
//						return JavaScriptUtils.alertMessageAndHistoryBack(msg.getMessage(this,"cmsAuth.authError"), request, response);
					}
				}
//				if ( memberAuthId > 200 ) {
//					String[] authList = adminMenuService.getAdminMenuAuthByUrl(new AdminMenu(getUri));
//					if ( authList != null && authList.length > 0 ) {
//						for ( String oneAuthId : authList ) {
//							if ( memberAuthList.indexOf(oneAuthId) != -1) {
//								// 권한이 있어서 통과
//								break;
//							}
//							else {
//								return JavaScriptUtils.alertMessageAndHistoryBack(msg.getMessage(this,"cmsAuth.authError"), request, response);
//							}
//						}
//					}
//				}

//				if (StringUtils.equals(member.getAuth_id(), "10000")) {
//					if (!StringUtils.equals(siteType, "/pms")) {
//						return false;
//					} else if (StringUtils.equals(siteType, "/pms")) {
//						return true;
//					}
//				}
			}

		}

		return true;
	}

	private boolean alertMessage(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();

		return false;
	}
}