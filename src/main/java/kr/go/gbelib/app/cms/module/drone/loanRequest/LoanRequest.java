package kr.go.gbelib.app.cms.module.drone.loanRequest;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;
import org.apache.commons.lang.math.LongRange;
import org.apache.commons.lang3.StringUtils;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.STVerticalAlignRun;

public class LoanRequest extends PagingUtils {
    private int request_idx;
    private String manage_code;
    private String user_key;
    private String member_id;
    private String member_name;
    private String reg_no;
    private String book_name;
    private String author;
    private String request_status;
    private String request_status_name;
    private String delete_yn = "N";
    private String device_code;
    private String pickup_place;
    private Date add_date;
    private String add_id;
    private String add_ip;
    private Date modify_date;
    private String modify_id;
    private String modify_ip;
    private String request_rank;

    // 신청 로그를 위한 빈
    private int request_log_idx;
    private Date work_date;
    private String work_id;
    private String work_ip;

    private String search_request_date;
    private String search_request_status;

    private String next_request_status;
    private String next_request_status_name;

    private String prev_request_status;
    private String prev_request_status_name;

    private String search_start_date;
    private String search_end_date;

    public LoanRequest() {}

    private LoanRequest(String manage_code) {
        this.manage_code = manage_code;
    }

    private LoanRequest(String manage_code, String member_id) {
        this.manage_code = manage_code;
        this.member_id = member_id;
    }

    private LoanRequest(String manage_code, String member_id, String reg_no) {
        this.manage_code = manage_code;
        this.member_id = member_id;
        this.reg_no = reg_no;
    }

    private LoanRequest(String manage_code,String user_key, String member_id, String member_name, String reg_no, String book_name, String author, String device_code,String add_ip){
        this.manage_code = manage_code;
        this.user_key = user_key;
        this.member_id = member_id;
        this.member_name = member_name;
        this.reg_no = reg_no;
        this.book_name = book_name;
        this.author = author;
        this.device_code = device_code;
        this.add_ip = add_ip;
        this.request_status = "1000"; // 신청
    }

    private LoanRequest(int request_idx,String manage_code, String user_key, String work_id, String work_ip, String request_status){
        this.request_idx = request_idx;
        this.manage_code = manage_code;
        this.user_key = user_key;
        this.work_id = work_id;
        this.modify_id = work_id;
        this.work_ip = work_ip;
        this.modify_ip = work_ip;
        this.request_status = request_status;
    }

    private LoanRequest(String manage_code, String member_id, String search_start_date, String search_end_date) {
        this.manage_code = manage_code;
        this.member_id = member_id;

        if (StringUtils.isEmpty(search_start_date) && StringUtils.isEmpty(search_end_date)) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            //현재 날짜로 설정
            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH);

            //현재 달의 시작일과 마지막일 구하기
            int start = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
            int end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

            calendar.set(year, month, start);
            String startdate =  dateFormat.format(calendar.getTime());
            this.search_start_date = startdate;
            calendar.set(year, month, end);
            String enddate = dateFormat.format(calendar.getTime());
            this.search_end_date = enddate;
        } else {
            this.search_start_date = search_start_date;
            this.search_end_date = search_end_date;
        }
    }

    public static LoanRequest fromManageCode(String manage_code) {
        return new LoanRequest(manage_code);
    }

    public static LoanRequest ofManageCodeAndMemberId(String manage_code, String member_id) {
        return new LoanRequest(manage_code, member_id);
    }

    public static LoanRequest ofManageCodeAndMemberIdAndRegNo(String manage_code, String member_id, String reg_no) {
        return new LoanRequest(manage_code,member_id,reg_no);
    }

    // insert를 위한 생성자
    public static LoanRequest ofCreate(String manage_code,String user_key, String member_id, String member_name, String reg_no, String book_name, String author, String device_code,String add_ip) {
        return new LoanRequest(manage_code,user_key,member_id,member_name,reg_no,book_name,author,device_code,add_ip);
    }

    // 대출상태 변경을 위한 생성자
    public static LoanRequest ofUpdateStatus(int request_idx,String manage_code, String user_key, String work_id, String work_ip, String request_status) {
        return new LoanRequest(request_idx,manage_code,user_key,work_id,work_ip,request_status);
    }

    // 홈페이지 리스트 조회 파람
    public static LoanRequest ofHomepageRequest(String manage_code, String member_id, String search_start_date, String search_end_date) {
        return new LoanRequest(manage_code,member_id,search_start_date,search_end_date);
    }

    public int getRequest_idx() {
        return request_idx;
    }

    public void setRequest_idx(int request_idx) {
        this.request_idx = request_idx;
    }

    public String getManage_code() {
        return manage_code;
    }

    public void setManage_code(String manage_code) {
        this.manage_code = manage_code;
    }

    public String getUser_key() {
        return user_key;
    }

    public void setUser_key(String user_key) {
        this.user_key = user_key;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getReg_no() {
        return reg_no;
    }

    public void setReg_no(String reg_no) {
        this.reg_no = reg_no;
    }

    public String getRequest_status() {
        return request_status;
    }

    public void setRequest_status(String request_status) {
        this.request_status = request_status;
    }

    public String getDelete_yn() {
        return delete_yn;
    }

    public void setDelete_yn(String delete_yn) {
        this.delete_yn = delete_yn;
    }

    public String getDevice_code() {
        return device_code;
    }

    public void setDevice_code(String device_code) {
        this.device_code = device_code;
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

    public String getModify_ip() {
        return modify_ip;
    }

    public void setModify_ip(String modify_ip) {
        this.modify_ip = modify_ip;
    }

    public int getRequest_log_idx() {
        return request_log_idx;
    }

    public void setRequest_log_idx(int request_log_idx) {
        this.request_log_idx = request_log_idx;
    }

    public Date getWork_date() {
        return work_date;
    }

    public void setWork_date(Date work_date) {
        this.work_date = work_date;
    }

    public String getWork_id() {
        return work_id;
    }

    public void setWork_id(String work_id) {
        this.work_id = work_id;
    }

    public String getWork_ip() {
        return work_ip;
    }

    public void setWork_ip(String work_ip) {
        this.work_ip = work_ip;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getRequest_status_name() {
        return request_status_name;
    }

    public void setRequest_status_name(String request_status_name) {
        this.request_status_name = request_status_name;
    }

    public String getPickup_place() {
        return pickup_place;
    }

    public void setPickup_place(String pickup_place) {
        this.pickup_place = pickup_place;
    }

    public String getSearch_request_date() {
        if (StringUtils.isEmpty(search_request_date)) {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date now = new Date();
            search_request_date = dateFormat.format(now);
        }
        return search_request_date;
    }

    public void setSearch_request_date(String search_request_date) { this.search_request_date = search_request_date; }

    public String getSearch_request_status() {
        return search_request_status;
    }

    public void setSearch_request_status(String search_request_status) {
        this.search_request_status = search_request_status;
    }

    public String getNext_request_status() {
        return next_request_status;
    }

    public void setNext_request_status(String next_request_status) {
        this.next_request_status = next_request_status;
    }

    public String getNext_request_status_name() {
        return next_request_status_name;
    }

    public void setNext_request_status_name(String next_request_status_name) {
        this.next_request_status_name = next_request_status_name;
    }

    public String getPrev_request_status() {
        return prev_request_status;
    }

    public void setPrev_request_status(String prev_request_status) {
        this.prev_request_status = prev_request_status;
    }

    public String getPrev_request_status_name() {
        return prev_request_status_name;
    }

    public void setPrev_request_status_name(String prev_request_status_name) {
        this.prev_request_status_name = prev_request_status_name;
    }

    public String getSearch_start_date() {
        return search_start_date;
    }

    public void setSearch_start_date(String search_start_date) {
        this.search_start_date = search_start_date;
    }

    public String getSearch_end_date() {
        return search_end_date;
    }

    public void setSearch_end_date(String search_end_date) {
        this.search_end_date = search_end_date;
    }

    public String getRequest_rank() {
        return request_rank;
    }

    public void setRequest_rank(String request_rank) {
        this.request_rank = request_rank;
    }
}
