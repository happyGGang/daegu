package kr.go.gbelib.app.cms.module.lecture.courseInfo;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class CourseInfo extends PagingUtils {

    private String course_id;  // 과정 고유 번호
    private String course_title;  // 과정명
    private String view_start_date;  // 과정노출시작기간
    private String view_end_date;  // 과정노출종료기간
    private char use_yn;  // 사용 여부(Y,N)
    private Date add_date;  // 등록일
    private String add_id;  // 등록 ID
    private String add_ip;  // 등록 IP


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

    public char getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(char use_yn) {
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
}
