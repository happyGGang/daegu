package kr.co.whalesoft.framework.utils;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JavaScriptUtils {
	
	/**
	 * 메시지 출력 후 뒤로간다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return history.back();
	 * @throws Exception
	 */
	public static boolean alertMessage(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 메시지 출력 후 URL로 이동한다.
	 * @param message 출력메시지
	 * @param location 이동할 URL
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessage(String message, String location, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("location.href = '" + location + "'");
		writer.println("</script>");
		writer.flush();

		return false;
	}
	
	/**
	 * 메시지 출력 후 뒤로간다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessageAndHistoryBack(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');");
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();

		return false;
	}
	
	/**
	 * 부모창을 URL로 이동시킨다.
	 * @param location 이동할 URL
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public static void parentRedirect(String location, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("parent.window.location.href = '" + location + "'");
		writer.println("</script>");
		writer.flush();
	}
	
	/**
	 * 메시지 출력 후 창을 닫는다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessagePopup(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("window.close();");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 메시지를 출력한다. 출력 후 아무런 행동을 하지 않는다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessageDialog(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 메시지를 출력한다. 출력 후 아무런 행동을 하지 않는다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessageAjax(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 메시지 출력 후 url로 이동한다.
	 * @param message 출력 메시지
	 * @param url 이동할 URL
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessageAndUrl(String message, String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("location.href = '"+url+"'");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 메시지 출력 후 현재 페이지를 새로고침한다.
	 * @param message 출력할 메시지
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean alertMessageAndReload(String message, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("alert('" + message + "');"); 
		writer.println("location.reload();");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 현재 페이지를 이동시킨다.
	 * @param url
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean redirectUrl(String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("location.href = '"+url+"'");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
	/**
	 * 뒤로간다.
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static boolean historyBack(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=" + request.getCharacterEncoding());
		PrintWriter writer = response.getWriter();
		writer.println("<script>");
		writer.println("history.back();");
		writer.println("</script>");
		writer.flush();
		
		return false;
	}
	
}
