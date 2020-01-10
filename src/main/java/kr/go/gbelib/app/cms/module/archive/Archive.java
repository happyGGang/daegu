package kr.go.gbelib.app.cms.module.archive;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Archive extends PagingUtils {
	
	private String homepage_id;
	private int book_idx;
	private String subject;
	private String regnumber;
	private String volume;
	private String author;
	private String publisher;
	private String year;
	private String callnumber;
	private String place;
	private int code;
	private String skin;
	private String logoimg;
	private String use_yn = "Y";
	private String viewtype;
	private int orig_width;
	private int orig_height;
	private int resize_width;
	private int resize_height;
	
	private int page_idx;
	private String page_idx_list;
	private String pageimg;
	private MultipartFile file;
	private String org_file_name;
	private String server_file_name;
	private String file_idx;
	
	private String add_date;
	private String add_id;
	private String mod_date;
	private String mod_id;
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getRegnumber() {
		return regnumber;
	}
	public void setRegnumber(String regnumber) {
		this.regnumber = regnumber;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getCallnumber() {
		return callnumber;
	}
	public void setCallnumber(String callnumber) {
		this.callnumber = callnumber;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getSkin() {
		return skin;
	}
	public void setSkin(String skin) {
		this.skin = skin;
	}
	public String getLogoimg() {
		return logoimg;
	}
	public void setLogoimg(String logoimg) {
		this.logoimg = logoimg;
	}
	public String getDelete_yn() {
		return use_yn;
	}
	public void setDelete_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getViewtype() {
		return viewtype;
	}
	public void setViewtype(String viewtype) {
		this.viewtype = viewtype;
	}
	public int getOrig_width() {
		return orig_width;
	}
	public void setOrig_width(int orig_width) {
		this.orig_width = orig_width;
	}
	public int getOrig_height() {
		return orig_height;
	}
	public void setOrig_height(int orig_height) {
		this.orig_height = orig_height;
	}
	public int getResize_width() {
		return resize_width;
	}
	public void setResize_width(int resize_width) {
		this.resize_width = resize_width;
	}
	public int getResize_height() {
		return resize_height;
	}
	public void setResize_height(int resize_height) {
		this.resize_height = resize_height;
	}
	public int getPage_idx() {
		return page_idx;
	}
	public void setPage_idx(int page_idx) {
		this.page_idx = page_idx;
	}
	public String getPageimg() {
		return pageimg;
	}
	public void setPageimg(String pageimg) {
		this.pageimg = pageimg;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getMod_date() {
		return mod_date;
	}
	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public String getOrg_file_name() {
		return org_file_name;
	}
	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}
	public String getServer_file_name() {
		return server_file_name;
	}
	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}
	public String getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(String file_idx) {
		this.file_idx = file_idx;
	}
	public String getPage_idx_list() {
		return page_idx_list;
	}
	public void setPage_idx_list(String page_idx_list) {
		this.page_idx_list = page_idx_list;
	}
	@Override
	public String toString() {
		return String.format(
				"Archive [homepage_id=%s, book_idx=%s, subject=%s, regnumber=%s, volume=%s, author=%s, publisher=%s, year=%s, callnumber=%s, place=%s, code=%s, skin=%s, logoimg=%s, use_yn=%s, viewtype=%s, orig_width=%s, orig_height=%s, resize_width=%s, resize_height=%s, page_idx=%s, pageimg=%s, file=%s, org_file_name=%s, server_file_name=%s, add_date=%s, add_id=%s, mod_date=%s, mod_id=%s]",
				homepage_id, book_idx, subject, regnumber, volume, author, publisher, year, callnumber, place, code,
				skin, logoimg, use_yn, viewtype, orig_width, orig_height, resize_width, resize_height, page_idx,
				pageimg, file, org_file_name, server_file_name, add_date, add_id, mod_date, mod_id);
	}
	
}
