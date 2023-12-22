package kr.go.gbelib.app.cms.module.archive.archiveCategory;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ArchiveCategory extends PagingUtils {
	
	private String large_code; // 대분류코드 (1차 카테고리)
	private String mid_code; // 중분류코드 (2차 카테고리)
	private String small_code; // 소분류코드 (3차 카테고리)
	private String code_name; // 분류명
	private String remark; // 비고
	private int print_seq; // 출력순서
	private Date add_date; // 등록일
	private String add_id; // 등록ID
	private Date modify_date; // 수정일
	private String modify_id; // 수정ID
	private String delete_yn = "N"; //삭제여부
	private Date delete_date; //삭제일
	private String delete_id; //삭제ID
	
	private String tempCode; // 입력용 임시변수 - 코드
	
	public String getLarge_code() {
		return large_code;
	}
	public void setLarge_code(String large_code) {
		this.large_code = large_code;
	}
	public String getMid_code() {
		return mid_code;
	}
	public void setMid_code(String mid_code) {
		this.mid_code = mid_code;
	}
	public String getSmall_code() {
		return small_code;
	}
	public void setSmall_code(String small_code) {
		this.small_code = small_code;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getPrint_seq() {
		return print_seq;
	}
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
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
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
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
	public String getDelete_id() {
		return delete_id;
	}
	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}
	public String getTempCode() {
		return tempCode;
	}
	public void setTempCode(String tempCode) {
		this.tempCode = tempCode;
	}
	
}
