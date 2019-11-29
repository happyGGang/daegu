package kr.co.whalesoft.framework.interceptor;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.MDC;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MDCInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		UUID requestId = UUID.randomUUID();
		MDC.clear();
		MDC.put("requestId", String.valueOf(requestId));
		MDC.put("sessionId", request.getSession().getId());

		return true;
	}
}
