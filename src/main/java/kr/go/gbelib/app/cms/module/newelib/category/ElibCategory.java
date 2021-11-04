package kr.go.gbelib.app.cms.module.newelib.category;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class ElibCategory extends PagingUtils {

	private int cate_id;
	private String cate_name;
	private int depth = 1;
	private int display_seq;
	private int parent_id;
	private String parent_name;
	private String type = "EBK";
	private String add_date; // 등록일
	private String add_id;
	private String modify_date;
	private String modify_id;
	private String delete_yn;
	private int cnt;
	private String approved_yn = "Y";

	public ElibCategory() {
	}

	public ElibCategory(int cate_id) {
		this.setCate_id(cate_id);
	}

	public ElibCategory(String type) {
		this.setType(type);
	}

	public ElibCategory(String type, int depth) {
		this.setType(type);
		this.setDepth(depth);
	}

	public ElibCategory(String type, int depth, int parent_id) {
		this.setType(type);
		this.setDepth(depth);
		this.setParent_id(parent_id);
	}

	public int getCate_id() {
		return cate_id;
	}

	public void setCate_id(int cate_id) {
		this.cate_id = cate_id;
	}

	public String getCate_name() {
		return cate_name;
	}

	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getApproved_yn() {
		return approved_yn;
	}

	public void setApproved_yn(String approved_yn) {
		this.approved_yn = approved_yn;
	}

	public String getParent_name() {
		return parent_name;
	}

	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}

}
