package kr.co.whalesoft.framework.utils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JsonResponse {

	private boolean			valid;
	private Object			result;
	private String			url;
	private String			message;
	private Object			data;
	private HttpServletRequest 	request;
	private boolean			reload = false;
	List<Map<String, Object>> errors;
	
	private boolean			targetOpener = false;
	private boolean closeFlag = false;
	
	public JsonResponse() {};
	
	public boolean isCloseFlag() {
		return closeFlag;
	}

	public void setCloseFlag(boolean closeFlag) {
		this.closeFlag = closeFlag;
	}

	public JsonResponse(HttpServletRequest request) {
		this.request = request;
	};
	
	public Object getResult() {
		return result;
	}
	public void setResult(Object result) {
		this.result = result;
	}
	public boolean isValid() {
		return valid;
	}
	public void setValid(boolean valid) {
		this.valid = valid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = RequestUtils.getContextPath(request)+url;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public boolean isTargetOpener() {
		return targetOpener;
	}

	public void setTargetOpener(boolean targetOpener) {
		this.targetOpener = targetOpener;
	}

	public boolean isReload() {
		return reload;
	}

	public void setReload(boolean reload) {
		this.reload = reload;
	}


	public boolean hasErrors() {
		return result != null;
	}

	public void addError(String field, String errorCode) {
		if (errors == null) {
			errors = new ArrayList<>();
		}
		Map<String, Object> error = new HashMap<>();
		error.put("code", errorCode);
		error.put("field", field);
		errors.add(error);
		if (result == null) {
			result = errors;
		}
	}
}