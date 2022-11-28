package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */
public class NeighborhoodLibraryDevice extends PagingUtils {
	/*운영장비*/	
	private int device_idx; //장비IDX
	private String device_code; //장비코드
	private String device_name; //장비명
	private String device_place; //장비장소
	private String device_area; //장비위치
	private String link_institution; //연계기관
	private String use_yn; //사용유무
	private Date add_date; //등록날짜
	private String add_id; //등록ID
	private Date modify_date; //수정날짜
	private String modify_id; //수정ID
	private String delete_id; //삭제ID
	private String delete_ip; //삭제IP
	private String delete_yn; //삭제여부
	private Date delete_date; //삭제날짜
	
	private String device_add_yn; //사물함등록유무
	
	
	public int getDevice_idx() {
		return device_idx;
	}
	public void setDevice_idx(int device_idx) {
		this.device_idx = device_idx;
	}
	public String getDevice_name() {
		return device_name;
	}
	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	public String getDevice_place() {
		return device_place;
	}
	public void setDevice_place(String device_place) {
		this.device_place = device_place;
	}
	public String getDevice_area() {
		return device_area;
	}
	public void setDevice_area(String device_area) {
		this.device_area = device_area;
	}
	public String getLink_institution() {
		return link_institution;
	}
	public void setLink_institution(String link_institution) {
		this.link_institution = link_institution;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getDevice_code() {
		return device_code;
	}
	public void setDevice_code(String device_code) {
		this.device_code = device_code;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getDevice_add_yn() {
		return device_add_yn;
	}
	public void setDevice_add_yn(String device_add_yn) {
		this.device_add_yn = device_add_yn;
	}
	public String getDelete_id() {
		return delete_id;
	}
	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public Date getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}
	public String getDelete_ip() {
		return delete_ip;
	}
	public void setDelete_ip(String delete_ip) {
		this.delete_ip = delete_ip;
	}
	
	
}
