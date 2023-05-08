package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibRaffle;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class NearbyLibRaffle extends PagingUtils {
	
	//추첨 설정용 변수
	private int raffle_idx; //추첨IDX
	private String raffle_name; //추첨명
	private int raffle_count; //추첨 설정 인원
	private int win_count; //당첨 설정 인원
	
	private int raffle_req_count;	//당첨인원
	
	//추첨인원용 변수
	private int raffle_req_idx; //추첨당첨IDX
	private String member_id; //회원ID
	private String name; //이름
	private String member_phone; //회원전화번호
	private String reserve_date; //신청일 
	private String add_id; //등록ID
	private String add_date; //등록일
	private String modify_id; //수정ID
	private String modify_date; //수정일
	
	//검색용 변수
	private String start_date;
	private String end_date;
	
	public int getRaffle_idx() {
		return raffle_idx;
	}
	public void setRaffle_idx(int raffle_idx) {
		this.raffle_idx = raffle_idx;
	}
	public String getRaffle_name() {
		return raffle_name;
	}
	public void setRaffle_name(String raffle_name) {
		this.raffle_name = raffle_name;
	}
	public int getRaffle_count() {
		return raffle_count;
	}
	public void setRaffle_count(int raffle_count) {
		this.raffle_count = raffle_count;
	}
	public int getWin_count() {
		return win_count;
	}
	public void setWin_count(int win_count) {
		this.win_count = win_count;
	}
	public int getRaffle_req_count() {
		return raffle_req_count;
	}
	public void setRaffle_req_count(int raffle_req_count) {
		this.raffle_req_count = raffle_req_count;
	}
	public int getRaffle_req_idx() {
		return raffle_req_idx;
	}
	public void setRaffle_req_idx(int raffle_req_idx) {
		this.raffle_req_idx = raffle_req_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getReserve_date() {
		return reserve_date;
	}
	public void setReserve_date(String reserve_date) {
		this.reserve_date = reserve_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	
}
