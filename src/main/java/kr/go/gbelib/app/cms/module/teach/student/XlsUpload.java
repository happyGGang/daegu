
package kr.go.gbelib.app.cms.module.teach.student;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

/**
 * 엑셀 업로드
 *
 * @author
 */
public class XlsUpload implements Serializable {

	private static final long serialVersionUID = 1L;

	private transient MultipartFile file;

	private int member_id 			= 0;
	private int applicant_name 		= 1;  //신청자명
	private int applicant_birth 	= 2;  //신청자생년월일
	private int applicant_sex 		= 3;  //신청자성별
	private int applicant_zipcode 	= 4;  //신청자우편번호
	private int applicant_address 	= 5;  //신청자주소
	private int applicant_cell_phone = 6;  //신청자폰번호
	private int self_yn             = 7;  //수강생-신청자 동일여부
	private int student_name 		= 8;  //수강생명
	private int student_birth 		= 9;  //수강생생년월일
	private int student_sex 		= 10;  //수강생성별
	private int student_zipcode 	= 11;  //수강생우편번호
	private int student_address 	= 12;  //수강생주소
	private int picture_use_yn      = 13;  //사진 촬영 동의 여부
	private int self_parent_yn      = 14;  //보호자-신청자 동일여부
	private int family_relation		= 15;  //보호자 관계
	private int family_name 		= 16;  //보호자 이름
	private int family_cell_phone	= 17;  //보호자 연락처
	private int sms_service_yn      = 18;  //SMS 수신 동의 여부
	private int family_confirm_yn	= 19;  //보호자 동의 여부
	private int family_desc	= 20;  //보호자 비고
	private int student_family_count	= 21;  //가족인원수
	private int student_school 		= 22;  //수강생학교
	private int student_hack 		= 23;  //수강생학년
	private int student_remark	= 24;  //일반 비고
	private int student_location_code	= 25;  //나이스 지역코드
	private int student_neis_cd	= 26;  //나이스 개인번호
	private int student_training_num	= 27;  //나이스 연수지명번호
	private int student_organization	= 28;  //기관
	private int student_rank			= 29;  //직급
	private int student_course_taken_yn	= 30;  //연수수강여부

//	private int self_info_yn 		= 16;  //개인정보동의여부
//	private int self_yn 			= 7;  //본인수강여부
//	private int student_old 		= 10;  //수강생나이

	private Integer startRow				= 1;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public int getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(int applicant_name) {
		this.applicant_name = applicant_name;
	}

	public int getApplicant_birth() {
		return applicant_birth;
	}

	public void setApplicant_birth(int applicant_birth) {
		this.applicant_birth = applicant_birth;
	}

	public int getApplicant_sex() {
		return applicant_sex;
	}

	public void setApplicant_sex(int applicant_sex) {
		this.applicant_sex = applicant_sex;
	}

	public int getApplicant_zipcode() {
		return applicant_zipcode;
	}

	public void setApplicant_zipcode(int applicant_zipcode) {
		this.applicant_zipcode = applicant_zipcode;
	}

	public int getApplicant_address() {
		return applicant_address;
	}

	public void setApplicant_address(int applicant_address) {
		this.applicant_address = applicant_address;
	}

	public int getApplicant_cell_phone() {
		return applicant_cell_phone;
	}

	public void setApplicant_cell_phone(int applicant_cell_phone) {
		this.applicant_cell_phone = applicant_cell_phone;
	}

	public int getSelf_yn() {
		return self_yn;
	}

	public void setSelf_yn(int self_yn) {
		this.self_yn = self_yn;
	}

	public int getStudent_name() {
		return student_name;
	}

	public void setStudent_name(int student_name) {
		this.student_name = student_name;
	}

	public int getStudent_birth() {
		return student_birth;
	}

	public void setStudent_birth(int student_birth) {
		this.student_birth = student_birth;
	}

//	public int getStudent_old() {
//		return student_old;
//	}
//
//	public void setStudent_old(int student_old) {
//		this.student_old = student_old;
//	}

	public int getStudent_sex() {
		return student_sex;
	}

	public void setStudent_sex(int student_sex) {
		this.student_sex = student_sex;
	}

	public int getStudent_zipcode() {
		return student_zipcode;
	}

	public void setStudent_zipcode(int student_zipcode) {
		this.student_zipcode = student_zipcode;
	}

	public int getStudent_address() {
		return student_address;
	}

	public void setStudent_address(int student_address) {
		this.student_address = student_address;
	}
	
	public int getPicture_use_yn() {
		return picture_use_yn;
	}

	public void setPicture_use_yn(int picture_use_yn) {
		this.picture_use_yn = picture_use_yn;
	}

	public int getStudent_school() {
		return student_school;
	}
	public void setStudent_school(int student_school) {
		this.student_school = student_school;
	}
	public int getStudent_hack() {
		return student_hack;
	}
	public void setStudent_hack(int student_hack) {
		this.student_hack = student_hack;
	}
//	public int getSelf_info_yn() {
//		return self_info_yn;
//	}
//	public void setSelf_info_yn(int self_info_yn) {
//		this.self_info_yn = self_info_yn;
//	}

	public Integer getStartRow() {
		return startRow;
	}
	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public int getMember_id() {
		return member_id;
	}

	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	
	public int getSelf_parent_yn() {
		return self_parent_yn;
	}
	
	public void setSelf_parent_yn(int self_parent_yn) {
		this.self_parent_yn = self_parent_yn;
	}
	
	public int getFamily_relation() {
		return family_relation;
	}

	public void setFamily_relation(int family_relation) {
		this.family_relation = family_relation;
	}

	public int getFamily_name() {
		return family_name;
	}

	public void setFamily_name(int family_name) {
		this.family_name = family_name;
	}

	public int getFamily_confirm_yn() {
		return family_confirm_yn;
	}

	public void setFamily_confirm_yn(int family_confirm_yn) {
		this.family_confirm_yn = family_confirm_yn;
	}


	public int getFamily_desc() {
		return family_desc;
	}


	public void setFamily_desc(int family_desc) {
		this.family_desc = family_desc;
	}


	public int getStudent_remark() {
		return student_remark;
	}


	public void setStudent_remark(int student_remark) {
		this.student_remark = student_remark;
	}


	public int getStudent_location_code() {
		return student_location_code;
	}


	public void setStudent_location_code(int student_location_code) {
		this.student_location_code = student_location_code;
	}


	public int getStudent_neis_cd() {
		return student_neis_cd;
	}


	public void setStudent_neis_cd(int student_neis_cd) {
		this.student_neis_cd = student_neis_cd;
	}


	public int getStudent_training_num() {
		return student_training_num;
	}


	public void setStudent_training_num(int student_training_num) {
		this.student_training_num = student_training_num;
	}

	public int getFamily_cell_phone() {
		return family_cell_phone;
	}

	public void setFamily_cell_phone(int family_cell_phone) {
		this.family_cell_phone = family_cell_phone;
	}
	
	public int getSms_service_yn() {
		return sms_service_yn;
	}
	
	public void setSms_service_yn(int sms_service_yn) {
		this.sms_service_yn = sms_service_yn;
	}

	public int getStudent_organization() {
		return student_organization;
	}

	public void setStudent_organization(int student_organization) {
		this.student_organization = student_organization;
	}

	public int getStudent_rank() {
		return student_rank;
	}

	public void setStudent_rank(int student_rank) {
		this.student_rank = student_rank;
	}

	public int getStudent_course_taken_yn() {
		return student_course_taken_yn;
	}

	public void setStudent_course_taken_yn(int student_course_taken_yn) {
		this.student_course_taken_yn = student_course_taken_yn;
	}


	public int getStudent_family_count() {
		return student_family_count;
	}


	public void setStudent_family_count(int student_family_count) {
		this.student_family_count = student_family_count;
	}

}
