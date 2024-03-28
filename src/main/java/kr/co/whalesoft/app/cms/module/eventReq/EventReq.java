package kr.co.whalesoft.app.cms.module.eventReq;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Calendar;

public class EventReq extends PagingUtils {
    private int search_event_year = Calendar.getInstance().get(Calendar.YEAR);  //이벤트연도;
    private int search_event_month = Calendar.getInstance().get(Calendar.MONTH) + 1;  //이벤트월
    private String search_event_type;

    private int event_idx;  //이벤트IDX
    private int event_req_idx;  //이벤트신청IDX
    private String event_answer;  //이벤트신청답변
    private String name;  //신청자명
    private String school; //학교
    private int hak;  //학년
    private int ban;  //반
    private String gender;  // 성별
    private String age;  // 연령대
    private String phone;  //전화번호
    private String zip_code;
    private String address;  //주소
    private String winner_yn;  //정답자여부
    private String add_ip;  //신청IP
    private String add_id;  //등록ID
    private String add_date;  //등록일
    private String terms_yn;	//약관동의여부
    private String chosen_yn;	//당첨자여부
    private String applicant_id; // 참여자ID

    public EventReq() { }

    public EventReq(String homepage_id, int event_idx) {
        setHomepage_id(homepage_id);
        this.event_idx = event_idx;
    }


    public int getSearch_event_year() {
        return search_event_year;
    }

    public void setSearch_event_year(int search_event_year) {
        this.search_event_year = search_event_year;
    }

    public int getSearch_event_month() {
        return search_event_month;
    }

    public void setSearch_event_month(int search_event_month) {
        this.search_event_month = search_event_month;
    }

    public String getSearch_event_type() {
        return search_event_type;
    }

    public void setSearch_event_type(String search_event_type) {
        this.search_event_type = search_event_type;
    }

    public int getEvent_idx() {
        return event_idx;
    }

    public void setEvent_idx(int event_idx) {
        this.event_idx = event_idx;
    }

    public int getEvent_req_idx() {
        return event_req_idx;
    }

    public void setEvent_req_idx(int event_req_idx) {
        this.event_req_idx = event_req_idx;
    }

    public String getEvent_answer() {
        return event_answer;
    }

    public void setEvent_answer(String event_answer) {
        this.event_answer = event_answer;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public int getHak() {
        return hak;
    }

    public void setHak(int hak) {
        this.hak = hak;
    }

    public int getBan() {
        return ban;
    }

    public void setBan(int ban) {
        this.ban = ban;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWinner_yn() {
        return winner_yn;
    }

    public void setWinner_yn(String winner_yn) {
        this.winner_yn = winner_yn;
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

    public String getAdd_date() {
        return add_date;
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date;
    }

    public String getTerms_yn() {
        return terms_yn;
    }

    public void setTerms_yn(String terms_yn) {
        this.terms_yn = terms_yn;
    }

    public String getChosen_yn() {
        return chosen_yn;
    }

    public void setChosen_yn(String chosen_yn) {
        this.chosen_yn = chosen_yn;
    }

    public String getApplicant_id() {
        return applicant_id;
    }

    public void setApplicant_id(String applicant_id) {
        this.applicant_id = applicant_id;
    }

    @Override
    public String toString() {
        return String.format(
                "EventReq [event_idx=%s, event_req_idx=%s, event_answer=%s, name=%s, school=%s, hak=%s, ban=%s, phone=%s, zip_code=%s, address=%s, winner_yn=%s, add_ip=%s, add_id=%s, add_date=%s, terms_yn=%s, chosen_yn=%s]",
                event_idx, event_req_idx, event_answer, name, school, hak, ban, phone, zip_code, address, winner_yn,
                add_ip, add_id, add_date, terms_yn, chosen_yn);
    }
}
