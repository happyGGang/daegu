package kr.go.gbelib.app.cms.module.cultureTeach.hashtag;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Hashtag extends PagingUtils {
    private int hashtag_idx;            // 해시태그지표
    private String hashtag_code;        // 해시태그코드
    private String hashtag_name;        // 해시태그명
    private String use_yn;              // 사용유무
    private String add_ip;              // 등록IP
    private String add_id;              // 등록ID
    private Date add_date;            // 등록일
    private String modify_ip;           // 수정IP
    private String modify_id;           // 수정ID
    private Date modify_date;         // 수정일

    public int getHashtag_idx() {
        return hashtag_idx;
    }

    public void setHashtag_idx(int hashtag_idx) {
        this.hashtag_idx = hashtag_idx;
    }

    public String getHashtag_code() {
        return hashtag_code;
    }

    public void setHashtag_code(String hashtag_code) {
        this.hashtag_code = hashtag_code;
    }

    public String getHashtag_name() {
        return hashtag_name;
    }

    public void setHashtag_name(String hashtag_name) {
        this.hashtag_name = hashtag_name;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
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

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }

    public String getModify_ip() {
        return modify_ip;
    }

    public void setModify_ip(String modify_ip) {
        this.modify_ip = modify_ip;
    }

    public String getModify_id() {
        return modify_id;
    }

    public void setModify_id(String modify_id) {
        this.modify_id = modify_id;
    }

    public Date getModify_date() {
        return modify_date;
    }

    public void setModify_date(Date modify_date) {
        this.modify_date = modify_date;
    }
}
