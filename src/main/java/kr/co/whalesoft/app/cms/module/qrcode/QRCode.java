package kr.co.whalesoft.app.cms.module.qrcode;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class QRCode extends PagingUtils {
	private String text;
	private String text1;
	private int width;
	private int height;
	private String extension;
	private String fullMsg; 
	private String qrCodeDiv;
	private String name;
	private String company;
	private String tel;
	private String email;
	private String addr;
	private String home_pg;
	private String memo;
	private String url;
	private String title;
	
	public String getFullMsg() {
		return fullMsg;
	}
	public void setFullMsg(String fullMsg) {
		this.fullMsg = fullMsg;
	}
	public String getQrCodeDiv() {
		return qrCodeDiv;
	}
	public void setQrCodeDiv(String qrCodeDiv) {
		this.qrCodeDiv = qrCodeDiv;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public String getText1() {
		return text1;
	}
	public void setText1(String text1) {
		this.text1 = text1;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getHome_pg() {
		return home_pg;
	}
	public void setHome_pg(String homePg) {
		home_pg = homePg;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
