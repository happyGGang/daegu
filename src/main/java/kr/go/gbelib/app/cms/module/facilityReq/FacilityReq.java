package kr.go.gbelib.app.cms.module.facilityReq;

import kr.go.gbelib.app.cms.module.facilityEquipment.FacilityEquipment;
import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.List;

public class FacilityReq extends PagingUtils {

	private int facility_idx;  //시설물IDX
	private int facility_req_idx;  //신청IDX
	private String apply_id;  //사용자ID
	private String member_key;  //사용자키
	private String apply_name;  //사용자명
	private String apply_phone;  //폰번호
	private String apply_desc;  //사용목적
	private String apply_status;  //신청상태 , 1 = 신청, 2 = 승인, 3 = 취소
	private String delete_yn;  //삭제여부
	private String add_date;  //등록일
	private String add_id;  //등록자
	private String modify_date;  //수정일
	private String modify_id;  //수정자
	private String self_info_yn = "N";
	
	private String facility_name;
	private String use_date;
	private String start_time;
	private String end_time;
	
	private String apply_phone1;
	private String apply_phone2;
	private String apply_phone3;
	
	private String search_api_type = "WEBID";
	
	private String masking_name;

	private String plan_date;
	
	private String excel_type;
	
	private int isBlackList;

	private String equipment;

	private List<FacilityEquipment> resultList;
	
	public FacilityReq() { }
	
	public FacilityReq(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public FacilityReq(String homepage_id, String plan_date, String excel_type){
		setHomepage_id(homepage_id);
		this.plan_date = plan_date;
		this.excel_type = excel_type;
	}

	public int getFacility_idx() {
		return facility_idx;
	}

	public void setFacility_idx(int facility_idx) {
		this.facility_idx = facility_idx;
	}

	public int getFacility_req_idx() {
		return facility_req_idx;
	}

	public void setFacility_req_idx(int facility_req_idx) {
		this.facility_req_idx = facility_req_idx;
	}

	public String getApply_id() {
		return apply_id;
	}

	public void setApply_id(String apply_id) {
		this.apply_id = apply_id;
	}

	public String getMember_key() {
		return member_key;
	}

	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}

	public String getApply_phone() {
		return apply_phone;
	}

	public void setApply_phone(String apply_phone) {
		this.apply_phone = apply_phone;
		if ( StringUtils.isNotEmpty(apply_phone) ) {
			String[] arr = apply_phone.split("-");	
			if ( arr.length > 0 ) {
				this.apply_phone1 = arr[0];
			}
			if ( arr.length > 1 ) {
				this.apply_phone2 = arr[1];
			}
			if ( arr.length > 2 ) {
				this.apply_phone3 = arr[2];
			}
		}
	}

	public String getApply_desc() {
		return apply_desc;
	}

	public void setApply_desc(String apply_desc) {
		this.apply_desc = apply_desc;
	}

	public String getApply_status() {
		return apply_status;
	}

	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
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

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

	public String getApply_name() {
		return apply_name;
	}

	public void setApply_name(String apply_name) {
		this.apply_name = apply_name;
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

	public String getApply_phone3() {
		return apply_phone3;
	}

	public void setApply_phone3(String apply_phone3) {
		this.apply_phone3 = apply_phone3;
	}

	public String getMasking_name() {
		return masking_name;
	}

	public void setMasking_name(String masking_name) {
		this.masking_name = masking_name;
	}

	public String getUse_date() {
		return use_date;
	}

	public void setUse_date(String use_date) {
		this.use_date = use_date;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getSelf_info_yn() {
		return self_info_yn;
	}

	public void setSelf_info_yn(String self_info_yn) {
		this.self_info_yn = self_info_yn;
	}

	public String getPlan_date() {
		return plan_date;
	}

	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
	}

	public String getExcel_type() {
		return excel_type;
	}

	public void setExcel_type(String excel_type) {
		this.excel_type = excel_type;
	}

	public String getStart_time() {
		return start_time;
	}

	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public int getIsBlackList() {
		return isBlackList;
	}

	public void setIsBlackList(int isBlackList) {
		this.isBlackList = isBlackList;
	}

	public String getEquipment() {
		return equipment;
	}

	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}

	public List<FacilityEquipment> getResultList() {
		return resultList;
	}

	public void setResultList(List<FacilityEquipment> resultList) {
		this.resultList = resultList;
	}
}