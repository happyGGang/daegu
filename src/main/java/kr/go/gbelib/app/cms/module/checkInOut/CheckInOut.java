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
	
	private String checkIn_Yn; //체크인유무

	private int borrowCount;

	private int total_count;

	private int cnt;

	private String visit_status; //재방문여부

	private int checkinout_notice_idx;  //공지IDX
	private String checkinout_notice_name;  //공지제목
	private String checkinout_notice_start_date;  //공지시작날짜
	private String checkinout_notice_end_date;  //공지종료날짜
	private String delete_yn;  //삭제여부
	private String use_yn;  //사용여부
	private String add_date;  //등록일시
	private String add_id;  //등록ID
	private String modify_date;  //수정일시
	private String modify_id;  //수정ID

	private String survey_use_yn;	//설문조사 사용유무

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

	public String getCheckIn_Yn() {
		return checkIn_Yn;
	}

	public void setCheckIn_Yn(String checkIn_Yn) {
		this.checkIn_Yn = checkIn_Yn;
	}

	public int getBorrowCount() {
		return borrowCount;
	}

	public void setBorrowCount(int borrowCount) {
		this.borrowCount = borrowCount;
	}

	public int getTotal_count() {
		return total_count;
	}

	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getVisit_status() {
		return visit_status;
	}

	public void setVisit_status(String visit_status) {
		this.visit_status = visit_status;
	}

	public int getCheckinout_notice_idx() {
		return checkinout_notice_idx;
	}

	public void setCheckinout_notice_idx(int checkinout_notice_idx) {
		this.checkinout_notice_idx = checkinout_notice_idx;
	}

	public String getCheckinout_notice_name() {
		return checkinout_notice_name;
	}

	public void setCheckinout_notice_name(String checkinout_notice_name) {
		this.checkinout_notice_name = checkinout_notice_name;
	}

	public String getCheckinout_notice_start_date() {
		return checkinout_notice_start_date;
	}

	public void setCheckinout_notice_start_date(String checkinout_notice_start_date) {
		this.checkinout_notice_start_date = checkinout_notice_start_date;
	}

	public String getCheckinout_notice_end_date() {
		return checkinout_notice_end_date;
	}

	public void setCheckinout_notice_end_date(String checkinout_notice_end_date) {
		this.checkinout_notice_end_date = checkinout_notice_end_date;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getSurvey_use_yn() {
		return survey_use_yn;
	}

	public void setSurvey_use_yn(String survey_use_yn) {
		this.survey_use_yn = survey_use_yn;
	}
}
