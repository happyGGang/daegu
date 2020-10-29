package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class RelayLectureApply extends PagingUtils {
	
	private int lecture_idx;	//릴레이강연IDX
	private int lecture_apply_idx;	//릴레이강연신청IDX
	private String applicant_name;	//신청자 이름
	private String applicant_sex;	//신청자 성별
	private String applicant_age;	//신청자 연령대
	private String applicant_phone;	//신청자 휴대폰
	private String applicant_belong;	//신청자 소속
	private String reception_status = "Y";	//접수상태
	private String add_id;	//등록ID
	private Date add_date;	//등록일
	private String modify_id;	//수정ID
	private Date modify_date;	//수정일

	public int getLecture_idx() {
		return lecture_idx;
	}

	public void setLecture_idx(int lecture_idx) {
		this.lecture_idx = lecture_idx;
	}

	public int getLecture_apply_idx() {
		return lecture_apply_idx;
	}

	public void setLecture_apply_idx(int lecture_apply_idx) {
		this.lecture_apply_idx = lecture_apply_idx;
	}

	public String getApplicant_name() {
		return applicant_name;
	}

	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}

	public String getApplicant_sex() {
		return applicant_sex;
	}

	public void setApplicant_sex(String applicant_sex) {
		this.applicant_sex = applicant_sex;
	}

	public String getApplicant_age() {
		return applicant_age;
	}

	public void setApplicant_age(String applicant_age) {
		this.applicant_age = applicant_age;
	}

	public String getApplicant_phone() {
		return applicant_phone;
	}

	public void setApplicant_phone(String applicant_phone) {
		this.applicant_phone = applicant_phone;
	}

	public String getApplicant_belong() {
		return applicant_belong;
	}

	public void setApplicant_belong(String applicant_belong) {
		this.applicant_belong = applicant_belong;
	}

	public String getReception_status() {
		return reception_status;
	}

	public void setReception_status(String reception_status) {
		this.reception_status = reception_status;
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

}
