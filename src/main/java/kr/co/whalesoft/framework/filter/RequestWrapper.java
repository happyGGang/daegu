package kr.co.whalesoft.framework.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public final class RequestWrapper extends HttpServletRequestWrapper {

	public RequestWrapper(HttpServletRequest servletRequest) {
		super(servletRequest);
	}
	
public String[] getParameterValues(String parameter) {
		
		String[] values = super.getParameterValues(parameter);
		
		if (values==null)  {
			return null;
		}
		
		int count = values.length;
		String[] encodedValues = new String[count];
		
		for (int i = 0; i < count; i++) {
			if(parameter.equals("content") || parameter.equals("html") || parameter.equals("top_html") || parameter.equals("bottom_html")) {
				encodedValues[i] = cleanXSSContent(values[i]);
			} else {
				encodedValues[i] = cleanXSS(values[i]);
			}
		}
		
		return encodedValues;
	}
	
	public String getParameter(String parameter) {
		
		String value = super.getParameter(parameter);
		
		if (value == null) {
			return null;
		}
		
		if (parameter.equals("content") || parameter.equals("html") || parameter.equals("top_html") || parameter.equals("bottom_html")) {
			return cleanXSSContent(value);
		} else {
			return cleanXSS(value);
		}
	}
	
	public String getHeader(String name) {
		
		String value = super.getHeader(name);
		
		if (value == null) {
			return null;
		}
		
		if (name.equals("content") || name.equals("html") || name.equals("top_html") || name.equals("bottom_html")) {
			return cleanXSSContent(value);
		} else {
			return cleanXSS(value);
		}
	}
	
	private String cleanXSS(String value) {
		//You'll need to remove the spaces from the html entities below
		value = value.replaceAll("<script>", "");
		value = value.replaceAll("</script>", "");
//		value = value.replaceAll("<iframe", "");
		value = value.replaceAll("<", "&lt");
		value = value.replaceAll(">", "&gt");
//		value = value.replaceAll("&", "&#38");
//		value = value.replaceAll("#", "&#35");
		// 채움 요청으로 ( )는 통과하도록 변경 20190612
//		value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
		value = value.replaceAll("'", "&#39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		return value;
	}
	
	private String cleanXSSContent(String value) {
		//You'll need to remove the spaces from the html entities below
		value = value.replaceAll("<script>", "");
		value = value.replaceAll("<script type=\"text/javascript\">", "");
//		value = value.replaceAll("<", "&lt");
//		value = value.replaceAll(">", "&gt");
//		value = value.replaceAll("&", "&#38");
//		value = value.replaceAll("#", "&#35");
		// ( )는 통과하도록 변경 20190612
//		value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
//		value = value.replaceAll("&", "&amp;");
//		value = value.replaceAll("\"", "&quot;");
//		value = value.replaceAll("\'", "&#x27;");
		
		value = value.replaceAll("'", "&#39;");
		value = value.replaceAll("eval\\((.*)\\)", "");
		value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
		return value;
	}

}
