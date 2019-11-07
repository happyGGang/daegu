package kr.co.whalesoft.app.cms.module.emailSend;

import kr.co.whalesoft.app.cms.module.smsSend.SmsSend;

public class EmailSend extends SmsSend {
	
	private String send_msg;
	
	private String status;
	
	private String tab_status = "table1";
	private String apply_status = "1";
	private String sms_yn;	
	
	private String caller_cell_phone;
	private String caller_cell_phone1;
	private String caller_cell_phone2;
	private String caller_cell_phone3;
	
	private Boolean code_type_1 = false;
	private Boolean code_type_2 = false;
	private Boolean code_type_3 = false;
	private Boolean code_type_4 = false;
	private Boolean code_type_5 = false;
	
	private String user_phone;
	
	private String start_date;
	private String end_date;
	private String start_age;
	private String end_age;
	
	private String homepage_code;
	/*selecet box*/
	
	private String code_id;
	private String code_name;
	private String codeList_1;
	private String code_id_1;
	private String code_name_1;
	private String codeList_2;
	private String code_id_2;
	private String code_name_2;
	private String codeList_3;
	private String code_id_3;
	private String code_name_3;
	private String codeList_4;
	private String code_id_4;
	private String code_name_4;
	private String codeList_5;
	private String code_id_5;
	private String code_name_5;
	private String codeList_6;	
	private String code_id_6;
	private String code_name_6;
	private String codeList_7;	
	private String code_id_7;
	private String code_name_7;
	private String codeList_8;	
	private String code_id_8;
	private String code_name_8;
	private String codeList_9;	
	private String code_id_9;
	private String code_name_9;
	private String codeList_10;	
	private String code_id_10;
	private String code_name_10;
	
	/*사용자 정보*/
	private String member_name;
	private String member_phone;
	private String member_id;
	private String member_key;
	
	private String imsi_v_1;
	private String imsi_v_2;
	private String imsi_v_3;
	private String imsi_v_4;
	private String imsi_v_5;	

	private String title;
	private String content;
	
	 /*API통신*/
	private String USER_NO;
	private String MOBILE_NO;
	private String USER_POSITN_NAME;
	private String SEX_NAME;
	private String BIRTHD;
	private String ADDRS;
	private String CMPNY_NAME;
	private String SMS_CHECK;
	private String MAIL_CHECK;
	private String EMAIL;
	
	public String getSend_msg() {
		return send_msg;
	}
	public void setSend_msg(String send_msg) {
		this.send_msg = send_msg;
	}
	public String getCodeList_1() {
		return codeList_1;
	}
	public void setCodeList_1(String codeList_1) {
		this.codeList_1 = codeList_1;
	}
	public String getCodeList_2() {
		return codeList_2;
	}
	public void setCodeList_2(String codeList_2) {
		this.codeList_2 = codeList_2;
	}
	public String getCodeList_3() {
		return codeList_3;
	}
	public void setCodeList_3(String codeList_3) {
		this.codeList_3 = codeList_3;
	}
	public String getCodeList_4() {
		return codeList_4;
	}
	public void setCodeList_4(String codeList_4) {
		this.codeList_4 = codeList_4;
	}
	public String getCodeList_5() {
		return codeList_5;
	}
	public void setCodeList_5(String codeList_5) {
		this.codeList_5 = codeList_5;
	}
	public String getCodeList_6() {
		return codeList_6;
	}
	public void setCodeList_6(String codeList_6) {
		this.codeList_6 = codeList_6;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getImsi_v_1() {
		return imsi_v_1;
	}
	public void setImsi_v_1(String imsi_v_1) {
		this.imsi_v_1 = imsi_v_1;
	}
	public String getImsi_v_2() {
		return imsi_v_2;
	}
	public void setImsi_v_2(String imsi_v_2) {
		this.imsi_v_2 = imsi_v_2;
	}
	public String getImsi_v_3() {
		return imsi_v_3;
	}
	public void setImsi_v_3(String imsi_v_3) {
		this.imsi_v_3 = imsi_v_3;
	}
	public String getImsi_v_4() {
		return imsi_v_4;
	}
	public void setImsi_v_4(String imsi_v_4) {
		this.imsi_v_4 = imsi_v_4;
	}
	public String getImsi_v_5() {
		return imsi_v_5;
	}
	public void setImsi_v_5(String imsi_v_5) {
		this.imsi_v_5 = imsi_v_5;
	}
	public String getCode_id_1() {
		return code_id_1;
	}
	public void setCode_id_1(String code_id_1) {
		this.code_id_1 = code_id_1;
	}
	public String getCode_name_1() {
		return code_name_1;
	}
	public void setCode_name_1(String code_name_1) {
		this.code_name_1 = code_name_1;
	}
	public String getCode_id_2() {
		return code_id_2;
	}
	public void setCode_id_2(String code_id_2) {
		this.code_id_2 = code_id_2;
	}
	public String getCode_name_2() {
		return code_name_2;
	}
	public void setCode_name_2(String code_name_2) {
		this.code_name_2 = code_name_2;
	}
	public String getCode_id_3() {
		return code_id_3;
	}
	public void setCode_id_3(String code_id_3) {
		this.code_id_3 = code_id_3;
	}
	public String getCode_name_3() {
		return code_name_3;
	}
	public void setCode_name_3(String code_name_3) {
		this.code_name_3 = code_name_3;
	}
	public String getCode_id_4() {
		return code_id_4;
	}
	public void setCode_id_4(String code_id_4) {
		this.code_id_4 = code_id_4;
	}
	public String getCode_name_4() {
		return code_name_4;
	}
	public void setCode_name_4(String code_name_4) {
		this.code_name_4 = code_name_4;
	}
	public String getCode_id_5() {
		return code_id_5;
	}
	public void setCode_id_5(String code_id_5) {
		this.code_id_5 = code_id_5;
	}
	public String getCode_name_5() {
		return code_name_5;
	}
	public void setCode_name_5(String code_name_5) {
		this.code_name_5 = code_name_5;
	}
	public String getCode_id_6() {
		return code_id_6;
	}
	public void setCode_id_6(String code_id_6) {
		this.code_id_6 = code_id_6;
	}
	public String getCode_name_6() {
		return code_name_6;
	}
	public void setCode_name_6(String code_name_6) {
		this.code_name_6 = code_name_6;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Boolean getCode_type_1() {
		return code_type_1;
	}
	public void setCode_type_1(Boolean code_type_1) {
		this.code_type_1 = code_type_1;
	}
	public Boolean getCode_type_2() {
		return code_type_2;
	}
	public void setCode_type_2(Boolean code_type_2) {
		this.code_type_2 = code_type_2;
	}
	public Boolean getCode_type_3() {
		return code_type_3;
	}
	public void setCode_type_3(Boolean code_type_3) {
		this.code_type_3 = code_type_3;
	}
	public Boolean getCode_type_4() {
		return code_type_4;
	}
	public void setCode_type_4(Boolean code_type_4) {
		this.code_type_4 = code_type_4;
	}
	public Boolean getCode_type_5() {
		return code_type_5;
	}
	public void setCode_type_5(Boolean code_type_5) {
		this.code_type_5 = code_type_5;
	}
	public String getCode_id() {
		return code_id;
	}
	public void setCode_id(String code_id) {
		this.code_id = code_id;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
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
	public String getTab_status() {
		return tab_status;
	}
	public void setTab_status(String tab_status) {
		this.tab_status = tab_status;
	}
	public String getApply_status() {
		return apply_status;
	}
	public void setApply_status(String apply_status) {
		this.apply_status = apply_status;
	}
	public String getCaller_cell_phone() {
		return caller_cell_phone;
	}
	public void setCaller_cell_phone(String caller_cell_phone) {
		this.caller_cell_phone = caller_cell_phone;
	}
	public String getCaller_cell_phone1() {
		return caller_cell_phone1;
	}
	public void setCaller_cell_phone1(String caller_cell_phone1) {
		this.caller_cell_phone1 = caller_cell_phone1;
	}
	public String getCaller_cell_phone2() {
		return caller_cell_phone2;
	}
	public void setCaller_cell_phone2(String caller_cell_phone2) {
		this.caller_cell_phone2 = caller_cell_phone2;
	}
	public String getCaller_cell_phone3() {
		return caller_cell_phone3;
	}
	public void setCaller_cell_phone3(String caller_cell_phone3) {
		this.caller_cell_phone3 = caller_cell_phone3;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getSms_yn() {
		return sms_yn;
	}
	public void setSms_yn(String sms_yn) {
		this.sms_yn = sms_yn;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getCodeList_7() {
		return codeList_7;
	}
	public void setCodeList_7(String codeList_7) {
		this.codeList_7 = codeList_7;
	}
	public String getCode_id_7() {
		return code_id_7;
	}
	public void setCode_id_7(String code_id_7) {
		this.code_id_7 = code_id_7;
	}
	public String getCode_name_7() {
		return code_name_7;
	}
	public void setCode_name_7(String code_name_7) {
		this.code_name_7 = code_name_7;
	}
	public String getCodeList_8() {
		return codeList_8;
	}
	public void setCodeList_8(String codeList_8) {
		this.codeList_8 = codeList_8;
	}
	public String getCode_id_8() {
		return code_id_8;
	}
	public void setCode_id_8(String code_id_8) {
		this.code_id_8 = code_id_8;
	}
	public String getCode_name_8() {
		return code_name_8;
	}
	public void setCode_name_8(String code_name_8) {
		this.code_name_8 = code_name_8;
	}
	public String getCodeList_9() {
		return codeList_9;
	}
	public void setCodeList_9(String codeList_9) {
		this.codeList_9 = codeList_9;
	}
	public String getCode_id_9() {
		return code_id_9;
	}
	public void setCode_id_9(String code_id_9) {
		this.code_id_9 = code_id_9;
	}
	public String getCode_name_9() {
		return code_name_9;
	}
	public void setCode_name_9(String code_name_9) {
		this.code_name_9 = code_name_9;
	}
	public String getCodeList_10() {
		return codeList_10;
	}
	public void setCodeList_10(String codeList_10) {
		this.codeList_10 = codeList_10;
	}
	public String getCode_id_10() {
		return code_id_10;
	}
	public void setCode_id_10(String code_id_10) {
		this.code_id_10 = code_id_10;
	}
	public String getCode_name_10() {
		return code_name_10;
	}
	public void setCode_name_10(String code_name_10) {
		this.code_name_10 = code_name_10;
	}
	public String getHomepage_code() {
		return homepage_code;
	}
	public void setHomepage_code(String homepage_code) {
		this.homepage_code = homepage_code;
	}
	public String getMOBILE_NO() {
		return MOBILE_NO;
	}
	public void setMOBILE_NO(String mOBILE_NO) {
		MOBILE_NO = mOBILE_NO;
	}
	public String getUSER_NO() {
		return USER_NO;
	}
	public void setUSER_NO(String uSER_NO) {
		USER_NO = uSER_NO;
	}
	public String getUSER_POSITN_NAME() {
		return USER_POSITN_NAME;
	}
	public void setUSER_POSITN_NAME(String uSER_POSITN_NAME) {
		USER_POSITN_NAME = uSER_POSITN_NAME;
	}
	public String getSEX_NAME() {
		return SEX_NAME;
	}
	public void setSEX_NAME(String sEX_NAME) {
		SEX_NAME = sEX_NAME;
	}
	public String getBIRTHD() {
		return BIRTHD;
	}
	public void setBIRTHD(String bIRTHD) {
		BIRTHD = bIRTHD;
	}
	public String getADDRS() {
		return ADDRS;
	}
	public void setADDRS(String aDDRS) {
		ADDRS = aDDRS;
	}
	public String getCMPNY_NAME() {
		return CMPNY_NAME;
	}
	public void setCMPNY_NAME(String cMPNY_NAME) {
		CMPNY_NAME = cMPNY_NAME;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStart_age() {
		return start_age;
	}
	public void setStart_age(String start_age) {
		this.start_age = start_age;
	}
	public String getEnd_age() {
		return end_age;
	}
	public void setEnd_age(String end_age) {
		this.end_age = end_age;
	}
	public String getMember_key() {
		return member_key;
	}
	public void setMember_key(String member_key) {
		this.member_key = member_key;
	}
	public String getSMS_CHECK() {
		return SMS_CHECK;
	}
	public void setSMS_CHECK(String sMS_CHECK) {
		SMS_CHECK = sMS_CHECK;
	}
	public String getMAIL_CHECK() {
		return MAIL_CHECK;
	}
	public void setMAIL_CHECK(String mAIL_CHECK) {
		MAIL_CHECK = mAIL_CHECK;
	}
	public String getEMAIL() {
		return EMAIL;
	}
	public void setEMAIL(String eMAIL) {
		EMAIL = eMAIL;
	}
}
