package kr.go.gbelib.app.cms.module.schoolSupport;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class SchoolSupport extends PagingUtils implements Cloneable {

	private Map<String, Integer> calendar;

	private int support_idx; // 지원IDX
	private String support_status; // 지원상태
	private String area_code; // 지역코드
	private String school_name; // 학교명
	private String support_year; // 지원날짜(년)
	private String support_month; // 지원날짜(월)
	private String support_day; // 지원날짜(일)
	private String support_req_first; // 지원요청1순위
	private String support_req_second; // 지원요청2순위
	private String first_start_date; // 지원요청1순위 시작일
	private String first_end_date; // 지원요청1순위 종료일
	private String second_start_date; // 지원요청2순위 시작일
	private String second_end_date; // 지원요청2순위 종료일
	private String support_req_desc; // 지원요청설명
	private String member_key; // 담당자구분
	private String member_position; // 담당자 직위
	private String member_id;
	private String member_name; // 담당자명
	private String member_phone; // 담당자전화
	private String member_phone1 = "010"; // 담당자전화1
	private String member_phone2; // 담당자전화2
	private String member_phone3; // 담당자전화3
	private String member_cell_phone; // 담당자휴대전화
	private String member_cell_phone1 = "054"; // 담당자휴대전화
	private String member_cell_phone2; // 담당자휴대전화
	private String member_cell_phone3; // 담당자휴대전화
	private int total_book_count; // 총장서수
	private String program_name; // 도서관리 프로그램명
	private int percent; // 자료 전산화현황
	private int parent_count; // 도우미 학부모수
	private int staff_count; // 도우미 도서부원수
	private int manager_count; // 학교도서관 담당자인원
	private String manager_type; // 학교도서관 담당자 구성
	private String add_date; // 등록일
	private String add_id; // 등록자
	private String mod_date; // 수정일
	private String mod_id; // 수정자
	private String delete_yn; // 삭제여부

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
	
	public SchoolSupport() {
	}

	public SchoolSupport(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public int getSupport_idx() {
		return support_idx;
	}

	public void setSupport_idx(int support_idx) {
		this.support_idx = support_idx;
	}

	public String getSupport_status() {
		return support_status;
	}

	public void setSupport_status(String support_status) {
		this.support_status = support_status;
	}

	public String getArea_code() {
		return area_code;
	}

	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getSupport_year() {
		return support_year;
	}

	public void setSupport_year(String support_year) {
		this.support_year = support_year;
	}

	public String getSupport_month() {
		return support_month;
	}

	public void setSupport_month(String support_month) {
		this.support_month = support_month;
	}

	public String getSupport_day() {
		return support_day;
	}

	public void setSupport_day(String support_day) {
		this.support_day = support_day;
	}

	public String getSupport_req_first() {
		return support_req_first;
	}

	public void setSupport_req_first(String support_req_first) {
		this.support_req_first = support_req_first;
	}

	public String getSupport_req_second() {
		return support_req_second;
	}

	public void setSupport_req_second(String support_req_second) {
		this.support_req_second = support_req_second;
	}

	public String getSupport_req_desc() {
		return support_req_desc;
	}

	public void setSupport_req_desc(String support_req_desc) {
		this.support_req_desc = support_req_desc;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
		String[] arr = member_phone.split("-");
		this.member_phone1 = arr[0];
		if(arr.length > 1) {
			this.member_phone2 = arr[1];
		}
		if(arr.length > 2) {
			this.member_phone3 = arr[2];
		}
	}

	public String getMember_cell_phone() {
		return member_cell_phone;
	}

	public void setMember_cell_phone(String member_cell_phone) {
		this.member_cell_phone = member_cell_phone;
		String[] arr = member_cell_phone.split("-");
		this.member_cell_phone1 = arr[0];
		if(arr.length > 1) {
			this.member_cell_phone2 = arr[1];
		}
		if(arr.length > 2) {
			this.member_cell_phone3 = arr[2];
		}
	}

	public int getTotal_book_count() {
		return total_book_count;
	}

	public void setTotal_book_count(int total_book_count) {
		this.total_book_count = total_book_count;
	}

	public String getProgram_name() {
		return program_name;
	}

	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}

	public int getPercent() {
		return percent;
	}

	public void setPercent(int percent) {
		this.percent = percent;
	}

	public int getParent_count() {
		return parent_count;
	}

	public void setParent_count(int parent_count) {
		this.parent_count = parent_count;
	}

	public int getStaff_count() {
		return staff_count;
	}

	public void setStaff_count(int staff_count) {
		this.staff_count = staff_count;
	}

	public int getManager_count() {
		return manager_count;
	}

	public void setManager_count(int manager_count) {
		this.manager_count = manager_count;
	}

	public String getManager_type() {
		return manager_type;
	}

	public void setManager_type(String manager_type) {
		this.manager_type = manager_type;
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

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public Map<String, Integer> getCalendar() {
		return calendar;
	}

	public void setCalendar(Map<String, Integer> calendar) {
		this.calendar = calendar;
	}

	public String getFirst_start_date() {
		return first_start_date;
	}

	public void setFirst_start_date(String first_start_date) {
		this.first_start_date = first_start_date;
	}

	public String getFirst_end_date() {
		return first_end_date;
	}

	public void setFirst_end_date(String first_end_date) {
		this.first_end_date = first_end_date;
	}

	public String getSecond_start_date() {
		return second_start_date;
	}

	public void setSecond_start_date(String second_start_date) {
		this.second_start_date = second_start_date;
	}

	public String getSecond_end_date() {
		return second_end_date;
	}

	public void setSecond_end_date(String second_end_date) {
		this.second_end_date = second_end_date;
	}

	public String getMember_position() {
		return member_position;
	}

	public void setMember_position(String member_position) {
		this.member_position = member_position;
	}

	public String getMember_phone1() {
		return member_phone1;
	}

	public void setMember_phone1(String member_phone1) {
		this.member_phone1 = member_phone1;
	}

	public String getMember_phone2() {
		return member_phone2;
	}

	public void setMember_phone2(String member_phone2) {
		this.member_phone2 = member_phone2;
	}

	public String getMember_phone3() {
		return member_phone3;
	}

	public void setMember_phone3(String member_phone3) {
		this.member_phone3 = member_phone3;
	}

	public String getMember_cell_phone1() {
		return member_cell_phone1;
	}

	public void setMember_cell_phone1(String member_cell_phone1) {
		this.member_cell_phone1 = member_cell_phone1;
	}

	public String getMember_cell_phone2() {
		return member_cell_phone2;
	}

	public void setMember_cell_phone2(String member_cell_phone2) {
		this.member_cell_phone2 = member_cell_phone2;
	}

	public String getMember_cell_phone3() {
		return member_cell_phone3;
	}

	public void setMember_cell_phone3(String member_cell_phone3) {
		this.member_cell_phone3 = member_cell_phone3;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
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

	public void makeCalendar() {
		if(StringUtils.isNotEmpty(this.support_year)) {
			try {
				int year = Integer.parseInt(this.support_year);

				this.calendar = new HashMap<String, Integer>();
				Calendar cal = Calendar.getInstance();
				cal.set(year, 0, 0);
				for(int i = 0; i < 365; i++) {
					cal.add(Calendar.DATE, 1);
					this.calendar.put(String.format("%s_%s", cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DATE)), cal.get(Calendar.DAY_OF_WEEK));
				}
			}
			catch(Exception e) {

			}
		}

	}

	public int getApply_count() {
		return apply_count;
	}

	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}
}