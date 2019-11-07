package kr.go.gbelib.app.cms.module.elib.member;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class ElibMember extends PagingUtils {

	private int user_idx;
	private String user_id;
	private String user_pw;
	private String user_name;
	private int user_level;
	private String user_dt;
	private int library_idx;
	private String user_birthd;
	private String seq_no;
	private String p_id;
	private String member_id;
	private String library_code;
	private String sex;
	private String birth_day;
	public ElibMember() { }
	public ElibMember(String user_id) {
		this.user_id = user_id;
	}
	public ElibMember(Member member) {
		this.member_id = member.getWeb_id();
		this.seq_no = member.getSeq_no();
		this.library_code = member.getLoca();
		this.p_id = member.getUser_no();
		this.sex = member.getSex();
		this.birth_day = member.getBirth_day();
	}
	public int getUser_idx() {
		return user_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public int getUser_level() {
		return user_level;
	}
	public String getUser_dt() {
		return user_dt;
	}
	public int getLibrary_idx() {
		return library_idx;
	}
	public String getUser_birthd() {
		return user_birthd;
	}
	public String getSeq_no() {
		return seq_no;
	}
	public String getP_id() {
		return p_id;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public void setUser_level(int user_level) {
		this.user_level = user_level;
	}
	public void setUser_dt(String user_dt) {
		this.user_dt = user_dt;
	}
	public void setLibrary_idx(int library_idx) {
		this.library_idx = library_idx;
	}
	public void setUser_birthd(String user_birthd) {
		this.user_birthd = user_birthd;
	}
	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	}
	public void setP_id(String p_id) {
		this.p_id = p_id;
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
	
}
