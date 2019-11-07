package kr.co.whalesoft.app.cms.news;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class News extends PagingUtils {

	private int news_idx;  //접수IDX
	private String title;  //제목
	private String sub_title; //소제목
	private String link_url; // 이동 url;
	private String contents;  //내용
	private String file_name;  // 파일명
	private int print_seq;
	private String add_date;  //등록일
	private String use_yn = "N";
	
	private MultipartFile file;
	private String img_file_name;	//이미지파일명
	private String real_file_name;
	private String file_extension;
	private long file_size;

	public News() { } 
	
	public News(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public int getNews_idx() {
		return news_idx;
	}
	public void setNews_idx(int news_idx) {
		this.news_idx = news_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
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
	public String getSub_title() {
		return sub_title;
	}
	public void setSub_title(String sub_title) {
		this.sub_title = sub_title;
	}

	public String getLink_url() {
		return link_url;
	}

	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getImg_file_name() {
		return img_file_name;
	}

	public void setImg_file_name(String img_file_name) {
		this.img_file_name = img_file_name;
	}

	public String getReal_file_name() {
		return real_file_name;
	}

	public void setReal_file_name(String real_file_name) {
		this.real_file_name = real_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	
}