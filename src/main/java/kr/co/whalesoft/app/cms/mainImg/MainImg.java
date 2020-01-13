package kr.co.whalesoft.app.cms.mainImg;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class MainImg extends PagingUtils {

	private int img_idx; // 접수IDX
	private String main_img_name; // 제목
	private String org_file_name; // 파일원본명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일 확장자
	private long file_size; // 파일크기
	private String use_yn; // 사용여부
	private int print_seq; // 출력순서
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시
	private String alt_text; // 대체 텍스트

	private MultipartFile img_file;

	public MainImg() {
	}

	public MainImg(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public int getImg_idx() {
		return img_idx;
	}

	public void setImg_idx(int img_idx) {
		this.img_idx = img_idx;
	}

	public String getMain_img_name() {
		return main_img_name;
	}

	public void setMain_img_name(String main_img_name) {
		this.main_img_name = main_img_name;
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

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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

	public MultipartFile getImg_file() {
		return img_file;
	}

	public void setImg_file(MultipartFile img_file) {
		this.img_file = img_file;
	}


	public String getAlt_text() {
		return alt_text;
	}


	public void setAlt_text(String alt_text) {
		this.alt_text = alt_text;
	}

}
