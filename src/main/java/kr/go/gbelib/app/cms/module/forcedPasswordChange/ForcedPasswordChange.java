package kr.go.gbelib.app.cms.module.forcedPasswordChange;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class ForcedPasswordChange extends PagingUtils {

    private int forced_password_change_idx; // 강제비밀번호IDX
    private String forced_password_change_status = "N"; //사용자 강제 비밀번호 초기화 상태
    private String member_id; // 사용자ID
    private String member_name; //사용자명
    private String reason; // 사유
    private Date add_date; // 등록일
    private String add_id; // 등록ID
    private Date modify_date; // 수정일
    private String modify_id; // 수정ID
    private String delete_yn = "N"; // 삭제여부

    public int getForced_password_change_idx() {
        return forced_password_change_idx;
    }

    public void setForced_password_change_idx(int forced_password_change_idx) {
        this.forced_password_change_idx = forced_password_change_idx;
    }

    public String getForced_password_change_status() {
        return forced_password_change_status;
    }

    public void setForced_password_change_status(String forced_password_change_status) {
        this.forced_password_change_status = forced_password_change_status;
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

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

    public String getDelete_yn() {
        return delete_yn;
    }

    public void setDelete_yn(String delete_yn) {
        this.delete_yn = delete_yn;
    }
}
