package kr.go.gbelib.app.cms.module.expReservation.expReservationApply;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ExpReservationApply extends PagingUtils{

	private int reservation_idx;	//예약IDX
	private int program_list_idx;	//프로그램목록IDX
	private String member_id;	//사용자ID 
	private String member_name;	//사용자 이름
	private String member_phone;	//사용자 연락처
	private String member_email;	//사용자 이메일
	private int application_people;	//신청인원
	private String reference;	//참조사항
	private Date add_date;	//예약신청일  
	private String usage_agreement_yn = "N";	//이용동의 여부
	private String approve_yn = "N";	//승인 여부
	private String cancel_yn = "N";	//취소 여부
	private Date modify_date;	//수정일시
	private String modify_id;	//수정ID
	private String expApply_id;
	
	private String pageType;

	private String plan_date;
	private String plan_year;
	private String plan_month;
	
	private String member_id_list;
	private String reservation_date;
	private String reservation_type;
	private String member_yn;
	private String search_date;
	private String program_name;
	private String use_time;
	private String notice;
	private String usage_agreement;
	private String homepage_id;
	private int total_people;
	private int totalPeople; //현재까지 총 참여자수
	private int enable_number_of_team;
	private int maximum_people_of_team;
	
	public ExpReservationApply() {};

	public ExpReservationApply(int program_list_idx, String homepage_id) {
		this.program_list_idx = program_list_idx;
		this.homepage_id = homepage_id;
	}
	public int getReservation_idx() {
		return reservation_idx;
	}
	public void setReservation_idx(int reservation_idx) {
		this.reservation_idx = reservation_idx;
	}
	public int getProgram_list_idx() {
		return program_list_idx;
	}
	public void setProgram_list_idx(int program_list_idx) {
		this.program_list_idx = program_list_idx;
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
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public int getApplication_people() {
		return application_people;
	}
	public void setApplication_people(int application_people) {
		this.application_people = application_people;
	}
	public String getReference() {
		return reference;
	}
	public void setReference(String reference) {
		this.reference = reference;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getUsage_agreement_yn() {
		return usage_agreement_yn;
	}
	public void setUsage_agreement_yn(String usage_agreement_yn) {
		this.usage_agreement_yn = usage_agreement_yn;
	}
	public String getApprove_yn() {
		return approve_yn;
	}
	public void setApprove_yn(String approve_yn) {
		this.approve_yn = approve_yn;
	}
	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
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
	public String getExpApply_id() {
		return expApply_id;
	}
	public void setExpApply_id(String expApply_id) {
		this.expApply_id = expApply_id;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
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
	public String getMember_id_list() {
		return member_id_list;
	}
	public void setMember_id_list(String member_id_list) {
		this.member_id_list = member_id_list;
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
	public String getMember_yn() {
		return member_yn;
	}
	public void setMember_yn(String member_yn) {
		this.member_yn = member_yn;
	}
	public String getSearch_date() {
		return search_date;
	}
	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}
	public String getProgram_name() {
		return program_name;
	}
	public void setProgram_name(String program_name) {
		this.program_name = program_name;
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
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getTotal_people() {
		return total_people;
	}
	public void setTotal_people(int total_people) {
		this.total_people = total_people;
	}
	public int getTotalPeople() {
		return totalPeople;
	}
	public void setTotalPeople(int totalPeople) {
		this.totalPeople = totalPeople;
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
}
