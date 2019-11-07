package kr.co.whalesoft.app.cms.mainImg;

import kr.co.whalesoft.framework.utils.PagingUtils;

import org.springframework.web.multipart.MultipartFile;

public class MainImg extends PagingUtils {

	private int img_idx;  //접수IDX
	private String title;  //제목
	private String img_file_name;  // 파일명
	private String real_file_name;
	private String file_extension;
	private long file_size;
	private String use_yn = "Y";
	private int print_seq;
	private String add_date;  //등록일
	
	private MultipartFile img_file;
	
	public MainImg() { }
	
	public MainImg(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public int getImg_idx() {
		return img_idx;
	}
	public void setImg_idx(int img_idx) {
		this.img_idx = img_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg_file_name() {
		return img_file_name;
	}
	public void setImg_file_name(String img_file_name) {
		this.img_file_name = img_file_name;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public MultipartFile getImg_file() {
		return img_file;
	}
	public void setImg_file(MultipartFile img_file) {
		this.img_file = img_file;
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

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
}