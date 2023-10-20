package kr.go.gbelib.app.cms.module.api;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import kr.co.whalesoft.app.board.Board;

@XmlRootElement(name = "oldBook_list")
public class OldBookXmlResult {

	private String image_url = "";
	private String url1 = "";
	private String url2 = "";
	private String title = "";
	private String author = "";
	private String pubdata = "";
	private String contents = "";
	
	private String message = "";
	
	private List<Board> boardList;
//	OldBookXmlResult() { }

//	OldBookXmlResult(String image_url, String url1, String url2, String title, String author, String pubdata, String contents, String message) {
//		this.image_url = image_url;
//		this.url1 = url1;
//		this.title = title;
//		this.author = author;
//		this.pubdata = pubdata;
//		this.contents = contents;
//		this.message = message;
//	}
	
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

	public String getUrl1() {
		return url1;
	}

	@XmlElement
	public void setUrl1(String url1) {
		this.url1 = url1;
	}

	public String getUrl2() {
		return url2;
	}

	@XmlElement
	public void setUrl2(String url2) {
		this.url2 = url2;
	}

	public String getTitle() {
		return title;
	}

	@XmlElement
	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	@XmlElement
	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPubdata() {
		return pubdata;
	}

	@XmlElement
	public void setPubdata(String pubdata) {
		this.pubdata = pubdata;
	}

	public String getContents() {
		return contents;
	}

	@XmlElement
	public void setContents(String contents) {
		this.contents = contents;
	}

	public List<Board> getBoardList() {
		return boardList;
	}

	@XmlElementWrapper(name = "RESERVE_LIST")
    @XmlElement(name = "ITEM")
	public void setBoardList(List<Board> boardList) {
		this.boardList = boardList;
	}
	
}
