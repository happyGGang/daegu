package kr.co.whalesoft.framework.base;


import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.common.api.MemberAPI;
import net.sf.classifier4J.util.WFMultiPartPost;

public abstract class BaseService {

	protected final Logger log = LoggerFactory.getLogger(getClass());

	/**
	 * 페이징 set
	 * @param model
	 * @param totalDataCount
	 * @param pagingUtils
	 */
	public void setPaging(Model model, int totalDataCount, PagingUtils pagingUtils) {
		pagingUtils.setTotalDataCount(totalDataCount);
		model.addAttribute("paging", pagingUtils);
	}

	public void setPaging1(Model model, int totalDataCount, PagingUtils pagingUtils) {
		pagingUtils.setTotalDataCount(totalDataCount);
		model.addAttribute("paging1", pagingUtils);
	}

	public void setPagingGallery(Model model, int totalDataCount, PagingUtils pagingUtils) {
		if ((pagingUtils.getRowCount() % 4) != 0) {
			pagingUtils.setRowCount(8);
		}
		pagingUtils.setTotalDataCount(totalDataCount);
		model.addAttribute("paging", pagingUtils);
	}
	
	public void setPagingArchiveThumbnail(Model model, int totalDataCount, PagingUtils pagingUtils) {
		if ((pagingUtils.getRowCount() % 3) != 0) {
			pagingUtils.setRowCount(6);
		}
		pagingUtils.setTotalDataCount(totalDataCount);
		model.addAttribute("paging", pagingUtils);
	}

	public PagingUtils copyObjectPaging(PagingUtils originalPaging, PagingUtils copyTargetPaging) {
		copyTargetPaging.setPagingUtils(originalPaging);
		return copyTargetPaging;
	}

	/**
	 *
	 * @param mode WEBID, USERID
	 * @param id webid, user_id
	 * @return
	 */
	public boolean isSmsReceive(String mode, String id) {
		Member member = new Member();
		Map<String, String> map = null;
		if ("WEBID".equals(mode)) {
//			member.setCheck_certify_type("WEBID");
//			member.setCheck_certify_data(id);
//			map = MemberAPI.getMemberCertify("WEB", member);
			member.setUser_id(map.get("USER_ID"));
		} else {
			member.setUser_id(id);
		}
		map = MemberAPI.getMember("WEB", member);

		if(map != null) {
			return StringUtils.equals(map.get("SMS_CHECK"), "Y");
		} else {
			return false;
		}
	}

	/**
	 * 웹필터 체크
	 * @param memberName //작성자명
	 * @param title //제목
	 * @param content //내용
	 * @param filePathName 파일목록(/data/1, /data/2, /data/3) NULLABLE
	 * @return
	 * @throws Exception
	 */
	public String webFilterCheck(String memberName, String title, String content, List<String> filePathName, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		/*
		 * WFMultiPartPost(웹서버도메인, 웹필터서버아이피, 웹필터서버포트)
		 */
		WFMultiPartPost wfsend = new WFMultiPartPost(homepage.getDomainWithoutProtocol(), "117.111.136.240", 80);

		/*
		 * WFMultiPartPost.sendWebFilter(작성자, 제목, 내용, 첨부파일경로)   - 첨부파일이 여러개 존재 시 , 로 구분하여 전송
		 * 웹필터서버 응답  : 	Y = 차단		 N = 등록			B = 바이패스
		 */

		String fileList = "";
		if (filePathName != null) {
			fileList = StringUtils.join(filePathName, ",");
		}

		String wfResponse = wfsend.sendWebFilter(memberName, title, content, fileList);
//		String wfResponse = wfsend.sendWebFilter("홍길동", "제목테스트 101111-1111111", "내용테스트 101111-1111111", "D:/101010.PNG");
		if(wfResponse.equals("Y")){
			// 차단내용 팝업창 URL 출력
//			res.setValid(true);
//			res.setUrl(wfsend.getDenyURL());
//			res.setTargetOpener(true);
			return wfsend.getDenyURL();
		} else if(wfResponse.equals("N")){

			return null;
		} else if(wfResponse.equals("B")){

			return null;
		}
		return null;
	}
	
	public boolean alertMessageOnly(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.print(message);
		writer.flush();

		return false;
	}

	public boolean alertMessage(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();

		return false;
	}
	
	public boolean alertMessageKiosk(String homepageName, String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<link rel='stylesheet' type='text/css' href='/resources/common/css/jquery.alert.css'/>");
		writer.println("<script type='text/javascript' src='/resources/common/js/jquery-1.12.4.min.js'></script>");
		writer.println("<script type='text/javascript' src='/resources/common/js/jquery.alert.js'></script>");
		writer.println("<body>");
		writer.println("<script>");
		if (StringUtils.isNotBlank(message)) {
			writer.println("$.alert('" + message + "',{title:'"+ homepageName +"',confirmButton:'확인',callEvent:function(){history.back();}});");
		}
		writer.println("</script>");
		writer.println("</body>");
		writer.flush();

		return false;
	}

	public boolean alertMessagePopup(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("window.close();");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	public boolean alertMessageDialog(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	public boolean alertMessageAjax(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	public boolean alertMessageAndUrl(String message, String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		if (StringUtils.isNotBlank(message)) {
			writer.println("alert('" + message + "');");
		}
		writer.println("location.href = '"+url+"'");
		writer.println("</script>");
		writer.flush();

		return false;
	}
	
	public boolean alertMessageAndUrlKiosk(String homepageName, String message, String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<link rel='stylesheet' type='text/css' href='/resources/common/css/jquery.alert.css'/>");
		writer.println("<script type='text/javascript' src='/resources/common/js/jquery-1.12.4.min.js'></script>");
		writer.println("<script type='text/javascript' src='/resources/common/js/jquery.alert.js'></script>");
		writer.println("<body>");
		writer.println("<script>");
		if (StringUtils.isNotBlank(message)) {
			writer.println("$.alert('" + message + "',{title:'"+ homepageName +"',confirmButton:'확인',callEvent:function(){location.href = '" + url + "';}});");
		}
		writer.println("</script>");
		writer.println("</body>");
		writer.flush();

		return false;
	}

	public boolean alertMessageAndReload(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("location.reload();");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	public boolean redirectUrl(String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("location.href = '"+url+"'");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	public boolean historyBack(int depth, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("history.go("+depth+");");
		writer.println("</script>");
		writer.flush();

		return false;
	}
	
	public boolean alertMessageAndHistoryBack(String message, int depth, HttpServletRequest request, HttpServletResponse response) throws Exception {
		setResponseHeader(response);
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("history.go("+depth+");");
		writer.println("</script>");
		writer.flush();

		return false;
	}

	private void setResponseHeader(HttpServletResponse response) {
		response.setHeader("X-Frame-Options", "DENY");
		response.setHeader("X-Content-Type-Options", "nosniff");
		response.setHeader("X-XSS-Protection", "1");
	}
}