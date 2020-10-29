package kr.go.gbelib.app.cms.module.relayLecture;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class RelayLecture extends PagingUtils {
	
	private String homepage_id;	//홈페이지ID
	private int lecture_idx;	//릴레이강연IDX
	private String event_name;	//행사명
	private String event_start_date;	//행사시작일자
	private String event_end_date;	//행사종료일자
	private String event_place;	//행사장소
	private String event_start_time;	//행사시작시간
	private String event_end_time;	//행사종료시간
	private String apply_start_date;	//신청시작일자
	private String apply_start_time;	//신청시작시간
	private String apply_end_date;	//신청종료일자
	private String apply_end_time;	//신청종료시간
	private int recruitment_number;	//모집인원
	private String conrtents;	//내용
	private String org_file_name;	//원본파일명
	private String server_file_name;	//서버파일명
	private String file_extension;	//파일확장자
	private long file_size;	//파일크기
	private String exposure_status = "Y";	//노출상태
	private String delete_yn = "N";	//삭제여부
	private String add_id;	//등록ID
	private Date add_date;	//등록일
	private String modify_id;	//수정ID
	private Date modify_date;	//수정일
	private String delete_id;	//삭제ID
	private int view_count; // 조회수
	private int apply_status;	//신청가능 상태
	
	private int apply_count;	//신청 수 
	
	public RelayLecture() {}
	
	public RelayLecture(String homepage_id, int lecture_idx) {
		setHomepage_id(homepage_id);
		this.lecture_idx = lecture_idx;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getLecture_idx() {
		return lecture_idx;
	}

	public void setLecture_idx(int lecture_idx) {
		this.lecture_idx = lecture_idx;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public String getEvent_start_date() {
		return event_start_date;
	}

	public void setEvent_start_date(String event_start_date) {
		this.event_start_date = event_start_date;
	}

	public String getEvent_end_date() {
		return event_end_date;
	}

	public void setEvent_end_date(String event_end_date) {
		this.event_end_date = event_end_date;
	}

	public String getEvent_place() {
		return event_place;
	}

	public void setEvent_place(String event_place) {
		this.event_place = event_place;
	}

	public String getEvent_start_time() {
		return event_start_time;
	}

	public void setEvent_start_time(String event_start_time) {
		this.event_start_time = event_start_time;
	}

	public String getEvent_end_time() {
		return event_end_time;
	}

	public void setEvent_end_time(String event_end_time) {
		this.event_end_time = event_end_time;
	}

	public String getApply_start_date() {
		return apply_start_date;
	}

	public void setApply_start_date(String apply_start_date) {
		this.apply_start_date = apply_start_date;
	}

	public String getApply_start_time() {
		return apply_start_time;
	}

	public void setApply_start_time(String apply_start_time) {
		this.apply_start_time = apply_start_time;
	}

	public String getApply_end_date() {
		return apply_end_date;
	}

	public void setApply_end_date(String apply_end_date) {
		this.apply_end_date = apply_end_date;
	}

	public String getApply_end_time() {
		return apply_end_time;
	}

	public void setApply_end_time(String apply_end_time) {
		this.apply_end_time = apply_end_time;
	}

	public int getRecruitment_number() {
		return recruitment_number;
	}

	public void setRecruitment_number(int recruitment_number) {
		this.recruitment_number = recruitment_number;
	}

	public String getConrtents() {
		return conrtents;
	}

	public void setConrtents(String conrtents) {
		this.conrtents = conrtents;
	}

	public String getOrg_file_name() {
		return org_file_name;
	}

	public void setOrg_file_name(String org_file_name) {
		this.org_file_name = org_file_name;
	}

	public String getServer_file_name() {
		return server_file_name;
	}

	public void setServer_file_name(String server_file_name) {
		this.server_file_name = server_file_name;
	}

	public String getFile_extension() {
		return file_extension;
	}

	public void setFile_extension(String file_extension) {
		this.file_extension = file_extension;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getExposure_status() {
		return exposure_status;
	}

	public void setExposure_status(String exposure_status) {
		this.exposure_status = exposure_status;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
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

	public String getDelete_id() {
		return delete_id;
	}

	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}

	public int getApply_count() {
		return apply_count;
	}

	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getApply_status() {
		return apply_status;
	}

	public void setApply_status(int apply_status) {
		this.apply_status = apply_status;
	}
	
}
