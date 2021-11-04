package kr.go.gbelib.app.cms.module.newelib.member;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class ElibMember extends PagingUtils {

	private int user_idx;
	private String user_dt;
	private String seq_no;
	private String member_id;
	private String library_code;
	private String sex;
	private String birth_day;
	private String lib_code; //도서관부호 6자리
	public ElibMember() { }
	public ElibMember(String member_id) {
		this.member_id = member_id;
	}
	public ElibMember(Member member) {
		this.member_id = member.getMember_id();
		this.seq_no = member.getRec_key();
//		this.library_code = member.getUser_manage_code();
		this.library_code = "10000009";
		this.sex = member.getSex();
		this.birth_day = member.getBirth_day();
	}
	public int getUser_idx() {
		return user_idx;
	}
	public String getUser_dt() {
		return user_dt;
	}
	public String getSeq_no() {
		return seq_no;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setUser_dt(String user_dt) {
		this.user_dt = user_dt;
	}
	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getLibrary_code() {
		return library_code;
	}
	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getLib_code() {
		return lib_code;
	}
	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}
	
}
