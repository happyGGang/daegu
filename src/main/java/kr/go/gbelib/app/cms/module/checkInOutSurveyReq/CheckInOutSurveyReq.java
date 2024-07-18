package kr.go.gbelib.app.cms.module.checkInOutSurveyReq;

import kr.co.whalesoft.framework.utils.PagingUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Calendar;

public class CheckInOutSurveyReq extends PagingUtils {

	private String homepage_id;  //홈페이지ID
	private int checkinout_survey_idx;  //설문조사IDX
	private int checkinout_survey_req_idx;  //설문조사신청IDX
	private String checkinout_survey_answer;  //설문조사신청답변
	private String member_age;  //등록자 연령
	private String member_sex;  //등록자 성별
	private String add_date;  //등록일시

	private String checkOut_msg;  //체크아웃 메세지
	private int req_count;  //설문조사신청횟수

	private String start_date; //검색시작시간
	private String end_date; //검색종료시간

	public CheckInOutSurveyReq() {
	}
	
	public CheckInOutSurveyReq(String homepage_id, int checkinout_survey_idx) {
		setHomepage_id(homepage_id);
		this.checkinout_survey_idx = checkinout_survey_idx;
	}

	@Override
	public String getHomepage_id() {
		return homepage_id;
	}

	@Override
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getCheckinout_survey_idx() {
		return checkinout_survey_idx;
	}

	public void setCheckinout_survey_idx(int checkinout_survey_idx) {
		this.checkinout_survey_idx = checkinout_survey_idx;
	}

	public int getCheckinout_survey_req_idx() {
		return checkinout_survey_req_idx;
	}

	public void setCheckinout_survey_req_idx(int checkinout_survey_req_idx) {
		this.checkinout_survey_req_idx = checkinout_survey_req_idx;
	}

	public String getCheckinout_survey_answer() {
		return checkinout_survey_answer;
	}

	public void setCheckinout_survey_answer(String checkinout_survey_answer) {
		this.checkinout_survey_answer = checkinout_survey_answer;
	}

	public String getAdd_date() {
		return add_date;
	}

	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}

	public String getMember_age() {
		return member_age;
	}

	public void setMember_age(String member_age) {
		this.member_age = member_age;
	}

	public String getMember_sex() {
		return member_sex;
	}

	public void setMember_sex(String member_sex) {
		this.member_sex = member_sex;
	}

	public String getCheckOut_msg() {
		return checkOut_msg;
	}

	public void setCheckOut_msg(String checkOut_msg) {
		this.checkOut_msg = checkOut_msg;
	}

	public int getReq_count() {
		return req_count;
	}

	public void setReq_count(int req_count) {
		this.req_count = req_count;
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
}
