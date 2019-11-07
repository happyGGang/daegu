package kr.co.whalesoft.framework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import kr.co.whalesoft.framework.base.BaseController;

public class AjaxValidationInterceptor extends HandlerInterceptorAdapter {
	
	private static final long serialVersionUID = 1L;
	
	private static final String ENABLE_AJAX_VALIDATION_PARAM = "spring.enableAjaxValidation";
	private static final String FORM_ID_PARAM = "spring.formId";
	
	
	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		
		
		String ajaxEnabled = request.getParameter( ENABLE_AJAX_VALIDATION_PARAM );
		String formId = request.getParameter( FORM_ID_PARAM );
		
		if ( ajaxEnabled != null && ajaxEnabled.equals( "true" ) ){
			
			
			
		/*	if (bindingResult.hasErrors()) {
				System.out.println("벨리데이션 테스트");
				return "redirect:" + redirectURL + "/cms/login/index.do";
			}*/
			
			//System.out.println(((LoginController)handler).loginProc());
			System.out.println(BindingResult.MODEL_KEY_PREFIX);
			if(handler instanceof BaseController){
				System.out.println("Controller확인");
			}
		}else {
		}
		/*	
			Object action = invocation.getAction();
			if ( !( action instanceof ValidationAware ) ) return invocation.invoke();
			ValidationAware validationAware = (ValidationAware) action;

			
			if ( ajaxEnabled != null && ajaxEnabled.equals( "true" ) )
				return JSONUtils.createJSONResult( request, response, formId, validationAware.getFieldErrors() );
			else if ( RequestUtils.isAjaxRequest( request ) ) {
				if ( validationAware.hasFieldErrors() )
					return JSONUtils.createJSONResult( request, response, formId, validationAware.getFieldErrors() );
				else
					return invocation.invoke();
			}
			else
				return invocation.invoke();*/
		
		
	}
	
}
