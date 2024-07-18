package kr.co.whalesoft.app.cms.member;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang.time.DateUtils;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.co.whalesoft.framework.utils.StrUtil;

public class Member extends PagingUtils implements Serializable {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;


	private boolean admin = false;		// 관리자 여부
	private boolean isLogin;
	private boolean anonymous = false;		// 게스트 여부

	private String member_id;  //사용자_아이디
	private String member_name;  //사용자_이름
	private String member_pw;  //패스워드
	private String memberNewPw;  //패스워드
	private String birth_day;  //생년월일
	private String email;  //이메일
	private String email1;  //이메일
	private String email2;  //이메일
	private String zipcode;  //우편번호
	private String address;  //주소
	private String address1;  //주소
	private String address2;  //동이하 주소
	private String phone;  //전화번호
	private String phone1;  //전화번호
	private String phone2;  //전화번호
	private String phone3;  //전화번호
	private String cell_phone;  //휴대폰
	private String cell_phone1;  //휴대폰
	private String cell_phone2;  //휴대폰
	private String cell_phone3;  //휴대폰
	private String sms_service_yn;  //SMS수신여부
	private String email_service_yn;  //EMAIL수신여부
	private String add_ip;  //등록IP
	private Date add_date;  //등록날짜
	private Date pw_change_date;  //비밀번호 변경일
	private Date last_login;  //마지막 로그인
	private String last_login_str;
	private String last_login_ip;
	private String sex;
	private String age;
	private String unAgreeFlag;
	private String unAgreeDate;

	private String search_auth;
	private String search_auth_name;

	private String add_id;

	/**
	 * 변경이력
	 */
	private int history_idx;  //변경이력IDX
	private String use_yn;  //허용여부
	private String in_ip;  //등록IP
	private Date in_date;  //등록날짜
	private Date up_date;  //수정날짜
	private String auth_id;  //권한
	private String auth_id_list;  //권한 리스트 (다중)
	private String auth_name; //권한명
	private String auth_name_list;  // 권한 명 리스트 (화면용)
	private String modify_id;  //수정자ID
	private Date modify_date;  //수정일
	private String modify_ip;  //수정자IP

	/**
	 * API 연동시 로그인 정보 -> 추후 정리
	 *
	 */
	//web_id = member_id, password = member_pw, user_name = member_name
	private String password_expiry_day;
	private String seq_no;
	private String user_no; // 이용자 대출번호
	private String user_class;// 불량회원구분 (0 : 정상, 1 : 대출정지, 2 : 제적, 3 : 탈퇴)
	private String kl_member_yn;//책이음회원여부 (Y : 책이음회원, N or null : 일반회원)
	private String user_class_code;//신청자 대출직급정보코드
	private String agreement_yn;//개인정보 동의정보 존재여부 (Y/N)
	private String rec_key;//이용자KEY
	private String agree_yn;//개인정보 재동의여부 (Y : 재동의 대상 아님, N : 동의일자가  오늘 이전이어서 재동의 필요)
	private String cert_yn;//CI 존재여부 (Y/N)
	private String expiredate_yn;//개인정보만료일 유무 (Y/N)
	private String loan_stop_date; //대출정지만기일 (YYYY/MM/DD)	- 오늘 이후의 날짜로 저장되어 있는 경우에만 값이 반환되며, 그 이외에는 NULL
	private String overdue_cnt; //대출연체 권수
	private String local_loanable_cnt; //(해당 회원 직급의) 자관대출가능권수
	private String unity_loanable_cnt; //(해당 회원 직급의) 통합대출가능권수
	private String local_loan_cnt;//자관대출중권수
	private String unity_loan_cnt;//통합대출중권수
	private String lost_card_yn;//회원증분실여부 (Y/N)
	private String member_class;//회원구분 (0 : 정회원, 1 : 비회원, 2 : 준회원)
	private String user_position_code;//이용자 소속정보코드
	private String user_manage_code;//이용자 가입도서관 관리구분코드
	private String workNo;//이용자 회원증 RFID 시리얼값
	private String login_id; //이용자 회원증 RFID 시리얼값

	private String card_no;
	private String card_password;
	private String mobile_no; // 이용자 폰
	private String web_id; // WEB_ID
	private String status_code; // 1 - 탈퇴 or 웹회원 , 0 - 그외 이용자(정상적인이용자)
	private String loca; // 소장처코드
	private String loca_name; // 소장처
	private String user_id; //

	private String di_value;
	private String ci_value;

	private String agree_codes;
	private String user_position;
	private Date agree_date;
	private String agree_date_str;

	private String company_name;//근무지명
	private String company_zipcode;//근무지우편번호
	private String company_addr;//근무지주소
	private String company_depart;//근무지부서명
	private String company_phone;
	private String company_phone1;
	private String company_phone2;
	private String company_phone3;
	private String parent_name;
	private String parent_phone;
	private String parent_phone1;
	private String parent_phone2;
	private String parent_phone3;

	private String loginCode;
	private String loginMsg;

	private String loginType; //CMS or HOMEPAGE

	private String link_member_yn;  //다른시스템 계정 링크
	/**
	 * 회원인증변수
	 */
	private String ageType;//14세미만:under, 14세이상:more
	private String certType;//gpin, sms
	private boolean certComplete;//인증 성공여부
	private String sci_result;

	private int menu_idx;
	private String integrationId;//회원통합시 선택값
	private String integrationIdList;//회원통합시 선택값
	private String integrationSeqNo;//회원통합시 선택값
	private String integrationSeqNoList;//회원통합시 선택값

	/*책 읽는 가게*/
	private String langMode = "kor";

	/*권한*/
	private List<Integer> authGroupIdxList;//권한그룹목록
	private List<Homepage> authorityHomepageList;//관리홈페이지리스트
	private Map<String, Object> authMap;

	//KCMS용 변수
	private String manage_code;
	private String lib_code;
	
	//사립도서관반입용 변수
	private String bringIn;
	private int log_idx;

	private String lill_stop_date; //상호대차 신청 제한일 (YYYY/MM/DD)

	public boolean getPrivateMemberYn(Homepage homepage) {
		if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
			return true;
		}
		return false;
	}

	public String getPram(String mode) {
		StringBuffer sb = new StringBuffer();
		sb.append(getPagingParam());
		return sb.toString();
	}

	public Member() {}

	public Member(String member_id) {
		this.member_id = member_id;
	}

	public boolean isAdmin() {
		return admin;
	}
	public void setAdmin(boolean admin) {
		this.admin = admin;
	}
	public boolean isLogin() {
		return isLogin;
	}
	public void setLogin(boolean isLogin) {
		this.isLogin = isLogin;
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
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getBirth_day() {
		return birth_day;
	}
	public void setBirth_day(String birth_day) {
		this.birth_day = birth_day;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCell_phone() {
		return cell_phone;
	}
	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}
	public String getSms_service_yn() {
		return StrUtil.isNull(sms_service_yn, "N");
	}
	public void setSms_service_yn(String sms_service_yn) {
		this.sms_service_yn = sms_service_yn;
	}
	public String getEmail_service_yn() {
		return StrUtil.isNull(email_service_yn, "N");
	}
	public void setEmail_service_yn(String email_service_yn) {
		this.email_service_yn = email_service_yn;
	}
	public String getAdd_ip() {
		return add_ip;
	}
	public void setAdd_ip(String add_ip) {
		this.add_ip = add_ip;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public Date getPw_change_date() {
		return pw_change_date;
	}
	public void setPw_change_date(Date pw_change_date) {
		this.pw_change_date = pw_change_date;
	}
	public Date getLast_login() {
		return last_login;
	}
	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}
	public int getHistory_idx() {
		return history_idx;
	}
	public void setHistory_idx(int history_idx) {
		this.history_idx = history_idx;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getIn_ip() {
		return in_ip;
	}
	public void setIn_ip(String in_ip) {
		this.in_ip = in_ip;
	}
	public Date getIn_date() {
		return in_date;
	}
	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}
	public Date getUp_date() {
		return up_date;
	}
	public void setUp_date(Date up_date) {
		this.up_date = up_date;
	}
	public String getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(String auth_id) {
		this.auth_id = auth_id;
	}
	public String getModify_id() {
		return modify_id;
	}
	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}
	public Date getModify_date() {
		return modify_date;
	}
	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}
	public String getModify_ip() {
		return modify_ip;
	}
	public void setModify_ip(String modify_ip) {
		this.modify_ip = modify_ip;
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
	public String getCell_phone1() {
		return cell_phone1;
	}
	public void setCell_phone1(String cell_phone1) {
		this.cell_phone1 = cell_phone1;
	}
	public String getCell_phone2() {
		return cell_phone2;
	}
	public void setCell_phone2(String cell_phone2) {
		this.cell_phone2 = cell_phone2;
	}
	public String getCell_phone3() {
		return cell_phone3;
	}
	public void setCell_phone3(String cell_phone3) {
		this.cell_phone3 = cell_phone3;
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
	public String getPassword_expiry_day() {
		return password_expiry_day;
	}
	public void setPassword_expiry_day(String password_expiry_day) {
		this.password_expiry_day = password_expiry_day;
	}
	public String getSeq_no() {
		return seq_no;
	}
	public void setSeq_no(String seq_no) {
		this.seq_no = seq_no;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getCard_no() {
		return card_no;
	}
	public void setCard_no(String card_no) {
		this.card_no = card_no;
	}
	public String getMobile_no() {
		return mobile_no;
	}
	public void setMobile_no(String mobile_no) {
		this.mobile_no = mobile_no;
	}
	public String getWeb_id() {
		return web_id;
	}
	public void setWeb_id(String web_id) {
		this.web_id = web_id;
	}
	public String getStatus_code() {
		return status_code;
	}
	public void setStatus_code(String status_code) {
		this.status_code = status_code;
	}
	public String getLoca() {
		return loca;
	}
	public void setLoca(String loca) {
		this.loca = loca;
	}
	public String getLoca_name() {
		return loca_name;
	}
	public void setLoca_name(String loca_name) {
		this.loca_name = loca_name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getDi_value() {
		return di_value;
	}
	public void setDi_value(String di_value) {
		this.di_value = di_value;
	}
	public String getCi_value() {
		return ci_value;
	}
	public void setCi_value(String ci_value) {
		this.ci_value = ci_value;
	}
	public String getAuth_id_list() {
		return auth_id_list;
	}
	public void setAuth_id_list(String auth_id_list) {
		this.auth_id_list = auth_id_list;
	}
	public String getAuth_name_list() {
		return auth_name_list;
	}
	public void setAuth_name_list(String auth_name_list) {
		this.auth_name_list = auth_name_list;
	}
	public String getAgree_codes() {
		return agree_codes;
	}
	public void setAgree_codes(String agree_codes) {
		this.agree_codes = agree_codes;
	}

	public String getUser_position() {
		return user_position;
	}

	public void setUser_position(String user_position) {
		this.user_position = user_position;
	}

	public String getAgeType() {
		return ageType;
	}

	public void setAgeType(String ageType) {
		this.ageType = ageType;
	}

	public String getCertType() {
		return certType;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public boolean isCertComplete() {
		return certComplete;
	}

	public void setCertComplete(boolean certComplete) {
		this.certComplete = certComplete;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCompany_zipcode() {
		return company_zipcode;
	}

	public void setCompany_zipcode(String company_zipcode) {
		this.company_zipcode = company_zipcode;
	}

	public String getCompany_addr() {
		return company_addr;
	}

	public void setCompany_addr(String company_addr) {
		this.company_addr = company_addr;
	}

	public String getCompany_phone() {
		return company_phone;
	}

	public void setCompany_phone(String company_phone) {
		this.company_phone = company_phone;
	}

	public String getCompany_phone1() {
		return company_phone1;
	}

	public void setCompany_phone1(String company_phone1) {
		this.company_phone1 = company_phone1;
	}

	public String getCompany_phone2() {
		return company_phone2;
	}

	public void setCompany_phone2(String company_phone2) {
		this.company_phone2 = company_phone2;
	}

	public String getCompany_phone3() {
		return company_phone3;
	}

	public void setCompany_phone3(String company_phone3) {
		this.company_phone3 = company_phone3;
	}

	public String getParent_name() {
		return parent_name;
	}

	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}

	public String getParent_phone() {
		return parent_phone;
	}

	public void setParent_phone(String parent_phone) {
		this.parent_phone = parent_phone;
	}

	public String getParent_phone1() {
		return parent_phone1;
	}

	public void setParent_phone1(String parent_phone1) {
		this.parent_phone1 = parent_phone1;
	}

	public String getParent_phone2() {
		return parent_phone2;
	}

	public void setParent_phone2(String parent_phone2) {
		this.parent_phone2 = parent_phone2;
	}

	public String getParent_phone3() {
		return parent_phone3;
	}

	public void setParent_phone3(String parent_phone3) {
		this.parent_phone3 = parent_phone3;
	}

	public String getLoginType() {
		return loginType;
	}

	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

	public String getLoginCode() {
		return loginCode;
	}

	public void setLoginCode(String loginCode) {
		this.loginCode = loginCode;
	}

	public String getLoginMsg() {
		return loginMsg;
	}

	public void setLoginMsg(String loginMsg) {
		this.loginMsg = loginMsg;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getSci_result() {
		return sci_result;
	}

	public void setSci_result(String sci_result) {
		this.sci_result = sci_result;
	}

	public String getSearch_auth() {
		return search_auth;
	}

	public void setSearch_auth(String search_auth) {
		this.search_auth = search_auth;
	}

	public String getSearch_auth_name() {
		return search_auth_name;
	}

	public void setSearch_auth_name(String search_auth_name) {
		this.search_auth_name = search_auth_name;
	}

	public String getAuth_name() {
		return auth_name;
	}

	public void setAuth_name(String auth_name) {
		this.auth_name = auth_name;
	}

	public int getMenu_idx() {
		return menu_idx;
	}

	public void setMenu_idx(int menu_idx) {
		this.menu_idx = menu_idx;
	}

	public Date getAgree_date() {
		return agree_date;
	}

	public void setAgree_date(Date agree_date) {
		this.agree_date = agree_date;
	}

	public boolean isHomepageLogin() {
		if ( isLogin() && "HOMEPAGE".equals(this.loginType) ) {
			return true;
		} else if ( isLogin() && "PRIVATEHOMEPAGE".equals(this.loginType) ) {
			return true;
		}
		return false;
	}

	public boolean isAgreeDateOver() {
		Date cur = new Date();
		/*if ( StringUtils.isNotEmpty(this.agree_date) ) {

		}*/
//		 현재 시간 (cur)이 agree_date+2년 보다 크면 true
//		return cur.after(DateUtils.addYears(this.agree_date, 2)); //2년
		try {
			return cur.after(DateUtils.addYears(this.agree_date, 2)); // 테스트용
		} catch ( NullPointerException e ) {
		} catch ( Exception e ) {
		}
		return false;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCard_password() {
		return card_password;
	}

	public void setCard_password(String card_password) {
		this.card_password = card_password;
	}

	public String getMemberNewPw() {
		return memberNewPw;
	}

	public void setMemberNewPw(String memberNewPw) {
		this.memberNewPw = memberNewPw;
	}

	@Override
	public String toString() {
		return String.format(
				"Member [admin=%s, isLogin=%s, member_id=%s, member_name=%s, member_pw=%s, memberNewPw=%s, birth_day=%s, email=%s, email1=%s, email2=%s, zipcode=%s, address=%s, address1=%s, address2=%s, phone=%s, phone1=%s, phone2=%s, phone3=%s, cell_phone=%s, cell_phone1=%s, cell_phone2=%s, cell_phone3=%s, sms_service_yn=%s, email_service_yn=%s, add_ip=%s, add_date=%s, pw_change_date=%s, last_login=%s, sex=%s, age=%s, search_auth=%s, search_auth_name=%s, history_idx=%s, use_yn=%s, in_ip=%s, in_date=%s, up_date=%s, auth_id=%s, auth_id_list=%s, auth_name=%s, auth_name_list=%s, modify_id=%s, modify_date=%s, modify_ip=%s, password_expiry_day=%s, seq_no=%s, user_no=%s, card_no=%s, card_password=%s, mobile_no=%s, web_id=%s, status_code=%s, loca=%s, loca_name=%s, user_id=%s, di_value=%s, ci_value=%s, agree_codes=%s, user_position=%s, agree_date=%s, company_name=%s, company_zipcode=%s, company_addr=%s, company_phone=%s, company_phone1=%s, company_phone2=%s, company_phone3=%s, parent_name=%s, parent_phone=%s, parent_phone1=%s, parent_phone2=%s, parent_phone3=%s, loginCode=%s, loginMsg=%s, loginType=%s, ageType=%s, certType=%s, certComplete=%s, sci_result=%s, menu_idx=%s, authgroupidlist=%s, admin=%s]",
				admin, isLogin, member_id, member_name, member_pw, memberNewPw, birth_day, email, email1, email2,
				zipcode, address, address1, address2, phone, phone1, phone2, phone3, cell_phone, cell_phone1, cell_phone2,
				cell_phone3, sms_service_yn, email_service_yn, add_ip, add_date, pw_change_date, last_login, sex, age,
				search_auth, search_auth_name, history_idx, use_yn, in_ip, in_date, up_date, auth_id, auth_id_list,
				auth_name, auth_name_list, modify_id, modify_date, modify_ip, password_expiry_day, seq_no, user_no,
				card_no, card_password, mobile_no, web_id, status_code, loca, loca_name, user_id,
				di_value, ci_value,
				agree_codes, user_position, agree_date, company_name, company_zipcode, company_addr, company_phone,
				company_phone1, company_phone2, company_phone3, parent_name, parent_phone, parent_phone1, parent_phone2,
				parent_phone3, loginCode, loginMsg, loginType, ageType, certType, certComplete, sci_result,
				menu_idx, authGroupIdxList, admin);
	}

	public String getUnAgreeFlag() {
		return unAgreeFlag;
	}

	public void setUnAgreeFlag(String unAgreeFlag) {
		this.unAgreeFlag = unAgreeFlag;
	}

	public String getUnAgreeDate() {
		return unAgreeDate;
	}

	public void setUnAgreeDate(String unAgreeDate) {
		this.unAgreeDate = unAgreeDate;
	}

	public String getIntegrationId() {
		return integrationId;
	}

	public void setIntegrationId(String integrationId) {
		this.integrationId = integrationId;
	}

	public String getIntegrationIdList() {
		return integrationIdList;
	}

	public void setIntegrationIdList(String integrationIdList) {
		this.integrationIdList = integrationIdList;
	}

	public String getLink_member_yn() {
		return link_member_yn;
	}

	public void setLink_member_yn(String link_member_yn) {
		this.link_member_yn = link_member_yn;
	}



	public String getIntegrationSeqNo() {
		return integrationSeqNo;
	}

	public void setIntegrationSeqNo(String integrationSeqNo) {
		this.integrationSeqNo = integrationSeqNo;
	}

	public String getIntegrationSeqNoList() {
		return integrationSeqNoList;
	}

	public void setIntegrationSeqNoList(String integrationSeqNoList) {
		this.integrationSeqNoList = integrationSeqNoList;
	}


	public String getLangMode() {
		return langMode;
	}


	public void setLangMode(String langMode) {
		this.langMode = langMode;
	}




	public String getLast_login_str() {
		return last_login_str;
	}


	public void setLast_login_str(String last_login_str) {
		this.last_login_str = last_login_str;
	}


	public String getLast_login_ip() {
		return last_login_ip;
	}


	public void setLast_login_ip(String last_login_ip) {
		this.last_login_ip = last_login_ip;
	}


	public String getAgree_date_str() {
		return agree_date_str;
	}


	public void setAgree_date_str(String agree_date_str) {
		this.agree_date_str = agree_date_str;
	}

	public List<Integer> getAuthGroupIdxList() {
		return authGroupIdxList;
	}



	public void setAuthGroupIdxList(List<Integer> authGroupIdxList) {
		this.authGroupIdxList = authGroupIdxList;
	}



	public Map<String, Object> getAuthMap() {
		return authMap;
	}



	public void setAuthMap(Map<String, Object> authMap) {
		this.authMap = authMap;
	}



	public List<Homepage> getAuthorityHomepageList() {
		return authorityHomepageList;
	}



	public void setAuthorityHomepageList(List<Homepage> authorityHomepageList) {
		this.authorityHomepageList = authorityHomepageList;
	}



	public static long getSerialversionuid() {
		return serialVersionUID;
	}



	public boolean isAnonymous() {
		return anonymous;
	}



	public void setAnonymous(boolean anonymous) {
		this.anonymous = anonymous;
	}



	public String getManage_code() {
		return manage_code;
	}



	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}



	public String getUser_class() {
		return user_class;
	}



	public String getKl_member_yn() {
		return kl_member_yn;
	}



	public String getUser_class_code() {
		return user_class_code;
	}



	public String getAgreement_yn() {
		return agreement_yn;
	}



	public String getRec_key() {
		return rec_key;
	}



	public String getAgree_yn() {
		return agree_yn;
	}



	public String getCert_yn() {
		return cert_yn;
	}



	public String getExpiredate_yn() {
		return expiredate_yn;
	}



	public void setUser_class(String user_class) {
		this.user_class = user_class;
	}



	public void setKl_member_yn(String kl_member_yn) {
		this.kl_member_yn = kl_member_yn;
	}



	public void setUser_class_code(String user_class_code) {
		this.user_class_code = user_class_code;
	}



	public void setAgreement_yn(String agreement_yn) {
		this.agreement_yn = agreement_yn;
	}



	public void setRec_key(String rec_key) {
		this.rec_key = rec_key;
	}



	public void setAgree_yn(String agree_yn) {
		this.agree_yn = agree_yn;
	}



	public void setCert_yn(String cert_yn) {
		this.cert_yn = cert_yn;
	}



	public void setExpiredate_yn(String expiredate_yn) {
		this.expiredate_yn = expiredate_yn;
	}



	public String getCompany_depart() {
		return company_depart;
	}



	public void setCompany_depart(String company_depart) {
		this.company_depart = company_depart;
	}



	public String getLoan_stop_date() {
		return loan_stop_date;
	}



	public String getOverdue_cnt() {
		return overdue_cnt;
	}



	public String getLocal_loanable_cnt() {
		return local_loanable_cnt;
	}



	public String getUnity_loanable_cnt() {
		return unity_loanable_cnt;
	}



	public String getLocal_loan_cnt() {
		return local_loan_cnt;
	}



	public String getUnity_loan_cnt() {
		return unity_loan_cnt;
	}



	public String getLost_card_yn() {
		return lost_card_yn;
	}



	public String getMember_class() {
		return member_class;
	}



	public void setLoan_stop_date(String loan_stop_date) {
		this.loan_stop_date = loan_stop_date;
	}



	public void setOverdue_cnt(String overdue_cnt) {
		this.overdue_cnt = overdue_cnt;
	}



	public void setLocal_loanable_cnt(String local_loanable_cnt) {
		this.local_loanable_cnt = local_loanable_cnt;
	}



	public void setUnity_loanable_cnt(String unity_loanable_cnt) {
		this.unity_loanable_cnt = unity_loanable_cnt;
	}



	public void setLocal_loan_cnt(String local_loan_cnt) {
		this.local_loan_cnt = local_loan_cnt;
	}



	public void setUnity_loan_cnt(String unity_loan_cnt) {
		this.unity_loan_cnt = unity_loan_cnt;
	}



	public void setLost_card_yn(String lost_card_yn) {
		this.lost_card_yn = lost_card_yn;
	}



	public void setMember_class(String member_class) {
		this.member_class = member_class;
	}


	public String getUser_position_code() {
		return user_position_code;
	}


	public void setUser_position_code(String user_position_code) {
		this.user_position_code = user_position_code;
	}


	public String getUser_manage_code() {
		return user_manage_code;
	}


	public void setUser_manage_code(String user_manage_code) {
		this.user_manage_code = user_manage_code;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getAdd_id() {
		return add_id;
	}



	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}



	public String getLib_code() {
		return lib_code;
	}

	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}

	public String getBringIn() {
		return bringIn;
	}

	public void setBringIn(String bringIn) {
		this.bringIn = bringIn;
	}

	public int getLog_idx() {
		return log_idx;
	}

	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}

	public String getWorkNo() {
		return workNo;
	}

	public void setWorkNo(String workNo) {
		this.workNo = workNo;
	}

	public String getLogin_id() {
		return login_id;
	}

	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	public String getLill_stop_date() {
		return lill_stop_date;
	}

	public void setLill_stop_date(String lill_stop_date) {
		this.lill_stop_date = lill_stop_date;
	}
}