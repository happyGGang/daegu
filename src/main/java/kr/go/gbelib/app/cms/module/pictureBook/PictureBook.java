package kr.go.gbelib.app.cms.module.pictureBook;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PictureBook extends PagingUtils {

	private int picture_book_idx; // 원화IDX
	private String picture_book_name; // 등록자명
	private String picture_book_subject; // 원화명
	private String author; // 작가
	private String publisher; // 출판사
	private int publish_year; // 출판년도
	private String isbn; // ISBN
	private int picture_price; // 가격
	private int picture_count; // 액자개수
	private String keyword; // 주제(키워드)
	private String category; // 원화유형별
	private String desc_link; // 도서설명페이지링크주소
	private String thumb_image; // 썸네일이미지
	private String content; // 내용
	private String org_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기

	List<Map<String, String>> monthList;

	private MultipartFile mfile;

	private int picture_book_loan_idx; // 원화 대출IDX
	private int[] picture_book_loan_arr;
	private String request_name; // 신청자명
	private String school_name; // 학교명
	private String loan_start_date; // 대출시작기간
	private String loan_end_date; // 대출종료기간
	private String loan_year; // 대출년도
	private String loan_month; // 대출월
	private String phone; // 연락처
	private String phone_1;
	private String phone_2;
	private String phone_3;
	private String school_tel; // 학교연락처
	private String school_tel_1;
	private String school_tel_2;
	private String school_tel_3;
	private String request_content; // 신청사유
	private String request_status; // 진행상태
	private String pay_yn; // 유료여부

	// 공통
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	public int getPicture_book_idx() {
		return picture_book_idx;
	}

	public void setPicture_book_idx(int picture_book_idx) {
		this.picture_book_idx = picture_book_idx;
	}

	public String getPicture_book_name() {
		return picture_book_name;
	}

	public void setPicture_book_name(String picture_book_name) {
		this.picture_book_name = picture_book_name;
	}

	public String getPicture_book_subject() {
		return picture_book_subject;
	}

	public void setPicture_book_subject(String picture_book_subject) {
		this.picture_book_subject = picture_book_subject;
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

	public int getPublish_year() {
		return publish_year;
	}

	public void setPublish_year(int publish_year) {
		this.publish_year = publish_year;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public int getPicture_price() {
		return picture_price;
	}

	public void setPicture_price(int picture_price) {
		this.picture_price = picture_price;
	}

	public int getPicture_count() {
		return picture_count;
	}

	public void setPicture_count(int picture_count) {
		this.picture_count = picture_count;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDesc_link() {
		return desc_link;
	}

	public void setDesc_link(String desc_link) {
		this.desc_link = desc_link;
	}

	public String getThumb_image() {
		return thumb_image;
	}

	public void setThumb_image(String thumb_image) {
		this.thumb_image = thumb_image;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public List<Map<String, String>> getMonthList() {
		return monthList;
	}

	public void setMonthList(List<Map<String, String>> monthList) {
		this.monthList = monthList;
	}

	public int getPicture_book_loan_idx() {
		return picture_book_loan_idx;
	}

	public void setPicture_book_loan_idx(int picture_book_loan_idx) {
		this.picture_book_loan_idx = picture_book_loan_idx;
	}

	public int[] getPicture_book_loan_arr() {
		return picture_book_loan_arr;
	}

	public void setPicture_book_loan_arr(int[] picture_book_loan_arr) {
		this.picture_book_loan_arr = picture_book_loan_arr;
	}

	public String getRequest_name() {
		return request_name;
	}

	public void setRequest_name(String request_name) {
		this.request_name = request_name;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getLoan_start_date() {
		return loan_start_date;
	}

	public void setLoan_start_date(String loan_start_date) {
		this.loan_start_date = loan_start_date;
	}

	public String getLoan_end_date() {
		return loan_end_date;
	}

	public void setLoan_end_date(String loan_end_date) {
		this.loan_end_date = loan_end_date;
	}

	public String getLoan_year() {
		return loan_year;
	}

	public void setLoan_year(String loan_year) {
		this.loan_year = loan_year;
	}

	public String getLoan_month() {
		return loan_month;
	}

	public void setLoan_month(String loan_month) {
		this.loan_month = loan_month;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone_1() {
		return phone_1;
	}

	public void setPhone_1(String phone_1) {
		this.phone_1 = phone_1;
	}

	public String getPhone_2() {
		return phone_2;
	}

	public void setPhone_2(String phone_2) {
		this.phone_2 = phone_2;
	}

	public String getPhone_3() {
		return phone_3;
	}

	public void setPhone_3(String phone_3) {
		this.phone_3 = phone_3;
	}

	public String getSchool_tel() {
		return school_tel;
	}

	public void setSchool_tel(String school_tel) {
		this.school_tel = school_tel;
	}

	public String getSchool_tel_1() {
		return school_tel_1;
	}

	public void setSchool_tel_1(String school_tel_1) {
		this.school_tel_1 = school_tel_1;
	}

	public String getSchool_tel_2() {
		return school_tel_2;
	}

	public void setSchool_tel_2(String school_tel_2) {
		this.school_tel_2 = school_tel_2;
	}

	public String getSchool_tel_3() {
		return school_tel_3;
	}

	public void setSchool_tel_3(String school_tel_3) {
		this.school_tel_3 = school_tel_3;
	}

	public String getRequest_content() {
		return request_content;
	}

	public void setRequest_content(String request_content) {
		this.request_content = request_content;
	}

	public String getRequest_status() {
		return request_status;
	}

	public void setRequest_status(String request_status) {
		this.request_status = request_status;
	}

	public String getPay_yn() {
		return pay_yn;
	}

	public void setPay_yn(String pay_yn) {
		this.pay_yn = pay_yn;
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

	public MultipartFile getMfile() {
		return mfile;
	}

	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}

}
