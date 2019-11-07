package kr.go.gbelib.app.cms.module.elib.api;

import java.util.HashMap;
import java.util.Map;

public class ElibException extends Exception {
	private static final long serialVersionUID = 1L;
	private Map<String, String> resultMap = new HashMap<String, String>();
    public Map<String, String> getResultMap() {
		return resultMap;
	}
	public ElibException(String message) {
        super(message);
    }
    public ElibException(String message, Map<String, String> map) {
    	super(message);
    	this.resultMap = map;
    }
}