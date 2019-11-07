package kr.co.whalesoft.app.cms.module.calendarManage;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class CalendarManage extends PagingUtils {
	private int cm_idx;  //일정IDX
	private int group_idx;	//그룹IDX
	private int group_idx_tmp;	//그룹IDX임시
	private String start_date;  //시작일자
	private String start_time;  //시작시간
	private String end_date;  //종료일자
	private String end_time;  //종료시간
	private String title;  //제목
	private String contents;  //내용
	private String date_type;  //일정종류
	private String delete_yn;
	private String weekday;
	private List<String> weekdayArr = new ArrayList<String>();
	
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
	private String agency_name;
	private String class_name;
	private int count;
	
	private String mm;
	private String dd;
	private String link_url;
	
	private Date days;
	private Date base_mon;
	private String individual_yn = "N";
	private String individual_yn2 = "N";//임시변수
	private int group_count;
	
	public CalendarManage() {}
	
	public CalendarManage(String homepage_id, String plan_date) {
		this.setHomepage_id(homepage_id);
		this.plan_date = plan_date;
	}
	
	public CalendarManage(String plan_date) {
		this.plan_date = plan_date;
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
	public int getCm_idx() {
		return cm_idx;
	}
	public void setCm_idx(int cm_idx) {
		this.cm_idx = cm_idx;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getAgency_name() {
		return agency_name;
	}
	public void setAgency_name(String agency_name) {
		this.agency_name = agency_name;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public String getDate_type() {
		return date_type;
	}
	public void setDate_type(String date_type) {
		this.date_type = date_type;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
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

	public String getMm() {
		return mm;
	}

	public void setMm(String mm) {
		this.mm = mm;
	}

	public String getDd() {
		return dd;
	}

	public void setDd(String dd) {
		this.dd = dd;
	}

	public String getWeekday() {
		return weekday;
	}

	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	
	public String getLink_url() {
		return link_url;
	}

	
	public void setLink_url(String link_url) {
		this.link_url = link_url;
	}

	
	public Date getDays() {
		return days;
	}

	
	public void setDays(Date days) {
		this.days = days;
	}

	
	public Date getBase_mon() {
		return base_mon;
	}

	
	public void setBase_mon(Date base_mon) {
		this.base_mon = base_mon;
	}

	
	public int getGroup_idx() {
		return group_idx;
	}

	
	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	
	public String getIndividual_yn() {
		return individual_yn;
	}

	
	public void setIndividual_yn(String individual_yn) {
		this.individual_yn = individual_yn;
	}

	
	public List<String> getWeekdayArr() {
		return weekdayArr;
	}

	
	public void setWeekdayArr(List<String> weekdayArr) {
		this.weekdayArr = weekdayArr;
	}

	
	public int getGroup_count() {
		return group_count;
	}

	
	public void setGroup_count(int group_count) {
		this.group_count = group_count;
	}

	
	public String getIndividual_yn2() {
		return individual_yn2;
	}

	
	public void setIndividual_yn2(String individual_yn2) {
		this.individual_yn2 = individual_yn2;
	}

	
	public int getGroup_idx_tmp() {
		return group_idx_tmp;
	}

	
	public void setGroup_idx_tmp(int group_idx_tmp) {
		this.group_idx_tmp = group_idx_tmp;
	}
	
}
