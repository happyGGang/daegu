package kr.co.whalesoft.framework.resolver;

import kr.go.gbelib.app.cms.module.bookOfYear.BookOfYear;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;

public class CustomArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public Object resolveArgument(MethodParameter arg0, ModelAndViewContainer arg1, NativeWebRequest arg2,
								  WebDataBinderFactory arg3) throws Exception {

		HttpServletRequest request = (HttpServletRequest) arg2.getNativeRequest();

		// 예외처리( 템플릿 위젯관리 )
		String excepUri = "|/apple/tm/tmplat/uptWidgInfo.do|/apple/tm/tmplat/uptFileInfo.do|";
		String reqUri = request.getRequestURI();
		boolean secCheckAt = true;

		// 신규 위젯을 위한 처리
		String[] reqUriArr = reqUri.split("/");

		if(excepUri.contains("|"+reqUri+"|") || reqUriArr[2].equals("wm")){
			secCheckAt = false;
		}

		BookOfYear commandMap = new BookOfYear();
		Enumeration<String> enumeration = request.getParameterNames();

		while (enumeration.hasMoreElements()) {
			String key = enumeration.nextElement();
			String[] values = request.getParameterValues(key);

			if (values != null) {
				if (values.length > 1) {
					String[] newValues = new String[values.length];

					for (int i = 0; i < values.length; i++) {
						String filterStr = values[i];

						if (filterStr.contains("0x00000001")) {
							ModelAndView modelAndView = new ModelAndView("nfu/ap/am/webfilerError");
							modelAndView.addObject("filterStr", filterStr.replaceAll("0x00000001", ""));
							throw new ModelAndViewDefiningException(modelAndView);
						} else {
							newValues[i] = filterStr;
						}
					}

					commandMap.put(key, newValues);
				} else {
					String filterStr = values[0];

					if (filterStr.contains("0x00000001")) {
						ModelAndView modelAndView = new ModelAndView("nfu/ap/am/webfilerError");
						modelAndView.addObject("filterStr", filterStr.replaceAll("0x00000001", ""));
						throw new ModelAndViewDefiningException(modelAndView);
					}

					commandMap.put(key, filterStr);
				}
			}
		}

		return commandMap;
	}

	@Override
	public boolean supportsParameter(MethodParameter arg0) {
		return BookOfYear.class.isAssignableFrom(arg0.getParameterType());
	}
	
}
