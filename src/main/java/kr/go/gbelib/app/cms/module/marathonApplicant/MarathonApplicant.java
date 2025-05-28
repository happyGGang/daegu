package kr.go.gbelib.app.cms.module.marathonApplicant;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MarathonApplicant extends PagingUtils{
	private String homepage_id; //홈페이지ID
	private int contest_idx; //대회번호
	private int contest_type_idx; //대회종목번호
	private int contest_type_idx_edit; //대회종목번호(모달창)
	private int applicant_idx; //참가번호
	private int[] applicant_idx_arr; //참가번호
	private String member_id; //회원 아이디
	private String member_name; //회원명
	private String age_type; //나이 유형(분류)
	private String school_name; //학교명
	private String school_class_one; //학년
	private String school_class_two; //학년의 반
	private String school_class; //학년, 반
	private String zipcode; //우편번호
	private String address_dong; //행정동
	private String address_one; //주소 (시도 + 시군구 + 읍면 + 도로명)
	private String address_two; //주소 (건물번호 + 동충호 + (법정동, 공동주택명)
	private String telephone; //전화번호
	private String telephone_one; //전화번호 앞자리
	private String telephone_two; //전화번호 중간자리
	private String telephone_three; //전화번호 끝자리
	private String cellphone; //휴대전화번호
	private String cellphone_one; //휴대전화번호 앞자리
	private String cellphone_two; //휴대전화번호 중간자리
	private String cellphone_three; //휴대전화번호 끝자리
	private String email; //이메일
	private String gender = "M"; //성별
	private String birthday; //생년월일
	private String birthday_year = "2000"; //생년월일 년도
	private String birthday_month = "01"; //생년월일 월
	private String birthday_date = "01"; //생년월일 일
	private String contest_type; //대회종목
	private String finish_memorial = "document"; //완주기념품
	private String determination_talk; //각오한마디
	private int process_status; //진행상태
	private Date add_date; //신청일자
	private Date modify_date; //수정일자
	private String modify_id; //수정인
	private Date finish_date; //완주일
	private int read_page_count_total; //누적 쪽수
	private int applicant_idx_modify; //신청자 번호 변경용
	private String del_yn = "N"; //삭제 여부
	private String finish_day; //완주확정일

	private int page_count; //쪽수
	private String contest_name; //대회명
	private int[] contest_type_idx_arr; //대회 종목 번호 배열 (삭제용, 상태 변경용)
	private int[] contest_idx_arr;
	private int contest_type_idx_before; //대회 종목 번호 (수정용)
	private int[] page_count_arr; //목표 페이지 배열 (상태 변경용)
	private int[] read_page_count_total_arr; //읽은 쪽수 배열 (상태 변경용)
	private String selectedType; //이용자 신청 현황 페이지에서 선택된 대회종목
	private char agree; //약관 동의
	private char agree1; //이용약관 동의
	private char agree2; //이용약관 동의
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getContest_idx() {
		return contest_idx;
	}
	public void setContest_idx(int contest_idx) {
		this.contest_idx = contest_idx;
	}
	public int getContest_type_idx() {
		return contest_type_idx;
	}
	public void setContest_type_idx(int contest_type_idx) {
		this.contest_type_idx = contest_type_idx;
	}
	public int getContest_type_idx_edit() {
		return contest_type_idx_edit;
	}
	public void setContest_type_idx_edit(int contest_type_idx_edit) {
		this.contest_type_idx_edit = contest_type_idx_edit;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getAge_type() {
		return age_type;
	}
	public void setAge_type(String age_type) {
		this.age_type = age_type;
	}
	public String getSchool_name() {
		return school_name;
	}
	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}
	public String getSchool_class_one() {
		return school_class_one;
	}
	public void setSchool_class_one(String school_class_one) {
		this.school_class_one = school_class_one;
	}
	public String getSchool_class_two() {
		return school_class_two;
	}
	public void setSchool_class_two(String school_class_two) {
		this.school_class_two = school_class_two;
	}
	public String getSchool_class() {
		return school_class;
	}
	public void setSchool_class(String school_class) {
		this.school_class = school_class;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress_dong() {
		return address_dong;
	}
	public void setAddress_dong(String address_dong) {
		this.address_dong = address_dong;
	}
	public String getAddress_one() {
		return address_one;
	}
	public void setAddress_one(String address_one) {
		this.address_one = address_one;
	}
	public String getAddress_two() {
		return address_two;
	}
	public void setAddress_two(String address_two) {
		this.address_two = address_two;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getTelephone_one() {
		return telephone_one;
	}
	public void setTelephone_one(String telephone_one) {
		this.telephone_one = telephone_one;
	}
	public String getTelephone_two() {
		return telephone_two;
	}
	public void setTelephone_two(String telephone_two) {
		this.telephone_two = telephone_two;
	}
	public String getTelephone_three() {
		return telephone_three;
	}
	public void setTelephone_three(String telephone_three) {
		this.telephone_three = telephone_three;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getCellphone_one() {
		return cellphone_one;
	}
	public void setCellphone_one(String cellphone_one) {
		this.cellphone_one = cellphone_one;
	}
	public String getCellphone_two() {
		return cellphone_two;
	}
	public void setCellphone_two(String cellphone_two) {
		this.cellphone_two = cellphone_two;
	}
	public String getCellphone_three() {
		return cellphone_three;
	}
	public void setCellphone_three(String cellphone_three) {
		this.cellphone_three = cellphone_three;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setApplicant_idx(int applicant_idx) {
		this.applicant_idx = applicant_idx;
	}
	public int[] getApplicant_idx_arr() {
		return applicant_idx_arr;
	}
	public void setApplicant_idx_arr(int[] applicant_idx_arr) {
		this.applicant_idx_arr = applicant_idx_arr;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getBirthday_year() {
		return birthday_year;
	}
	public void setBirthday_year(String birthday_year) {
		this.birthday_year = birthday_year;
	}
	public String getBirthday_month() {
		return birthday_month;
	}
	public void setBirthday_month(String birthday_month) {
		this.birthday_month = birthday_month;
	}
	public String getBirthday_date() {
		return birthday_date;
	}
	public void setBirthday_date(String birthday_date) {
		this.birthday_date = birthday_date;
	}
	public String getContest_type() {
		return contest_type;
	}
	public void setContest_type(String contest_type) {
		this.contest_type = contest_type;
	}
	public String getFinish_memorial() {
		return finish_memorial;
	}
	public void setFinish_memorial(String finish_memorial) {
		this.finish_memorial = finish_memorial;
	}
	public String getDetermination_talk() {
		return determination_talk;
	}
	public void setDetermination_talk(String determination_talk) {
		this.determination_talk = determination_talk;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
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
	public int getApplicant_idx() {
		return applicant_idx;
	}
	public int getProcess_status() {
		return process_status;
	}
	public void setProcess_status(int process_status) {
		this.process_status = process_status;
	}
	public int getPage_count() {
		return page_count;
	}
	public void setPage_count(int page_count) {
		this.page_count = page_count;
	}
	public String getContest_name() {
		return contest_name;
	}
	public void setContest_name(String contest_name) {
		this.contest_name = contest_name;
	}
	public int[] getContest_type_idx_arr() {
		return contest_type_idx_arr;
	}
	public void setContest_type_idx_arr(int[] contest_type_idx_arr) {
		this.contest_type_idx_arr = contest_type_idx_arr;
	}
	public int[] getContest_idx_arr() {
		return contest_idx_arr;
	}
	public void setContest_idx_arr(int[] contest_idx_arr) {
		this.contest_idx_arr = contest_idx_arr;
	}
	public int getContest_type_idx_before() {
		return contest_type_idx_before;
	}
	public void setContest_type_idx_before(int contest_type_idx_before) {
		this.contest_type_idx_before = contest_type_idx_before;
	}
	public int getRead_page_count_total() {
		return read_page_count_total;
	}
	public void setRead_page_count_total(int read_page_count_total) {
		this.read_page_count_total = read_page_count_total;
	}
	public Date getFinish_date() {
		return finish_date;
	}
	public void setFinish_date(Date finish_date) {
		this.finish_date = finish_date;
	}
	public int[] getPage_count_arr() {
		return page_count_arr;
	}
	public void setPage_count_arr(int[] page_count_arr) {
		this.page_count_arr = page_count_arr;
	}
	public int[] getRead_page_count_total_arr() {
		return read_page_count_total_arr;
	}
	public void setRead_page_count_total_arr(int[] read_page_count_total_arr) {
		this.read_page_count_total_arr = read_page_count_total_arr;
	}
	public int getApplicant_idx_modify() {
		return applicant_idx_modify;
	}
	public void setApplicant_idx_modify(int applicant_idx_modify) {
		this.applicant_idx_modify = applicant_idx_modify;
	}
	public String getSelectedType() {
		return selectedType;
	}
	public void setSelectedType(String selectedType) {
		this.selectedType = selectedType;
	}
	public char getAgree() {
		return agree;
	}
	public void setAgree(char agree) {
		this.agree = agree;
	}
	public char getAgree1() {
		return agree1;
	}
	public void setAgree1(char agree1) {
		this.agree1 = agree1;
	}
	public char getAgree2() {
		return agree2;
	}
	public void setAgree2(char agree2) {
		this.agree2 = agree2;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getFinish_day() {
		return finish_day;
	}
	public void setFinish_day(String finish_day) {
		this.finish_day = finish_day;
	}
	
}
