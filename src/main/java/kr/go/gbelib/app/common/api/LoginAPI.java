package kr.go.gbelib.app.common.api;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.CalculateHashUtils;

public class LoginAPI {

	protected final static Logger log = LoggerFactory.getLogger(LoginAPI.class);

	/**
	 * K.API - 28
	 * 회원 로그인
	 * @author whalesoft YONGJU 2019. 11. 15.
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public static Object login(Member member) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		if (StringUtils.isEmpty(member.getMember_id()) && StringUtils.isNotEmpty(member.getCi_value())) {
			param.put("option", 5);
			try {
				param.put("ipin_hash", URLEncoder.encode(member.getCi_value(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
			}//CI
			param.put("api_key", "79724C6D73152DC1035B16B6198665D34A640D5D11E8ACD60083FA80FE417E58");
			member.setMember_pw("test");
		} else {
			if (StringUtils.isNotEmpty(member.getManage_code()) && member.getManage_code().length() == 2) {
				param.put("manage_code", member.getManage_code());
			}
			param.put("password", CalculateHashUtils.calculateHashSHA256(member.getMember_pw()));// PW는 sha256
			param.put("id", URLEncoder.encode(member.getMember_id(), "UTF-8"));
		}


		//local
//		param.put("option", 3);
//		param.put("user_no", member.getMember_id());
//		param.put("api_key", "79724C6D73152DC1035B16B6198665D34A640D5D11E8ACD60083FA80FE417E58");

		Map<String, Object> loginMap = CommonAPI.sendKCMS("userlogin", param);

		String resultInfo = String.valueOf(loginMap.get("RESULT_INFO"));

		if (StringUtils.equals(resultInfo, "SUCCESS")) {
			@SuppressWarnings ("unchecked")
			Map<String, Object> userMap = (Map<String, Object>) loginMap.get("USER_DATA");
			if (userMap != null && !userMap.isEmpty()) {
				if ("1".equals(String.valueOf(userMap.get("MEMBER_CLASS")))) {
					return new ApiResponse(false, "해당 회원은 제적회원 또는 탈퇴회원입니다.");
				}
				member.setUser_no(String.valueOf(userMap.get("USER_NO")));
				member.setUser_class(String.valueOf(userMap.get("USER_CLASS")));
				member.setKl_member_yn(String.valueOf(userMap.get("KL_MEMBER_YN")));
				member.setUser_class_code(String.valueOf(userMap.get("USER_CLASS_CODE")));
				member.setAgreement_yn(String.valueOf(userMap.get("AGREEMENT_YN")));
				member.setRec_key(String.valueOf(userMap.get("REC_KEY")));
				member.setAgree_yn(String.valueOf(userMap.get("AGREE_YN")));
				member.setCert_yn(String.valueOf(userMap.get("CERT_YN")));
				member.setExpiredate_yn(String.valueOf(userMap.get("EXPIREDATE_YN")));
				member.setMember_id(String.valueOf(userMap.get("USER_ID")));
				member.setMember_name(String.valueOf(userMap.get("NAME")));
				member.setLoan_stop_date(String.valueOf(userMap.get("LOAN_STOP_DATE")));
				member.setOverdue_cnt(String.valueOf(userMap.get("OVERDUE_CNT")));
				member.setLocal_loanable_cnt(String.valueOf(userMap.get("LOCAL_LOANABLE_CNT")));
				member.setUnity_loanable_cnt(String.valueOf(userMap.get("UNITY_LOANABLE_CNT")));
				member.setLocal_loan_cnt(String.valueOf(userMap.get("LOCAL_LOAN_CNT")));
				member.setUnity_loan_cnt(String.valueOf(userMap.get("UNITY_LOAN_CNT")));
				member.setLost_card_yn(String.valueOf(userMap.get("LOST_CARD_YN")));
				member.setMember_class(String.valueOf(userMap.get("MEMBER_CLASS")));
				member.setUser_position_code(String.valueOf(userMap.get("USER_POSITION_CODE")));
				member.setUser_manage_code(String.valueOf(userMap.get("USER_MANAGE_CODE")));
				member.setEmail_service_yn(String.valueOf(userMap.get("MAILING_USE_YN")));
				member.setSms_service_yn(String.valueOf(userMap.get("SMS_USE_YN")));

				try {
					Map<String, Object> libSettingInfoView = LibSearchAPI.getLibSettingInfoView(member.getUser_manage_code(), null, null, null, null, null);
					List<Map<String, String>> libMap = (List<Map<String, String>>) libSettingInfoView.get("LIB_SETTING_INFO");
					member.setLib_code(libMap.get(0).get("LIB_CODE"));
				} catch (Exception e) {
					log.error("getlibcode error");
				}


				Map<String, Object> userInfo = new HashMap<String, Object>();
				String userInfoResult = "";
				if (StringUtils.equals(member.getMember_pw(), "test")) {
					List<Map<String, Object>> maps = MemberAPI.checkDupUser("1", member);
					if (maps != null) {
						userInfo = maps.get(0);
						userInfoResult = "SUCCESS";
					}
				} else {
					userInfo = MemberAPI.getUserInfo(member.getMember_id(), member.getMember_pw());
					userInfoResult = String.valueOf(userInfo.get("RESULT_INFO"));
				}

				Map<String, Object> memberInfo = null;

				if (StringUtils.equals(userInfoResult, "SUCCESS")) {
					if (StringUtils.equals(member.getMember_pw(), "test")) {
						memberInfo = userInfo;
					} else {
						memberInfo = LibSearchAPI.getListData(userInfo, "USER_DATA").get(0);
					}


					String zipcode = String.valueOf(memberInfo.get("H_ZIPCODE"));
					if (StringUtils.isNotEmpty(zipcode) && !StringUtils.equals(zipcode, "null")) {
						member.setZipcode(zipcode);
					}

					String address = String.valueOf(memberInfo.get("H_ADDR1"));
					if (StringUtils.isNotEmpty(address) && !StringUtils.equals(address, "null")) {
						member.setAddress1(address);
						member.setAddress(address);
					}

					String handphone = String.valueOf(memberInfo.get("HANDPHONE"));
					if (StringUtils.isNotEmpty(handphone) && !StringUtils.equals(handphone, "null")) {
						member.setCell_phone(handphone);
						try {
							String[] handphone_arr = String.valueOf(memberInfo.get("HANDPHONE")).split("-");
							if (String.valueOf(memberInfo.get("HANDPHONE")) != null && !String.valueOf(memberInfo.get("HANDPHONE")).equals("")) {
								member.setCell_phone(String.valueOf(memberInfo.get("HANDPHONE")));
							}
							if (handphone_arr[0] != null && !handphone_arr[0].equals("null") && !handphone_arr[0].equals("")) {
								member.setCell_phone1(handphone_arr[0]);
							} else {
								member.setCell_phone1("");
							}
							if (handphone_arr[1] != null && !handphone_arr[1].equals("null") && !handphone_arr[1].equals("")) {
								member.setCell_phone2(handphone_arr[1]);
							} else {
								member.setCell_phone2("");
							}
							if (handphone_arr[2] != null && !handphone_arr[2].equals("null") && !handphone_arr[2].equals("")) {
								member.setCell_phone3(handphone_arr[2]);
							} else {
								member.setCell_phone3("");
							}
						} catch (Exception e) {}
					}

					String phone = String.valueOf(memberInfo.get("H_PHONE"));
					if (StringUtils.isNotEmpty(phone) && !StringUtils.equals(phone, "null")) {
						member.setPhone(phone);
						try {
							String[] phone_arr = phone.split("-");
							if (phone_arr[0] != null && !phone_arr[0].equals("null") && !phone_arr[0].equals("")) {
								member.setPhone1(phone_arr[0]);
							} else {
								member.setPhone1("");
							}
							if (phone_arr[1] != null && !phone_arr[1].equals("null") && !phone_arr[1].equals("")) {
								member.setPhone2(phone_arr[1]);
							} else {
								member.setPhone2("");
							}
							if (phone_arr[2] != null && !phone_arr[2].equals("null") && !phone_arr[2].equals("")) {
								member.setPhone3(phone_arr[2]);
							} else {
								member.setPhone3("");
							}
						} catch (Exception e) {}
					}

					String email = String.valueOf(memberInfo.get("E_MAIL"));
					if (StringUtils.isNotEmpty(email) && !StringUtils.equals(email, "null")) {
						member.setEmail(email);
						try {
							String[] email_arr = email.split("@");
							if (email_arr[0] != null && !email_arr[0].equals("null") && !email_arr[0].equals("")) {
								member.setEmail1(email_arr[0]);
							} else {
								member.setEmail1("");
							}
							if (email_arr[1] != null && !email_arr[1].equals("null") && !email_arr[1].equals("")) {
								member.setEmail2(email_arr[1]);
							} else {
								member.setEmail2("");
							}
						} catch (Exception e) {}
					}

					String gpinSex = String.valueOf(memberInfo.get("GPIN_SEX"));
					if (StringUtils.isNotEmpty(gpinSex) && !StringUtils.equals(gpinSex, "null")) {
						member.setSex(gpinSex);// 성별 (0 : 남자, 1 : 여자)
					}

					String brithsday = String.valueOf(memberInfo.get("BIRTHDAY"));
					if (StringUtils.isNotEmpty(brithsday) && !StringUtils.equals(brithsday, "null")) {
						member.setBirth_day(brithsday.replaceAll("/", "-"));
					}
				}

				return member;
			}
			return null;
		} else {
			return new ApiResponse(false, String.valueOf(loginMap.get("RESULT_MESSAGE")));
		}

	}
	
	public static Object login2(Member member) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("option", 3);
		param.put("user_no", member.getUser_no());
		param.put("api_key", "79724C6D73152DC1035B16B6198665D34A640D5D11E8ACD60083FA80FE417E58");

		Map<String, Object> loginMap = CommonAPI.sendKCMS("userlogin", param);

		String resultInfo = String.valueOf(loginMap.get("RESULT_INFO"));

		if (StringUtils.equals(resultInfo, "SUCCESS")) {
			@SuppressWarnings ("unchecked")
			Map<String, Object> userMap = (Map<String, Object>) loginMap.get("USER_DATA");
			if (userMap != null && !userMap.isEmpty()) {
				if ("1".equals(String.valueOf(userMap.get("MEMBER_CLASS")))) {
					return new ApiResponse(false, "해당 회원은 제적회원 또는 탈퇴회원입니다.");
				}
				member.setUser_no(String.valueOf(userMap.get("USER_NO")));
				member.setUser_class(String.valueOf(userMap.get("USER_CLASS")));
				member.setKl_member_yn(String.valueOf(userMap.get("KL_MEMBER_YN")));
				member.setUser_class_code(String.valueOf(userMap.get("USER_CLASS_CODE")));
				member.setAgreement_yn(String.valueOf(userMap.get("AGREEMENT_YN")));
				member.setRec_key(String.valueOf(userMap.get("REC_KEY")));
				member.setAgree_yn(String.valueOf(userMap.get("AGREE_YN")));
				member.setCert_yn(String.valueOf(userMap.get("CERT_YN")));
				member.setExpiredate_yn(String.valueOf(userMap.get("EXPIREDATE_YN")));
				member.setMember_id(String.valueOf(userMap.get("USER_ID")));
				member.setMember_name(String.valueOf(userMap.get("NAME")));
				member.setLoan_stop_date(String.valueOf(userMap.get("LOAN_STOP_DATE")));
				member.setOverdue_cnt(String.valueOf(userMap.get("OVERDUE_CNT")));
				member.setLocal_loanable_cnt(String.valueOf(userMap.get("LOCAL_LOANABLE_CNT")));
				member.setUnity_loanable_cnt(String.valueOf(userMap.get("UNITY_LOANABLE_CNT")));
				member.setLocal_loan_cnt(String.valueOf(userMap.get("LOCAL_LOAN_CNT")));
				member.setUnity_loan_cnt(String.valueOf(userMap.get("UNITY_LOAN_CNT")));
				member.setLost_card_yn(String.valueOf(userMap.get("LOST_CARD_YN")));
				member.setMember_class(String.valueOf(userMap.get("MEMBER_CLASS")));
				member.setUser_position_code(String.valueOf(userMap.get("USER_POSITION_CODE")));
				member.setUser_manage_code(String.valueOf(userMap.get("USER_MANAGE_CODE")));
				member.setEmail_service_yn(String.valueOf(userMap.get("MAILING_USE_YN")));
				member.setSms_service_yn(String.valueOf(userMap.get("SMS_USE_YN")));

				return member;
			}
			return null;
		} else {
			return new ApiResponse(false, String.valueOf(loginMap.get("RESULT_MESSAGE")));
		}

	}
}
