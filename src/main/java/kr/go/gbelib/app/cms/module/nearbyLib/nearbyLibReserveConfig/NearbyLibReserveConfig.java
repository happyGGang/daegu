package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class NearbyLibReserveConfig extends PagingUtils{
	private String homepage_id;  //홈페이지ID
	private String manage_code; //도서관관리코드
	private int reserve_config_idx;  //예약설정_지표
	private String day_of_week;  //설정요일
	private String reserve_start_time;  //예약시작시간
	private String reserve_end_time;  //예약종료시간
	private String use_yn;  //버튼노출유무
	private int take_term;  //취거기간
	private int expire_date_cnt;  //예약만기일수
	private String add_id;  //등록ID
	private String add_date;  //등록날짜
	private String modify_id;  //수정ID
	private String modify_date;  //수정날짜
	private String tomorrow_end_day_yn;  //내일종료날짜사용여부
	
	private String member_id; //회원개인 예약 정보 받아오기용 회원아이디
	private int device_idx; //회원개인 예약 정보 받아오기용 기기코드

    private String[] hour = {"00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"};
    private String[] minute = {"00", "10", "20", "30", "40", "50"};
	
	public NearbyLibReserveConfig() {}
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getReserve_config_idx() {
		return reserve_config_idx;
	}
	public void setReserve_config_idx(int reserve_config_idx) {
		this.reserve_config_idx = reserve_config_idx;
	}
	public String getDay_of_week() {
		return day_of_week;
	}
	public void setDay_of_week(String day_of_week) {
		this.day_of_week = day_of_week;
	}
	public String getReserve_start_time() {
		return reserve_start_time;
	}
	public void setReserve_start_time(String reserve_start_time) {
		this.reserve_start_time = reserve_start_time;
	}
	public String getReserve_end_time() {
		return reserve_end_time;
	}
	public void setReserve_end_time(String reserve_end_time) {
		this.reserve_end_time = reserve_end_time;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getTake_term() {
		return take_term;
	}
	public void setTake_term(int take_term) {
		this.take_term = take_term;
	}
	public int getExpire_date_cnt() {
		return expire_date_cnt;
	}
	public void setExpire_date_cnt(int expire_date_cnt) {
		this.expire_date_cnt = expire_date_cnt;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getTomorrow_end_day_yn() {
		return tomorrow_end_day_yn;
	}
	public void setTomorrow_end_day_yn(String tomorrow_end_day_yn) {
		this.tomorrow_end_day_yn = tomorrow_end_day_yn;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getDevice_idx() {
		return device_idx;
	}

	public void setDevice_idx(int device_idx) {
		this.device_idx = device_idx;
	}

	public String[] getHour() {
        return hour;
    }

    public void setHour(String[] hour) {
        this.hour = hour;
    }

	public String[] getMinute() {
		return minute;
	}

	public void setMinute(String[] minute) {
		this.minute = minute;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}
	
}
