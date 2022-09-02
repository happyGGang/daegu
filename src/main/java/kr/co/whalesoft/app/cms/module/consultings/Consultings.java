package kr.co.whalesoft.app.cms.module.consultings;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Consultings extends PagingUtils {

	private int consultings_idx;
	private int[] consultings_idx_arr;
	private String date_type;
	private String apply_yn;
	private String start_date;
	private String start_time;
	private String end_date;
	private String end_time;
	private String apply_start_date;
	private String apply_start_time;
	private String apply_end_date;
	private String apply_end_time;
	private int max_apply;
	private String add_id;
	private Date add_date;
	private String modify_id;
	private Date modify_date;
	private String code_name;
	private String weekday;

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

	private int closed_day; // 휴관일 포함여부
	private int apply_count; // 신청자 수
	private String remark;

	private String pageType;

	public Consultings() {
	}

	public Consultings(String homepage_id, int consultings_idx) {
		setHomepage_id(homepage_id);
		this.consultings_idx = consultings_idx;
	}

	public int getConsultings_idx() {
		return consultings_idx;
	}

	public void setConsultings_idx(int consultings_idx) {
		this.consultings_idx = consultings_idx;
	}

	public int[] getConsultings_idx_arr() {
		return consultings_idx_arr;
	}

	public void setConsultings_idx_arr(int[] consultings_idx_arr) {
		this.consultings_idx_arr = consultings_idx_arr;
	}

	public String getDate_type() {
		return date_type;
	}

	public void setDate_type(String date_type) {
		this.date_type = date_type;
	}

	public String getApply_yn() {
		return apply_yn;
	}

	public void setApply_yn(String apply_yn) {
		this.apply_yn = apply_yn;
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

	public String getApply_start_date() {
		return apply_start_date;
	}

	public void setApply_start_date(String apply_start_date) {
		this.apply_start_date = apply_start_date;
	}

	public String getApply_start_time() {
		return apply_start_time;
	}

	public void setApply_start_time(String apply_start_time) {
		this.apply_start_time = apply_start_time;
	}

	public String getApply_end_date() {
		return apply_end_date;
	}

	public void setApply_end_date(String apply_end_date) {
		this.apply_end_date = apply_end_date;
	}

	public String getApply_end_time() {
		return apply_end_time;
	}

	public void setApply_end_time(String apply_end_time) {
		this.apply_end_time = apply_end_time;
	}

	public int getMax_apply() {
		return max_apply;
	}

	public void setMax_apply(int max_apply) {
		this.max_apply = max_apply;
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

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public String getWeekday() {
		return weekday;
	}

	public void setWeekday(String weekday) {
		this.weekday = weekday;
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

	public int getClosed_day() {
		return closed_day;
	}

	public void setClosed_day(int closed_day) {
		this.closed_day = closed_day;
	}

	public int getApply_count() {
		return apply_count;
	}

	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getPageType() {
		return pageType;
	}

	public void setPageType(String pageType) {
		this.pageType = pageType;
	}

}
