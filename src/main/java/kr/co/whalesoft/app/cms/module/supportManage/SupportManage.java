package kr.co.whalesoft.app.cms.module.supportManage;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class SupportManage extends PagingUtils {
	private int support_manage_idx;
	private String start_date;  //신청시작일
	private String end_date;  //신청종료일
	private int limit_req_count;  //신청제한수
	private Date add_date;  //등록일
	private String add_id;  //등록자
	private Date mod_date;  //수정일
	private String mod_id;  //수정자
	private String delete_yn; //삭제여부
	
	private String plan_date;
	private int req_count;
	
	public SupportManage() { }
	
	public SupportManage(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public SupportManage(String homepage_id, String plan_date) {
		setHomepage_id(homepage_id);
		this.setPlan_date(plan_date);
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
	public int getLimit_req_count() {
		return limit_req_count;
	}
	public void setLimit_req_count(int limit_req_count) {
		this.limit_req_count = limit_req_count;
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
	public Date getMod_date() {
		return mod_date;
	}
	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}
	public String getMod_id() {
		return mod_id;
	}
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public int getSupport_manage_idx() {
		return support_manage_idx;
	}

	public void setSupport_manage_idx(int support_manage_idx) {
		this.support_manage_idx = support_manage_idx;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public int getReq_count() {
		return req_count;
	}

	public void setReq_count(int req_count) {
		this.req_count = req_count;
	}
}
