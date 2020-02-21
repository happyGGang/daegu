package kr.go.gbelib.app.cms.module.api;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "CheckLogin")
public class ElibLoginXmlResult {

	private String Result = "false";
	private String Message = "";
	private String manage_code = "";
	
	ElibLoginXmlResult() { }
	
	ElibLoginXmlResult(String result) {
		this.Result = result;
	}

	ElibLoginXmlResult(String Result, String Message) {
		this.Result = Result;
		this.Message = Message;
	}
	
	public String getResult() {
		return Result;
	}
	
	@XmlElement(name="Result")
	public void setResult(String Result) {
		this.Result = Result;
	}

	public String getMessage() {
		return Message;
	}

	@XmlElement(name="Message")
	public void setMessage(String Message) {
		this.Message = Message;
	}

	public String getManage_code() {
		return manage_code;
	}

	@XmlElement(name="manage_code")
	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	
}
