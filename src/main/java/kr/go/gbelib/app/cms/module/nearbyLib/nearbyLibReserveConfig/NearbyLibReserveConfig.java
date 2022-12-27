package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
public class NearbyLibReserveConfig extends PagingUtils{
	/*예약설정(사용자 대출버튼 노출용)*/
	private int reserve_config_idx; //예약설정IDX
	private String reserve_start_time; //예약시작시간
	private String reserve_end_time; //예약종료시간	
	private String tomorrow_end_day_yn; //다음날종료 사용여부
	private int take_term; //취거기간(도서를 가져가야 할 기간)
	private int expire_date_cnt; //예약만기일수
	private Date add_date; //등록날짜
	private String add_id; //등록ID
	private Date modify_date; //등록날짜
	private String modify_id; //등록ID
	
	
	private String reserve_start_time1;
	private String reserve_start_time2;
	
	private String reserve_end_time1;
	private String reserve_end_time2;
	
	public String getReserve_start_time() {
		return reserve_start_time;
	}
	public void setReserve_start_time(String reserve_start_time) {
		this.reserve_start_time = reserve_start_time;
	}
	public String getReserve_end_time() {
		return reserve_end_time;
	}
	public void setReserve_end_time(String reserve_end_time) {
		this.reserve_end_time = reserve_end_time;
	}
	public int getTake_term() {
		return take_term;
	}
	public void setTake_term(int take_term) {
		this.take_term = take_term;
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
	public String getReserve_start_time1() {
		return reserve_start_time1;
	}
	public void setReserve_start_time1(String reserve_start_time1) {
		this.reserve_start_time1 = reserve_start_time1;
	}
	public String getReserve_start_time2() {
		return reserve_start_time2;
	}
	public void setReserve_start_time2(String reserve_start_time2) {
		this.reserve_start_time2 = reserve_start_time2;
	}
	public String getReserve_end_time1() {
		return reserve_end_time1;
	}
	public void setReserve_end_time1(String reserve_end_time1) {
		this.reserve_end_time1 = reserve_end_time1;
	}
	public String getReserve_end_time2() {
		return reserve_end_time2;
	}
	public void setReserve_end_time2(String reserve_end_time2) {
		this.reserve_end_time2 = reserve_end_time2;
	}
	public int getReserve_config_idx() {
		return reserve_config_idx;
	}
	public void setReserve_config_idx(int reserve_config_idx) {
		this.reserve_config_idx = reserve_config_idx;
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
	public String getTomorrow_end_day_yn() {
		return tomorrow_end_day_yn;
	}
	public void setTomorrow_end_day_yn(String tomorrow_end_day_yn) {
		this.tomorrow_end_day_yn = tomorrow_end_day_yn;
	}
	public int getExpire_date_cnt() {
		return expire_date_cnt;
	}
	public void setExpire_date_cnt(int expire_date_cnt) {
		this.expire_date_cnt = expire_date_cnt;
	}
	
	
}
