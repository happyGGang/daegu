package kr.co.whalesoft.app.cms.organization;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Organization extends PagingUtils {

	// 부서관리
	private int organization_idx; // 부서IDX
	private String organization_name; // 부서명
	private int above_idx; // 상위부서IDX
	private int in_cnt; // 그룹 개수
	private char chart_yn = 'N'; // 차트 사용여부

	// 업무관리
	private int organization_work_idx; // 업무IDX
	private String position; // 직위
	private String worker; // 담당자
	private String phone; // 전화번호
	private String work_info; // 업무내용

	// 직렬
	private int division_idx;  // 직렬IDX
	private String division_name; // 직렬명
	private int column_cnt; // colspan

	// 조직현황
	private int status_idx; // 현황 IDX
	private String rating = "-"; // 급수
	private int max_cnt; // 최대인원
	private int current_cnt; // 현재인원

	// 공통
	private int print_seq; // 출력순서
	private String add_id; // 등록ID
	private Date add_date; // 등록일시
	private String modify_id; // 수정ID
	private Date modify_date; // 수정일시

	public int getOrganization_idx() {
		return organization_idx;
	}

	public void setOrganization_idx(int organization_idx) {
		this.organization_idx = organization_idx;
	}

	public String getOrganization_name() {
		return organization_name;
	}

	public void setOrganization_name(String organization_name) {
		this.organization_name = organization_name;
	}

	public int getAbove_idx() {
		return above_idx;
	}

	public void setAbove_idx(int above_idx) {
		this.above_idx = above_idx;
	}

	public int getIn_cnt() {
		return in_cnt;
	}

	public void setIn_cnt(int in_cnt) {
		this.in_cnt = in_cnt;
	}

	public char getChart_yn() {
		return chart_yn;
	}

	public void setChart_yn(char chart_yn) {
		this.chart_yn = chart_yn;
	}

	public int getOrganization_work_idx() {
		return organization_work_idx;
	}

	public void setOrganization_work_idx(int organization_work_idx) {
		this.organization_work_idx = organization_work_idx;
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

	public int getDivision_idx() {
		return division_idx;
	}

	public void setDivision_idx(int division_idx) {
		this.division_idx = division_idx;
	}

	public String getDivision_name() {
		return division_name;
	}

	public void setDivision_name(String division_name) {
		this.division_name = division_name;
	}

	public int getColumn_cnt() {
		return column_cnt;
	}

	public void setColumn_cnt(int column_cnt) {
		this.column_cnt = column_cnt;
	}

	public int getStatus_idx() {
		return status_idx;
	}

	public void setStatus_idx(int status_idx) {
		this.status_idx = status_idx;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public int getMax_cnt() {
		return max_cnt;
	}

	public void setMax_cnt(int max_cnt) {
		this.max_cnt = max_cnt;
	}

	public int getCurrent_cnt() {
		return current_cnt;
	}

	public void setCurrent_cnt(int current_cnt) {
		this.current_cnt = current_cnt;
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

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

}
