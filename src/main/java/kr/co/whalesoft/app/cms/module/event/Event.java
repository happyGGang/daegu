package kr.co.whalesoft.app.cms.module.event;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class Event extends PagingUtils {


    private int event_idx; // 이벤트IDX
    private String event_type; // 이벤트타입
    private String event_name; // 이벤트제목
    private int event_year; // 이벤트연도
    private int event_month; // 이벤트월
    private String book_name; // 책이름
    private String book_author; // 저자
    private String book_publisher; // 출판사
    private String call_no; // 청구기호
    private String book_desc; // 책설명
    private String event_start_date; // 이벤트시작날짜
    private String event_end_date; // 이벤트종료날짜
    private String book_image; // 책 이미지
    private String top_html; // 상단 HTML
    private String bottom_html; // 하단 HTML
    private String delete_yn; // 삭제여부
    private Date add_date; // 등록일
    private String add_id; // 등록ID
    private Date modify_date; // 수정일
    private String modify_id; // 수정ID
    private int event_req_count; // 이벤트 신청수
    private String school_yn = "Y"; // 학교입력여부
    private String ban_yn = "Y"; // 반입력여부
    private String hak_yn = "Y"; // 학년입력여부
    private String gender_yn = "Y"; // 성별 선택여부
    private String age_yn = "Y"; // 연령대 선택여부
    private String address_yn = "N"; // 주소 선택여부
    private int select_cnt;
    private int re_select_cnt;
    private String applicant_id_yn = "N";

    public Event() {
    }

    public Event(String homepage_id, int event_idx) {
        setHomepage_id(homepage_id);
        this.event_idx = event_idx;
    }

    // 사용자 화면에서 사용하는 생성자
    public Event(String homepage_id, String event_type, int event_year, int event_month) {
        setHomepage_id(homepage_id);
        this.event_type = event_type;
        this.event_year = event_year;
        this.event_month = event_month;
    }

    public int getEvent_idx() {
        return event_idx;
    }

    public void setEvent_idx(int event_idx) {
        this.event_idx = event_idx;
    }

    public String getEvent_type() {
        return event_type;
    }

    public void setEvent_type(String event_type) {
        this.event_type = event_type;
    }

    public String getEvent_name() {
        return event_name;
    }

    public void setEvent_name(String event_name) {
        this.event_name = event_name;
    }

    public int getEvent_year() {
        return event_year;
    }

    public void setEvent_year(int event_year) {
        this.event_year = event_year;
    }

    public int getEvent_month() {
        return event_month;
    }

    public void setEvent_month(int event_month) {
        this.event_month = event_month;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getBook_author() {
        return book_author;
    }

    public void setBook_author(String book_author) {
        this.book_author = book_author;
    }

    public String getBook_publisher() {
        return book_publisher;
    }

    public void setBook_publisher(String book_publisher) {
        this.book_publisher = book_publisher;
    }

    public String getCall_no() {
        return call_no;
    }

    public void setCall_no(String call_no) {
        this.call_no = call_no;
    }

    public String getBook_desc() {
        return book_desc;
    }

    public void setBook_desc(String book_desc) {
        this.book_desc = book_desc;
    }

    public String getEvent_start_date() {
        return event_start_date;
    }

    public void setEvent_start_date(String event_start_date) {
        this.event_start_date = event_start_date;
    }

    public String getEvent_end_date() {
        return event_end_date;
    }

    public void setEvent_end_date(String event_end_date) {
        this.event_end_date = event_end_date;
    }

    public String getBook_image() {
        return book_image;
    }

    public void setBook_image(String book_image) {
        this.book_image = book_image;
    }

    public String getTop_html() {
        return top_html;
    }

    public void setTop_html(String top_html) {
        this.top_html = top_html;
    }

    public String getBottom_html() {
        return bottom_html;
    }

    public void setBottom_html(String bottom_html) {
        this.bottom_html = bottom_html;
    }

    public String getDelete_yn() {
        return delete_yn;
    }

    public void setDelete_yn(String delete_yn) {
        this.delete_yn = delete_yn;
    }

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }

    public String getAdd_id() {
        return add_id;
    }

    public void setAdd_id(String add_id) {
        this.add_id = add_id;
    }

    public Date getModify_date() {
        return modify_date;
    }

    public void setModify_date(Date modify_date) {
        this.modify_date = modify_date;
    }

    public String getModify_id() {
        return modify_id;
    }

    public void setModify_id(String modify_id) {
        this.modify_id = modify_id;
    }

    public int getEvent_req_count() {
        return event_req_count;
    }

    public void setEvent_req_count(int event_req_count) {
        this.event_req_count = event_req_count;
    }

    public String getSchool_yn() {
        return school_yn;
    }

    public void setSchool_yn(String school_yn) {
        this.school_yn = school_yn;
    }

    public String getBan_yn() {
        return ban_yn;
    }

    public void setBan_yn(String ban_yn) {
        this.ban_yn = ban_yn;
    }

    public String getHak_yn() {
        return hak_yn;
    }

    public void setHak_yn(String hak_yn) {
        this.hak_yn = hak_yn;
    }

    public String getGender_yn() {
        return gender_yn;
    }

    public void setGender_yn(String gender_yn) {
        this.gender_yn = gender_yn;
    }

    public String getAge_yn() {
        return age_yn;
    }

    public void setAge_yn(String age_yn) {
        this.age_yn = age_yn;
    }

    public String getAddress_yn() {
        return address_yn;
    }

    public void setAddress_yn(String address_yn) {
        this.address_yn = address_yn;
    }

    public int getSelect_cnt() {
        return select_cnt;
    }

    public void setSelect_cnt(int select_cnt) {
        this.select_cnt = select_cnt;
    }

    public int getRe_select_cnt() {
        return re_select_cnt;
    }

    public void setRe_select_cnt(int re_select_cnt) {
        this.re_select_cnt = re_select_cnt;
    }

    public String getApplicant_id_yn() {
        return applicant_id_yn;
    }

    public void setApplicant_id_yn(String applicant_id_yn) {
        this.applicant_id_yn = applicant_id_yn;
    }
}
