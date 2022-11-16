package kr.go.gbelib.app.cms.module.teach.hashtag;

import java.util.Date;
import kr.co.whalesoft.app.cms.member.Member;
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

    private String double_check_yn = "N";     // 해시태그 중복확인 여부

    public Hashtag() {}

    private Hashtag(int hashtag_idx, String hashtag_name, String use_yn, String modify_id, String modify_ip) {
        this.hashtag_idx = hashtag_idx;
        this.hashtag_name = hashtag_name;
        this.use_yn = use_yn;
        this.modify_id = modify_id;
        this.modify_ip = modify_ip;
    }

    private Hashtag(String hashtag_code, String hashtag_name, String use_yn, String add_ip, String add_id,String modify_ip, String modify_id, String homepage_id) {
        this.hashtag_code = hashtag_code;
        this.hashtag_name = hashtag_name;
        this.use_yn = use_yn;
        this.add_ip = add_ip;
        this.add_id = add_id;
        this.modify_ip = modify_ip;
        this.modify_id = modify_id;
        setHomepage_id(homepage_id);
    }

    public static Hashtag ofcreate(Hashtag hashtag, Member member, String ip) {
        String member_id = member.getMember_id();
        String hashtag_code = hashtag.getHashtag_code();
        String hashtag_name = hashtag.getHashtag_name();
        String use_yn = hashtag.getUse_yn();
        String homepage_id = hashtag.getHomepage_id();
        return new Hashtag(hashtag_code,hashtag_name,use_yn,ip,member_id,ip,member_id,homepage_id);
    }

    public static Hashtag ofupdate(Hashtag hashtag, Member member, String ip) {
        String member_id = member.getMember_id();
        int hashtag_idx = hashtag.getHashtag_idx();
        String hashtag_name = hashtag.getHashtag_name();
        String use_yn = hashtag.getUse_yn();
        return new Hashtag(hashtag_idx, hashtag_name, use_yn, member_id, ip);
    }

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

    public String getDouble_check_yn() {
        return double_check_yn;
    }

    public void setDouble_check_yn(String double_check_yn) {
        this.double_check_yn = double_check_yn;
    }
}
