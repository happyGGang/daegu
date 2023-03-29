package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class UntactBookReservation extends PagingUtils {
	
	private String homepage_id;  //홈페이지ID
	private int locker_number;  //사물함번호
	private int request_number;  //신청번호
	private String member_id;  //신청자ID
	private String member_name;  //신청자명
	private String request_date;  //신청일
	private int locker_password;  //사물함비밀번호
	private String reservation_step;  //대출단계
	private String rec_key;  //대출KEY
	private String manage_code;  //도서관관리구분코드
	private String user_key;  //이용자KEY
	private String reg_no;  //도서등록번호
	private String book_isbn;  //ISBN
	private String book_name;  //도서명
	private String loan_date;  //대출일
	private String cancel_yn;  //대출취소여부
	private String cancel_reason;  //대출취소사유
	private String cancel_id;  //대출취소아이디
	private String cancel_ip;  //대출취소IP
	private String cancel_date;  //대출취소시간
	private String sms_send_yn;  //SMS발송여부
	private String sms_send_date;  //SMS발송일시
	private String round_idx;  //신청회차
	private String shelf_loc_name; //도서 소재
	private String call_no; //청구기호
	
	//코드명
	private String reservation_step_code_name;  //대출단계 코드명
	
	//KLAS 예약상태변경용 변수
	private String loankey;  //예약상태키
	private String reserve_type;  //예약타입
	
	private int[] request_number_arr;  //신청번호_arr
	
	private String before_round_idx;  //이전회차
	private String now_round_idx;  //현재회차
	
	private String start_date;
	private String end_date;
	
	private String adminMessage;
	
	private String admin_member_id;
	
	private int unused_locker_number;
	
	private int unity_loanable_cnt; //통합대출가능권수
	private int unity_loan_cnt;	//통합대출중권수
	private int local_loanable_cnt;	//자관대출가능권수
	private int local_loan_cnt;	//자관대출중권수
	
	public UntactBookReservation() {}

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

	public String getRequest_date() {
		return request_date;
	}

	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}

	public int getLocker_password() {
		return locker_password;
	}

	public void setLocker_password(int locker_password) {
		this.locker_password = locker_password;
	}

	public String getReservation_step() {
		return reservation_step;
	}

	public void setReservation_step(String reservation_step) {
		this.reservation_step = reservation_step;
	}

	public String getRec_key() {
		return rec_key;
	}

	public void setRec_key(String rec_key) {
		this.rec_key = rec_key;
	}

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}

	public String getUser_key() {
		return user_key;
	}

	public void setUser_key(String user_key) {
		this.user_key = user_key;
	}

	public String getReg_no() {
		return reg_no;
	}

	public void setReg_no(String reg_no) {
		this.reg_no = reg_no;
	}

	public String getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(String book_isbn) {
		this.book_isbn = book_isbn;
	}

	public String getBook_name() {
		return book_name;
	}

	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}

	public String getLoan_date() {
		return loan_date;
	}

	public void setLoan_date(String loan_date) {
		this.loan_date = loan_date;
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

	public String getRound_idx() {
		return round_idx;
	}

	public void setRound_idx(String round_idx) {
		this.round_idx = round_idx;
	}

	public int[] getRequest_number_arr() {
		return request_number_arr;
	}

	public void setRequest_number_arr(int[] request_number_arr) {
		this.request_number_arr = request_number_arr;
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

	public String getAdminMessage() {
		return adminMessage;
	}

	public void setAdminMessage(String adminMessage) {
		this.adminMessage = adminMessage;
	}

	public String getAdmin_member_id() {
		return admin_member_id;
	}

	public void setAdmin_member_id(String admin_member_id) {
		this.admin_member_id = admin_member_id;
	}

	public String getLoankey() {
		return loankey;
	}

	public void setLoankey(String loankey) {
		this.loankey = loankey;
	}

	public String getReserve_type() {
		return reserve_type;
	}

	public void setReserve_type(String reserve_type) {
		this.reserve_type = reserve_type;
	}

	public String getReservation_step_code_name() {
		return reservation_step_code_name;
	}

	public void setReservation_step_code_name(String reservation_step_code_name) {
		this.reservation_step_code_name = reservation_step_code_name;
	}

	public String getBefore_round_idx() {
		return before_round_idx;
	}

	public void setBefore_round_idx(String before_round_idx) {
		this.before_round_idx = before_round_idx;
	}

	public String getNow_round_idx() {
		return now_round_idx;
	}

	public void setNow_round_idx(String now_round_idx) {
		this.now_round_idx = now_round_idx;
	}

	public int getUnused_locker_number() {
		return unused_locker_number;
	}

	public void setUnused_locker_number(int unused_locker_number) {
		this.unused_locker_number = unused_locker_number;
	}

	public int getLocal_loanable_cnt() {
		return local_loanable_cnt;
	}

	public void setLocal_loanable_cnt(int local_loanable_cnt) {
		this.local_loanable_cnt = local_loanable_cnt;
	}

	public int getUnity_loan_cnt() {
		return unity_loan_cnt;
	}

	public void setUnity_loan_cnt(int unity_loan_cnt) {
		this.unity_loan_cnt = unity_loan_cnt;
	}

	public int getUnity_loanable_cnt() {
		return unity_loanable_cnt;
	}

	public void setUnity_loanable_cnt(int unity_loanable_cnt) {
		this.unity_loanable_cnt = unity_loanable_cnt;
	}

	public int getLocal_loan_cnt() {
		return local_loan_cnt;
	}

	public void setLocal_loan_cnt(int local_loan_cnt) {
		this.local_loan_cnt = local_loan_cnt;
	}

	public String getShelf_loc_name() {
		return shelf_loc_name;
	}

	public void setShelf_loc_name(String shelf_loc_name) {
		this.shelf_loc_name = shelf_loc_name;
	}

	public String getCall_no() {
		return call_no;
	}

	public void setCall_no(String call_no) {
		this.call_no = call_no;
	}
	
}
