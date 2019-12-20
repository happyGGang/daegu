package kr.go.gbelib.app.cms.module.bookPackage;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookPackage extends PagingUtils {

	private Integer book_package_idx; // 책 꾸러미 IDX
	private String book_package_name; // 신청자명
	private String book_package_subject; // 책 꾸러미명
	private String author; // 저자
	private String publisher; // 출판사
	private Integer publish_year; // 출파년도
	private String isbn; // ISBN
	private Integer book_price; // 가격
	private Integer book_pages; // 페이지 수
	private String purpose; // 대상
	private Integer loan_count; // 대출가능권수
	private Integer quantity; // 소장권수
	private String grade; // 수준별
	private String category; // 주류별
	private String keyword; // 키워드
	private String desc_link; // 도서설명링크
	private String image_link; // 이미지 링크
	private String content; // 내용
	private String org_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	private MultipartFile mfile;

	public Integer getBook_package_idx() {
		return book_package_idx;
	}

	public void setBook_package_idx(Integer book_package_idx) {
		this.book_package_idx = book_package_idx;
	}

	public String getBook_package_name() {
		return book_package_name;
	}

	public void setBook_package_name(String book_package_name) {
		this.book_package_name = book_package_name;
	}

	public String getBook_package_subject() {
		return book_package_subject;
	}

	public void setBook_package_subject(String book_package_subject) {
		this.book_package_subject = book_package_subject;
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

	public Integer getPublish_year() {
		return publish_year;
	}

	public void setPublish_year(Integer publish_year) {
		this.publish_year = publish_year;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public Integer getBook_price() {
		return book_price;
	}

	public void setBook_price(Integer book_price) {
		this.book_price = book_price;
	}

	public Integer getBook_pages() {
		return book_pages;
	}

	public void setBook_pages(Integer book_pages) {
		this.book_pages = book_pages;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public Integer getLoan_count() {
		return loan_count;
	}

	public void setLoan_count(Integer loan_count) {
		this.loan_count = loan_count;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getDesc_link() {
		return desc_link;
	}

	public void setDesc_link(String desc_link) {
		this.desc_link = desc_link;
	}

	public String getImage_link() {
		return image_link;
	}

	public void setImage_link(String image_link) {
		this.image_link = image_link;
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
