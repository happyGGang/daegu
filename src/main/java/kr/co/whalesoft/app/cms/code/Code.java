package kr.co.whalesoft.app.cms.code;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Code extends PagingUtils {

	private List<String> code_id_list; //코드ID_LIST
	private String parent_group_id; //부모코드그룹ID
	private String group_id; //코드그룹ID
	private String group_name; //코드그룹명
	private String remark; //비고
	private String code_id; //코드ID
	private String code_name; // 코드명
	private String use_yn; //사용여부
	private int print_seq; //정렬순서
	private String large_div;
	private String homepage_yn = "Y";
	private Date add_date;
	private Date modify_date;
	private String add_id;
	private String modify_id;
	private boolean	load_on_demand; //tree폴더 여부

	private String mode;

	public Code() {}
	public Code(String mode, String homepage_id) {
		this.mode = mode;
		if ("CMS".equals(mode)) {
			homepage_id = "CMS";
		}
		setHomepage_id(homepage_id);
	}

	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCode_id() {
		return code_id;
	}
	public void setCode_id(String code_id) {
		this.code_id = code_id;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public int getPrint_seq() {
		return print_seq;
	}
	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}
	public boolean isLoad_on_demand() {
		return load_on_demand;
	}
	public void setLoad_on_demand(boolean load_on_demand) {
		this.load_on_demand = load_on_demand;
	}
	public String getParent_group_id() {
		return parent_group_id;
	}
	public void setParent_group_id(String parent_group_id) {
		this.parent_group_id = parent_group_id;
	}
	public List<String> getCode_id_list() {
		if(code_id_list != null) {
			List<String> arrayList = new ArrayList<String>();
			arrayList.addAll(this.code_id_list);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setCode_id_list(List<String> code_id_list) {
		if(code_id_list != null) {
			this.code_id_list = new ArrayList<String>();
			this.code_id_list.addAll(code_id_list);
		}
	}
	public String getLarge_div() {
		return large_div;
	}
	public void setLarge_div(String large_div) {
		this.large_div = large_div;
	}
	public String getHomepage_yn() {
		return homepage_yn;
	}
	public void setHomepage_yn(String homepage_yn) {
		this.homepage_yn = homepage_yn;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}

}