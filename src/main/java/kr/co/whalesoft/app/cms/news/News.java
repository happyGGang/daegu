package kr.co.whalesoft.app.cms.news;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class News extends PagingUtils {

	private int news_idx; // 접수IDX
	private String news_name; // 제목
	private String sub_news_name; // 소제목
	private String link_url; // 이동 url;
	private String contents; // 내용
	private int print_seq; // 출력순서
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시
	private String use_yn;

	private MultipartFile file;
	private String org_file_name; // 원본 파일명
	private String server_file_name; // 서버 파일명
	private String file_extension; // 파일 확장자
	private long file_size; // 파일 용량

	public News() {
	}

	public News(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public int getNews_idx() {
		return news_idx;
	}

	public void setNews_idx(int news_idx) {
		this.news_idx = news_idx;
	}

	public String getNews_name() {
		return news_name;
	}

	public void setNews_name(String news_name) {
		this.news_name = news_name;
	}

	public String getSub_news_name() {
		return sub_news_name;
	}

	public void setSub_news_name(String sub_news_name) {
		this.sub_news_name = sub_news_name;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
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

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
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
