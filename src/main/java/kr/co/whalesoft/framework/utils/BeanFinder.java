
package kr.co.whalesoft.framework.utils;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.FrameworkServlet;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 * 현재 컨텍스트 내의 빈을 다양한 방법으로 찾을 수 있는 메소드들을 제공한다.
 */
public class BeanFinder {
	
	private static ApplicationContext getApplicationContext( ServletContext context ) {
		return (ApplicationContext) context.getAttribute( FrameworkServlet.SERVLET_CONTEXT_PREFIX + "spring" );
	}
	
	private static ApplicationContext getApplicationContext( ServletRequest request ) {
		return RequestContextUtils.getWebApplicationContext( request );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param context ApplicationContext
	 * @param id 빈의 ID
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ApplicationContext context, String id ) {
		return context.getBean( id );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param context 서블릿 Context
	 * @param id 빈의 ID
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ServletContext context, String id ) {
		return getBean( getApplicationContext( context ), id );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param request 서블릿 Request
	 * @param id 빈의 ID
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ServletRequest request, String id ) {
		return getBean( getApplicationContext( request ), id );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param context ApplicationContext
	 * @param clazz 빈의 타입
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ApplicationContext context, Class<?> clazz ) {
		return getBean( context, getBeanName( context, clazz ) );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param context 서블릿 Context
	 * @param clazz 빈의 타입
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ServletContext context, Class<?> clazz ) {
		return getBean( getApplicationContext( context ), clazz );
	}
	
	/**
	 * 빈을 찾는다.
	 * 
	 * @param request 서블릿 Request
	 * @param clazz 빈의 타입
	 * @return 빈의 인스턴스
	 */
	public static Object getBean( ServletRequest request, Class<?> clazz ) {
		return getBean( getApplicationContext( request ), clazz );
	}
	
	/**
	 * 빈의 이름을 찾는다.
	 * 
	 * @param context ApplicationContext
	 * @param clazz 빈의 타입
	 * @return 빈의 이름
	 */
	public static String getBeanName( ApplicationContext context, Class<?> clazz ) {
		
		for ( String beanName : context.getBeanNamesForType( clazz ) ) {
			// getBeanNamesForType은 지정 클래스의 하위 클래스들도 찾으므로,
			// 정확히 같은 클래스인지를 다시 검사해야 한다.
			if ( getBeanClassName( context, beanName ).equals( clazz.getName() ) ) return beanName;
		}
		
		return null;
	}
	
	private static String getBeanClassName( ApplicationContext context, String beanName ) {
		
		String className = context.getBean( beanName ).getClass().getName();
		int pos = className.indexOf( "$$" );
		
		// TODO Proxy 클래스일 경우는 원래 클래스 이름을 리턴해야 한다.
		return pos == -1 ? className : className.substring( 0, pos );
	}
}
