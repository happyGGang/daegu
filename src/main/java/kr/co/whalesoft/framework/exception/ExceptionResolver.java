package kr.co.whalesoft.framework.exception;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

public class ExceptionResolver implements HandlerExceptionResolver {
	protected final Logger log = LoggerFactory.getLogger(getClass());

//	private static final String ENABLE_AJAX_VALIDATION_PARAM = "spring.enableAjaxValidation";
	private static final String ENABLE_AJAX_HEADER = "x-requested-with";
	private static final String ENABLE_AJAX_VALUE = "XMLHttpRequest";

	private String view = null;

	public void setView(String view) {
		this.view = view;
	}

	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) {
		
		// 기본 requset에 메세지 저장
		request.setAttribute("errorMessage", exception.getMessage());
		boolean isAjaxRequest = StringUtils.equals(request.getHeader(ENABLE_AJAX_HEADER), ENABLE_AJAX_VALUE);
		String exceptionAllMessage = exception.toString() + "\n";
		exceptionAllMessage += exception.getMessage() + "\n";	
		// 권한 예외처리라면
		StackTraceElement[] elem = exception.getStackTrace();
		for(int i=0;i< elem.length; i++) {
			exceptionAllMessage = exceptionAllMessage + elem[i].toString() + "\n";
		}
		if(exception.toString().indexOf("AuthException") > -1) {
			// exception 상세내역 로그 기록
			
			if (isAjaxRequest) {
				response.setContentType("text/html; charset=" + request.getCharacterEncoding());
				PrintWriter writer;
				try {
					writer = response.getWriter();
					writer.println("<script>");
					writer.println("alert('" + exception.getMessage() + "');");
					writer.println("</script>");
					writer.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			} else {
				if (view == null) {
					response.setContentType("text/html; charset=" + request.getCharacterEncoding());
					PrintWriter writer;
					try {
						writer = response.getWriter();
						writer.println("<script>");
						writer.println("alert('" + exception.getMessage() + "');");
						writer.println("history.back();");
						writer.println("</script>");
						writer.flush();
					} catch (IOException e) { 
						e.printStackTrace();
					}
					return null;
				}
				return new ModelAndView(view);
			}
			
			
		} else{
			//권한제외 모든 경우
			log.error(exceptionAllMessage); 
		}
		
		return new ModelAndView("/exception/error");
	}
}
