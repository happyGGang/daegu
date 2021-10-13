package kr.go.gbelib.app.cms.module.untactBook.untactBookCancelHistory;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class UntactBookCancelHistory extends PagingUtils {
	
	private String homepage_id;  //홈페이지ID
	private int locker_number;  //사물함번호
	private int request_number;  //신청번호
	private String member_id;  //신청자ID
	private String member_name;  //신청자명
	
	private String cancel_yn;  //대출취소여부
	private String cancel_reason;  //대출취소사유
	private String cancel_id;  //대출취소아이디
	private String cancel_ip;  //대출취소아이피
	private String cancel_date; //대출취소시간
	private String sms_send_yn;  //SMS발송여부
	private String sms_send_date;  //SMS발송일시
	
	private int[] request_number_arr;  //신청번호_arr
	
	private String cancel_start_date;
	private String cancel_end_date;
	
	public UntactBookCancelHistory() {}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getLocker_number() {
		return locker_number;
	}

	public void setLocker_number(int locker_number) {
		this.locker_number = locker_number;
	}

	public int getRequest_number() {
		return request_number;
	}

	public void setRequest_number(int request_number) {
		this.request_number = request_number;
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

	public String getCancel_yn() {
		return cancel_yn;
	}

	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}

	public String getCancel_reason() {
		return cancel_reason;
	}

	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}

	public String getCancel_id() {
		return cancel_id;
	}

	public void setCancel_id(String cancel_id) {
		this.cancel_id = cancel_id;
	}

	public String getCancel_ip() {
		return cancel_ip;
	}

	public void setCancel_ip(String cancel_ip) {
		this.cancel_ip = cancel_ip;
	}

	public String getCancel_date() {
		return cancel_date;
	}

	public void setCancel_date(String cancel_date) {
		this.cancel_date = cancel_date;
	}

	public String getSms_send_yn() {
		return sms_send_yn;
	}

	public void setSms_send_yn(String sms_send_yn) {
		this.sms_send_yn = sms_send_yn;
	}

	public String getSms_send_date() {
		return sms_send_date;
	}

	public void setSms_send_date(String sms_send_date) {
		this.sms_send_date = sms_send_date;
	}

	public int[] getRequest_number_arr() {
		return request_number_arr;
	}

	public void setRequest_number_arr(int[] request_number_arr) {
		this.request_number_arr = request_number_arr;
	}

	public String getCancel_start_date() {
		return cancel_start_date;
	}

	public void setCancel_start_date(String cancel_start_date) {
		this.cancel_start_date = cancel_start_date;
	}

	public String getCancel_end_date() {
		return cancel_end_date;
	}

	public void setCancel_end_date(String cancel_end_date) {
		this.cancel_end_date = cancel_end_date;
	}
	
	
	
}
