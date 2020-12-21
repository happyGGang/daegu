package kr.go.gbelib.app.cms.module.expReservation;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ExpReservation extends PagingUtils{

	private int program_list_idx;  //프로그램목록IDX
	private String program_name;  //프로그램명
	private String member_yn; //정회원전용여부 
	private String reservation_date;  //예약일
	private String reservation_type; //신청 구분
	private String reservation_type_original; //신청 구분 (수정용)
	private String use_time;  //이용시간
	private String notice;  //공지사항
	private String usage_agreement;  //이용동의 안내
	private int total_people;  //총신청인원
	private int enable_number_of_team; //신청 가능 팀수
	private int maximum_people_of_team; //팀당 최대 신청 인원수
	private Date add_date;  //등록일시
	private String add_id;  //등록ID
	private Date modify_date;  //수정일시
	private String modify_id;  //수정ID
	
	
	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;
	private String plan_date;
	private String plan_year;
	private String plan_month;
	
	private int apply_count; //신청 수
	private int apply_people_count; //신청자 수
	
	private String pageType;

	private String from_date;//등록용 from
	private String to_date;//등록용 to
	private int[] weeks;

	public ExpReservation() {}

	public ExpReservation(String homepage_id, int program_list_idx) {
		setHomepage_id(homepage_id);
		this.program_list_idx = program_list_idx;
	}
	public int getProgram_list_idx() {
		return program_list_idx;
	}
	public void setProgram_list_idx(int program_list_idx) {
		this.program_list_idx = program_list_idx;
	}
	public String getProgram_name() {
		return program_name;
	}
	public void setProgram_name(String program_name) {
		this.program_name = program_name;
	}
	public String getMember_yn() {
		return member_yn;
	}
	public void setMember_yn(String member_yn) {
		this.member_yn = member_yn;
	}
	public String getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}
	public String getReservation_type() {
		return reservation_type;
	}
	public void setReservation_type(String reservation_type) {
		this.reservation_type = reservation_type;
	}
	public String getReservation_type_original() {
		return reservation_type_original;
	}
	public void setReservation_type_original(String reservation_type_original) {
		this.reservation_type_original = reservation_type_original;
	}
	public String getUse_time() {
		return use_time;
	}
	public void setUse_time(String use_time) {
		this.use_time = use_time;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getUsage_agreement() {
		return usage_agreement;
	}
	public void setUsage_agreement(String usage_agreement) {
		this.usage_agreement = usage_agreement;
	}
	public int getTotal_people() {
		return total_people;
	}
	public void setTotal_people(int total_people) {
		this.total_people = total_people;
	}
	public int getEnable_number_of_team() {
		return enable_number_of_team;
	}
	public void setEnable_number_of_team(int enable_number_of_team) {
		this.enable_number_of_team = enable_number_of_team;
	}
	public int getMaximum_people_of_team() {
		return maximum_people_of_team;
	}
	public void setMaximum_people_of_team(int maximum_people_of_team) {
		this.maximum_people_of_team = maximum_people_of_team;
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
	public String getPlan_date() {
		return plan_date;
	}
	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
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
	public int getApply_count() {
		return apply_count;
	}
	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	public int[] getWeeks() {
		return weeks;
	}
	public void setWeeks(int[] weeks) {
		this.weeks = weeks;
	}
	public int getApply_people_count() {
		return apply_people_count;
	}
	public void setApply_people_count(int apply_people_count) {
		this.apply_people_count = apply_people_count;
	}
}
