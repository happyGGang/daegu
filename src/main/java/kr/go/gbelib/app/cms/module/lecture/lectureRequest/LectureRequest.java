package kr.go.gbelib.app.cms.module.lecture.lectureRequest;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class LectureRequest extends PagingUtils {

    private String lecture_id; // 강좌고유번호
    private String request_id; // 신청고유번호
    private String request_name; // 신청자명
    private String birthday; // 생년월일
    private char gender; // 성별
    private String phone_number; // 휴대전화
    private String email; // 이메일
    private String zip_code; // 우편번호
    private String address1; // 주소
    private String address2; // 상세주소
    private String request_status; // 예약상태
    private String request_type; // 접수방법
    private String complete_yn; // 수료여부
    private String cancel_yn; // 취소여부
    private Date add_date; // 등록일
    private String add_ip; // 등록 ip
    private String add_id; // 등록 id
    private Date cancel_date; // 취소날짜
    private String cancel_ip; // 취소 ip
    private String cancel_id; // 취소 id

    /**
     * LECTURE_REQUEST 테이블 외의 값
     * */
    private int reverse_rownum; // 순번
    private String lecture_title; // 강좌명
    private String course_id; // 강좌명
    private String after_raffle_list;
    private String info_request_type; // 강좌 접수방법

    /**
     * 검색을 위한 필드
     * */
    private String search_course_id; // 과정 id
    private String search_lecture_id; // 강좌 id
    private String search_request_type; // 접수방법
    private String search_cancel_yn; // 취소여부

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public int getReverse_rownum() {
        return reverse_rownum;
    }

    public void setReverse_rownum(int reverse_rownum) {
        this.reverse_rownum = reverse_rownum;
    }

    public String getLecture_title() {
        return lecture_title;
    }

    public void setLecture_title(String lecture_title) {
        this.lecture_title = lecture_title;
    }

    public String getSearch_course_id() {
        return search_course_id;
    }

    public void setSearch_course_id(String search_course_id) {
        this.search_course_id = search_course_id;
    }

    public String getSearch_lecture_id() {
        return search_lecture_id;
    }

    public void setSearch_lecture_id(String search_lecture_id) {
        this.search_lecture_id = search_lecture_id;
    }

    public String getSearch_request_type() {
        return search_request_type;
    }

    public void setSearch_request_type(String search_request_type) {
        this.search_request_type = search_request_type;
    }

    public String getSearch_cancel_yn() {
        return search_cancel_yn;
    }

    public void setSearch_cancel_yn(String search_cancel_yn) {
        this.search_cancel_yn = search_cancel_yn;
    }

    public String getLecture_id() {
        return lecture_id;
    }

    public void setLecture_id(String lecture_id) {
        this.lecture_id = lecture_id;
    }

    public String getRequest_id() {
        return request_id;
    }

    public void setRequest_id(String request_id) {
        this.request_id = request_id;
    }

    public String getRequest_name() {
        return request_name;
    }

    public void setRequest_name(String request_name) {
        this.request_name = request_name;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public char getGender() {
        return gender;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
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

    public String getRequest_status() {
        return request_status;
    }

    public void setRequest_status(String request_status) {
        this.request_status = request_status;
    }

    public String getRequest_type() {
        return request_type;
    }

    public void setRequest_type(String request_type) {
        this.request_type = request_type;
    }

    public String getComplete_yn() {
        return complete_yn;
    }

    public void setComplete_yn(String complete_yn) {
        this.complete_yn = complete_yn;
    }

    public String getCancel_yn() {
        return cancel_yn;
    }

    public void setCancel_yn(String cancel_yn) {
        this.cancel_yn = cancel_yn;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }

    public String getAdd_ip() {
        return add_ip;
    }

    public void setAdd_ip(String add_ip) {
        this.add_ip = add_ip;
    }

    public String getAdd_id() {
        return add_id;
    }

    public void setAdd_id(String add_id) {
        this.add_id = add_id;
    }

    public Date getCancel_date() {
        return cancel_date;
    }

    public void setCancel_date(Date cancel_date) {
        this.cancel_date = cancel_date;
    }

    public String getCancel_ip() {
        return cancel_ip;
    }

    public void setCancel_ip(String cancel_ip) {
        this.cancel_ip = cancel_ip;
    }

    public String getCancel_id() {
        return cancel_id;
    }

    public void setCancel_id(String cancel_id) {
        this.cancel_id = cancel_id;
    }

    public String getAfter_raffle_list() {
        return after_raffle_list;
    }

    public void setAfter_raffle_list(String after_raffle_list) {
        this.after_raffle_list = after_raffle_list;
    }

    public String getInfo_request_type() {
        return info_request_type;
    }

    public void setInfo_request_type(String info_request_type) {
        this.info_request_type = info_request_type;
    }
}
