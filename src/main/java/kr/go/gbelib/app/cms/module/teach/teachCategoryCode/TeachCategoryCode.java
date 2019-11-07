package kr.go.gbelib.app.cms.module.teach.teachCategoryCode;

import java.util.Date;

/**
 * 강좌분류코드
 * @author YONGJU
 *
 */
public class TeachCategoryCode {

	private String teach_group_id;  //코드그룹ID
	private String teach_code_id;  //코드ID
	private String teach_code_name;  //코드명
	private String up_teach_code_id;  //상위코드ID
	private String remark;  //비고
	private int print_seq;  //정렬순서
	private Date add_date;  //등록일
	private String add_id;  //등록ID
	private Date modify_date;  //수정일
	private String modify_id;  //수정ID
	
	private String	editMode;

	
	public String getTeach_group_id() {
		return teach_group_id;
	}

	
	public void setTeach_group_id(String teach_group_id) {
		this.teach_group_id = teach_group_id;
	}

	
	public String getTeach_code_id() {
		return teach_code_id;
	}

	
	public void setTeach_code_id(String teach_code_id) {
		this.teach_code_id = teach_code_id;
	}

	
	public String getTeach_code_name() {
		return teach_code_name;
	}

	
	public void setTeach_code_name(String teach_code_name) {
		this.teach_code_name = teach_code_name;
	}

	
	public String getUp_teach_code_id() {
		return up_teach_code_id;
	}

	
	public void setUp_teach_code_id(String up_teach_code_id) {
		this.up_teach_code_id = up_teach_code_id;
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

	
	public String getEditMode() {
		return editMode;
	}

	
	public void setEditMode(String editMode) {
		this.editMode = editMode;
	}
	
}