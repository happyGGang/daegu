package kr.go.gbelib.app.cms.module.statistics;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ModuleStatistics extends PagingUtils {

	private String module_type;
	
	private String start_date;
	private String end_date;
	
	// 사물함 통계 변수 
	private int locker_pre_idx;
	private String locker_pre_name;
	private String locker_pre_type;
	private int locker_count;
	private int locker_req_count;
	private int locker_use_count;
	
	// 견학 통계 변수
	private int excursion_idx;
	private int excursions_count;
	private int apply_ok_count;

	// 시설물 통계 변수 
	private String facility_name;
	private String use_date;
	private int limit_count;
	private int facility_count;

	// 견학, 시설물 공통변수
	private int apply_count;
	
	// 강좌 통계변수 
	private int group_idx;
	private int category_idx;
	
	public ModuleStatistics() {}
	
	public ModuleStatistics(String homepage_id) {
		setHomepage_id(homepage_id);
	}

	public String getModule_type() {
		return module_type;
	}
	public void setModule_type(String module_type) {
		this.module_type = module_type;
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
	public int getLocker_pre_idx() {
		return locker_pre_idx;
	}
	public void setLocker_pre_idx(int locker_pre_idx) {
		this.locker_pre_idx = locker_pre_idx;
	}
	public String getLocker_pre_name() {
		return locker_pre_name;
	}
	public void setLocker_pre_name(String locker_pre_name) {
		this.locker_pre_name = locker_pre_name;
	}
	public int getLocker_count() {
		return locker_count;
	}
	public void setLocker_count(int locker_count) {
		this.locker_count = locker_count;
	}
	public int getLocker_req_count() {
		return locker_req_count;
	}
	public void setLocker_req_count(int locker_req_count) {
		this.locker_req_count = locker_req_count;
	}
	public int getLocker_use_count() {
		return locker_use_count;
	}
	public void setLocker_use_count(int locker_use_count) {
		this.locker_use_count = locker_use_count;
	}
	public String getLocker_pre_type() {
		return locker_pre_type;
	}
	public void setLocker_pre_type(String locker_pre_type) {
		this.locker_pre_type = locker_pre_type;
	}
	public int getExcursion_idx() {
		return excursion_idx;
	}
	public void setExcursion_idx(int excursion_idx) {
		this.excursion_idx = excursion_idx;
	}
	public int getApply_count() {
		return apply_count;
	}
	public void setApply_count(int apply_count) {
		this.apply_count = apply_count;
	}
	public int getApply_ok_count() {
		return apply_ok_count;
	}
	public void setApply_ok_count(int apply_ok_count) {
		this.apply_ok_count = apply_ok_count;
	}

	public int getExcursions_count() {
		return excursions_count;
	}

	public void setExcursions_count(int excursions_count) {
		this.excursions_count = excursions_count;
	}

	public int getGroup_idx() {
		return group_idx;
	}

	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	public int getCategory_idx() {
		return category_idx;
	}

	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getUse_date() {
		return use_date;
	}

	public void setUse_date(String use_date) {
		this.use_date = use_date;
	}

	public int getLimit_count() {
		return limit_count;
	}

	public void setLimit_count(int limit_count) {
		this.limit_count = limit_count;
	}

	public int getFacility_count() {
		return facility_count;
	}

	public void setFacility_count(int facility_count) {
		this.facility_count = facility_count;
	}
}
