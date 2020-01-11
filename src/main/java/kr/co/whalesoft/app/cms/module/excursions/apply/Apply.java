package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Apply extends PagingUtils {

	private int apply_idx;
	private int excursions_idx;
	private String password;
	private String agency_name;
	private String agency_tel;
	private String agency_tel_1;
	private String agency_tel_2;
	private String agency_tel_3;
	private String agency_address;
	private String applicant_name;
	private String applicant_member_id;
	private String member_key;
	private String applicant_tel;
	private String applicant_tel_1;
	private String applicant_tel_2;
	private String applicant_tel_3;
	private String applicant_email;
	private String age;
	private String guide_name;
	private String guide_tel;
	private String guide_tel_1;
	private String guide_tel_2;
	private String guide_tel_3;
	private String start_date;
	private String start_time;
	private String end_date;
	private String end_time;
	private int personnel;
	private String apply_state;
	private String ip;
	private String remarks;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;
	private String date_type;
	private String code_name;
	private String apply_id;

	private String pageType;

	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	private String plan_date;
	private String plan_day;

	private String search_api_type = "WEBID";

	private String self_info_yn = "N";

	private int isBlackList;

	public int getApply_idx() {
		return apply_idx;
	}

	public void setApply_idx(int apply_idx) {
		this.apply_idx = apply_idx;
	}

	public int getExcursions_idx() {
		return excursions_idx;
	}

	public void setExcursions_idx(int excursions_idx) {
		this.excursions_idx = excursions_idx;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAgency_name() {
		return agency_name;
	}

	public void setAgency_name(String agency_name) {
		this.agency_name = agency_name;
	}

	public String getAgency_tel() {
		return agency_tel;
	}

	public void setAgency_tel(String agency_tel) {
		this.agency_tel = agency_tel;
	}

	public String getAgency_tel_1() {
		return agency_tel_1;
	}

	public void setAgency_tel_1(String agency_tel_1) {
		this.agency_tel_1 = agency_tel_1;
	}

	public String getAgency_tel_2() {
		return agency_tel_2;
	}

	public void setAgency_tel_2(String agency_tel_2) {
		this.agency_tel_2 = agency_tel_2;
	}

	public String getAgency_tel_3() {
		return agency_tel_3;
	}

	public void setAgency_tel_3(String agency_tel_3) {
		this.agency_tel_3 = agency_tel_3;
	}

	public String getAgency_address() {
		return agency_address;
	}

	public void setAgency_address(String agency_address) {
		this.agency_address = agency_address;
	}

	public String getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}

	public String getApplicant_tel() {
		return applicant_tel;
	}

	public void setApplicant_tel(String applicant_tel) {
		this.applicant_tel = applicant_tel;
	}

	public String getApplicant_tel_1() {
		return applicant_tel_1;
	}

	public void setApplicant_tel_1(String applicant_tel_1) {
		this.applicant_tel_1 = applicant_tel_1;
	}

	public String getApplicant_tel_2() {
		return applicant_tel_2;
	}

	public void setApplicant_tel_2(String applicant_tel_2) {
		this.applicant_tel_2 = applicant_tel_2;
	}

	public String getApplicant_tel_3() {
		return applicant_tel_3;
	}

	public void setApplicant_tel_3(String applicant_tel_3) {
		this.applicant_tel_3 = applicant_tel_3;
	}

	public String getApplicant_email() {
		return applicant_email;
	}

	public void setApplicant_email(String applicant_email) {
		this.applicant_email = applicant_email;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGuide_name() {
		return guide_name;
	}

	public void setGuide_name(String guide_name) {
		this.guide_name = guide_name;
	}

	public String getGuide_tel() {
		return guide_tel;
	}

	public void setGuide_tel(String guide_tel) {
		this.guide_tel = guide_tel;
	}

	public String getGuide_tel_1() {
		return guide_tel_1;
	}

	public void setGuide_tel_1(String guide_tel_1) {
		this.guide_tel_1 = guide_tel_1;
	}

	public String getGuide_tel_2() {
		return guide_tel_2;
	}

	public void setGuide_tel_2(String guide_tel_2) {
		this.guide_tel_2 = guide_tel_2;
	}

	public String getGuide_tel_3() {
		return guide_tel_3;
	}

	public void setGuide_tel_3(String guide_tel_3) {
		this.guide_tel_3 = guide_tel_3;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getPersonnel() {
		return personnel;
	}

	public void setPersonnel(int personnel) {
		this.personnel = personnel;
	}

	public String getApply_state() {
		return apply_state;
	}

	public void setApply_state(String apply_state) {
		this.apply_state = apply_state;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public String getSun() {
		return sun;
	}

	public void setSun(String sun) {
		this.sun = sun;
	}

	public String getMon() {
		return mon;
	}

	public void setMon(String mon) {
		this.mon = mon;
	}

	public String getTue() {
		return tue;
	}

	public void setTue(String tue) {
		this.tue = tue;
	}

	public String getWed() {
		return wed;
	}

	public void setWed(String wed) {
		this.wed = wed;
	}

	public String getThu() {
		return thu;
	}

	public void setThu(String thu) {
		this.thu = thu;
	}

	public String getFri() {
		return fri;
	}

	public void setFri(String fri) {
		this.fri = fri;
	}

	public String getSat() {
		return sat;
	}

	public void setSat(String sat) {
		this.sat = sat;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getDate_type() {
		return date_type;
	}

	public void setDate_type(String date_type) {
		this.date_type = date_type;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getApply_id() {
		return apply_id;
	}

	public void setApply_id(String apply_id) {
		this.apply_id = apply_id;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

	public String getApplicant_member_id() {
		return applicant_member_id;
	}

	public void setApplicant_member_id(String applicant_member_id) {
		this.applicant_member_id = applicant_member_id;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
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

	public int getIsBlackList() {
		return isBlackList;
	}

	public void setIsBlackList(int isBlackList) {
		this.isBlackList = isBlackList;
	}


	public String getPlan_day() {
		return plan_day;
	}


	public void setPlan_day(String plan_day) {
		this.plan_day = plan_day;
	}

}
