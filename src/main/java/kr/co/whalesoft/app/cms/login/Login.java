package kr.co.whalesoft.app.cms.login;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

public class Login {
	
	@NotBlank(message="login.member_id.NotBlank")
	@Size(min=1, max=20,message="login.member_id.Size")
	private String member_id;  //사용자_아이디
	
	@NotBlank(message="login.member_pw.NotBlank")
	@Size(min=1, max=12,message="login.member_pw.Size")
	private String member_pw;  //사용자_비밀번호
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	
	
	
}
