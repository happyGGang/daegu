package kr.go.gbelib.app.cms.module.checkInOutSurvey;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class CheckInOutSurvey extends PagingUtils {

	private String homepage_id;  //홈페이지ID
	private int checkinout_survey_idx;  //설문조사IDX
	private String checkinout_survey_name;  //설문조사제목
	private String checkinout_survey_start_date;  //설문조사시작날짜
	private String checkinout_survey_end_date;  //설문조사종료날짜
	private String delete_yn;  //삭제여부
	private String use_yn;  //사용여부
	private String add_date;  //등록일시
	private String add_id;  //등록ID
	private String modify_date;  //수정일시
	private String modify_id;  //수정ID

	private int checkinout_survey_req_count;

	private String checkOut_msg;  //체크아웃 메세지

	public CheckInOutSurvey() {
	}

	public CheckInOutSurvey(String homepage_id, int checkinout_survey_idx) {
		setHomepage_id(homepage_id);
		this.checkinout_survey_idx = checkinout_survey_idx;
	}

	public CheckInOutSurvey(String homepage_id) {
		setHomepage_id(homepage_id);
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

	public String getCheckinout_survey_name() {
		return checkinout_survey_name;
	}

	public void setCheckinout_survey_name(String checkinout_survey_name) {
		this.checkinout_survey_name = checkinout_survey_name;
	}

	public String getCheckinout_survey_start_date() {
		return checkinout_survey_start_date;
	}

	public void setCheckinout_survey_start_date(String checkinout_survey_start_date) {
		this.checkinout_survey_start_date = checkinout_survey_start_date;
	}

	public String getCheckinout_survey_end_date() {
		return checkinout_survey_end_date;
	}

	public void setCheckinout_survey_end_date(String checkinout_survey_end_date) {
		this.checkinout_survey_end_date = checkinout_survey_end_date;
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

	public int getCheckinout_survey_req_count() {
		return checkinout_survey_req_count;
	}

	public void setCheckinout_survey_req_count(int checkinout_survey_req_count) {
		this.checkinout_survey_req_count = checkinout_survey_req_count;
	}

	public String getCheckOut_msg() {
		return checkOut_msg;
	}

	public void setCheckOut_msg(String checkOut_msg) {
		this.checkOut_msg = checkOut_msg;
	}
}
