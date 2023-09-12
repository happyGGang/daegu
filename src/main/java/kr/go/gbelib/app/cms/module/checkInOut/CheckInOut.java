package kr.go.gbelib.app.cms.module.checkInOut;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class CheckInOut extends PagingUtils{

	private int checkInOut_idx; //IDX
	private int[] checkInOut_arr;  //IDX_ARR
	
	private String user_no; //대출자번호
	private String member_id; //ID
	private String member_name; //이름
	private String member_birth; //생년월일
	private String member_sex; //성별
	private String member_area; //지역구
	private String checkIn_time; //체크인 시간
	private String checkOut_time; //체크아웃 시간
	private String checkInOut_time; //이용시간
	
	private String check_type; //체크인 유형
	private String gubun; //체크인 구분
	
	private String start_date; //검색시작시간
	private String end_date; //검색종료시간
	
	private String result_date; //검색종료시간
	private String result_count; //검색종료시간
	
	public int getCheckInOut_idx() {
		return checkInOut_idx;
	}

	public void setCheckInOut_idx(int checkInOut_idx) {
		this.checkInOut_idx = checkInOut_idx;
	}

	public int[] getCheckInOut_arr() {
		return checkInOut_arr;
	}

	public void setCheckInOut_arr(int[] checkInOut_arr) {
		this.checkInOut_arr = checkInOut_arr;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_birth() {
		return member_birth;
	}

	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}

	public String getMember_sex() {
		return member_sex;
	}

	public void setMember_sex(String member_sex) {
		this.member_sex = member_sex;
	}

	public String getMember_area() {
		return member_area;
	}

	public void setMember_area(String member_area) {
		this.member_area = member_area;
	}

	public String getCheckIn_time() {
		return checkIn_time;
	}

	public void setCheckIn_time(String checkIn_time) {
		this.checkIn_time = checkIn_time;
	}

	public String getCheckOut_time() {
		return checkOut_time;
	}

	public void setCheckOut_time(String checkOut_time) {
		this.checkOut_time = checkOut_time;
	}

	public String getCheckInOut_time() {
		return checkInOut_time;
	}

	public void setCheckInOut_time(String checkInOut_time) {
		this.checkInOut_time = checkInOut_time;
	}

	public String getCheck_type() {
		return check_type;
	}

	public void setCheck_type(String check_type) {
		this.check_type = check_type;
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

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getResult_date() {
		return result_date;
	}

	public void setResult_date(String result_date) {
		this.result_date = result_date;
	}

	public String getResult_count() {
		return result_count;
	}

	public void setResult_count(String result_count) {
		this.result_count = result_count;
	}
	
}
