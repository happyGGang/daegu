package kr.go.gbelib.app.cms.module.paymentMember;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PaymentFamilyMember extends PagingUtils {
	//사립도서관 유료 가족회원
	private String homepage_id;  //홈페이지ID
	private int pay_family_member_idx;  //사립회원가족IDX
	private int family_idx;  //가족회원IDX
	private String family_name;  //이름
	private String family_phone;  //연락처
	private String family_tel;  //연락처2
	private String family_birth;  //출생연도
	private String family_sex;  //성별
	private String family_email_address;  //이메일주소
	private String family_etc;  //기타
	private String family_add_id;  //등록ID
	private String family_add_date;  //등록일시
	private String family_add_ip;  //등록IP
	private String family_modify_id;  //수정ID
	private String family_modify_date;  //수정일시
	private String family_delete_id;  //삭제ID
	private String family_delete_date;  //삭제일시
	private String family_delete_ip;  //삭제IP
	private String family_delete_yn;  //삭제여부
	public int getFamily_idx() {
		return family_idx;
	}
	public void setFamily_idx(int family_idx) {
		this.family_idx = family_idx;
	}
	public String getFamily_name() {
		return family_name;
	}
	public void setFamily_name(String family_name) {
		this.family_name = family_name;
	}
	public String getFamily_phone() {
		return family_phone;
	}
	public void setFamily_phone(String family_phone) {
		this.family_phone = family_phone;
	}
	public String getFamily_tel() {
		return family_tel;
	}
	public void setFamily_tel(String family_tel) {
		this.family_tel = family_tel;
	}
	public String getFamily_birth() {
		return family_birth;
	}
	public void setFamily_birth(String family_birth) {
		this.family_birth = family_birth;
	}
	public String getFamily_sex() {
		return family_sex;
	}
	public void setFamily_sex(String family_sex) {
		this.family_sex = family_sex;
	}
	public String getFamily_email_address() {
		return family_email_address;
	}
	public void setFamily_email_address(String family_email_address) {
		this.family_email_address = family_email_address;
	}
	public String getFamily_etc() {
		return family_etc;
	}
	public void setFamily_etc(String family_etc) {
		this.family_etc = family_etc;
	}
	public String getFamily_add_id() {
		return family_add_id;
	}
	public void setFamily_add_id(String family_add_id) {
		this.family_add_id = family_add_id;
	}
	public String getFamily_add_date() {
		return family_add_date;
	}
	public void setFamily_add_date(String family_add_date) {
		this.family_add_date = family_add_date;
	}
	public String getFamily_add_ip() {
		return family_add_ip;
	}
	public void setFamily_add_ip(String family_add_ip) {
		this.family_add_ip = family_add_ip;
	}
	public String getFamily_modify_id() {
		return family_modify_id;
	}
	public void setFamily_modify_id(String family_modify_id) {
		this.family_modify_id = family_modify_id;
	}
	public String getFamily_modify_date() {
		return family_modify_date;
	}
	public void setFamily_modify_date(String family_modify_date) {
		this.family_modify_date = family_modify_date;
	}
	public String getFamily_delete_id() {
		return family_delete_id;
	}
	public void setFamily_delete_id(String family_delete_id) {
		this.family_delete_id = family_delete_id;
	}
	public String getFamily_delete_date() {
		return family_delete_date;
	}
	public void setFamily_delete_date(String family_delete_date) {
		this.family_delete_date = family_delete_date;
	}
	public String getFamily_delete_ip() {
		return family_delete_ip;
	}
	public void setFamily_delete_ip(String family_delete_ip) {
		this.family_delete_ip = family_delete_ip;
	}
	public String getFamily_delete_yn() {
		return family_delete_yn;
	}
	public void setFamily_delete_yn(String family_delete_yn) {
		this.family_delete_yn = family_delete_yn;
	}
	public int getPay_family_member_idx() {
		return pay_family_member_idx;
	}
	public void setPay_family_member_idx(int pay_family_member_idx) {
		this.pay_family_member_idx = pay_family_member_idx;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	
}
