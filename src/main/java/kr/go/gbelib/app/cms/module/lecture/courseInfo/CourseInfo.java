package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;
import java.util.List;

public class CourseInfo extends PagingUtils {

    private String course_id;  // 과정 고유 번호
    private String course_title;  // 과정명
    private String view_start_date;  // 과정노출시작기간
    private String view_end_date;  // 과정노출종료기간
    private String use_yn;  // 사용 여부(Y,N)
    private Date add_date;  // 등록일
    private String add_id;  // 등록 ID
    private String add_ip;  // 등록 IP
    private int limit_count; // 1인 최대 수강신청 강좌수

    /**
     * DB에서 만들어져 오는 값
     * */
    private int reverse_rownum; // 순번
    private int day_count;

    /**
     * DB에 없는 값
     * */
    private List<String> disabledDays;  // 사용할 수 없는 날짜

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getCourse_title() {
        return course_title;
    }

    public void setCourse_title(String course_title) {
        this.course_title = course_title;
    }

    public String getView_start_date() {
        return view_start_date;
    }

    public void setView_start_date(String view_start_date) {
        this.view_start_date = view_start_date;
    }

    public String getView_end_date() {
        return view_end_date;
    }

    public void setView_end_date(String view_end_date) {
        this.view_end_date = view_end_date;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
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

    public String getAdd_ip() {
        return add_ip;
    }

    public void setAdd_ip(String add_ip) {
        this.add_ip = add_ip;
    }

    public int getReverse_rownum() {
        return reverse_rownum;
    }

    public void setReverse_rownum(int reverse_rownum) {
        this.reverse_rownum = reverse_rownum;
    }

    public int getDay_count() {
        return day_count;
    }

    public void setDay_count(int day_count) {
        this.day_count = day_count;
    }

    public List<String> getDisabledDays() {
        return disabledDays;
    }

    public void setDisabledDays(List<String> disabledDays) {
        this.disabledDays = disabledDays;
    }

    public int getLimit_count() {
        return limit_count;
    }

    public void setLimit_count(int limit_count) {
        this.limit_count = limit_count;
    }
}
