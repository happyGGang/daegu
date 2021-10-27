package kr.go.gbelib.app.cms.module.lecture;

import org.springframework.stereotype.Service;

@Service
public class SendMessageService {

    public void printMessage(String name, String phone_number, String lecture_title, String support_name, String support_tel, String request_status, String content) {

        System.out.println("메시지 발송\n" +
                "받는사람 : " + name + "\n" +
                "전화번호 : " + phone_number + "\n" +
                "강좌이름 : " + lecture_title + "\n" +
                "담당자 : " + support_name + "\n" +
                "담당자번호 : " + support_tel + "\n" +
                "예약상태 : " + request_status + "\n" +
                "문자내용 : " + content);
    }

}
