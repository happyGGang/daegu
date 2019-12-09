package kr.go.gbelib.app.cms.module.lasReqConfig;

import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LasReqConfig extends PagingUtils {

	private int las_req_idx; // 기능제한 번호
	private String las_req_code; // 기능제한 코드
	private String loca_code; // 소장처(도서관) 코드
	private String loca_name; // 소장처(도서관)명
	private String sub_loca_code; // 자료실 코드
	private String[] sub_loca_codes; // 자료실 코드리스트
	private String str_date; // 시작날자
	private String end_date; // 종료날짜
	private String str_time; // 시작시간
	private String end_time; // 종료시간
	private String res_msg; // 메세지
	private String use_yn = "N"; // 사용여부

	private String add_date; // 등록날자
	private String add_id; // 등록자
	private String mod_date; // 수정날자
	private String mod_id; // 수정자

	private List<LasReqConfig> las_config_list;
	private int date_chk; // 기간체크	1: 제한기간과 사용여부가 맞는 값, 0: 제한기간과 사용여부가 아닌 값 
	
	public int getLas_req_idx() {
		return las_req_idx;
	}

	public void setLas_req_idx(int las_req_idx) {
		this.las_req_idx = las_req_idx;
	}

	public String getLas_req_code() {
		return las_req_code;
	}

	public void setLas_req_code(String las_req_code) {
		this.las_req_code = las_req_code;
	}

	public String getLoca_code() {
		return loca_code;
	}

	public void setLoca_code(String loca_code) {
		this.loca_code = loca_code;
	}

	public String getLoca_name() {
		return loca_name;
	}

	public void setLoca_name(String loca_name) {
		this.loca_name = loca_name;
	}

	public String getSub_loca_code() {
		return sub_loca_code;
	}

	public void setSub_loca_code(String sub_loca_code) {
		this.sub_loca_code = sub_loca_code;
	}

	public String[] getSub_loca_codes() {
		return sub_loca_codes;
	}

	public void setSub_loca_codes(String[] sub_loca_codes) {
		this.sub_loca_codes = sub_loca_codes;
	}

	public String getStr_date() {
		return str_date;
	}

	public void setStr_date(String str_date) {
		this.str_date = str_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getStr_time() {
		return str_time;
	}

	public void setStr_time(String str_time) {
		this.str_time = str_time;
	}

	public String getEnd_time() {
		return end_time;
	}

	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}

	public String getRes_msg() {
		return res_msg;
	}

	public void setRes_msg(String res_msg) {
		this.res_msg = res_msg;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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

	public int getDate_chk() {
		return date_chk;
	}

	public void setDate_chk(int date_chk) {
		this.date_chk = date_chk;
	}

	public List<LasReqConfig> getLas_config_list() {
		return las_config_list;
	}

	public void setLas_config_list(List<LasReqConfig> las_config_list) {
		this.las_config_list = las_config_list;
	}

}
