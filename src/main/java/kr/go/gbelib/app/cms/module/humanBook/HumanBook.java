package kr.go.gbelib.app.cms.module.humanBook;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class HumanBook extends PagingUtils {

	private String homepage_id; // 홈페이지ID
	private int human_book_idx; // 사람책 IDX
	private String teacher_name; // 강사명
	private String teacher_birth; // 강사생년원일
	private String teacher_gender; // 강사성별
	private String teacher_email; // 강사email
	// private String teacher_tel; // 강사연락처
	private String teacher_phone; // 강사핸드폰연락처
	private String teacher_agency; // 소속
	private String teacher_zipcode; // 강사우편주소
	private String teacher_address; // 강사주소
	private String activity_category; // 강좌분류
	private String activity_day; // 활동일
	private String activity_time; // 활동시간
	private String activity_time_txt; // 활동시간 기타
	private String human_book_title; // 사람책 제목
	private String teacher_content; // 강사자기소개
	private String human_book_content; // 사람책 내용
	private String origin_file_name; // 원본파일명
	private String server_file_name; // 서버파일명
	private String file_extension; // 파일확장자
	private long file_size; // 파일크기
	// private Date apply_date; // 신청일자
	// private String apply_func; // 기능
	private String apply_status; // 상태
	private String unapproved_reasons; // 미승인사유
	private Date add_date; // 등록일자
	private String add_id; // 등록ID
	private Date modify_date; // 수정일자
	private String modify_id; // 수정ID

	private MultipartFile mFile;

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getHuman_book_idx() {
		return human_book_idx;
	}

	public void setHuman_book_idx(int human_book_idx) {
		this.human_book_idx = human_book_idx;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getTeacher_birth() {
		return teacher_birth;
	}

	public void setTeacher_birth(String teacher_birth) {
		this.teacher_birth = teacher_birth;
	}

	public String getTeacher_gender() {
		return teacher_gender;
	}

	public void setTeacher_gender(String teacher_gender) {
		this.teacher_gender = teacher_gender;
	}

	public String getTeacher_email() {
		return teacher_email;
	}

	public void setTeacher_email(String teacher_email) {
		this.teacher_email = teacher_email;
	}

	// public String getTeacher_tel() {
	// return teacher_tel;
	// }
	//
	// public void setTeacher_tel(String teacher_tel) {
	// this.teacher_tel = teacher_tel;
	// }

	public String getTeacher_phone() {
		return teacher_phone;
	}

	public void setTeacher_phone(String teacher_phone) {
		this.teacher_phone = teacher_phone;
	}

	public String getTeacher_agency() {
		return teacher_agency;
	}

	public void setTeacher_agency(String teacher_agency) {
		this.teacher_agency = teacher_agency;
	}

	public String getTeacher_zipcode() {
		return teacher_zipcode;
	}

	public void setTeacher_zipcode(String teacher_zipcode) {
		this.teacher_zipcode = teacher_zipcode;
	}

	public String getTeacher_address() {
		return teacher_address;
	}

	public void setTeacher_address(String teacher_address) {
		this.teacher_address = teacher_address;
	}

	public String getActivity_category() {
		return activity_category;
	}

	public void setActivity_category(String activity_category) {
		this.activity_category = activity_category;
	}

	public String getActivity_day() {
		return activity_day;
	}

	public void setActivity_day(String activity_day) {
		this.activity_day = activity_day;
	}

	public String getActivity_time() {
		return activity_time;
	}

	public void setActivity_time(String activity_time) {
		this.activity_time = activity_time;
	}

	public String getActivity_time_txt() {
		return activity_time_txt;
	}

	public void setActivity_time_txt(String activity_time_txt) {
		this.activity_time_txt = activity_time_txt;
	}

	public String getHuman_book_title() {
		return human_book_title;
	}

	public void setHuman_book_title(String human_book_title) {
		this.human_book_title = human_book_title;
	}

	public String getTeacher_content() {
		return teacher_content;
	}

	public void setTeacher_content(String teacher_content) {
		this.teacher_content = teacher_content;
	}

	public String getHuman_book_content() {
		return human_book_content;
	}

	public void setHuman_book_content(String human_book_content) {
		this.human_book_content = human_book_content;
	}

	public String getOrigin_file_name() {
		return origin_file_name;
	}

	public void setOrigin_file_name(String origin_file_name) {
		this.origin_file_name = origin_file_name;
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

	// public Date getApply_date() {
	// return apply_date;
	// }
	//
	// public void setApply_date(Date apply_date) {
	// this.apply_date = apply_date;
	// }
	//
	// public String getApply_func() {
	// return apply_func;
	// }
	//
	// public void setApply_func(String apply_func) {
	// this.apply_func = apply_func;
	// }

	public String getApply_status() {
		return apply_status;
	}

	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}

	public String getUnapproved_reasons() {
		return unapproved_reasons;
	}

	public void setUnapproved_reasons(String unapproved_reasons) {
		this.unapproved_reasons = unapproved_reasons;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public MultipartFile getmFile() {
		return mFile;
	}

	public void setmFile(MultipartFile mFile) {
		this.mFile = mFile;
	}

}
