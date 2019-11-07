package kr.go.gbelib.app.common.api;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.emailSend.EmailSender;

public class PushAPI {
	protected final static Logger log = LoggerFactory.getLogger(PushAPI.class);

	public static final String EMAIL_URL 	= "";
	public static final String SMS_URL 		= "";
	
	public static final int SMS_TYPE_EMAIL 	= 1;
	public static final int SMS_TYPE_SMS 	= 2;
	
	//public static void sendMessage(String homepage_id, int type, String auth_id, String message)
	
	/**
	 * 사용자용
	 * @param homepage
	 * @param type SmsAPI static 변수 SMS_TYPE_EMAIL, SMS_TYPE_SMS
	 * @param cellPhone SMS_TYPE_SMS : 전송될 수신자 폰번호, SMS_TYPE_EMAIL : 이메일 주소
	 * @param message 전송될 문구
	 * @param fromTel SMS_TYPE_SMS : 발신번호, SMS_TYPE_EMAIL : 발신 메일주소
	 * @param includeLibName SMS_TYPE_SMS : 문자메시지 앞에 도서관명 포함여부, SMS_TYPE_EMAIL : null
	 */
	@Async
	public static void sendMessage(Homepage homepage, int type, String cellPhone, String message, String fromTel, boolean includeLibName) {
		Member member = new Member();
		member.setCell_phone(cellPhone);
		member.setEmail(cellPhone);
		sendMessage(homepage, type, member, message, null, fromTel, includeLibName, "");
	}
	
	/**
	 * 사용자용
	 * @param homepage
	 * @param type SmsAPI static 변수 SMS_TYPE_EMAIL, SMS_TYPE_SMS
	 * @param cellPhone SMS_TYPE_SMS : 전송될 수신자 폰번호, SMS_TYPE_EMAIL : 이메일 주소
	 * @param title 전송될 문구
	 * @param message 전송될 문구
	 * @param fromTel SMS_TYPE_SMS : 발신번호, SMS_TYPE_EMAIL : 발신 메일주소
	 * @param includeLibName SMS_TYPE_SMS : 문자메시지 앞에 도서관명 포함여부, SMS_TYPE_EMAIL : null
	 * @param includeLibName SMS_TYPE_EMAIL : 메일 제목
	 */
	@Async
	public static void sendMessage(Homepage homepage, int type, String cellPhone, String message, String fromTel, boolean includeLibName, String title) {
		Member member = new Member();
		member.setCell_phone(cellPhone);
		member.setEmail(cellPhone);
		sendMessage(homepage, type, member, message, null, fromTel, includeLibName, title);
	}
	
	/**
	 * @param type SmsAPI static 변수 SMS_TYPE_EMAIL, SMS_TYPE_SMS
	 * @param member 전송될 수신자 정보 EMAIL - member.email, SMS - member.cell_phone 
	 * @param message 전송될 문구
	 * @param sendTime 전송될 시간 yyyy-MM-dd hh:mm
	 */
	@Async
	private static void sendMessage(Homepage homepage, int type, Member member, String message, String sendTime, String fromTel, boolean includeLibName, String title) {
		switch (type) {
			case SMS_TYPE_EMAIL:
				sendEmail(homepage, member, message, sendTime, fromTel, title);
				break;
			case SMS_TYPE_SMS:
				sendSms(homepage, member, message, fromTel, includeLibName);
				break;
			default:
				break;
		}
	}
	
	/**
	 * @param homepage_id
	 * @param member
	 * @param message
	 */
	@Async
	private static void sendEmail(Homepage homepage, Member member, String message, String sendTime, String fromEmail, String title) {
		String sendEmail = member.getEmail();
		if ( sendEmail != null && message != null ) {
			if ( StringUtils.isNotEmpty(sendEmail.trim()) && StringUtils.isNotEmpty(message.trim())) {
				title = StringUtils.isEmpty(title) ? "["+homepage.getHomepage_name()+"]에서 발송된 메일입니다." : "["+homepage.getHomepage_name()+"] " + title;
				fromEmail = StringUtils.isEmpty(fromEmail) ? "gbelib@info.go.kr" : fromEmail;
				List<String> emailList = new ArrayList<String>();
				emailList.add(sendEmail);
				EmailSender.sendMail(title, message, fromEmail, emailList);
			}
			else {
			}	
		}
		else {
		}
	}
	
	/**
	 * @param homepage_id
	 * @param member
	 * @param message
	 */
	private static void sendSms(Homepage homepage, Member member, String message, String fromTel, boolean includeLibName) {
		String sendSms = member.getCell_phone();
		if (StringUtils.isEmpty(fromTel) ) {
			fromTel = "0538109999";
		}
		if ( StringUtils.isNotEmpty(sendSms) && StringUtils.isNotEmpty(message) ) { 
			
			if ( StringUtils.isNotEmpty(sendSms.trim()) && StringUtils.isNotEmpty(message.trim())) {
				sendSms = sendSms.replaceAll("-", "");
				if (includeLibName) {
					message = String.format("[%s] - %s", homepage.getHomepage_name(), message);
				}
				MemberAPI.sendSMS("WEB", homepage.getHomepage_code(), "t23", sendSms, fromTel, message);
			}	
		}
		else {
		}
	}
}
