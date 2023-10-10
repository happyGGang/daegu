package kr.go.gbelib.app.cms.module.bookPackageBundle;

import java.util.Date;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookPackageBundle extends PagingUtils {

	//학생추천도서꾸러미 변수
	private String homepage_id;  //홈페이지ID
	private int book_package_bundle_idx;  //책꾸러미묶음IDX
	private int[] book_package_bundle_idx_arr;
	private int book_package_bundle_detail_idx;  //책꾸러미묶음상세IDX
	private int[] book_package_bundle_detail_idx_arr;
	private String book_package_bundle_title;  //책꾸러미묶음제목
	private int book_package_bundle_seq;  //꾸러미 출력순서
	
	//학생추천도서꾸러미 도서모음 변수
	private int bundle_idx;  //꾸러미IDX
	private int[] bundle_idx_arr;
	
	//학생추천도서꾸러미 상세정보 변수
	private String book_package_name;  //책제목명
	private String author;  //작가
	private String publisher;  //출판사
	private int publish_year;  //출판년도
	private Integer loan_count;  //대출가능권수
	private Integer quantity;  //소장권수
	private String grade;  //수준별
	private String category;  //주류별
	private String keyword;  //키워드
	private String desc_link;  //도서설명페이지링크주소
	private String image_link;  //링크이미지
	private String content;  //내용
	private String org_file_name;  //원본파일명
	private String server_file_name;  //서버파일명
	private String file_extension;  //파일확장자
	private long file_size;  //파일크기
	private String doc_org_file_name;  //문서파일원본명
	private String doc_server_file_name;  //문서서버파일명
	private String doc_file_extension;  //문서파일확장자
	private long doc_file_size;  //문서파일크기
	private int book_package_bundle_detail_seq;  //꾸러미 상세보기 출력순서
	
	private MultipartFile mfile;
	private MultipartFile doc_file;
	
	private int lender_count = -1; // 대출자 수
	
	//학생추천도서꾸러미 대출정보 변수
	private int book_package_bundle_loan_idx;  //책꾸러미대출IDX
	private int[] book_package_bundle_loan_arr;
	private String request_name;  //신청자
	private String school_name;  //학교명
	private String loan_start_date;  //대출시작기간
	private String loan_end_date;  //대출종료기간
	private String phone;  //연락처
	private String phone_1;
	private String phone_2;
	private String phone_3;
	private String school_tel;  //학교연락처
	private String school_tel_1;
	private String school_tel_2;
	private String school_tel_3;
	private String request_content;  //신청사유
	private String request_status;  //진행상태
	private String return_yn;  //반납여부
	
	private String add_id;  //등록ID
	private Date add_date;  //등록일시
	private String modify_id;  //수정ID
	private Date modify_date;  //수정일시

	private String cal_setting_loan_start_date;  //달력 셋팅 기간
	private String cal_setting_loan_end_date;  //달력 셋팅 기간
	
	private String loan_place; // 대출장소
	
	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getBook_package_bundle_idx() {
		return book_package_bundle_idx;
	}

	public void setBook_package_bundle_idx(int book_package_bundle_idx) {
		this.book_package_bundle_idx = book_package_bundle_idx;
	}

	public String getBook_package_bundle_title() {
		return book_package_bundle_title;
	}

	public void setBook_package_bundle_title(String book_package_bundle_title) {
		this.book_package_bundle_title = book_package_bundle_title;
	}

	public String getBook_package_name() {
		return book_package_name;
	}

	public void setBook_package_name(String book_package_name) {
		this.book_package_name = book_package_name;
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

	public String getDoc_org_file_name() {
		return doc_org_file_name;
	}

	public void setDoc_org_file_name(String doc_org_file_name) {
		this.doc_org_file_name = doc_org_file_name;
	}

	public String getDoc_server_file_name() {
		return doc_server_file_name;
	}

	public void setDoc_server_file_name(String doc_server_file_name) {
		this.doc_server_file_name = doc_server_file_name;
	}

	public String getDoc_file_extension() {
		return doc_file_extension;
	}

	public void setDoc_file_extension(String doc_file_extension) {
		this.doc_file_extension = doc_file_extension;
	}

	public long getDoc_file_size() {
		return doc_file_size;
	}

	public void setDoc_file_size(long doc_file_size) {
		this.doc_file_size = doc_file_size;
	}

	public int[] getBook_package_bundle_idx_arr() {
		return book_package_bundle_idx_arr;
	}

	public void setBook_package_bundle_idx_arr(int[] book_package_bundle_idx_arr) {
		this.book_package_bundle_idx_arr = book_package_bundle_idx_arr;
	}

	public MultipartFile getMfile() {
		return mfile;
	}

	public void setMfile(MultipartFile mfile) {
		this.mfile = mfile;
	}

	public MultipartFile getDoc_file() {
		return doc_file;
	}

	public void setDoc_file(MultipartFile doc_file) {
		this.doc_file = doc_file;
	}

	public int getBook_package_bundle_detail_idx() {
		return book_package_bundle_detail_idx;
	}

	public void setBook_package_bundle_detail_idx(int book_package_bundle_detail_idx) {
		this.book_package_bundle_detail_idx = book_package_bundle_detail_idx;
	}

	public int getBook_package_bundle_loan_idx() {
		return book_package_bundle_loan_idx;
	}

	public void setBook_package_bundle_loan_idx(int book_package_bundle_loan_idx) {
		this.book_package_bundle_loan_idx = book_package_bundle_loan_idx;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSchool_tel() {
		return school_tel;
	}

	public void setSchool_tel(String school_tel) {
		this.school_tel = school_tel;
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

	public String getReturn_yn() {
		return return_yn;
	}

	public void setReturn_yn(String return_yn) {
		this.return_yn = return_yn;
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

	public int getLender_count() {
		return lender_count;
	}

	public void setLender_count(int lender_count) {
		this.lender_count = lender_count;
	}

	public int[] getBook_package_bundle_loan_arr() {
		return book_package_bundle_loan_arr;
	}

	public void setBook_package_bundle_loan_arr(int[] book_package_bundle_loan_arr) {
		this.book_package_bundle_loan_arr = book_package_bundle_loan_arr;
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

	public int getBundle_idx() {
		return bundle_idx;
	}

	public void setBundle_idx(int bundle_idx) {
		this.bundle_idx = bundle_idx;
	}

	public int[] getBundle_idx_arr() {
		return bundle_idx_arr;
	}

	public void setBundle_idx_arr(int[] bundle_idx_arr) {
		this.bundle_idx_arr = bundle_idx_arr;
	}

	public int getBook_package_bundle_seq() {
		return book_package_bundle_seq;
	}

	public void setBook_package_bundle_seq(int book_package_bundle_seq) {
		this.book_package_bundle_seq = book_package_bundle_seq;
	}

	public int getBook_package_bundle_detail_seq() {
		return book_package_bundle_detail_seq;
	}

	public void setBook_package_bundle_detail_seq(int book_package_bundle_detail_seq) {
		this.book_package_bundle_detail_seq = book_package_bundle_detail_seq;
	}

	public int[] getBook_package_bundle_detail_idx_arr() {
		return book_package_bundle_detail_idx_arr;
	}

	public void setBook_package_bundle_detail_idx_arr(int[] book_package_bundle_detail_idx_arr) {
		this.book_package_bundle_detail_idx_arr = book_package_bundle_detail_idx_arr;
	}

	public String getCal_setting_loan_start_date() {
		return cal_setting_loan_start_date;
	}

	public void setCal_setting_loan_start_date(String cal_setting_loan_start_date) {
		this.cal_setting_loan_start_date = cal_setting_loan_start_date;
	}

	public String getCal_setting_loan_end_date() {
		return cal_setting_loan_end_date;
	}

	public void setCal_setting_loan_end_date(String cal_setting_loan_end_date) {
		this.cal_setting_loan_end_date = cal_setting_loan_end_date;
	}

	public String getLoan_place() {
		return loan_place;
	}

	public void setLoan_place(String loan_place) {
		this.loan_place = loan_place;
	}
	
}
