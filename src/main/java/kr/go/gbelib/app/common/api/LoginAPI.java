package kr.go.gbelib.app.common.api;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import kr.co.whalesoft.app.cms.member.Member;

public class LoginAPI {
	protected final static Logger log = LoggerFactory.getLogger(LoginAPI.class);

	/**
	 * 로그인 API
	 * @param id
	 * @param pw
	 * @return String[]
	 * @throws Exception
	 */
	public static Object login(Member member) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkLogin");
//		param.put("vId", StringUtils.leftPad(StringUtils.upperCase(id), 12, "0"));
		param.put("vId", member.getMember_id());


//		if (member.getLoginType2().equals("id")) {
			param.put("vPw", CommonAPI.getCrypt(member.getMember_pw()));
//			param.put("vType", "0002"); // WEB_ID OR USER_ID 일경우 넣어줘야 함.
//		} else {
//			param.put("vPw", CommonAPI.getCrypt(member.getMember_name()));
//			param.put("vType", "0003"); // WEB_ID OR USER_ID 일경우 넣어줘야 함.
//		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");

		if ( "0".equals(code) ) { // 로그인 성공
			member.setLoginType("HOMEPAGE");
			NodeList nodeList = doc.getElementsByTagName("field");
			for ( int i = 0; i < nodeList.getLength(); i ++ ) {
				Node oneNode = nodeList.item(i);
				String nodeName = oneNode.getAttributes().getNamedItem("name").getNodeValue();
				if ( "USER_ID".equals(nodeName) ) {
					member.setMember_id(oneNode.getTextContent());
					member.setUser_id(oneNode.getTextContent());// 대출번호 넘어옴 ex)1234214342532 << 숫자
					//준회원은 *******123456 형태였다가 정회원이 되면 *******값이 숫자로 변경되어 유니크가 아니여서 member_id로 사용 못함.
				}
				else if ( "WEB_ID".equals(nodeName) ) {
					//기존 회원은 web_id 자체가 없는 애들도 있어서 member_id로 활용 못함.
					//탈퇴시 web_id는 삭제되어 재 사용이 가능해짐.
					if (StringUtils.isNotEmpty(oneNode.getTextContent())) {
						member.setMember_id(oneNode.getTextContent());
					}
					member.setWeb_id(oneNode.getTextContent());
				}
				else if ( "USER_NAME".equals(nodeName) ) {
					member.setMember_name(oneNode.getTextContent());
				}
				else if ( "USER_NO".equals(nodeName) ) {
					member.setUser_no(oneNode.getTextContent());
				}
				else if ( "PASSWORD".equals(nodeName) ) {
					member.setMember_pw(oneNode.getTextContent());
				}
				else if ( "PASSWORD_EXPIRY_DAY".equals(nodeName) ) {
					member.setPassword_expiry_day(oneNode.getTextContent());
				}
				else if ( "PASSWORD_UPDATE_DATE".equals(nodeName) ) {
					member.setPassword_update_date(oneNode.getTextContent());
				}
				else if ( "SEQ_NO".equals(nodeName) ) {
					member.setSeq_no(oneNode.getTextContent());
				}
				else if ( "CARD_NO".equals(nodeName) ) {
					member.setCard_no(oneNode.getTextContent());
				}
				else if ( "MOBILE_NO".equals(nodeName) ) {
					member.setMobile_no(oneNode.getTextContent());


					String cellPhone = member.getMobile_no();
					if ( !StringUtils.isEmpty(cellPhone) ) {
						try {
							cellPhone = cellPhone.replaceAll("-", "");
							Long.parseLong(cellPhone);
							if ( cellPhone.length() > 3 ) {
								member.setCell_phone1(cellPhone.substring(0, 3));
							} else {
								member.setCell_phone1(cellPhone.substring(0));
							}

							String phoneTemp = cellPhone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else {
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (cellPhone.length() >= 11) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else if (cellPhone.length() == 10) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

				}
				else if ( "UN_AGREE_FLAG".equals(nodeName) ) {
					member.setUnAgreeFlag(oneNode.getTextContent());
				}
				else if ( "UN_AGREE_DATE".equals(nodeName) ) {
					member.setUnAgreeDate(oneNode.getTextContent());
				}

				else if ( "STATUS_CODE".equals(nodeName) ) {
					String statusCode = oneNode.getTextContent();
					if ("0001".equals(statusCode) || "0".equals(statusCode)) {
						member.setAuth_id("20000"); //정회원
						member.setAuth_id_list("20000");
					}
					else if ("0002".equals(statusCode) || "1".equals(statusCode)) {
						member.setAuth_id("30000"); // 준회원
						member.setAuth_id_list("30000");
					}
					else {
						member.setAuth_id("9999999"); // 모르는 회원
					}
					member.setStatus_code(statusCode);
				}
				else if ( "LOCA".equals(nodeName) ) {
					member.setLoca(oneNode.getTextContent());
				}
				else if ( "LOCA_NAME".equals(nodeName) ) {
					member.setLoca_name(oneNode.getTextContent());
				}
				else if ( "AGREE_DATE".equals(nodeName) ) {
					if ( !StringUtils.isEmpty(oneNode.getTextContent()) ) {
						String[] parsePatterns = {"yyyyMMdd"};
						Date agreeDate = DateUtils.parseDate(oneNode.getTextContent(), parsePatterns);
						member.setAgree_date(agreeDate);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
						member.setAgree_date_str(sdf.format(member.getAgree_date()));
					}
				}
				else if ("NOT_LOAN_SDATE".equals(nodeName) ) {
					member.setNot_loan_sdate(oneNode.getTextContent());
				}
				else if ("NOT_LOAN_EDATE".equals(nodeName) ) {
					member.setNot_loan_edate(oneNode.getTextContent());
				}
			}
			List<Map<String, String>> memberInfo = MemberAPI.getMemberList("WEB", member);
			for (Map<String, String> map : memberInfo) {
				if (StringUtils.isNotEmpty(map.get("SMS_CHECK"))) {
					member.setSms_service_yn(map.get("SMS_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("MAIL_CHECK"))) {
					member.setEmail_service_yn(map.get("MAIL_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("BIRTHD"))) {
					member.setBirth_day(map.get("BIRTHD"));
				}
				if (StringUtils.isNotEmpty(map.get("SEX"))) {
					member.setSex(map.get("SEX"));
				}
				if (StringUtils.isNotEmpty(map.get("EMAIL"))) {
					member.setEmail(map.get("EMAIL"));
				}
				if (StringUtils.isNotEmpty(map.get("CONN_INFO"))) {
					member.setCi_value(map.get("CONN_INFO"));
				}
				if (StringUtils.isNotEmpty(map.get("DUPINFO"))) {
					member.setDi_value(map.get("DUPINFO"));
				}
				if (StringUtils.isNotEmpty(map.get("ADDRS"))) {
					member.setAddress1(map.get("ADDRS"));
				}
				if (StringUtils.isNotEmpty(map.get("ZIP_CODE"))) {
					member.setZipcode(map.get("ZIP_CODE"));
				}
				if (StringUtils.isNotEmpty(map.get("TEL_NO"))) {
					member.setPhone(map.get("TEL_NO"));
					String phone = member.getPhone();
					if ( !StringUtils.isEmpty(phone) ) {
						try {
							phone = phone.replaceAll("-", "");
							Long.parseLong(phone);
							if ( phone.length() > 3 ) {
								member.setPhone1(phone.substring(0, 3));
							} else {
								member.setPhone1(phone.substring(0));
							}

							String phoneTemp = phone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else {
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (phone.length() >= 11) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else if (phone.length() == 10) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}
				}
				if (StringUtils.isNotEmpty(map.get("LOGIN_DATE"))) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					member.setLast_login(sdf.parse(map.get("LOGIN_DATE")));
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
					member.setLast_login_str(sdf2.format(member.getLast_login()));
				}
			}

			return member;
		}
		else { // 로그인 실패
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 로그인API 대출자번호용
	 * @author YONGJU 2018. 2. 20.
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public static Object login2(Member member) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkLogin");
//		param.put("vId", StringUtils.leftPad(StringUtils.upperCase(id), 12, "0"));
		param.put("vId", member.getMember_id());


//		if (member.getLoginType2().equals("id")) {
//		param.put("vPw", CommonAPI.getCrypt(member.getMember_pw()));
//		param.put("vType", "0002"); // WEB_ID OR USER_ID 일경우 넣어줘야 함.
//		} else {
			param.put("vPw", CommonAPI.getCrypt(member.getMember_name()));
			param.put("vType", "0003"); // WEB_ID OR USER_ID 일경우 넣어줘야 함.
//		}

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");

		if ( "0".equals(code) ) { // 로그인 성공
			member.setLoginType("HOMEPAGE");
			NodeList nodeList = doc.getElementsByTagName("field");
			for ( int i = 0; i < nodeList.getLength(); i ++ ) {
				Node oneNode = nodeList.item(i);
				String nodeName = oneNode.getAttributes().getNamedItem("name").getNodeValue();
				if ( "USER_ID".equals(nodeName) ) {
					member.setMember_id(oneNode.getTextContent());
					member.setUser_id(oneNode.getTextContent());// 대출번호 넘어옴 ex)1234214342532 << 숫자
					//준회원은 *******123456 형태였다가 정회원이 되면 *******값이 숫자로 변경되어 유니크가 아니여서 member_id로 사용 못함.
				}
				else if ( "WEB_ID".equals(nodeName) ) {
					//기존 회원은 web_id 자체가 없는 애들도 있어서 member_id로 활용 못함.
					//탈퇴시 web_id는 삭제되어 재 사용이 가능해짐.
					if (StringUtils.isNotEmpty(oneNode.getTextContent())) {
						member.setMember_id(oneNode.getTextContent());
					}
					member.setWeb_id(oneNode.getTextContent());
				}
				else if ( "USER_NAME".equals(nodeName) ) {
					member.setMember_name(oneNode.getTextContent());
				}
				else if ( "USER_NO".equals(nodeName) ) {
					member.setUser_no(oneNode.getTextContent());
				}
				else if ( "PASSWORD".equals(nodeName) ) {
					member.setMember_pw(oneNode.getTextContent());
				}
				else if ( "SEQ_NO".equals(nodeName) ) {

					member.setSeq_no(oneNode.getTextContent());
				}
				else if ( "CARD_NO".equals(nodeName) ) {
					member.setCard_no(oneNode.getTextContent());
				}
				else if ( "MOBILE_NO".equals(nodeName) ) {
					member.setMobile_no(oneNode.getTextContent());


					String cellPhone = member.getMobile_no();
					if ( !StringUtils.isEmpty(cellPhone) ) {
						try {
							cellPhone = cellPhone.replaceAll("-", "");
							Long.parseLong(cellPhone);
							if ( cellPhone.length() > 3 ) {
								member.setCell_phone1(cellPhone.substring(0, 3));
							} else {
								member.setCell_phone1(cellPhone.substring(0));
							}

							String phoneTemp = cellPhone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else {
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (cellPhone.length() >= 11) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else if (cellPhone.length() == 10) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

				}
				else if ( "UN_AGREE_FLAG".equals(nodeName) ) {
					member.setUnAgreeFlag(oneNode.getTextContent());
				}
				else if ( "UN_AGREE_DATE".equals(nodeName) ) {
					member.setUnAgreeDate(oneNode.getTextContent());
				}

				else if ( "STATUS_CODE".equals(nodeName) ) {
					String statusCode = oneNode.getTextContent();
					if ("0001".equals(statusCode) || "0".equals(statusCode)) {
						member.setAuth_id("20000"); //정회원
						member.setAuth_id_list("20000");
					}
					else if ("0002".equals(statusCode) || "1".equals(statusCode)) {
						member.setAuth_id("30000"); // 준회원
						member.setAuth_id_list("30000");
					}
					else {
						member.setAuth_id("9999999"); // 모르는 회원
					}
					member.setStatus_code(statusCode);
				}
				else if ( "LOCA".equals(nodeName) ) {
					member.setLoca(oneNode.getTextContent());
				}
				else if ( "LOCA_NAME".equals(nodeName) ) {
					member.setLoca_name(oneNode.getTextContent());
				}
				else if ( "AGREE_DATE".equals(nodeName) ) {
					if ( !StringUtils.isEmpty(oneNode.getTextContent()) ) {
						String[] parsePatterns = {"yyyyMMdd"};
						Date agreeDate = DateUtils.parseDate(oneNode.getTextContent(), parsePatterns);
						member.setAgree_date(agreeDate);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
						member.setAgree_date_str(sdf.format(member.getAgree_date()));
					}
				}
			}
			List<Map<String, String>> memberInfo = MemberAPI.getMemberList("WEB", member);
			for (Map<String, String> map : memberInfo) {
				if (StringUtils.isNotEmpty(map.get("SMS_CHECK"))) {
					member.setSms_service_yn(map.get("SMS_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("MAIL_CHECK"))) {
					member.setEmail_service_yn(map.get("MAIL_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("BIRTHD"))) {
					member.setBirth_day(map.get("BIRTHD"));
				}
				if (StringUtils.isNotEmpty(map.get("SEX"))) {
					member.setSex(map.get("SEX"));
				}
				if (StringUtils.isNotEmpty(map.get("EMAIL"))) {
					member.setEmail(map.get("EMAIL"));
				}
				if (StringUtils.isNotEmpty(map.get("CONN_INFO"))) {
					member.setCi_value(map.get("CONN_INFO"));
				}
				if (StringUtils.isNotEmpty(map.get("DUPINFO"))) {
					member.setDi_value(map.get("DUPINFO"));
				}
				if (StringUtils.isNotEmpty(map.get("ADDRS"))) {
					member.setAddress1(map.get("ADDRS"));
				}
				if (StringUtils.isNotEmpty(map.get("ZIP_CODE"))) {
					member.setZipcode(map.get("ZIP_CODE"));
				}
				if (StringUtils.isNotEmpty(map.get("TEL_NO"))) {
					member.setPhone(map.get("TEL_NO"));
					String phone = member.getPhone();
					if ( !StringUtils.isEmpty(phone) ) {
						try {
							phone = phone.replaceAll("-", "");
							Long.parseLong(phone);
							if ( phone.length() > 3 ) {
								member.setPhone1(phone.substring(0, 3));
							} else {
								member.setPhone1(phone.substring(0));
							}

							String phoneTemp = phone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else {
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (phone.length() >= 11) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else if (phone.length() == 10) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}
				}
				if (StringUtils.isNotEmpty(map.get("LOGIN_DATE"))) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					member.setLast_login(sdf.parse(map.get("LOGIN_DATE")));
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
					member.setLast_login_str(sdf2.format(member.getLast_login()));
				}
			}

			return member;
		}
		else { // 로그인 실패
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * RFID 로그인
	 * @author YONGJU 2018. 2. 4.
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public static Object rfidLogin(Member member) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkRfidUserCheckAndCardPw");
		param.put("vLocation", member.getLoca());
		param.put("vRfidTag", member.getMember_id().toUpperCase());
		param.put("vTagDiv", ",");

		Document doc = CommonAPI.sendILUS(param);

		String code = CommonAPI.getElementValueByName(doc, "code");

		if ( "0".equals(code) ) { // 로그인 성공
			member.setLoginType("HOMEPAGE");
			NodeList nodeList = doc.getElementsByTagName("field");
			for ( int i = 0; i < nodeList.getLength(); i ++ ) {
				Node oneNode = nodeList.item(i);
				String nodeName = oneNode.getAttributes().getNamedItem("name").getNodeValue();
				if ( "USER_ID".equals(nodeName) ) {
					member.setMember_id(oneNode.getTextContent());
					member.setUser_id(oneNode.getTextContent());// 대출번호 넘어옴 ex)1234214342532 << 숫자
					//준회원은 *******123456 형태였다가 정회원이 되면 *******값이 숫자로 변경되어 유니크가 아니여서 member_id로 사용 못함.
				}
				else if ( "WEB_ID".equals(nodeName) ) {
					//기존 회원은 web_id 자체가 없는 애들도 있어서 member_id로 활용 못함.
					//탈퇴시 web_id는 삭제되어 재 사용이 가능해짐.
					if (StringUtils.isNotEmpty(oneNode.getTextContent())) {
						member.setMember_id(oneNode.getTextContent());
					}
					member.setWeb_id(oneNode.getTextContent());
				}
				else if ( "USER_NAME".equals(nodeName) ) {
					member.setMember_name(oneNode.getTextContent());
				}
				else if ( "USER_NO".equals(nodeName) ) {
					member.setUser_no(oneNode.getTextContent());
				}
				else if ( "PASSWORD".equals(nodeName) ) {
					member.setMember_pw(oneNode.getTextContent());
				}
				else if ( "SEQ_NO".equals(nodeName) ) {

					member.setSeq_no(oneNode.getTextContent());
				}
				else if ( "CARD_NO".equals(nodeName) ) {
					member.setCard_no(oneNode.getTextContent());
				}
				else if ( "MOBILE_NO".equals(nodeName) ) {
					member.setMobile_no(oneNode.getTextContent());


					String cellPhone = member.getMobile_no();
					if ( !StringUtils.isEmpty(cellPhone) ) {
						try {
							cellPhone = cellPhone.replaceAll("-", "");
							Long.parseLong(cellPhone);
							if ( cellPhone.length() > 3 ) {
								member.setCell_phone1(cellPhone.substring(0, 3));
							} else {
								member.setCell_phone1(cellPhone.substring(0));
							}

							String phoneTemp = cellPhone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else {
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (cellPhone.length() >= 11) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 7));
								member.setCell_phone3(cellPhone.substring(7));
							} else if (cellPhone.length() == 10) {
								member.setCell_phone1(cellPhone.substring(0, 3));
								member.setCell_phone2(cellPhone.substring(3, 6));
								member.setCell_phone3(cellPhone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}

				}
				else if ( "UN_AGREE_FLAG".equals(nodeName) ) {
					member.setUnAgreeFlag(oneNode.getTextContent());
				}
				else if ( "UN_AGREE_DATE".equals(nodeName) ) {
					member.setUnAgreeDate(oneNode.getTextContent());
				}

				else if ( "STATUS_CODE".equals(nodeName) ) {
					String statusCode = oneNode.getTextContent();
					if ("0001".equals(statusCode) || "0".equals(statusCode)) {
						member.setAuth_id("20000"); //정회원
						member.setAuth_id_list("20000");
					}
					else if ("0002".equals(statusCode) || "1".equals(statusCode)) {
						member.setAuth_id("30000"); // 준회원
						member.setAuth_id_list("30000");
					}
					else {
						member.setAuth_id("9999999"); // 모르는 회원
					}
					member.setStatus_code(statusCode);
				}
				else if ( "LOCA".equals(nodeName) ) {
					member.setLoca(oneNode.getTextContent());
				}
				else if ( "LOCA_NAME".equals(nodeName) ) {
					member.setLoca_name(oneNode.getTextContent());
				}
				else if ( "AGREE_DATE".equals(nodeName) ) {
					if ( !StringUtils.isEmpty(oneNode.getTextContent()) ) {
						String[] parsePatterns = {"yyyyMMdd"};
						Date agreeDate = DateUtils.parseDate(oneNode.getTextContent(), parsePatterns);
						member.setAgree_date(agreeDate);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
						member.setAgree_date_str(sdf.format(member.getAgree_date()));
					}
				}
			}
			List<Map<String, String>> memberInfo = MemberAPI.getMemberList("WEB", member);
			for (Map<String, String> map : memberInfo) {
				if (StringUtils.isNotEmpty(map.get("SMS_CHECK"))) {
					member.setSms_service_yn(map.get("SMS_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("MAIL_CHECK"))) {
					member.setEmail_service_yn(map.get("MAIL_CHECK"));
				}
				if (StringUtils.isNotEmpty(map.get("BIRTHD"))) {
					member.setBirth_day(map.get("BIRTHD"));
				}
				if (StringUtils.isNotEmpty(map.get("SEX"))) {
					member.setSex(map.get("SEX"));
				}
				if (StringUtils.isNotEmpty(map.get("EMAIL"))) {
					member.setEmail(map.get("EMAIL"));
				}
				if (StringUtils.isNotEmpty(map.get("CONN_INFO"))) {
					member.setCi_value(map.get("CONN_INFO"));
				}
				if (StringUtils.isNotEmpty(map.get("DUPINFO"))) {
					member.setDi_value(map.get("DUPINFO"));
				}
				if (StringUtils.isNotEmpty(map.get("ADDRS"))) {
					member.setAddress1(map.get("ADDRS"));
				}
				if (StringUtils.isNotEmpty(map.get("ZIP_CODE"))) {
					member.setZipcode(map.get("ZIP_CODE"));
				}
				if (StringUtils.isNotEmpty(map.get("TEL_NO"))) {
					member.setPhone(map.get("TEL_NO"));
					String phone = member.getPhone();
					if ( !StringUtils.isEmpty(phone) ) {
						try {
							phone = phone.replaceAll("-", "");
							Long.parseLong(phone);
							if ( phone.length() > 3 ) {
								member.setPhone1(phone.substring(0, 3));
							} else {
								member.setPhone1(phone.substring(0));
							}

							String phoneTemp = phone.substring(3);
							if ( phoneTemp.length() >= 8 ) {
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else {
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						}
						catch (NumberFormatException e) {
							// 숫자가 아니면 파싱안함.
							if (phone.length() >= 11) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 7));
								member.setPhone3(phone.substring(7));
							} else if (phone.length() == 10) {
								member.setPhone1(phone.substring(0, 3));
								member.setPhone2(phone.substring(3, 6));
								member.setPhone3(phone.substring(6));
							}
						} catch (Exception e) {
							// TODO: handle exception
						}
					}
				}
				if (StringUtils.isNotEmpty(map.get("LOGIN_DATE"))) {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
					member.setLast_login(sdf.parse(map.get("LOGIN_DATE")));
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
					member.setLast_login_str(sdf2.format(member.getLast_login()));
				}
			}

			return member;
		}
		else { // 로그인 실패
			return new ApiResponse(false, CommonAPI.getElementValueByName(doc, "message"));
		}
	}

	/**
	 * 문자열 암호화 API
	 * @param vPw
	 * @return String
	 * @throws Exception
	 */
	public static String getCrypt(String vPw) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("USERID", "WEB");
		param.put("className", "action.lnk.LnkCrypt");
		param.put("vType", "en_duplex");
		param.put("vText", vPw);
		param.put("vBrowser", "Y");

		Document doc = CommonAPI.sendILUS(param);
		String code = CommonAPI.getElementValueByName(doc, "code");

		if ( "0".equals(code) ) {
			return CommonAPI.getElementValueByName(doc, "field");
		}
		else {
			return null;
		}
	}

}
