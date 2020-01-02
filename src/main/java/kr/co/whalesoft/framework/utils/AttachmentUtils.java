
package kr.co.whalesoft.framework.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import is.tagomor.woothee.Classifier;

public class AttachmentUtils {

	public static String getContentDisposition(String filename, String user_agent) throws UnsupportedEncodingException {
		Map<String, String> r = Classifier.parse(user_agent);
		String name = r.get("name");
//		String category = r.get("category");
//		String os = r.get("os");
//		String version = r.get("version");
//		String os_version = r.get("os_version");

		if("Chrome".equals(name) || "Edge".equals(name) || "Firefox".equals(name) || "Safari".equals(name)) {
			return String.format("attachment; filename=\"%s\"; filename*=UTF-8''%s", filename, URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20"));
		} else if("Internet Explorer".equals(name)) {
			return String.format("attachment; filename=\"%s\";", URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20"));
		} else {
			return String.format("attachment; filename=\"%s\";", filename);
		}
	}

	public static String getContentType(String extension) {
		String ext = extension.toUpperCase();
		if (ext.equals("HWP")) {
			return "application/x-hwp";
		} else if (ext.equals("PDF")) {
			return "application/pdf";
		} else if (ext.equals("PPT") || ext.equals("PPTX")) {
			return "application/vnd.ms-powerpoint";
		} else if (ext.equals("DOC") || ext.equals("DOCX")) {
			return "application/msword";
		} else if (ext.equals("XLS") || ext.equals("XLSX")) {
			return "application/vnd.ms-excel";
		} else if (ext.equals("BMP")) {
			return "image/bmp";
		} else if (ext.equals("GIF")) {
			return "image/gif";
		} else if (ext.equals("PNG")) {
			return "image/png";
		} else if (ext.equals("JPG") || ext.equals("JPEG")) {
			return "image/jpeg";
		} else if (ext.equals("MP3")) {
			return "audio/mpeg";
		} else {
			return "application/octet-stream";
		}
	}

}
