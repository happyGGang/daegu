package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class LectureInfo extends PagingUtils {

    private String course_id;           // 과정고유번호
    private String lecture_id;          // 강좌고유번호
    private String lecture_title;       // 강좌명
    private String edu_start_date;      // 교육기간_시작일
    private String edu_end_date;        // 교육기간_종료일
    private String edu_start_time;      // 교육시작시간
    private String edu_end_time;        // 교육종료시간
    private String request_start_date;  // 접수기간_시작일
    private String request_end_date;    // 접수기간_종료일
    private String edu_school;          // 교육장
    private int online_person_count;    // 온라인 모집인원
    private int offline_person_count;   // 오프라인 모집인원
    private int wait_person_count;      // 대기 모집인원
    private String request_type;        // 접수방법
    private String teacher_name;        // 강사명
    private String teacher_tel;         // 강사_연락처
    private String supporter_name;      // 담당자
    private String supporter_tel;       // 담당자_연락처
    private String edu_school_map;      // 교육장_지도링크
    private String lecture_content;     // 교육소개
    private Date add_date;              // 등록일
    private String add_ip;              // 등록_IP
    private String add_id;              // 등록_ID
    private String edu_address_1;       // 교육장소1
    private String edu_address_2;       // 교육장소2
    private String teacher_id;             // 강사_ID
    private String day_week;            // 교육요일
    private String edu_second_school;   // 교육장_부속
    private String auto_sms;   // 자동 sms 전송

    /**
     * DB 에서 만들어지는 값
     * */
    private String reverse_rownum;      // 순번
    private String lecture_status1;     // 모집 상태
    private String lecture_status2;     // 교육 상태
    private int online_request_count;   // 온라인 신청자 수
    private int offline_request_count;  // 오프라인 신청자 수
    private int wait_request_count;     // 대기 신청자 수
    private Date request_add_date;      // 수강신청 날짜
    private String request_add_id; // 수강신청 id
    private String request_status; // 수강신청 예약 상태
    private String request_id; // 수강신청 고유번호

    /**
     * DB에 없는 값
     * */
    private String searching_course_id; // 과정 검색을위한 필드
    private String searching_reservation; // 예약상태 검색
    private String searching_edu_status; // 교육상태 검색
    private String searching_request_type; // 접수방법 검색
    private String start_period; // 접수기간 시작
    private String end_period; // 접수기간 종료
    private String connect_type; // 접속 타입

    private String[] day_week_arr; // 요일 배열

    public String[] getDay_week_arr() {
        String[] ret = null;
        if(this.day_week_arr != null) {
            ret = new String[this.day_week_arr.length];
            for(int i = 0; i<this.day_week_arr.length; i++) {
                ret[i] = this.day_week_arr[i];
            }
        }
        return ret;
    }

    public String getRequest_id() {
        return request_id;
    }

    public void setRequest_id(String request_id) {
        this.request_id = request_id;
    }

    public String getRequest_status() {
        return request_status;
    }

    public void setRequest_status(String request_status) {
        this.request_status = request_status;
    }

    public String getRequest_add_id() {
        return request_add_id;
    }

    public void setRequest_add_id(String request_add_id) {
        this.request_add_id = request_add_id;
    }

    public String getReverse_rownum() {
        return reverse_rownum;
    }

    public void setReverse_rownum(String reverse_rownum) {
        this.reverse_rownum = reverse_rownum;
    }

    public String getStart_period() {
        return start_period;
    }

    public void setStart_period(String start_period) {
        this.start_period = start_period;
    }

    public String getEnd_period() {
        return end_period;
    }

    public void setEnd_period(String end_period) {
        this.end_period = end_period;
    }

    public String getSearching_reservation() {
        return searching_reservation;
    }

    public void setSearching_reservation(String searching_reservation) {
        this.searching_reservation = searching_reservation;
    }

    public String getSearching_edu_status() {
        return searching_edu_status;
    }

    public void setSearching_edu_status(String searching_edu_status) {
        this.searching_edu_status = searching_edu_status;
    }

    public String getSearching_request_type() {
        return searching_request_type;
    }

    public void setSearching_request_type(String searching_request_type) {
        this.searching_request_type = searching_request_type;
    }

    public void setDay_week_arr(String[] day_week_arr) {
        this.day_week_arr = new String[day_week_arr.length];
        for(int i = 0; i< day_week_arr.length; i++) {
            this.day_week_arr[i] = day_week_arr[i];
        }
    }

    public String getSearching_course_id() {
        return searching_course_id;
    }

    public void setSearching_course_id(String searching_course_id) {
        this.searching_course_id = searching_course_id;
    }

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getLecture_id() {
        return lecture_id;
    }

    public void setLecture_id(String lecture_id) {
        this.lecture_id = lecture_id;
    }

    public String getLecture_title() {
        return lecture_title;
    }

    public void setLecture_title(String lecture_title) {
        this.lecture_title = lecture_title;
    }

    public String getEdu_start_date() {
        return edu_start_date;
    }

    public void setEdu_start_date(String edu_start_date) {
        this.edu_start_date = edu_start_date;
    }

    public String getEdu_end_date() {
        return edu_end_date;
    }

    public void setEdu_end_date(String edu_end_date) {
        this.edu_end_date = edu_end_date;
    }

    public String getEdu_start_time() {
        return edu_start_time;
    }

    public void setEdu_start_time(String edu_start_time) {
        this.edu_start_time = edu_start_time;
    }

    public String getRequest_start_date() {
        return request_start_date;
    }

    public void setRequest_start_date(String request_start_date) {
        this.request_start_date = request_start_date;
    }

    public String getRequest_end_date() {
        return request_end_date;
    }

    public void setRequest_end_date(String request_end_date) {
        this.request_end_date = request_end_date;
    }

    public String getEdu_school() {
        return edu_school;
    }

    public void setEdu_school(String edu_school) {
        this.edu_school = edu_school;
    }

    public int getOnline_person_count() {
        return online_person_count;
    }

    public void setOnline_person_count(int online_person_count) {
        this.online_person_count = online_person_count;
    }

    public String getRequest_type() {
        return request_type;
    }

    public void setRequest_type(String request_type) {
        this.request_type = request_type;
    }

    public String getTeacher_name() {
        return teacher_name;
    }

    public void setTeacher_name(String teacher_name) {
        this.teacher_name = teacher_name;
    }

    public String getSupporter_name() {
        return supporter_name;
    }

    public void setSupporter_name(String supporter_name) {
        this.supporter_name = supporter_name;
    }

    public String getSupporter_tel() {
        return supporter_tel;
    }

    public void setSupporter_tel(String supporter_tel) {
        this.supporter_tel = supporter_tel;
    }

    public String getTeacher_tel() {
        return teacher_tel;
    }

    public void setTeacher_tel(String teacher_tel) {
        this.teacher_tel = teacher_tel;
    }

    public String getEdu_school_map() {
        return edu_school_map;
    }

    public void setEdu_school_map(String edu_school_map) {
        this.edu_school_map = edu_school_map;
    }

    public String getLecture_content() {
        return lecture_content;
    }

    public void setLecture_content(String lecture_content) {
        this.lecture_content = lecture_content;
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

    public String getEdu_end_time() {
        return edu_end_time;
    }

    public void setEdu_end_time(String edu_end_time) {
        this.edu_end_time = edu_end_time;
    }

    public String getEdu_address_1() {
        return edu_address_1;
    }

    public void setEdu_address_1(String edu_address_1) {
        this.edu_address_1 = edu_address_1;
    }

    public String getEdu_address_2() {
        return edu_address_2;
    }

    public void setEdu_address_2(String edu_address_2) {
        this.edu_address_2 = edu_address_2;
    }

    public int getOffline_person_count() {
        return offline_person_count;
    }

    public void setOffline_person_count(int offline_person_count) {
        this.offline_person_count = offline_person_count;
    }

    public int getWait_person_count() {
        return wait_person_count;
    }

    public void setWait_person_count(int wait_person_count) {
        this.wait_person_count = wait_person_count;
    }

    public String getTeacher_id() {
        return teacher_id;
    }

    public void setTeacher_id(String teacher_id) {
        this.teacher_id = teacher_id;
    }

    public String getDay_week() {
        return day_week;
    }

    public void setDay_week(String day_week) {
        this.day_week = day_week;
    }

    public String getEdu_second_school() {
        return edu_second_school;
    }

    public void setEdu_second_school(String edu_second_school) {
        this.edu_second_school = edu_second_school;
    }

    public String getLecture_status1() {
        return lecture_status1;
    }

    public void setLecture_status1(String lecture_status1) {
        this.lecture_status1 = lecture_status1;
    }

    public String getLecture_status2() {
        return lecture_status2;
    }

    public void setLecture_status2(String lecture_status2) {
        this.lecture_status2 = lecture_status2;
    }

    public int getOnline_request_count() {
        return online_request_count;
    }

    public void setOnline_request_count(int online_request_count) {
        this.online_request_count = online_request_count;
    }

    public int getOffline_request_count() {
        return offline_request_count;
    }

    public void setOffline_request_count(int offline_request_count) {
        this.offline_request_count = offline_request_count;
    }

    public int getWait_request_count() {
        return wait_request_count;
    }

    public void setWait_request_count(int wait_request_count) {
        this.wait_request_count = wait_request_count;
    }

    public String getConnect_type() {
        return connect_type;
    }

    public void setConnect_type(String connect_type) {
        this.connect_type = connect_type;
    }

    public Date getRequest_add_date() {
        return request_add_date;
    }

    public void setRequest_add_date(Date request_add_date) {
        this.request_add_date = request_add_date;
    }

    public String getAuto_sms() {
        return auto_sms;
    }

    public void setAuto_sms(String auto_sms) {
        this.auto_sms = auto_sms;
    }
}
