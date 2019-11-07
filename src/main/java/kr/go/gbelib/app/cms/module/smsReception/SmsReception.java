package kr.go.gbelib.app.cms.module.smsReception;

import java.sql.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class SmsReception extends PagingUtils {

	private int reception_idx; // 수신여부IDX
	private String reception_name; // 수신자 이름
	private String reception_phone; // 수신자 연락처
	private String add_id; // 등록자
	private Date add_date; // 등록일
	private String mod_id; // 수정자
	private Date mod_date; // 수정일

	private int work_idx; // 수신업무IDX
	private String work_code; // 업무코드
	private String reception_yn; // 수신여부
	
	private List<SmsReception> reception_list;

	public int getReception_idx() {
		return reception_idx;
	}

	public void setReception_idx(int reception_idx) {
		this.reception_idx = reception_idx;
	}

	public String getReception_name() {
		return reception_name;
	}

	public void setReception_name(String reception_name) {
		this.reception_name = reception_name;
	}

	public String getReception_phone() {
		return reception_phone;
	}

	public void setReception_phone(String reception_phone) {
		this.reception_phone = reception_phone;
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

	public int getWork_idx() {
		return work_idx;
	}

	public void setWork_idx(int work_idx) {
		this.work_idx = work_idx;
	}

	public String getWork_code() {
		return work_code;
	}

	public void setWork_code(String work_code) {
		this.work_code = work_code;
	}

	public String getReception_yn() {
		return reception_yn;
	}

	public void setReception_yn(String reception_yn) {
		this.reception_yn = reception_yn;
	}

	public List<SmsReception> getReception_list() {
		return reception_list;
	}

	public void setReception_list(List<SmsReception> reception_list) {
		this.reception_list = reception_list;
	}


}
