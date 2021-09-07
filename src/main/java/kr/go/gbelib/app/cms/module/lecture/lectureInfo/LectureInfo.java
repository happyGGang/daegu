package kr.go.gbelib.app.cms.module.lecture.lectureInfo;

import kr.co.whalesoft.framework.utils.PagingUtils;
import java.util.List;

public class LectureInfo extends PagingUtils {

    private String lecture_id;
    private String request_id;
    private String lecture_title;
    private String edu_start_date;
    private String edu_end_date;
    private String edu_start_time;
    private String edu_start_time_1;
    private String edu_start_time_2;
    private String edu_end_time;
    private String edu_end_time_1;
    private String edu_end_time_2;
    private String day_week = "";
    private String day_week_array[];
    private String request_start_date;
    private String request_end_date;
    private String edu_address_1;
    private String edu_address_2;
    private String edu_school;
    private String edu_second_school;
    private String edu_school_map;
    private int online_person_count;
    private int offline_person_count;
    private int wait_person_count;
    private String edu_category;
    private String edu_category_array[];
    private String edu_target;
    private String edu_target_array[];
    private String request_type;
    private String student_id;
    private String teacher_id;
    private String teacher_name;
    private String teacher_tel;
    private String supporter_name;
    private String supporter_tel;
    private String lecture_content;
    private String duplicate_yn;

    private int online_request_count;
    private int offline_request_count;
    private int wait_request_count;
    private String lecture_status1;
    private String lecture_status2;

    private String member_type = "MEMBER";

    private int file_count = 1;
    private String file_original_name;
    private String file_server_name;
    private List<String> delete_file_list;

    private String search_edu_status;	//교육상태
    private String search_request_type;	//접수방법

    private LectureInfo search;

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

    public String getEdu_start_time_1() {
        return edu_start_time_1;
    }

    public void setEdu_start_time_1(String edu_start_time_1) {
        this.edu_start_time_1 = edu_start_time_1;
    }

    public String getEdu_start_time_2() {
        return edu_start_time_2;
    }

    public void setEdu_start_time_2(String edu_start_time_2) {
        this.edu_start_time_2 = edu_start_time_2;
    }

    public String getEdu_end_time() {
        return edu_end_time;
    }

    public void setEdu_end_time(String edu_end_time) {
        this.edu_end_time = edu_end_time;
    }

    public String getEdu_end_time_1() {
        return edu_end_time_1;
    }

    public void setEdu_end_time_1(String edu_end_time_1) {
        this.edu_end_time_1 = edu_end_time_1;
    }

    public String getEdu_end_time_2() {
        return edu_end_time_2;
    }

    public void setEdu_end_time_2(String edu_end_time_2) {
        this.edu_end_time_2 = edu_end_time_2;
    }

    public String getDay_week() {
        return day_week;
    }

    public void setDay_week(String day_week) {
        this.day_week = day_week;
    }

    public String[] getDay_week_array() {
        return day_week_array;
    }

    public void setDay_week_array(String[] day_week_array) {
        this.day_week_array = day_week_array;
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

    public String getEdu_school() {
        return edu_school;
    }

    public void setEdu_school(String edu_school) {
        this.edu_school = edu_school;
    }

    public String getEdu_second_school() {
        return edu_second_school;
    }

    public void setEdu_second_school(String edu_second_school) {
        this.edu_second_school = edu_second_school;
    }

    public String getEdu_school_map() {
        return edu_school_map;
    }

    public void setEdu_school_map(String edu_school_map) {
        this.edu_school_map = edu_school_map;
    }

    public int getOnline_person_count() {
        return online_person_count;
    }

    public void setOnline_person_count(int online_person_count) {
        this.online_person_count = online_person_count;
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

    public String getEdu_category() {
        return edu_category;
    }

    public void setEdu_category(String edu_category) {
        this.edu_category = edu_category;
    }

    public String[] getEdu_category_array() {
        return edu_category_array;
    }

    public void setEdu_category_array(String[] edu_category_array) {
        this.edu_category_array = edu_category_array;
    }

    public String getEdu_target() {
        return edu_target;
    }

    public void setEdu_target(String edu_target) {
        this.edu_target = edu_target;
    }

    public String[] getEdu_target_array() {
        return edu_target_array;
    }

    public void setEdu_target_array(String[] edu_target_array) {
        this.edu_target_array = edu_target_array;
    }

    public String getRequest_type() {
        return request_type;
    }

    public void setRequest_type(String request_type) {
        this.request_type = request_type;
    }

    public String getStudent_id() {
        return student_id;
    }

    public void setStudent_id(String student_id) {
        this.student_id = student_id;
    }

    public String getTeacher_id() {
        return teacher_id;
    }

    public void setTeacher_id(String teacher_id) {
        this.teacher_id = teacher_id;
    }

    public String getTeacher_name() {
        return teacher_name;
    }

    public void setTeacher_name(String teacher_name) {
        this.teacher_name = teacher_name;
    }

    public String getTeacher_tel() {
        return teacher_tel;
    }

    public void setTeacher_tel(String teacher_tel) {
        this.teacher_tel = teacher_tel;
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

    public String getLecture_content() {
        return lecture_content;
    }

    public void setLecture_content(String lecture_content) {
        this.lecture_content = lecture_content;
    }

    public String getDuplicate_yn() {
        return duplicate_yn;
    }

    public void setDuplicate_yn(String duplicate_yn) {
        this.duplicate_yn = duplicate_yn;
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

    public String getMember_type() {
        return member_type;
    }

    public void setMember_type(String member_type) {
        this.member_type = member_type;
    }

    public int getFile_count() {
        return file_count;
    }

    public void setFile_count(int file_count) {
        this.file_count = file_count;
    }

    public String getFile_original_name() {
        return file_original_name;
    }

    public void setFile_original_name(String file_original_name) {
        this.file_original_name = file_original_name;
    }

    public String getFile_server_name() {
        return file_server_name;
    }

    public void setFile_server_name(String file_server_name) {
        this.file_server_name = file_server_name;
    }

    public List<String> getDelete_file_list() {
        return delete_file_list;
    }

    public void setDelete_file_list(List<String> delete_file_list) {
        this.delete_file_list = delete_file_list;
    }

    public String getSearch_edu_status() {
        return search_edu_status;
    }

    public void setSearch_edu_status(String search_edu_status) {
        this.search_edu_status = search_edu_status;
    }

    public String getSearch_request_type() {
        return search_request_type;
    }

    public void setSearch_request_type(String search_request_type) {
        this.search_request_type = search_request_type;
    }

    public LectureInfo getSearch() {
        return search;
    }

    public void setSearch(LectureInfo search) {
        this.search = search;
    }
}