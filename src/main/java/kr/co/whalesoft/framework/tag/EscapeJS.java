package kr.co.whalesoft.framework.tag;

import org.apache.commons.lang.StringEscapeUtils;

public class EscapeJS {
	public static String escapeJS(String value) {
		return StringEscapeUtils.escapeJavaScript(value);
	}
}
