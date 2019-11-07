package kr.co.whalesoft.app.cms.libSvcStatistics;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LibSvcStatistics extends PagingUtils {

	private int req_cnt; // 요청(0)
	private int reg_cnt; // 접수(1)
	private int cmp_cnt; // 완료(2)
	private int sum_cnt; // 합계

	private String code_id; // 코드ID
	
	private String start_date; // 시작일자
	private String end_date; // 종료일자
	
	private String loca; // 도서관번호
	private int all_member_cnt;	// 통합회원수
	private int a_member_cnt; // 자관회원수
	private int b_member_cnt; // 준회원수
	private int c_member_cnt;	// 탈퇴회원수
	private int d_member_cnt; // 반입회원
	private int e_member_cnt; // 전환회원
	private int loan_cnt; // 대출권수
	
	private String sum_yn; // 합계여부
	
	public int getReq_cnt() {
		return req_cnt;
	}

	public void setReq_cnt(int req_cnt) {
		this.req_cnt = req_cnt;
	}

	public int getReg_cnt() {
		return reg_cnt;
	}

	public void setReg_cnt(int reg_cnt) {
		this.reg_cnt = reg_cnt;
	}

	public int getCmp_cnt() {
		return cmp_cnt;
	}

	public void setCmp_cnt(int cmp_cnt) {
		this.cmp_cnt = cmp_cnt;
	}

	public int getSum_cnt() {
		return sum_cnt;
	}

	public void setSum_cnt(int sum_cnt) {
		this.sum_cnt = sum_cnt;
	}

	public String getCode_id() {
		return code_id;
	}

	public void setCode_id(String code_id) {
		this.code_id = code_id;
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
	
	

	public String getLoca() {
		return loca;
	}

	public void setLoca(String loca) {
		this.loca = loca;
	}

	public int getAll_member_cnt() {
		return all_member_cnt;
	}

	public void setAll_member_cnt(int all_member_cnt) {
		this.all_member_cnt = all_member_cnt;
	}

	public int getA_member_cnt() {
		return a_member_cnt;
	}

	public void setA_member_cnt(int a_member_cnt) {
		this.a_member_cnt = a_member_cnt;
	}

	public int getB_member_cnt() {
		return b_member_cnt;
	}

	public void setB_member_cnt(int b_member_cnt) {
		this.b_member_cnt = b_member_cnt;
	}

	public int getC_member_cnt() {
		return c_member_cnt;
	}

	public void setC_member_cnt(int c_member_cnt) {
		this.c_member_cnt = c_member_cnt;
	}

	public int getD_member_cnt() {
		return d_member_cnt;
	}

	public void setD_member_cnt(int d_member_cnt) {
		this.d_member_cnt = d_member_cnt;
	}

	public int getE_member_cnt() {
		return e_member_cnt;
	}

	public void setE_member_cnt(int e_member_cnt) {
		this.e_member_cnt = e_member_cnt;
	}

	public int getLoan_cnt() {
		return loan_cnt;
	}

	public void setLoan_cnt(int loan_cnt) {
		this.loan_cnt = loan_cnt;
	}

	public String getSum_yn() {
		return sum_yn;
	}

	public void setSum_yn(String sum_yn) {
		this.sum_yn = sum_yn;
	}

}
