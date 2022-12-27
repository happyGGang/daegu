package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author ttkaz
 * 2022. 10. 12.
 *
 */
public class NearbyLibLocker extends PagingUtils  {
	private int device_idx; //장비IDX
	private String device_code; //장비코드
	private String device_name; //장비명
	
	/* 사물함 전체설정 변수 */
	private int row_no; //행갯수
	private int col_no; //열갯수
	private int total_count; //사물함 총 갯수
	
	private String return_machine_yn; //반납기여부
	private int monitor_position; //모니터위치
	private int add_row_no; //추가행갯수 (모니터열에 들어가는)
	
	/* 사물함 개별설정 변수 */
	private int locker_idx; //개별 사물함 INDEX
	private int locker_each_idx; //장비별 사물함 INDEX
	private String use_yn; //사용여부
	private String unused_reason; //미사용사유
	private int row_num;	//사물함 행번호
	private int col_num;	//사물함 열번호
	
	/* 대출예약 사물함 배정 변수 */
	private String reserve_status; //상태값 
	private int reserve_idx; //예약idx
	private int[] reserve_idx_arr; //체크박스용
	
	public int getDevice_idx() {
		return device_idx;
	}
	public void setDevice_idx(int device_idx) {
		this.device_idx = device_idx;
	}
	public int getRow_no() {
		return row_no;
	}
	public void setRow_no(int row_no) {
		this.row_no = row_no;
	}
	public int getCol_no() {
		return col_no;
	}
	public void setCol_no(int col_no) {
		this.col_no = col_no;
	}
	public String getReturn_machine_yn() {
		return return_machine_yn;
	}
	public void setReturn_machine_yn(String return_machine_yn) {
		this.return_machine_yn = return_machine_yn;
	}
	public int getMonitor_position() {
		return monitor_position;
	}
	public void setMonitor_position(int monitor_position) {
		this.monitor_position = monitor_position;
	}
	public int getAdd_row_no() {
		return add_row_no;
	}
	public void setAdd_row_no(int add_row_no) {
		this.add_row_no = add_row_no;
	}
	public int getLocker_idx() {
		return locker_idx;
	}
	public void setLocker_idx(int locker_idx) {
		this.locker_idx = locker_idx;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getUnused_reason() {
		return unused_reason;
	}
	public void setUnused_reason(String unused_reason) {
		this.unused_reason = unused_reason;
	}
	public String getDevice_code() {
		return device_code;
	}
	public void setDevice_code(String device_code) {
		this.device_code = device_code;
	}
	public String getDevice_name() {
		return device_name;
	}
	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getCol_num() {
		return col_num;
	}
	public void setCol_num(int col_num) {
		this.col_num = col_num;
	}
	public int getLocker_each_idx() {
		return locker_each_idx;
	}
	public void setLocker_each_idx(int locker_each_idx) {
		this.locker_each_idx = locker_each_idx;
	}
	public int getTotal_count() {
		return total_count;
	}
	public void setTotal_count(int total_count) {
		this.total_count = total_count;
	}
	public String getReserve_status() {
		return reserve_status;
	}
	public void setReserve_status(String reserve_status) {
		this.reserve_status = reserve_status;
	}
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public int[] getReserve_idx_arr() {
		return reserve_idx_arr;
	}
	public void setReserve_idx_arr(int[] reserve_idx_arr) {
		this.reserve_idx_arr = reserve_idx_arr;
	}
}
