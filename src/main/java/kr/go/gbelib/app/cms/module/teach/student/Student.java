package kr.go.gbelib.app.cms.module.teach.student;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Student extends PagingUtils {
	private List<Student> studentList = new ArrayList<Student>();

	private int large_category_idx;
	private int group_idx;  //카테고리 그룹IDX
	private int category_idx;  //카테고리IDX
	private int teach_idx;  //강의IDX
	private int student_idx;  //수강생IDX

	private String member_id;
	private String member_key; //사용자 구분 키
	private String applicant_name;  //신청자명
	private String applicant_birth;  //신청자생년월일
	private int applicant_old;  //신청자나이
	private String applicant_sex;  //신청자성별
	private String applicant_zipcode;  //신청자우편번호
	private String applicant_address;  //신청자주소
	private String applicant_address_detail;  //신청자상세주소
	private String applicant_phone;  //신청자전화번호
	private String applicant_cell_phone;  //신청자폰번호
	private String web_id;

	private String self_yn;  //본인수강여부
	private String self_parent_yn;  //보호자 동일 여부

	private String student_name;  //수강생명
	private String student_birth;  //수강생생년월일
	private int student_old;  //수강생나이
	private String student_sex;  //수강생성별
	private String student_zipcode;  //수강생우편번호
	private String student_address;  //수강생주소
	private String student_address_detail;  //수강생상세주소
	private String student_school;  //수강생학교
	private int student_hack;  //수강생학년
	private String student_hack_str;  //수강생학년
	private String student_ban;  //수강생반
	private String student_age; // 신청자나이
	private String student_remark;  //수강생비고
	private String student_family_count;//가족인원수
	private String student_location_code;//지역코드 - 나이스시스템 관리자 연수용
	private String student_location_code_str;//지역코드 - 나이스시스템 관리자 연수용
	private String student_neis_cd;//neis 개인번호 (R로 시작하는 10자리) - 나이스시스템 관리자 연수용
	private String student_training_num;//연수지명번호 (텍스트30자리) - 나이스시스템 관리자 연수용
	private String student_organization;//기관 (한글40자리)
	private String student_rank;//직급 (한글20자리)
	private String student_course_taken_yn;//연수수강여부
	private String student_password;//비회원 패스워드
	private String sms_service_yn;  //sms 수신 동의 여부
	private String picture_use_yn;  //사진 촬영 동의 여부

	private String self_info_yn;  //개인정보동의여부
	private String apply_type;
	private String apply_status;  //신청상태 : 1 - 참여, 2 - 후보, 5 - 오프라인 참여 , 99 - 취소

	private String pay1_yn; //수강료 납부 여부
	private String pay2_yn; //교재비 납부 여부
	private String pay3_yn; //재료비 납부 여부

	private String add_date;  //등록일
	private String add_id;
	private String modify_date;
	private String modify_id;
	private Date cancel_date; // 취소일
	private String cancel_id; // 취소ID
	private String delete_yn;  //삭제 여부

	private String family_relation; //법정대리인 관계
	private String family_name; // 법정대리인 명
	private String family_cell_phone; // 법정대리인 연락처
	private String family_confirm_yn; // 법정대리인 승인 여부
	private String family_desc;

	private String num;
	private String teach_date;
	private String teach_name;
	private String teach_stage;
	private String homepage_name;
	private String end_date;
	private String end_time;



	private String teach_status;
	private String student_status;
	private int cert_percent = 70;

	private String search_api_type = "WEBID";

	private String api_user_id; // 대출번호만 담는 변수

	private String search_start_date;
	private String search_end_date;

	private String userNo;

	private Date fromDate;
	private Date toDate;

	private String fromDateStr;
	private String toDateStr;
	
	private MultipartFile apply_file;
	
	private int file_idx; // 수강생 파일 idx
	private String org_file_name;  //강의이미지파일명
	private String server_file_name; //실제파일명
	private String file_extension;  //파일확장자
	private long file_size;  //파일 사이즈

	private List<Integer> student_idx_arr;	// 체크박스로 일괄 삭제할 때 씀
	
	private String agree_codes; // 선택 약관

	public Student() {}

	public Student(String homepage_id, int group_idx, int category_idx, int teach_idx) {
		this.setHomepage_id(homepage_id);
		this.group_idx = group_idx;
		this.category_idx = category_idx;
		this.teach_idx = teach_idx;
	}

	public Student(String homepage_id, int group_idx, int category_idx, int teach_idx, String apply_status) {
		this.setHomepage_id(homepage_id);
		this.group_idx = group_idx;
		this.category_idx = category_idx;
		this.teach_idx = teach_idx;
		this.apply_status = apply_status;
	}

	public int getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}
	public int getTeach_idx() {
		return teach_idx;
	}
	public void setTeach_idx(int teach_idx) {
		this.teach_idx = teach_idx;
	}
	public int getStudent_idx() {
		return student_idx;
	}
	public void setStudent_idx(int student_idx) {
		this.student_idx = student_idx;
	}
	public String getApplicant_name() {
		return applicant_name;
	}
	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}
	public String getApplicant_birth() {
		return applicant_birth;
	}
	public void setApplicant_birth(String applicant_birth) {
		this.applicant_birth = applicant_birth;
	}
	public int getApplicant_old() {
		return applicant_old;
	}
	public void setApplicatn_old(int applicant_old) {
		this.applicant_old = applicant_old;
	}
	public String getApplicant_sex() {
		return applicant_sex;
	}
	public void setApplicant_sex(String applicant_sex) {
		this.applicant_sex = applicant_sex;
	}
	public String getApplicant_address() {
		return applicant_address;
	}
	public void setApplicant_address(String applicant_address) {
		this.applicant_address = applicant_address;
	}
	public String getApplicant_phone() {
		return applicant_phone;
	}
	public void setApplicant_phone(String applicant_phone) {
		/*String[] arr = applicant_phone.split("-");
		this.applicant_phone1 = arr[0];
		if ( arr.length > 1 ) {
			this.applicant_phone2 = arr[1];
		}
		if ( arr.length > 2 ) {
			this.applicant_phone3 = arr[2];
		}*/
		this.applicant_phone = applicant_phone;
	}
	public String getApplicant_cell_phone() {
		return applicant_cell_phone;
	}
	public void setApplicant_cell_phone(String applicant_cell_phone) {
		/*String[] arr = applicant_cell_phone.split("-");
		this.applicant_cell_phone1 = arr[0];
		if ( arr.length > 1 ) {
			this.applicant_cell_phone2 = arr[1];
		}
		if ( arr.length > 2 ) {
			this.applicant_cell_phone3 = arr[2];
		}*/
		this.applicant_cell_phone = applicant_cell_phone;
	}
	public String getSelf_yn() {
		return self_yn;
	}
	public void setSelf_yn(String self_yn) {
		this.self_yn = self_yn;
	}
	public String getSelf_parent_yn() {
		return self_parent_yn;
	}
	public void setSelf_parent_yn(String self_parent_yn) {
		this.self_parent_yn = self_parent_yn;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getStudent_sex() {
		return student_sex;
	}
	public void setStudent_sex(String student_sex) {
		this.student_sex = student_sex;
	}
	public String getStudent_school() {
		return student_school;
	}
	public void setStudent_school(String student_school) {
		this.student_school = student_school;
	}
	public int getStudent_hack() {
		return student_hack;
	}
	public void setStudent_hack(int student_hack) {
		this.student_hack = student_hack;
	}
	public int getStudent_old() {
		return student_old;
	}
	public void setStudent_old(int student_old) {
		this.student_old = student_old;
	}
	public String getSelf_info_yn() {
		return self_info_yn;
	}
	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
	}
	public String getApply_status() {
		return apply_status;
	}
	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getStudent_birth() {
		return student_birth;
	}
	public void setStudent_birth(String student_birth) {
		this.student_birth = student_birth;
	}
	public String getStudent_address() {
		return student_address;
	}
	public void setStudent_address(String student_address) {
		this.student_address = student_address;
	}
	public void setApplicant_old(int applicant_old) {
		this.applicant_old = applicant_old;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getApplicant_zipcode() {
		return applicant_zipcode;
	}
	public void setApplicant_zipcode(String applicant_zipcode) {
		this.applicant_zipcode = applicant_zipcode;
	}
	public String getApplicant_address_detail() {
		return applicant_address_detail;
	}
	public void setApplicant_address_detail(String applicant_address_detail) {
		this.applicant_address_detail = applicant_address_detail;
	}
	public String getStudent_zipcode() {
		return student_zipcode;
	}
	public void setStudent_zipcode(String student_zipcode) {
		this.student_zipcode = student_zipcode;
	}
	public String getStudent_address_detail() {
		return student_address_detail;
	}
	public void setStudent_address_detail(String student_address_detail) {
		this.student_address_detail = student_address_detail;
	}
	public String getNum() {
		return num;
	}
	public String getTeach_date() {
		return teach_date;
	}
	public String getTeach_name() {
		return teach_name;
	}
	public String getTeach_stage() {
		return teach_stage;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public void setTeach_date(String teach_date) {
		this.teach_date = teach_date;
	}
	public void setTeach_name(String teach_name) {
		this.teach_name = teach_name;
	}
	public void setTeach_stage(String teach_stage) {
		this.teach_stage = teach_stage;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public Date getCancel_date() {
		return cancel_date;
	}
	public String getCancel_id() {
		return cancel_id;
	}
	public void setCancel_date(Date cancel_date) {
		this.cancel_date = cancel_date;
	}
	public void setCancel_id(String cancel_id) {
		this.cancel_id = cancel_id;
	}
	public int getCert_percent() {
		return cert_percent;
	}
	public void setCert_percent(int cert_percent) {
		this.cert_percent = cert_percent;
	}
	public String getEnd_time() {
		return end_time;
	}
	public String getTeach_status() {
		return teach_status;
	}
	public String getStudent_status() {
		return student_status;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public void setTeach_status(String teach_status) {
		this.teach_status = teach_status;
	}
	public void setStudent_status(String student_status) {
		this.student_status = student_status;
	}
	public int getGroup_idx() {
		return group_idx;
	}
	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getApply_type() {
		return apply_type;
	}

	public void setApply_type(String apply_type) {
		this.apply_type = apply_type;
	}

	public String getPay1_yn() {
		return pay1_yn;
	}

	public void setPay1_yn(String pay1_yn) {
		this.pay1_yn = pay1_yn;
	}

	public String getPay2_yn() {
		return pay2_yn;
	}

	public void setPay2_yn(String pay2_yn) {
		this.pay2_yn = pay2_yn;
	}

	public String getPay3_yn() {
		return pay3_yn;
	}

	public void setPay3_yn(String pay3_yn) {
		this.pay3_yn = pay3_yn;
	}


//	public List<Student> getStudentList() {
//		if(studentList != null) {
//			List<Student> arrayList = new ArrayList<Student>();
//			arrayList.addAll(this.studentList);
//			return arrayList;
//		} else {
//			return null;
//		}
//	}
//
//	public void setStudentList(List<Student> studentList) {
//		if(studentList != null) {
//			this.studentList = new ArrayList<Student>();
//			this.studentList.addAll(studentList);
//		}
//	}


	public List<Student> getStudentList() {
		return studentList;
	}


	public void setStudentList(List<Student> studentList) {
		this.studentList = studentList;
	}

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

	public String getFamily_relation() {
		return family_relation;
	}

	public void setFamily_relation(String family_relation) {
		this.family_relation = family_relation;
	}

	public String getFamily_name() {
		return family_name;
	}

	public void setFamily_name(String family_name) {
		this.family_name = family_name;
	}

	public String getFamily_confirm_yn() {
		return family_confirm_yn;
	}

	public void setFamily_confirm_yn(String family_confirm_yn) {
		this.family_confirm_yn = family_confirm_yn;
	}

	public String getFamily_desc() {
		return family_desc;
	}

	public void setFamily_desc(String family_desc) {
		this.family_desc = family_desc;
	}

	public String getApi_user_id() {
		return api_user_id;
	}

	public void setApi_user_id(String api_user_id) {
		this.api_user_id = api_user_id;
	}

	public String getSearch_start_date() {
		return search_start_date;
	}

	public void setSearch_start_date(String search_start_date) {
		this.search_start_date = search_start_date;
	}

	public String getSearch_end_date() {
		return search_end_date;
	}

	public void setSearch_end_date(String search_end_date) {
		this.search_end_date = search_end_date;
	}


	public String getWeb_id() {
		return web_id;
	}


	public void setWeb_id(String web_id) {
		this.web_id = web_id;
	}


	public String getStudent_family_count() {
		return student_family_count;
	}


	public void setStudent_family_count(String student_family_count) {
		this.student_family_count = student_family_count;
	}

	public String getStudent_age() {
		return student_age;
	}
	
	public void setStudent_age(String student_age) {
		this.student_age = student_age;
	}

	public String getStudent_remark() {
		return student_remark;
	}


	public void setStudent_remark(String student_remark) {
		this.student_remark = student_remark;
	}


	public String getStudent_ban() {
		return student_ban;
	}


	public void setStudent_ban(String student_ban) {
		this.student_ban = student_ban;
	}


	public String getUserNo() {
		return userNo;
	}


	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}


	public Date getFromDate() {
		return fromDate;
	}


	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}


	public Date getToDate() {
		return toDate;
	}


	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}


	public String getStudent_hack_str() {
		return student_hack_str;
	}


	public void setStudent_hack_str(String student_hack_str) {
		this.student_hack_str = student_hack_str;
	}


	public String getFromDateStr() {
		return fromDateStr;
	}


	public void setFromDateStr(String fromDateStr) {
		this.fromDateStr = fromDateStr;
	}


	public String getToDateStr() {
		return toDateStr;
	}


	public void setToDateStr(String toDateStr) {
		this.toDateStr = toDateStr;
	}


	public String getStudent_location_code() {
		return student_location_code;
	}


	public void setStudent_location_code(String student_location_code) {
		this.student_location_code = student_location_code;
	}


	public String getStudent_neis_cd() {
		return student_neis_cd;
	}


	public void setStudent_neis_cd(String student_neis_cd) {
		this.student_neis_cd = student_neis_cd;
	}


	public String getStudent_training_num() {
		return student_training_num;
	}


	public void setStudent_training_num(String student_training_num) {
		this.student_training_num = student_training_num;
	}


	public String getStudent_location_code_str() {
		return student_location_code_str;
	}


	public void setStudent_location_code_str(String student_location_code_str) {
		this.student_location_code_str = student_location_code_str;
	}


	public int getLarge_category_idx() {
		return large_category_idx;
	}


	public void setLarge_category_idx(int large_category_idx) {
		this.large_category_idx = large_category_idx;
	}

	public String getFamily_cell_phone() {
		return family_cell_phone;
	}

	public void setFamily_cell_phone(String family_cell_phone) {
		this.family_cell_phone = family_cell_phone;
	}

	public String getStudent_organization() {
		return student_organization;
	}

	public void setStudent_organization(String student_organization) {
		this.student_organization = student_organization;
	}

	public String getStudent_rank() {
		return student_rank;
	}

	public void setStudent_rank(String student_rank) {
		this.student_rank = student_rank;
	}

	public String getStudent_course_taken_yn() {
		return student_course_taken_yn;
	}

	public void setStudent_course_taken_yn(String student_course_taken_yn) {
		this.student_course_taken_yn = student_course_taken_yn;
	}
	
	public MultipartFile getApply_file() {
		return apply_file;
	}
	
	public void setApply_file(MultipartFile apply_file) {
		this.apply_file = apply_file;
	}
	
	public int getFile_idx() {
		return file_idx;
	}
	
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
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

	public List<Integer> getStudent_idx_arr() {
		return student_idx_arr;
	}

	public void setStudent_idx_arr(List<Integer> student_idx_arr) {
		this.student_idx_arr = student_idx_arr;
	}


	public String getModify_date() {
		return modify_date;
	}


	public String getModify_id() {
		return modify_id;
	}


	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}


	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	
	public String getStudent_password() {
		return student_password;
	}


	public void setStudent_password(String student_password) {
		this.student_password = student_password;
	}

	
	public String getSms_service_yn() {
		return sms_service_yn;
	}

	
	public void setSms_service_yn(String sms_service_yn) {
		this.sms_service_yn = sms_service_yn;
	}

	
	public String getPicture_use_yn() {
		return picture_use_yn;
	}

	
	public void setPicture_use_yn(String picture_use_yn) {
		this.picture_use_yn = picture_use_yn;
	}

	public String getAgree_codes() {
		return agree_codes;
	}

	
	public void setAgree_codes(String agree_codes) {
		this.agree_codes = agree_codes;
	}

}