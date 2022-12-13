package kr.co.whalesoft.framework.interceptor;

import java.io.PrintWriter;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import kr.co.whalesoft.app.cms.boardBlockIp.BoardBlockIpService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;

public class BoardAuthoritiesInterceptor extends HandlerInterceptorAdapter {

	protected final Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BoardManageService boardManageService;
	
	@Autowired
	private BoardBlockIpService boardBlockIpService;
	
	@Autowired
	private LoginService loginService;
	
	private final String boardUriArray[] = {"/board/index", "/board/view", "/board/preview","/board/edit","/board/otherBoardEdit", "/board/reply", "/board/save", "/board/delete", "/boardDelete/", "/board/boardComment"};
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		BoardManage boardManage = null;
		
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		String currentURI = request.getRequestURI().substring(request.getContextPath().length());
		
//		String contextPath = currentURI.substring(1, currentURI.indexOf("/", 1));
		
		if(homepage != null) {
			currentURI = currentURI.replaceAll("/" + homepage.getContext_path(), "");
		}
		
		boolean boardAuth = true;
		boolean boardUriCheck = false;
		
		if(request.getParameter("manage_idx")!=null) {
			for(String boardUri : boardUriArray) {
				if(currentURI.indexOf(boardUri) > -1) {
					boardUriCheck = true;
					break;
				}
			}
			
			if(boardUriCheck) {
				if(request.getParameter("manage_idx")!=null) {
					String homepage_id = null;
					
					if(homepage != null) {
						homepage_id = homepage.getHomepage_id();
					}else{
						homepage_id = request.getParameter("homepage_id");
					}
					log.debug("homepage_id : " + homepage_id);
					
					boardManage = boardManageService.getBoardManageOne(new BoardManage(homepage_id, Integer.parseInt(request.getParameter("manage_idx"))));
					if(boardManage != null) {
						
						//게시판 관리자 권한
//						boardManage.setAdmin_auth_check(loginAndAuthCheck(request, response, boardManage.getAdmin_auth(), boardManage));
//						if(boardManage.isAdmin_auth_check()) {
//							boardManage.setEdit_auth_check(true);
//							boardManage.setDelete_auth_check(true);
//							boardAuth = true;
//						} else {
//							if(currentURI.startsWith("/board/index")) {
//								boardManage.setEdit_auth_check(editAuthCheck(request, response, boardManage.getEdit_auth()));
//							} else if(currentURI.startsWith("/board/view")) {
//								boardAuth = viewAuthCheck(request, response, boardManage.getView_auth());
//								boardManage.setEdit_auth_check(loginAndAuthCheck(request, response, boardManage.getEdit_auth(), boardManage));
//								boardManage.setDelete_auth_check(loginAndAuthCheck(request, response, boardManage.getDelete_auth(), boardManage));
//							} else if(currentURI.startsWith("/board/edit") || currentURI.startsWith("/board/reply") || currentURI.startsWith("/board/save")) {
//								if(boardBlockIpService.getBoardBlockIpUseCount(RequestUtils.getClientIpAddr(request)) > 0) {
//									return alertMessage("해당 IP는 글등록이 차단되었습니다.", request, response);
//								}
//								if (boardManage.getManage_idx() == 563 || boardManage.getManage_idx() == 592) {
//									boardAuth = editAuthCheck(request, response, boardManage.getEdit_auth());
//								} else {
//									boardAuth = loginAndAuthCheck(request, response, boardManage.getEdit_auth(), boardManage);
//									
//								}
//							} else if(currentURI.startsWith("/board/delete")) {
//								boardAuth = loginAndAuthCheck(request, response, boardManage.getDelete_auth(), boardManage);
//							} else if(currentURI.startsWith("/boardDelete/")) {
//								boardAuth = loginAndAuthCheck(request, response, boardManage.getAdmin_auth(), boardManage);
//							}
//						}
						
						if(!boardAuth) {
//							return alertMessage("권한이 없습니다.", request, response);
						}
					} else {
						return alertMessage("잘못된 게시판 정보입니다.", request, response);
					}
				} else {
					return alertMessage("잘못된 게시판 정보입니다.", request, response);
				}
			}
		}

		request.setAttribute("boardManage", boardManage);
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
	
	private boolean loginAndAuthCheck(HttpServletRequest request, HttpServletResponse response, String boardAuthToken, BoardManage boardManage) {
		Member member = loginService.getSessionMember(request);
		
		StringTokenizer authToken = null;
		
		if(member.isLogin()) {
			if (member.isAdmin()) {
				return true;
			}
			
//			if(Integer.parseInt(member.getAuth_id()) <= 200) {
//				if(member.getHomepage_id().equals(boardManage.getHomepage_id())) {
//					return true;
//					
//				//200번데 관리자가 PMS같은 CMS형태의 홈페이지 접속시 권환확인
//				}else if(Integer.parseInt(member.getAuth_id()) >= 200) {
//					if (member.getLoginType().equals("CMS") || member.getLoginType().equals("PMS")) {
//						Homepage homepage = null;
//						if(request.getAttribute("homepage") != null){
//							homepage = (Homepage) request.getAttribute("homepage");
//						}
//						if(homepage != null && homepage.getHomepage_type().equals("0")) {
//							request.setAttribute("member_homepage_id", member.getHomepage_id());
//							return true;
//						}
//						
//					}
//				}
//			}
			
			if (member.getLoginType().equals("HOMEPAGE")) {
				if ( member.getWeb_id().equals(boardManage.getAdmin_id()) ) {
					return true;
				}
			} else if (member.getLoginType().equals("CMS")) {
				if ( member.getMember_id().equals(boardManage.getAdmin_id()) ) {
					return true;
				}
			} else if (member.getLoginType().equals("PRIVATEHOMEPAGE")) {
				if ( member.getMember_id().equals(boardManage.getAdmin_id()) ) {
					return true;
				}
			}
			
			
//			if(boardAuthToken != null) {
//				authToken = new StringTokenizer(boardAuthToken, ",");
//				
//				while(authToken.hasMoreTokens()) {
//					String authId = authToken.nextToken();
//					if (member.getAuth_id().equals(authId)) {
//						return true;
//					}
//					if(member.getAuth_id_list().contains(authId)) {
//						return true;
//					}
//				}
//			}
		}
		// 최고관리자||현재게시판 관리자
		
		
		return false;
	}
	
	private boolean editAuthCheck(HttpServletRequest request, HttpServletResponse response, String boardAuthToken) {
		StringTokenizer authToken = null;
		Member member = loginService.getSessionMember(request);

		if (member == null) {
			return false;
		} else if(member.getAuth_id() == null) {
			return false;
		} else if(Integer.parseInt(member.getAuth_id()) == 200) {
			Homepage homepage = null;
			if(request.getAttribute("homepage") != null){
				homepage = (Homepage) request.getAttribute("homepage");
			}
			if(homepage != null && homepage.getHomepage_type().equals("0")) {
				return true;
			}
		}else if (member.getAuth_id_list() == null) {
			return false;
		}
		
		
		if(boardAuthToken != null) {
			authToken = new StringTokenizer(boardAuthToken, ",");
			
			while(authToken.hasMoreTokens()) {
				String authId = authToken.nextToken();
				if (member.getAuth_id().equals(authId)) {
					return true;
				}
				String [] authIdList = member.getAuth_id_list().split(",");
				for ( String string : authIdList ) {
					if (string.equals(authId)) {
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
	private boolean viewAuthCheck(HttpServletRequest request, HttpServletResponse response, String boardAuthToken) {
		Member member = loginService.getSessionMember(request);
		StringTokenizer authToken = null;
		
		if ( StringUtils.isNotEmpty(member.getAuth_id()) ) {
			if(Integer.parseInt(member.getAuth_id()) == 200) {
				Homepage homepage = null;
				if(request.getAttribute("homepage") != null){
					homepage = (Homepage) request.getAttribute("homepage");
				}
				if(homepage != null && homepage.getHomepage_type().equals("0")) {
					return true;
				}
			}	
		}
		
		if (StringUtils.isEmpty(boardAuthToken) || StringUtils.isEmpty(member.getAuth_id_list())) {
			return true;
		}
		
		if(boardAuthToken != null) {
			authToken = new StringTokenizer(boardAuthToken, ",");
			
			while(authToken.hasMoreTokens()) {
				String authId = authToken.nextToken();
				if("ANONYMOUS".equals(authId)) {
					return true;
				}
				if (member.getAuth_id().equals(authId)) {
					return true;
				}
				if (member.getAuth_id_list().contains(authId)) {
					return true;
				}
			}
		} else {
			return false;
		}
		
		return false;
		
	}
	
//	@SuppressWarnings("unused")
//	private boolean idCheck(String member_id, HttpServletRequest request, HttpServletResponse response) {
//		Member member = loginService.getSessionMember(request);
//		
//		if(member.isLogin() && member_id.equals(member.getDept_cd())) {
//			return true;
//		} else {
//			return false;
//		}
//	}
	
}