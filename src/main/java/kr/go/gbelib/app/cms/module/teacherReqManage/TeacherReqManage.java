package kr.go.gbelib.app.cms.module.teacherReqManage;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class TeacherReqManage extends PagingUtils {
	private int teacher_idx; // 강사IDX
	private String teacher_id;
	private String member_key;
	private String teacher_name; // 강사명
	private String teacher_subject_name; // 과목명
	private String stage; // 강의실
	private String teacher_birth; // 생년월일
	private String teacher_sex; // 성별
	private String teacher_phone; // 전화번호
	private String teacher_cell_phone; // 폰번호
	private String teacher_email;
	private String teacher_nationality; // 국적
	private String teacher_location_code; // 지역코드
	private String teacher_location_code_name; // 지역코드
	private String teacher_zipcode;
	private String teacher_address; // 주소
	private String teacher_history; // 이력
	private String teacher_history_manage;
	private String self_info_yn;
	private String confirm_yn; //승인여부
	private String add_date; // 등록일
	private String add_id; //등록자
	private String mod_date; //수정일 
	private String mod_id; //수정자
	private String delete_yn; // 삭제여부
	private String subject_cd; // 과목코드
	private String subject_cd_name; // 과목코드명
	private String largeSubjectCode;
	private String smallSubjectCode;
	private String teacher_education; // 학력
	private String teacher_experience; // 경력사항
	private String teacher_certifications; // 자격 및 면허
	private String homepage_name; // 신청 기관명
	
	private String full_adder; // 전체 주소
	
	private MultipartFile file;
	private String file_name;
	private String real_file_name;
	private String file_extension;
	private long file_size;
	
	private String search_api_type = "WEBID";

	private String teach_name; // 이력 화면에 뿌릴 용도로 사용 (디비 컬럼 아님)
	
	private List<MultipartFile> open_file;
	private String teacher_open_files; // 공개 첨부파일
	
	public TeacherReqManage() { }
	
	public TeacherReqManage(String homepage_id, int teacher_idx) {
		setHomepage_id(homepage_id);
		this.teacher_idx = teacher_idx;
	}
	
	public int getTeacher_idx() {
		return teacher_idx;
	}

	public void setTeacher_idx(int teacher_idx) {
		this.teacher_idx = teacher_idx;
	}

	public String getTeacher_name() {
		return teacher_name;
	}

	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}

	public String getTeacher_subject_name() {
		return teacher_subject_name;
	}

	public void setTeacher_subject_name(String teacher_subject_name) {
		this.teacher_subject_name = teacher_subject_name;
	}

	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}

	public String getTeacher_birth() {
		return teacher_birth;
	}

	public void setTeacher_birth(String teacher_birth) {
		this.teacher_birth = teacher_birth;
	}

	public String getTeacher_sex() {
		return teacher_sex;
	}

	public void setTeacher_sex(String teacher_sex) {
		this.teacher_sex = teacher_sex;
	}

	public String getTeacher_phone() {
		return teacher_phone;
	}

	public void setTeacher_phone(String teacher_phone) {
		this.teacher_phone = teacher_phone;
	}

	public String getTeacher_cell_phone() {
		return teacher_cell_phone;
	}

	public void setTeacher_cell_phone(String teacher_cell_phone) {
		this.teacher_cell_phone = teacher_cell_phone;
	}

	public String getTeacher_nationality() {
		return teacher_nationality;
	}

	public void setTeacher_nationality(String teacher_nationality) {
		this.teacher_nationality = teacher_nationality;
	}

	public String getTeacher_address() {
		return teacher_address;
	}

	public void setTeacher_address(String teacher_address) {
		this.teacher_address = teacher_address;
	}

	public String getTeacher_history() {
		return teacher_history;
	}

	public void setTeacher_history(String teacher_history) {
		this.teacher_history = teacher_history;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getTeach_name() {
		return teach_name;
	}

	public void setTeach_name(String teach_name) {
		this.teach_name = teach_name;
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

	public String getTeacher_id() {
		return teacher_id;
	}

	public void setTeacher_id(String teacher_id) {
		this.teacher_id = teacher_id;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getTeacher_zipcode() {
		return teacher_zipcode;
	}

	public void setTeacher_zipcode(String teacher_zipcode) {
		this.teacher_zipcode = teacher_zipcode;
	}

	public String getConfirm_yn() {
		return confirm_yn;
	}

	public void setConfirm_yn(String confirm_yn) {
		this.confirm_yn = confirm_yn;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getReal_file_name() {
		return real_file_name;
	}

	public void setReal_file_name(String real_file_name) {
		this.real_file_name = real_file_name;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

	public String getSelf_info_yn() {
		return self_info_yn;
	}

	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
	}

	public String getTeacher_history_manage() {
		return teacher_history_manage;
	}

	public void setTeacher_history_manage(String teacher_history_manage) {
		this.teacher_history_manage = teacher_history_manage;
	}

	
	public String getTeacher_location_code() {
		return teacher_location_code;
	}

	
	public void setTeacher_location_code(String teacher_location_code) {
		this.teacher_location_code = teacher_location_code;
	}

	
	public String getTeacher_location_code_name() {
		return teacher_location_code_name;
	}

	
	public void setTeacher_location_code_name(String teacher_location_code_name) {
		this.teacher_location_code_name = teacher_location_code_name;
	}

	
	public String getSubject_cd() {
		return subject_cd;
	}

	
	public void setSubject_cd(String subject_cd) {
		this.subject_cd = subject_cd;
	}

	
	public String getSubject_cd_name() {
		return subject_cd_name;
	}

	
	public void setSubject_cd_name(String subject_cd_name) {
		this.subject_cd_name = subject_cd_name;
	}

	
	public String getLargeSubjectCode() {
		return largeSubjectCode;
	}

	
	public void setLargeSubjectCode(String largeSubjectCode) {
		this.largeSubjectCode = largeSubjectCode;
	}

	
	public String getSmallSubjectCode() {
		return smallSubjectCode;
	}

	
	public void setSmallSubjectCode(String smallSubjectCode) {
		this.smallSubjectCode = smallSubjectCode;
	}

	public String getTeacher_email() {
		return teacher_email;
	}

	public void setTeacher_email(String teacher_email) {
		this.teacher_email = teacher_email;
	}

	public String getTeacher_education() {
		return teacher_education;
	}

	public void setTeacher_education(String teacher_education) {
		this.teacher_education = teacher_education;
	}

	public String getTeacher_experience() {
		return teacher_experience;
	}

	public void setTeacher_experience(String teacher_experience) {
		this.teacher_experience = teacher_experience;
	}

	public String getTeacher_certifications() {
		return teacher_certifications;
	}

	public void setTeacher_certifications(String teacher_certifications) {
		this.teacher_certifications = teacher_certifications;
	}

	public List<MultipartFile> getOpen_file() {
		return open_file;
	}

	public void setOpen_file(List<MultipartFile> open_file) {
		this.open_file = open_file;
	}

	public String getTeacher_open_files() {
		return teacher_open_files;
	}

	public void setTeacher_open_files(String teacher_open_files) {
		this.teacher_open_files = teacher_open_files;
	}

	public String getFull_adder() {
		return full_adder;
	}

	public void setFull_adder(String full_adder) {
		this.full_adder = full_adder;
	}

	public String getHomepage_name() {
		return homepage_name;
	}

	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	
}
