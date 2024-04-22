package kr.go.gbelib.app.common.api;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;

public class MemberAPI {
	protected final static Logger log = LoggerFactory.getLogger(MemberAPI.class);


	/**
	 * K.API - 18
	 * 회원정보조회
	 *
	 * @author YONGJU 2017. 12. 29.
	 * @param member_id
	 * @param member_pw
	 */
	public static Map<String, Object> getUserInfo(String member_id, String member_pw) {
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> result = null;

		param.put("option", "0");
		param.put("id", member_id);
		param.put("password", CalculateHashUtils.calculateHashSHA256(member_pw));

		result = CommonAPI.sendKCMS("userinfoview", param);

		return result;
	}

	/**
	 * K.API - 19
	 * 회원정보수정 (아이디 비밀번호 제외 , userkey 외에 반드시 하나의 값은 필수로 입력)
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member
	 * @return
	 */
	public static boolean updateMember(Member member) {

		Map<String, Object> param = new HashMap<String, Object>();

		try {
			param.put("userkey", member.getRec_key());

			if (StringUtils.isNotBlank(member.getBirth_day())) {
				String birth[] = member.getBirth_day().split("/");
				param.put("birthday_year", birth[0]);
				param.put("birthday_month", birth[1]);
				param.put("birthday_day", birth[2]);
			}
//			param.put("birthday_type", URLEncoder.encode("+", "UTF-8"));//+:양력, -:음력

			if (StringUtils.isNotEmpty(member.getZipcode())) {
				param.put("h_zipcode", member.getZipcode());//집우편번호
			}
			if (StringUtils.isNotEmpty(member.getAddress1())) {
				param.put("h_addr1", URLEncoder.encode(member.getAddress1(), "UTF-8"));//집주소
			}
			if (StringUtils.isNotEmpty(member.getSms_service_yn())) {
				param.put("sms_use_yn", member.getSms_service_yn());//SMS수신여부 Y/N
			}
			if (StringUtils.isNotEmpty(member.getEmail_service_yn())) {
				param.put("mailing_use_yn", member.getEmail_service_yn());//이메일수신여부 Y/N
			}
			if (StringUtils.isNotEmpty(member.getSex())) {
				param.put("gpin_sex", member.getSex());//성멸 0:남, 1:여
			}
			param.put("client_ip", member.getIn_ip());//요청IP
			if (StringUtils.isNotEmpty(member.getCi_value())) {
				try {
					param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
				} catch (UnsupportedEncodingException e) {
				}//CI
			}
			//선택입력값
			if (StringUtils.isNotEmpty(member.getPhone1()) && StringUtils.isNotEmpty(member.getPhone2()) && StringUtils.isNotEmpty(member.getPhone3())) {
				param.put("home_exchange_phone", member.getPhone1());//집 전화번호 첫자리
				param.put("home_phone1", member.getPhone2());//집전화번호 가운데(첫자리 있는 경우 필수)
				param.put("home_phone2", member.getPhone3());//집전화번호 뒷자리(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCell_phone1()) && StringUtils.isNotEmpty(member.getCell_phone2()) && StringUtils.isNotEmpty(member.getCell_phone3())) {
				param.put("exchange_mobile", member.getCell_phone1());//휴대전화번호 첫자리
				param.put("mobile1", member.getCell_phone2());//휴대전화번호 가운데(첫자리 있는 경우 필수)
				param.put("mobile2", member.getCell_phone3());//휴대전화번호 가운데(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getEmail1()) && StringUtils.isNotEmpty(member.getEmail2())) {
				param.put("email_id", member.getEmail1());//이메일 아이디
				param.put("email_domain", member.getEmail2());//이메일 도메인(이메일 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCompany_phone1()) && StringUtils.isNotEmpty(member.getCompany_phone2()) && StringUtils.isNotEmpty(member.getCompany_phone3())) {
				param.put("office_exchange_phone", member.getCompany_phone1());//근무지 전화번호 첫자리
				param.put("office_phone1", member.getCompany_phone2());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
				param.put("office_phone2", member.getCompany_phone3());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCompany_zipcode())) {
				param.put("w_zipcode", member.getCompany_zipcode());//근무지 우편번호
			}

			if (StringUtils.isNotEmpty(member.getCompany_addr())) {
				param.put("w_addr1", member.getCompany_addr());//근무지 주소
			}

			if (StringUtils.isNotEmpty(member.getCompany_name())) {
				param.put("office_name", member.getCompany_name());//근무지 명
			}

			if (StringUtils.isNotEmpty(member.getCompany_depart())) {
				param.put("department", member.getCompany_depart());//근무지 부서명
			}

			if (StringUtils.isNotBlank(member.getCard_password())) {
				param.put("card_password", CalculateHashUtils.calculateHashSHA256(member.getCard_password()));//카드 비밀번호
			}
		} catch (Exception e) {}

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("userinfomodify", param);
		String resultInfo = (String) sendKCMS.get("RESULT_INFO");

		return resultInfo.equals("SUCCESS");
	}

	/**
	 * K.API - 20
	 * 회원정보수정 (아이디 비밀번호 포함)
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member
	 * @return
	 */
	public static ApiResponse modifyMember(Member member) {

		Map<String, Object> param = new HashMap<String, Object>();

		try {
			param.put("userkey", member.getRec_key());
			param.put("user_id", member.getMember_id());
			param.put("user_password", CalculateHashUtils.calculateHashSHA256(member.getMember_pw()));

			if (StringUtils.isNotBlank(member.getBirth_day())) {
				String birth = member.getBirth_day();
				param.put("birthday_year", birth.substring(0, 4));
				param.put("birthday_month", birth.substring(4, 6));
				param.put("birthday_day", birth.substring(6, 8));
			}
//			param.put("birthday_type", URLEncoder.encode("+", "UTF-8"));//+:양력, -:음력

			if (StringUtils.isNotEmpty(member.getZipcode())) {
				param.put("h_zipcode", member.getZipcode());//집우편번호
			}
			if (StringUtils.isNotEmpty(member.getAddress1())) {
				String addr = member.getAddress1();
				if (StringUtils.isNotBlank(member.getAddress2())) {
					addr += " " + member.getAddress2();
				}
				param.put("h_addr1", URLEncoder.encode(addr, "UTF-8"));//집주소
			}
			if (StringUtils.isNotBlank(member.getSms_service_yn())) {
				param.put("sms_use_yn", member.getSms_service_yn());//SMS수신여부 Y/N
			}
			if (StringUtils.isNotBlank(member.getEmail_service_yn())) {
				param.put("mailing_use_yn", member.getEmail_service_yn());//이메일수신여부 Y/N
			}
			if (StringUtils.isNotEmpty(member.getSex())) {
				param.put("gpin_sex", member.getSex());//성멸 0:남, 1:여
			}
			param.put("client_ip", member.getIn_ip());//요청IP
			if (StringUtils.isNotEmpty(member.getCi_value())) {
				try {
					param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
				} catch (UnsupportedEncodingException e) {
				}//CI
			}
			//선택입력값
			if (StringUtils.isNotEmpty(member.getPhone1()) && StringUtils.isNotEmpty(member.getPhone2()) && StringUtils.isNotEmpty(member.getPhone3())) {
				param.put("home_exchange_phone", member.getPhone1());//집 전화번호 첫자리
				param.put("home_phone1", member.getPhone2());//집전화번호 가운데(첫자리 있는 경우 필수)
				param.put("home_phone2", member.getPhone3());//집전화번호 뒷자리(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCell_phone1()) && StringUtils.isNotEmpty(member.getCell_phone2()) && StringUtils.isNotEmpty(member.getCell_phone3())) {
				param.put("exchange_mobile", member.getCell_phone1());//휴대전화번호 첫자리
				param.put("mobile1", member.getCell_phone2());//휴대전화번호 가운데(첫자리 있는 경우 필수)
				param.put("mobile2", member.getCell_phone3());//휴대전화번호 가운데(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getEmail1()) && StringUtils.isNotEmpty(member.getEmail2())) {
				param.put("email_id", member.getEmail1());//이메일 아이디
				param.put("email_domain", member.getEmail2());//이메일 도메인(이메일 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCompany_phone1()) && StringUtils.isNotEmpty(member.getCompany_phone2()) && StringUtils.isNotEmpty(member.getCompany_phone3())) {
				param.put("office_exchange_phone", member.getCompany_phone1());//근무지 전화번호 첫자리
				param.put("office_phone1", member.getCompany_phone2());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
				param.put("office_phone2", member.getCompany_phone3());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
			}

			if (StringUtils.isNotEmpty(member.getCompany_zipcode())) {
				param.put("w_zipcode", member.getCompany_zipcode());//근무지 우편번호
			}

			if (StringUtils.isNotEmpty(member.getCompany_addr())) {
				param.put("w_addr1", member.getCompany_addr());//근무지 주소
			}

			if (StringUtils.isNotEmpty(member.getCompany_name())) {
				param.put("office_name", member.getCompany_name());//근무지 명
			}

			if (StringUtils.isNotEmpty(member.getCompany_depart())) {
				param.put("department", member.getCompany_depart());//근무지 부서명
			}

			if (StringUtils.isNotBlank(member.getCard_password())) {
				param.put("card_password", CalculateHashUtils.calculateHashSHA256(member.getCard_password()));//카드 비밀번호
			}


		} catch (Exception e) {}

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("useraccountmodify", param);
		String resultInfo = (String) sendKCMS.get("RESULT_INFO");

		if ("SUCCESS".equals(resultInfo)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}

	}

	/**
	 * K.API - 21
	 * 회원 비밀번호 변경
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member
	 * @return
	 */
	public static ApiResponse updateMemberPasswd(Member member) {
		Map<String, Object> param = new HashMap<String, Object>();

		String regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d$!@#$%^&*]{9,20}$";

		Pattern pattern = Pattern.compile(regexp);
		Matcher matcher = pattern.matcher(member.getMemberNewPw());
		if (!matcher.matches()) {
			return new ApiResponse(false, "비밀번호 규칙이 올바르지 않습니다.");
		}

		param.put("userkey", member.getRec_key());
		param.put("password", CalculateHashUtils.calculateHashSHA256(member.getMemberNewPw()));
		param.put("client_ip", member.getIn_ip());

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("userpasswordmodify", param);
		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 22
	 *
	 * 회원정보 입력(회원가입)
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member
	 * @return 성공 : 이용자KEY, 실패 : 실패사유
	 */
	public static Map<String, Object> addMember(Member member) {
		Map<String, Object> param = new HashMap<String, Object>();

		//필수입력값
		param.put("id", member.getMember_id());
		param.put("password", CalculateHashUtils.calculateHashSHA256(member.getMember_pw()));
		param.put("name", member.getMember_name());
		param.put("birthday_year", member.getBirth_day().substring(0, 4));
		param.put("birthday_month", member.getBirth_day().substring(4, 6));
		param.put("birthday_day", member.getBirth_day().substring(6, 8));
		param.put("birthday_type", "+");//+:양력, -:음력
		param.put("h_zipcode", member.getZipcode());//집우편번호
		String addr = member.getAddress1();
		if (StringUtils.isNotBlank(member.getAddress2())) {
			addr += " "+member.getAddress2();
		}
		param.put("h_addr1", addr);//집주소
		param.put("sms_use_yn", member.getSms_service_yn());//SMS수신여부 Y/N
		param.put("mailing_use_yn", member.getEmail_service_yn());//이메일수신여부 Y/N
		param.put("gpin_sex", member.getSex());//성멸 0:남, 1:여
		param.put("manage_code", member.getManage_code());//도서관부호
		if (StringUtils.isNotEmpty(member.getCi_value())) {
			try {
				param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
			}//CI
		}
		param.put("client_ip", member.getIn_ip());//요청IP

		//선택입력값
		if (StringUtils.isNotEmpty(member.getPhone1()) && StringUtils.isNotEmpty(member.getPhone2()) && StringUtils.isNotEmpty(member.getPhone3())) {
			param.put("home_exchange_phone", member.getPhone1());//집 전화번호 첫자리
			param.put("home_phone1", member.getPhone2());//집전화번호 가운데(첫자리 있는 경우 필수)
			param.put("home_phone2", member.getPhone3());//집전화번호 뒷자리(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCell_phone1()) && StringUtils.isNotEmpty(member.getCell_phone2()) && StringUtils.isNotEmpty(member.getCell_phone3())) {
			param.put("exchange_mobile", member.getCell_phone1());//휴대전화번호 첫자리
			param.put("mobile1", member.getCell_phone2());//휴대전화번호 가운데(첫자리 있는 경우 필수)
			param.put("mobile2", member.getCell_phone3());//휴대전화번호 가운데(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getEmail1()) && StringUtils.isNotEmpty(member.getEmail2())) {
			param.put("email_id", member.getEmail1());//이메일 아이디
			param.put("email_domain", member.getEmail2());//이메일 도메인(이메일 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCompany_phone1()) && StringUtils.isNotEmpty(member.getCompany_phone2()) && StringUtils.isNotEmpty(member.getCompany_phone3())) {
			param.put("office_exchange_phone", member.getCompany_phone1());//근무지 전화번호 첫자리
			param.put("office_phone1", member.getCompany_phone2());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
			param.put("office_phone2", member.getCompany_phone3());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCompany_zipcode())) {
			param.put("w_zipcode", member.getCompany_zipcode());//근무지 우편번호
		}

		if (StringUtils.isNotEmpty(member.getCompany_addr())) {
			param.put("w_addr1", member.getCompany_addr());//근무지 주소
		}

		if (StringUtils.isNotEmpty(member.getCompany_name())) {
			param.put("office_name", member.getCompany_name());//근무지 명
		}

		if (StringUtils.isNotEmpty(member.getCompany_depart())) {
			param.put("department", member.getCompany_depart());//근무지 부서명
		}

		if (StringUtils.isNotBlank(member.getCard_password())) {
			param.put("card_password", CalculateHashUtils.calculateHashSHA256(member.getCard_password()));//카드 비밀번호
		}

		/**
		 * 대구는 DI 사용안함.
		 * 2019.12.19
		 */
//		if (StringUtils.isNotEmpty(member.getDi_value())) {
//			param.put("gpin_hash", member.getDi_value());//DI
//		}

		return CommonAPI.sendKCMS("userinfoinsert", param);
	}

	/**
	 * K.API - 23
	 *
	 * 가입확인 및 중복조사
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param member - option 0 : member.member_id
     * option 2 : member.user_no, member.member_name
     * option 1or3 : member.ci_value  ※ get파라미터 전송방식의 특성상 일부 특수문자는 변환하여 전송 필요. + => %2B & => %26
     * option 4 : member.member_name, member.cellphone, member.birth_day
     * @param option - 0:이용자ID, 1:CI, 2:대출자번호+이름, 3:책이음 가입확인, 4:이름+핸드폰번호+생년월일(YYYYMMDD)
     * @return
	 */
	public static List<Map<String, Object>> checkDupUser(String option, Member member) {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", option);
		try {
			if (StringUtils.equals(option, "0")) {
				param.put("id", member.getMember_id());
			} else if (StringUtils.equals(option, "2")) {
				param.put("user_no", member.getUser_no());
				param.put("name", URLEncoder.encode(member.getMember_name(), "UTF-8"));
			} else if (StringUtils.equals(option, "4")) {
				param.put("name", URLEncoder.encode(member.getMember_name(), "UTF-8"));
				param.put("idx_handphone", member.getCell_phone());
				param.put("birthday", member.getBirth_day());
			} else {
				// option:1 or option:3
				param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
			}
		} catch (UnsupportedEncodingException e) {}

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("usercheck", param);

		String resultInfo = (String) sendKCMS.get("RESULT_INFO");
		if (resultInfo.equals("SUCCESS")) {
			List<Map<String, Object>> listData = LibSearchAPI.getListData(sendKCMS, "USER_DATA");
			return listData;
		} else {
			return null;
		}
	}

	/**
	 *
	 * K.API - 31
	 *
	 * 개인정보 수집/이용에 대한 동의정보 생성, 갱신
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param manage_code
	 * @param rec_key
	 * @param kl_member_yn 책이음여부
	 * @return
	 */
	public static ApiResponse agreeInfo(String manage_code, String rec_key, String kl_member_yn) {
		Map<String, Object> param = new HashMap<String, Object>();

//		param.put("manage_code", manage_code);
		param.put("userkey", rec_key);
//		if (StringUtils.equals(kl_member_yn, "Y")) {
			param.put("kl_agree_yn", "Y");
//		}

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("useragreeinfoinsert", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 32
	 *
	 * 법정대리인 동의정보 생성, 갱신
	 *
	 * @author whalesoft YONGJU 2019. 11. 16.
	 * @param userKey
	 * @param member_name
	 * @param manage_code
	 * @return
	 */
	public static ApiResponse useragentinfoinsert(String userKey, String member_name, String manage_code) {
		Map<String, Object> param = new HashMap<String, Object>();

		// Map<String, Object> libsettinginfoview = libsettinginfoview(manage_code);
		// List<Map<String, Object>> libSettingInfo = (List<Map<String, Object>>) libsettinginfoview.get("LIB_SETTING_INFO");

		param.put("userkey", userKey);
		try {
			param.put("guardian_name", URLEncoder.encode(member_name, "UTF-8"));
		} catch (UnsupportedEncodingException e) {}
		param.put("relation", "친권자");
		// try {
		// param.put("lib_code", String.valueOf(libSettingInfo.get(0).get("LIB_CODE")));
		// param.put("lib_name", String.valueOf(libSettingInfo.get(0).get("LIB_NAME")));
		// } catch (Exception e) {
		// }

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("useragentinfoinsert", param);

		String code = String.valueOf(sendKCMS.get("RESULT_INFO"));

		if ("SUCCESS".equals(code)) {
			return new ApiResponse(true);
		} else {
			return new ApiResponse(false, String.valueOf(sendKCMS.get("RESULT_MESSAGE")));
		}
	}

	/**
	 * K.API - 42
	 *
	 * 이용자 탈퇴
	 *
	 * @author whalesoft YONGJU 2019. 11. 29.
	 * @param rec_key
	 * @param remoteAddr
	 * @return
	 */
	public static Map<String, Object> secessionUser(String rec_key, String in_ip ) {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userkey", rec_key);
		param.put("option", "direct");
		param.put("sys", "홈페이지탈퇴");
		param.put("client_ip", in_ip);

		Map<String, Object> sendKCMS = CommonAPI.sendKCMS("userquit", param);

		return sendKCMS;
	}




















	/**
	 * API로 부터 회원정보 조회
	 * @param workerId
	 * @param member
	 * @return Map<String, String>
	 */
	public static Map<String, String> getMember(String workerId, Member member) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", workerId);
		param.put("className", "action.lnk.LnkUserInfoD");
		param.put("vUserId", member.getUser_id());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.getFieldData(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * API로 부터 회원정보 조회
	 * @param workerId
	 * @param member
	 * @return Map<String, String>
	 */
	public static List<Map<String, String>> getMemberList(String workerId, Member member) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", workerId);
		param.put("className", "action.lnk.LnkUserInfoD");
		param.put("vUserId", member.getUser_id());

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");
		if ( "0".equals(code) ) {
			return CommonAPI.getFieldDataList(doc);
		}
		else {
			return null;
		}
	}

	/**
	 * K.API - 91
	 * @author whalesoft YONGJU 2020. 4. 7.
	 * @param dlsMember
	 * @param mode - DLS : 독서교육종합시스템, UNTACT : 비대면
	 *
	 */
	public static Map<String, Object> regularUserInfoInsert(Member member, String mode) {
		Map<String, Object> param = new HashMap<String, Object>();

		//필수입력값
		param.put("id", member.getMember_id());
		//2022-10-05 비밀번호 필수파라미터에서 제외
		//param.put("password", CalculateHashUtils.calculateHashSHA256(member.getMember_pw()));
		param.put("name", member.getMember_name());
		param.put("birthday_year", member.getBirth_day().substring(0, 4));
		param.put("birthday_month", member.getBirth_day().substring(4, 6));
		param.put("birthday_day", member.getBirth_day().substring(6, 8));
		param.put("birthday_type", "+");//+:양력, -:음력
		param.put("h_zipcode", member.getZipcode());//집우편번호
		String addr = member.getAddress1();
		if (StringUtils.isNotBlank(member.getAddress2())) {
			addr += " "+member.getAddress2();
		}
		param.put("h_addr1", addr);//집주소
		param.put("sms_use_yn", member.getSms_service_yn());//SMS수신여부 Y/N
		param.put("mailing_use_yn", member.getEmail_service_yn());//이메일수신여부 Y/N
		param.put("gpin_sex", member.getSex());//성멸 0:남, 1:여
		param.put("manage_code", member.getManage_code());//도서관부호
		if (StringUtils.isNotEmpty(member.getCi_value())) {
			try {
				param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
			}//CI
		}
		param.put("client_ip", member.getIn_ip());//요청IP

		//선택입력값
		if (StringUtils.isNotEmpty(member.getPhone1()) && StringUtils.isNotEmpty(member.getPhone2()) && StringUtils.isNotEmpty(member.getPhone3())) {
			param.put("home_exchange_phone", member.getPhone1());//집 전화번호 첫자리
			param.put("home_phone1", member.getPhone2());//집전화번호 가운데(첫자리 있는 경우 필수)
			param.put("home_phone2", member.getPhone3());//집전화번호 뒷자리(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCell_phone1()) && StringUtils.isNotEmpty(member.getCell_phone2()) && StringUtils.isNotEmpty(member.getCell_phone3())) {
			param.put("exchange_mobile", member.getCell_phone1());//휴대전화번호 첫자리
			param.put("mobile1", member.getCell_phone2());//휴대전화번호 가운데(첫자리 있는 경우 필수)
			param.put("mobile2", member.getCell_phone3());//휴대전화번호 가운데(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getEmail1()) && StringUtils.isNotEmpty(member.getEmail2())) {
			param.put("email_id", member.getEmail1());//이메일 아이디
			param.put("email_domain", member.getEmail2());//이메일 도메인(이메일 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCompany_phone1()) && StringUtils.isNotEmpty(member.getCompany_phone2()) && StringUtils.isNotEmpty(member.getCompany_phone3())) {
			param.put("office_exchange_phone", member.getCompany_phone1());//근무지 전화번호 첫자리
			param.put("office_phone1", member.getCompany_phone2());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
			param.put("office_phone2", member.getCompany_phone3());//근무지 전화번호 가운데(첫자리 있는 경우 필수)
		}

		if (StringUtils.isNotEmpty(member.getCompany_zipcode())) {
			param.put("w_zipcode", member.getCompany_zipcode());//근무지 우편번호
		}

		if (StringUtils.isNotEmpty(member.getCompany_addr())) {
			param.put("w_addr1", member.getCompany_addr());//근무지 주소
		}

		if (StringUtils.isNotEmpty(member.getCompany_name())) {
			param.put("office_name", member.getCompany_name());//근무지 명
		}

		if (StringUtils.isNotEmpty(member.getCompany_depart())) {
			param.put("department", member.getCompany_depart());//근무지 부서명
		}

		if (StringUtils.equals(mode, "DLS")) {
			param.put("dls_id", member.getIntegrationId());//dls아이디
			param.put("user_class_code", "016");//이용자 직급 코드(016(DLS인증회원) 고정)
		}
		if (StringUtils.equals(mode, "UNTACT")) {
			param.put("user_class_code", "017");//이용자 직급 코드(017(비대면인증회원) 고정)
		}

		String user_position_code = "001"; //중앙, 228학생
		if (member.getUser_manage_code().equals("AA") || member.getUser_manage_code().equals("AH") || member.getUser_manage_code().equals("CA") || member.getUser_manage_code().equals("CB")) {
			user_position_code = "002"; //228기념, 동부, 안심, 신천
		} else if (member.getUser_manage_code().equals("AF") || member.getUser_manage_code().equals("BL") || member.getUser_manage_code().equals("BM") || member.getUser_manage_code().equals("BN")
				 || member.getUser_manage_code().equals("BP") || member.getUser_manage_code().equals("BQ")) {
			user_position_code = "003"; //서부, 대구서구어린이, 비원, 원고개, 서구영어, 비산
		} else if (member.getUser_manage_code().equals("AG") || member.getUser_manage_code().equals("BS") || member.getUser_manage_code().equals("BT")) {
			user_position_code = "004"; //남부
		} else if (member.getUser_manage_code().equals("AC") || member.getUser_manage_code().equals("BA") || member.getUser_manage_code().equals("BB") || member.getUser_manage_code().equals("BC")) {
			user_position_code = "005"; //북부, 구수산, 대현, 태전
		} else if (member.getUser_manage_code().equals("AE") || member.getUser_manage_code().equals("BD") || member.getUser_manage_code().equals("BE") || member.getUser_manage_code().equals("BF")
				 || member.getUser_manage_code().equals("BG") || member.getUser_manage_code().equals("BH") || member.getUser_manage_code().equals("BJ") || member.getUser_manage_code().equals("BK") || member.getUser_manage_code().equals("HR")) {
			user_position_code = "006"; //수성, 범어, 용학, 고산, 파동, 무학숲, 책숲길, 물망이
		} else if (member.getUser_manage_code().equals("AB") || member.getUser_manage_code().equals("BU") || member.getUser_manage_code().equals("BV") || member.getUser_manage_code().equals("BW")
				 || member.getUser_manage_code().equals("BX") || member.getUser_manage_code().equals("BY") || member.getUser_manage_code().equals("BZ")) {
			user_position_code = "007"; //두류, 성서, 달서어린이, 도원, 본리, 달서가족문화, 달서영어
		} else if (member.getUser_manage_code().equals("AJ") || member.getUser_manage_code().equals("BR")) {
			user_position_code = "008"; //달성, 달성군립
		}
		param.put("user_position_code", user_position_code);//이용자소속코드
		param.put("worker", "통합도서관홈페이지");

		return CommonAPI.sendKCMS("regularUserInfoInsert", param);
	}



}
