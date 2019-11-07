package kr.co.whalesoft.app.cms.module.emailSend;

import java.util.List;
import java.util.Properties;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailSender {

	@Autowired
	private MessageSource messageSource;
	
	private static final String SMTP_HOST_NAME = "mail.info.go.kr";
	private static final String userName = "gbelib";
	private static final String userPassword = "gbelib1!";//
//	private static final String userName = "************";
//	private static final String userPassword = "*************";//

	@Async
	public static void sendMail(String title, String content, String fromEmail, List<String> toMail) {

	
		try {
//			List<String> emailList = new ArrayList<String>();// 메일 보낼사람 리스트
//			emailList.add(email);
//			emailList.add("***@naver.com");
			// emailList.add("***@naver.com");
			// emailList.add("****@gmail.com");
//			StringBuffer emailSubject = new StringBuffer();
//			emailSubject.append("["+homepage.getHomepage_name()+"] ");
//			emailSubject.append(emailSend.getTitle());
			
//			String emailMsgTxt = emailSend.getContent();// 내용
//			emailMsgTxt += "<br /><br /><br />본 메일은 발신전용메일입니다.";
//			emailMsgTxt += "<br />문의사항이 있으신 경우 PMS게시판을 이용해 주시기 바랍니다.";
//			emailMsgTxt += "<br />감사합니다.";
			fromEmail = "gbelib@info.go.kr";
			// 메일보내기
			postMail(toMail, title, content,	fromEmail);
			// System.out.println("모든 사용자에게 메일이 성공적으로 보내졌음~~");
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	private static void postMail(List<String> to, String subject, String text,String from) throws MessagingException {
		boolean debug = false;

		// Properties 설정
		Properties props = new Properties();
		props.put("mail.transport.protocol", "smtp");
//		props.put("mail.smtp.starttls.enable", "true");
//		props.put("mail.smtp.starttls.required", "true");
		props.put("mail.smtp.host", SMTP_HOST_NAME);
//		props.put("mail.smtp.auth", "true");

//		Authenticator auth = new SMTPAuthenticator();
		Session session = Session.getDefaultInstance(props, null);

		session.setDebug(debug);

		MimeMessage msg = new MimeMessage(session);

		try {
			MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "UTF-8");

			msgHelper.setSubject(subject);
			InternetAddress[] addressTo = new InternetAddress[to.size()];
			for (int i = 0; i < addressTo.length; i++) {
				addressTo[i] = new InternetAddress(to.get(i));
			}
			msgHelper.setTo(addressTo);
			msgHelper.setFrom(from);
			msgHelper.setText(text, true);

			Transport.send(msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
