
package kr.co.whalesoft.framework.utils;

import javax.servlet.http.HttpServletRequest;

public class ResponseUtils {

	/**
	 * ContextPath를 가져온다.
	 * @param request
	 * @return
	 */
	public static String getContextPath(HttpServletRequest request) {
		return request.getContextPath();
	}
	
}
