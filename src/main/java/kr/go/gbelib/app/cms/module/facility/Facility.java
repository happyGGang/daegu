package kr.go.gbelib.app.cms.module.facility;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Facility extends PagingUtils implements Cloneable {
	
	private int facility_idx;  //시설물IDX
	private String facility_name;  //시설물명
	private String facility_desc;  //시설물설명
	private String use_date;
	private String start_time;  //사용 시작 시간
	private String end_time;  //사용 종료 시간
	private int limit_count = 1;  //최대 신청인원수
	private String apply_start_date;  //신청 시작일
	private String apply_end_date;  //신청 종료일
	private String apply_start_time;  //신청 시작 시간
	private String apply_end_time;  //신청 종료 시간
	private String use_yn = "Y";  //사용여부
	private String delete_yn;  //삭제여부
	private String add_date;  //등록일
	private String add_id;  //등록자
	private String mod_date;  //수정일
	private String mod_id;  //수정자

	// 등록시에만 사용하는 변수
	private String start_date;  //사용 시작일
	private String end_date;  //사용 종료일
	private String use_day; // 사용 요일 
	//
	
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
	
	private int apply_count;
	private String apply_yn;

	private String excel_type;
	
	public Facility() { }
	
	public Facility(String homepage_id) { 
		setHomepage_id(homepage_id);
	}
	
	public Facility(String homepage_id, int facility_idx) { 
		setHomepage_id(homepage_id);
		this.facility_idx = facility_idx;
	}

	public int getFacility_idx() {
		return facility_idx;
	}

	public void setFacility_idx(int facility_idx) {
		this.facility_idx = facility_idx;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getFacility_desc() {
		return facility_desc;
	}

	public void setFacility_desc(String facility_desc) {
		this.facility_desc = facility_desc;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getLimit_count() {
		return limit_count;
	}

	public void setLimit_count(int limit_count) {
		this.limit_count = limit_count;
	}

	public String getApply_start_date() {
		return apply_start_date;
	}

	public void setApply_start_date(String apply_start_date) {
		this.apply_start_date = apply_start_date;
	}

	public String getApply_end_date() {
		return apply_end_date;
	}

	public void setApply_end_date(String apply_end_date) {
		this.apply_end_date = apply_end_date;
	}

	public String getApply_start_time() {
		return apply_start_time;
	}

	public void setApply_start_time(String apply_start_time) {
		this.apply_start_time = apply_start_time;
	}

	public String getApply_end_time() {
		return apply_end_time;
	}

	public void setApply_end_time(String apply_end_time) {
		this.apply_end_time = apply_end_time;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
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

	public String getUse_day() {
		return use_day;
	}

	public void setUse_day(String use_day) {
		this.use_day = use_day;
	}

	public String getUse_date() {
		return use_date;
	}

	public void setUse_date(String use_date) {
		this.use_date = use_date;
	}
	
	public Facility clone() {
		Facility o = null;
		try {
			o = (Facility) super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return o;
	}

	public int getApply_count() {
		return apply_count;
	}

	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}

	public String getApply_yn() {
		return apply_yn;
	}

	public void setApply_yn(String apply_yn) {
		this.apply_yn = apply_yn;
	}

	public String getExcel_type() {
		return excel_type;
	}

	public void setExcel_type(String excel_type) {
		this.excel_type = excel_type;
	}

}