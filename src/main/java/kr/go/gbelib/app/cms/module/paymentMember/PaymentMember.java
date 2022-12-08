package kr.go.gbelib.app.cms.module.paymentMember;

import java.util.ArrayList;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class PaymentMember extends PagingUtils {
	
	//사립도서관 유료회원
	private String homepage_id;  //홈페이지ID
	private int pay_member_idx;  //사립회원IDX
	private int pay_family_member_idx;  //사립회원가족IDX
	private String pay_member_name;  //이름
	private String phone;  //연락처
	private String phone1;  //연락처
	private String phone2;  //연락처
	private String phone3;  //연락처
	private String tel;  //연락처2
	private String tel1;  //연락처2
	private String tel2;  //연락처2
	private String tel3;  //연락처2
	private int loan_number;  //대출번호
	private String birth;  //출생연도
	private String join_start_date;  //가입시작일
	private String join_end_date;  //가입종료일
	private String use_type;  //이용구분
	private String use_type1;  //이용구분
	private String use_type2;  //이용구분
	private String use_type3;  //이용구분
	private String sex;  //성별
	private String sponsorship_amount;  //금액
	private String approve_yn;  //승인여부
	private String add_id;  //등록ID
	private String add_date;  //등록일시
	private String add_ip;  //등록IP
	private String modify_id;  //수정ID
	private String modify_date;  //수정일시
	private String delete_id;  //삭제ID
	private String delete_date;  //삭제일시
	private String delete_ip;  //삭제IP
	private String delete_yn;  //삭제여부
	private String etc;  //기타
	private String email_address;  //이메일주소
	private String email1;  //이메일
	private String email2;  //이메일
	private String family_yn;  //가족이용자여부
	
	//사립도서관 유료 가족회원
	private int family_idx;  //가족회원IDX
	private String family_name;  //이름
	private String family_phone;  //연락처
	private String family_phone1;  //연락처
	private String family_phone2;  //연락처
	private String family_phone3;  //연락처
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
	private List<PaymentFamilyMember> paymentFamilyMemberList = new ArrayList<PaymentFamilyMember>();
	
	private int family_count;
	
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public int getPay_member_idx() {
		return pay_member_idx;
	}
	public void setPay_member_idx(int pay_member_idx) {
		this.pay_member_idx = pay_member_idx;
	}
	public int getPay_family_member_idx() {
		return pay_family_member_idx;
	}
	public void setPay_family_member_idx(int pay_family_member_idx) {
		this.pay_family_member_idx = pay_family_member_idx;
	}
	public String getPay_member_name() {
		return pay_member_name;
	}
	public void setPay_member_name(String pay_member_name) {
		this.pay_member_name = pay_member_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public int getLoan_number() {
		return loan_number;
	}
	public void setLoan_number(int loan_number) {
		this.loan_number = loan_number;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getJoin_start_date() {
		return join_start_date;
	}
	public void setJoin_start_date(String join_start_date) {
		this.join_start_date = join_start_date;
	}
	public String getJoin_end_date() {
		return join_end_date;
	}
	public void setJoin_end_date(String join_end_date) {
		this.join_end_date = join_end_date;
	}
	public String getUse_type() {
		return use_type;
	}
	public void setUse_type(String use_type) {
		this.use_type = use_type;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getSponsorship_amount() {
		return sponsorship_amount;
	}
	public void setSponsorship_amount(String sponsorship_amount) {
		this.sponsorship_amount = sponsorship_amount;
	}
	public String getApprove_yn() {
		return approve_yn;
	}
	public void setApprove_yn(String approve_yn) {
		this.approve_yn = approve_yn;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public String getAdd_date() {
		return add_date;
	}
	public void setAdd_date(String add_date) {
		this.add_date = add_date;
	}
	public String getAdd_ip() {
		return add_ip;
	}
	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public String getDelete_id() {
		return delete_id;
	}
	public void setDelete_id(String delete_id) {
		this.delete_id = delete_id;
	}
	public String getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(String delete_date) {
		this.delete_date = delete_date;
	}
	public String getDelete_ip() {
		return delete_ip;
	}
	public void setDelete_ip(String delete_ip) {
		this.delete_ip = delete_ip;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getEmail_address() {
		return email_address;
	}
	public void setEmail_address(String email_address) {
		this.email_address = email_address;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getFamily_yn() {
		return family_yn;
	}
	public void setFamily_yn(String family_yn) {
		this.family_yn = family_yn;
	}
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
	public String getFamily_phone1() {
		return family_phone1;
	}
	public void setFamily_phone1(String family_phone1) {
		this.family_phone1 = family_phone1;
	}
	public String getFamily_phone2() {
		return family_phone2;
	}
	public void setFamily_phone2(String family_phone2) {
		this.family_phone2 = family_phone2;
	}
	public String getFamily_phone3() {
		return family_phone3;
	}
	public void setFamily_phone3(String family_phone3) {
		this.family_phone3 = family_phone3;
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
	public int getFamily_count() {
		return family_count;
	}
	public void setFamily_count(int family_count) {
		this.family_count = family_count;
	}
	public List<PaymentFamilyMember> getPaymentFamilyMemberList() {
		return paymentFamilyMemberList;
	}
	public void setPaymentFamilyMemberList(List<PaymentFamilyMember> paymentFamilyMemberList) {
		this.paymentFamilyMemberList = paymentFamilyMemberList;
	}
	public String getUse_type1() {
		return use_type1;
	}
	public void setUse_type1(String use_type1) {
		this.use_type1 = use_type1;
	}
	public String getUse_type2() {
		return use_type2;
	}
	public void setUse_type2(String use_type2) {
		this.use_type2 = use_type2;
	}
	public String getUse_type3() {
		return use_type3;
	}
	public void setUse_type3(String use_type3) {
		this.use_type3 = use_type3;
	}
	
	
}
