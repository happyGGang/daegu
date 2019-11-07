package kr.co.whalesoft.app.cms.deptMng;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class DeptMng extends PagingUtils {

	// 부서관리
	private int dept_idx;
	private String dept_name;
	private int dept_print_seq;
	private int in_cnt;
	private int above_idx;
	private char chart_yn = 'N';
	
	// 업무관리
	private int work_idx;
	private int parent_idx;
	private String position;
	private String worker;
	private String phone;
	private String work_info;
	private int print_seq;
	
	// 공통
	private String add_id;
	private Date add_date;
	private String mod_id;
	private Date mod_date;
	
	private String siteMode;

	public int getDept_idx() {
		return dept_idx;
	}

	public void setDept_idx(int dept_idx) {
		this.dept_idx = dept_idx;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public int getDept_print_seq() {
		return dept_print_seq;
	}

	public void setDept_print_seq(int dept_print_seq) {
		this.dept_print_seq = dept_print_seq;
	}
	
	public int getIn_cnt() {
		return in_cnt;
	}

	public void setIn_cnt(int in_cnt) {
		this.in_cnt = in_cnt;
	}

	public int getAbove_idx() {
		return above_idx;
	}

	public void setAbove_idx(int above_idx) {
		this.above_idx = above_idx;
	}

	public char getChart_yn() {
		return chart_yn;
	}

	public void setChart_yn(char chart_yn) {
		this.chart_yn = chart_yn;
	}

	public int getWork_idx() {
		return work_idx;
	}

	public void setWork_idx(int work_idx) {
		this.work_idx = work_idx;
	}

	public int getParent_idx() {
		return parent_idx;
	}

	public void setParent_idx(int parent_idx) {
		this.parent_idx = parent_idx;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getWorker() {
		return worker;
	}

	public void setWorker(String worker) {
		this.worker = worker;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getWork_info() {
		return work_info;
	}

	public void setWork_info(String work_info) {
		this.work_info = work_info;
	}

	public int getPrint_seq() {
		return print_seq;
	}

	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public Date getMod_date() {
		return mod_date;
	}

	public void setMod_date(Date mod_date) {
		this.mod_date = mod_date;
	}

	public String getSiteMode() {
		return siteMode;
	}

	public void setSiteMode(String siteMode) {
		this.siteMode = siteMode;
	}

}
