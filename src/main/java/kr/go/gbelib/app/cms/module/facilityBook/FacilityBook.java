package kr.go.gbelib.app.cms.module.facilityBook;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class FacilityBook extends PagingUtils {

	private int facility_book_idx; // 시설물IDX
	private String apply_name; // 신청자
	private String phone; // 신청자 연락처
	private String phone1;
	private String phone2;
	private String phone3;
	private String sub_phone; // 참여인원 연락처
	private String sub_phone1;
	private String sub_phone2;
	private String sub_phone3;
	private String facility_book_name; // 사용시설
	private String apply_date; // 신청일
	private String apply_time_code; // 이용시간
	private String curcles_name; // 모임명
	private int man_count; // 남자 참여인원
	private int woman_count; // 여자 참여인원
	private String attend_list; // 참가자 명단
	private String apply_status; // 신청상태

	// 휴관일
	private int close_idx;
	private String close_date;
	private String close_time;

	// 공통
	private Date add_date; // 등록일시
	private String add_id; // 등록ID
	private Date modify_date; // 수정일시
	private String modify_id; // 수정ID

	// 달력
	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	private String plan_year;
	private String plan_month;
	private String plan_date;

	public int getFacility_book_idx() {
		return facility_book_idx;
	}

	public void setFacility_book_idx(int facility_book_idx) {
		this.facility_book_idx = facility_book_idx;
	}

	public String getApply_name() {
		return apply_name;
	}

	public void setApply_name(String apply_name) {
		this.apply_name = apply_name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getSub_phone() {
		return sub_phone;
	}

	public void setSub_phone(String sub_phone) {
		this.sub_phone = sub_phone;
	}

	public String getSub_phone1() {
		return sub_phone1;
	}

	public void setSub_phone1(String sub_phone1) {
		this.sub_phone1 = sub_phone1;
	}

	public String getSub_phone2() {
		return sub_phone2;
	}

	public void setSub_phone2(String sub_phone2) {
		this.sub_phone2 = sub_phone2;
	}

	public String getSub_phone3() {
		return sub_phone3;
	}

	public void setSub_phone3(String sub_phone3) {
		this.sub_phone3 = sub_phone3;
	}

	public String getFacility_book_name() {
		return facility_book_name;
	}

	public void setFacility_book_name(String facility_book_name) {
		this.facility_book_name = facility_book_name;
	}

	public String getApply_date() {
		return apply_date;
	}

	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}

	public String getApply_time_code() {
		return apply_time_code;
	}

	public void setApply_time_code(String apply_time_code) {
		this.apply_time_code = apply_time_code;
	}

	public String getCurcles_name() {
		return curcles_name;
	}

	public void setCurcles_name(String curcles_name) {
		this.curcles_name = curcles_name;
	}

	public int getMan_count() {
		return man_count;
	}

	public void setMan_count(int man_count) {
		this.man_count = man_count;
	}

	public int getWoman_count() {
		return woman_count;
	}

	public void setWoman_count(int woman_count) {
		this.woman_count = woman_count;
	}

	public String getAttend_list() {
		return attend_list;
	}

	public void setAttend_list(String attend_list) {
		this.attend_list = attend_list;
	}

	public String getApply_status() {
		return apply_status;
	}

	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}

	public int getClose_idx() {
		return close_idx;
	}

	public void setClose_idx(int close_idx) {
		this.close_idx = close_idx;
	}

	public String getClose_date() {
		return close_date;
	}

	public void setClose_date(String close_date) {
		this.close_date = close_date;
	}

	public String getClose_time() {
		return close_time;
	}

	public void setClose_time(String close_time) {
		this.close_time = close_time;
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

	public String getPlan_year() {
		return plan_year;
	}

	public void setPlan_year(String plan_year) {
		this.plan_year = plan_year;
	}

	public String getPlan_month() {
		return plan_month;
	}

	public void setPlan_month(String plan_month) {
		this.plan_month = plan_month;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

}
