package kr.go.gbelib.app.cms.module.teach.teachCode2;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class TeachCode2 extends PagingUtils {

	private int teach_code;
	private String code_name;
	private int depth = 1;
	private int display_seq;
	private int parent_id;
	private String code_type = "";
	private String add_date; // 등록일
	private String add_id;
	private String modify_date;
	private String modify_id;
	private String delete_yn;
	private int cnt;

	public TeachCode2() {
	}

	public TeachCode2(int teach_code) {
		this.setTeach_code(teach_code);
	}

	public TeachCode2(String code_type) {
		this.setCode_type(code_type);
	}

	public TeachCode2(String code_type, int depth) {
		this.setCode_type(code_type);
		this.setDepth(depth);
	}

	public int getTeach_code() {
		return teach_code;
	}

	public void setTeach_code(int teach_code) {
		this.teach_code = teach_code;
	}

	public String getCode_name() {
		return code_name;
	}

	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getDisplay_seq() {
		return display_seq;
	}

	public void setDisplay_seq(int display_seq) {
		this.display_seq = display_seq;
	}

	public int getParent_id() {
		return parent_id;
	}

	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}

	public String getCode_type() {
		return code_type;
	}

	public void setCode_type(String code_type) {
		this.code_type = code_type;
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

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getModify_date() {
		return modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

}
