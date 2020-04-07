/**
 *
 */
package kr.go.gbelib.app.cms.module.facilityStudy;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
public class FacilityStudy extends PagingUtils {

	private int study_idx; // 신청IDX
	private int[] study_idx_arr; // 신청IDX_arr
	private int study_num; // 스터디룸번호
	private String study_date; // 사용일자
	private String study_time; // 사용시간
	private String apply_name; // 신청자명
	private String apply_password; // 비밀번호
	private String apply_phone1; // 휴대전화1
	private String apply_phone2; // 휴대전화2
	private String study_name; // 모임명
	private String study_purpose; // 신청목적
	private int man_count; // 남자인원
	private int woman_count; // 여자인원
	private String apply_list; // 참가자명단
	private Date apply_date; // 신청일시
	private String apply_status; // 신청상태 0:대기, 1:승인, 2:이용자취소, 3:관리자취소
	private String cancel_reason; // 취소사유
	private String cancel_txt; // 취소 사

	private String plan_date;// 조회일시

	public int getStudy_idx() {
		return study_idx;
	}

	public void setStudy_idx(int study_idx) {
		this.study_idx = study_idx;
	}

	public int[] getStudy_idx_arr() {
		return study_idx_arr;
	}

	public void setStudy_idx_arr(int[] study_idx_arr) {
		this.study_idx_arr = study_idx_arr;
	}

	public int getStudy_num() {
		return study_num;
	}

	public void setStudy_num(int study_num) {
		this.study_num = study_num;
	}

	public String getStudy_date() {
		return study_date;
	}

	public void setStudy_date(String study_date) {
		this.study_date = study_date;
	}

	public String getStudy_time() {
		return study_time;
	}

	public void setStudy_time(String study_time) {
		this.study_time = study_time;
	}

	public String getApply_name() {
		return apply_name;
	}

	public void setApply_name(String apply_name) {
		this.apply_name = apply_name;
	}

	public String getApply_password() {
		return apply_password;
	}

	public void setApply_password(String apply_password) {
		this.apply_password = apply_password;
	}

	public String getApply_phone1() {
		return apply_phone1;
	}

	public void setApply_phone1(String apply_phone1) {
		this.apply_phone1 = apply_phone1;
	}

	public String getApply_phone2() {
		return apply_phone2;
	}

	public void setApply_phone2(String apply_phone2) {
		this.apply_phone2 = apply_phone2;
	}

	public String getStudy_name() {
		return study_name;
	}

	public void setStudy_name(String study_name) {
		this.study_name = study_name;
	}

	public String getStudy_purpose() {
		return study_purpose;
	}

	public void setStudy_purpose(String study_purpose) {
		this.study_purpose = study_purpose;
	}

	public int getMan_count() {
		return man_count;
	}

	public void setMan_count(int man_count) {
		this.man_count = man_count;
	}

	public int getWoman_count() {
		return woman_count;
	}

	public void setWoman_count(int woman_count) {
		this.woman_count = woman_count;
	}

	public String getApply_list() {
		return apply_list;
	}

	public void setApply_list(String apply_list) {
		this.apply_list = apply_list;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

	public String getApply_status() {
		return apply_status;
	}

	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}

	public String getCancel_reason() {
		return cancel_reason;
	}

	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getCancel_txt() {
		return cancel_txt;
	}

	public void setCancel_txt(String cancel_txt) {
		this.cancel_txt = cancel_txt;
	}

}
