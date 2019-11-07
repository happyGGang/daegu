package kr.go.gbelib.app.cms.module.api;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "elib_api")
public class ElibXmlResult {

	private String result = "false";
	private String msg = "";
	private String errcode = "";
	
	ElibXmlResult() { }
	
	ElibXmlResult(String result) {
		this.result = result;
	}

	ElibXmlResult(String result, String errcode, String msg) {
		this.result = result;
		this.errcode = errcode;
		this.msg = msg;
	}
	
	public String getResult() {
		return result;
	}
	
	@XmlElement
	public void setResult(String result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	@XmlElement
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getErrcode() {
		return errcode;
	}

	@XmlElement
	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}
	
}
