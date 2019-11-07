package kr.co.whalesoft.app.cms.taskManage;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class TaskManage extends PagingUtils {

	private String search_task_idx_list;
	
	private int task_idx;  //업무IDX
	private String dept_name;  //부서
	private String rank_name;  //직급
	private String task_desc;  //업무
	private String phone;  //전화번호
	private String add_date;  //등록일
	private String add_id;  //등록자
	private String mod_date;  //수정일
	private String mod_id;  //수정자
	private int print_seq;
	
	private String manager_name;
	
	private String member_id;
	private String member_name;
	private String manage_type;
	
	private String manage_list;
	
	public TaskManage(){}

	public TaskManage(String homepage_id) {
		setHomepage_id(homepage_id);
	}
	
	public int getTask_idx() {
		return task_idx;
	}

	public void setTask_idx(int task_idx) {
		this.task_idx = task_idx;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public String getRank_name() {
		return rank_name;
	}

	public void setRank_name(String rank_name) {
		this.rank_name = rank_name;
	}

	public String getTask_desc() {
		return task_desc;
	}

	public void setTask_desc(String task_desc) {
		this.task_desc = task_desc;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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

	public String getMod_date() {
		return mod_date;
	}

	public void setMod_date(String mod_date) {
		this.mod_date = mod_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getSearch_task_idx_list() {
		return search_task_idx_list;
	}

	public void setSearch_task_idx_list(String search_task_idx_list) {
		this.search_task_idx_list = search_task_idx_list;
	}

	public String getManage_type() {
		return manage_type;
	}

	public void setManage_type(String manage_type) {
		this.manage_type = manage_type;
	}

	public String getManage_list() {
		return manage_list;
	}

	public void setManage_list(String manage_list) {
		this.manage_list = manage_list;
	}

	public String getManager_name() {
		return manager_name;
	}

	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}
}