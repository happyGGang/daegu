package kr.go.gbelib.app.cms.module.push;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class Push extends PagingUtils {
	
	private int tid;                      // 푸쉬 키
	private String lib_code;              // 대상도서관(전체시 ALL)
	private String push_type;             // 타입 : (일반텍스트, 긴텍스트, 이미지)
	private String push_msg;              // 푸쉬 메시지(최대 길이 150자 제한)
	private String push_url;              // 푸쉬 링크 URL
	private String push_status;           // 발송타입(0: 발송완료, 1:발송대기, 2: 임시저장, 3:발송실패)
	private String push_reserve_date;     // 발송일자 (YYYYMMDDHI)
	private String push_date;
	private String push_hour;
	private String push_regdate;          // 푸쉬관리 등록일자
	private String push_moddate;          // 푸쉬관리 수정일자
	private String push_reg_id;           // 푸쉬 등록자 ID
	private String push_reg_nm;           // 푸쉬 등록자 이름
	private String push_reg_ip;           // 푸쉬 등록자 IP
	private String push_mod_id;           // 푸쉬 수정자 ID
	private String push_mod_nm;           // 푸쉬 수정자 이름
	private String push_mod_ip;           // 푸쉬 수정자 IP
	private String push_target;			  // 푸쉬 대상 ( 0 = 전체발송 )

	private MultipartFile file;
	
	private String lib_name;
	
	public Push() {}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getLib_code() {
		return lib_code;
	}

	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}

	public String getPush_type() {
		return push_type;
	}

	public void setPush_type(String push_type) {
		this.push_type = push_type;
	}

	public String getPush_msg() {
		return push_msg;
	}

	public void setPush_msg(String push_msg) {
		this.push_msg = push_msg;
	}

	public String getPush_url() {
		return push_url;
	}

	public void setPush_url(String push_url) {
		this.push_url = push_url;
	}

	public String getPush_status() {
		return push_status;
	}

	public void setPush_status(String push_status) {
		this.push_status = push_status;
	}

	public String getPush_reserve_date() {
		return push_reserve_date;
	}

	public void setPush_reserve_date(String push_reserve_date) {
		this.push_reserve_date = push_reserve_date;
		if ( StringUtils.isNotEmpty(push_reserve_date.trim()) ) {
			String[] pattern = {"yyyyMMddHH"};
			Date d = null;
			try {
				d = DateUtils.parseDate(push_reserve_date, pattern);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			SimpleDateFormat sfDate = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat sfHour = new SimpleDateFormat("HH");
			this.push_date = sfDate.format(d);
			this.push_hour = sfHour.format(d);	
		}
	}

	public String getPush_regdate() {
		return push_regdate;
	}

	public void setPush_regdate(String push_regdate) {
		this.push_regdate = push_regdate;
	}

	public String getPush_moddate() {
		return push_moddate;
	}

	public void setPush_moddate(String push_moddate) {
		this.push_moddate = push_moddate;
	}

	public String getPush_reg_id() {
		return push_reg_id;
	}

	public void setPush_reg_id(String push_reg_id) {
		this.push_reg_id = push_reg_id;
	}

	public String getPush_reg_nm() {
		return push_reg_nm;
	}

	public void setPush_reg_nm(String push_reg_nm) {
		this.push_reg_nm = push_reg_nm;
	}

	public String getPush_reg_ip() {
		return push_reg_ip;
	}

	public void setPush_reg_ip(String push_reg_ip) {
		this.push_reg_ip = push_reg_ip;
	}

	public String getPush_mod_id() {
		return push_mod_id;
	}

	public void setPush_mod_id(String push_mod_id) {
		this.push_mod_id = push_mod_id;
	}

	public String getPush_mod_nm() {
		return push_mod_nm;
	}

	public void setPush_mod_nm(String push_mod_nm) {
		this.push_mod_nm = push_mod_nm;
	}

	public String getPush_mod_ip() {
		return push_mod_ip;
	}

	public void setPush_mod_ip(String push_mod_ip) {
		this.push_mod_ip = push_mod_ip;
	}

	public String getPush_date() {
		return push_date;
	}

	public void setPush_date(String push_date) {
		this.push_date = push_date;
	}

	public String getPush_hour() {
		return push_hour;
	}

	public void setPush_hour(String push_hour) {
		this.push_hour = push_hour;
	}

	public String getLib_name() {
		return lib_name;
	}

	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getPush_target() {
		return push_target;
	}

	public void setPush_target(String push_target) {
		this.push_target = push_target;
	}
}
