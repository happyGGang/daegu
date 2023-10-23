package kr.go.gbelib.app.cms.module.api;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "internationalBook_list")
public class InternationalBookXmlResult {

	private String image_url = "";
	private String reg_no = "";
	private String author = "";
	private String pubyear = "";
	private String title = "";
	private String publisher = "";
	private String contents = "";
	private String call_no = "";
	private String loc_name = "";
	
	private String message = "";
	
	InternationalBookXmlResult() { }

	InternationalBookXmlResult(String image_url, String reg_no, String author, String pubyear, String title, String publisher, String contents, String call_no, String loc_name, String message) {
		this.image_url = image_url;
		this.reg_no = reg_no;
		this.author = author;
		this.pubyear = pubyear;
		this.title = title;
		this.publisher = publisher;
		this.contents = contents;
		this.call_no = call_no;
		this.loc_name = loc_name;
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}

	@XmlElement
	public void setMessage(String message) {
		this.message = message;
	}

	public String getImage_url() {
		return image_url;
	}

	@XmlElement
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}

	public String getReg_no() {
		return reg_no;
	}

	@XmlElement
	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}
	
	public String getAuthor() {
		return author;
	}

	@XmlElement
	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPubyear() {
		return pubyear;
	}

	@XmlElement
	public void setPubyear(String pubyear) {
		this.pubyear = pubyear;
	}

	public String getTitle() {
		return title;
	}

	@XmlElement
	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublisher() {
		return publisher;
	}

	@XmlElement
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getContents() {
		return contents;
	}

	@XmlElement
	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getCall_no() {
		return call_no;
	}

	@XmlElement
	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}

	public String getLoc_name() {
		return loc_name;
	}

	@XmlElement
	public void setLoc_name(String loc_name) {
		this.loc_name = loc_name;
	}

}
