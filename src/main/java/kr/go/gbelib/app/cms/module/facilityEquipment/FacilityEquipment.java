package kr.go.gbelib.app.cms.module.facilityEquipment;

import kr.co.whalesoft.framework.utils.PagingUtils;
import org.apache.commons.lang.StringUtils;

public class FacilityEquipment extends PagingUtils {

	private int facility_idx;  //시설물IDX
	private int equipment_idx;  //시설물IDX
	private String add_date;  //등록일
	private String add_id;  //등록자
	private String modify_date;  //수정일
	private String modify_id;  //수정자
	private String equipment_name;					//장비명
	private String equipment_standard;				//장비규격
	private String equipment_cnt;						//장비갯수

	private String equipment_need_cnt;						//장비필요갯수

	public int getFacility_idx() {
		return facility_idx;
	}

	public void setFacility_idx(int facility_idx) {
		this.facility_idx = facility_idx;
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

	public String getEquipment_name() {
		return equipment_name;
	}

	public void setEquipment_name(String equipment_name) {
		this.equipment_name = equipment_name;
	}

	public String getEquipment_standard() {
		return equipment_standard;
	}

	public void setEquipment_standard(String equipment_standard) {
		this.equipment_standard = equipment_standard;
	}

	public String getEquipment_cnt() {
		return equipment_cnt;
	}

	public void setEquipment_cnt(String equipment_cnt) {
		this.equipment_cnt = equipment_cnt;
	}

	public int getEquipment_idx() {
		return equipment_idx;
	}

	public void setEquipment_idx(int equipment_idx) {
		this.equipment_idx = equipment_idx;
	}

	public String getEquipment_need_cnt() {
		return equipment_need_cnt;
	}

	public void setEquipment_need_cnt(String equipment_need_cnt) {
		this.equipment_need_cnt = equipment_need_cnt;
	}
}