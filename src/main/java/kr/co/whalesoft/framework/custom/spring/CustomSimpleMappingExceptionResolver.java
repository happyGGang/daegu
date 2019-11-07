package kr.co.whalesoft.framework.custom.spring;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

/**
 * Exception시 기본 SimpleMappingExceptionResolver 로는 logging이 되지 않기 때문에 상속받아 처리 
 * @author 김병덕
 *
 */
public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {
	
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
	    logger.error("##ERROR", ex);
	    return super.resolveException(request, response, handler, ex);
	}
}