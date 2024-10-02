package kr.go.gbelib.app.intro.join;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class CertificateCitizen extends PagingUtils {

    private int citizen_idx;         //시민인증idx
    private String user_name;           //이름
    private String user_id;             //id
    private String library;             //도서관
    private String user_ci;             //CI
    private String apply_date;          //신청날짜
    private String user_key;            //이용자KEY
    private String user_number;         //이용자번호


    public CertificateCitizen() {}

    public int getCitizen_idx() {
        return citizen_idx;
    }

    public void setCitizen_idx(int citizen_idx) {
        this.citizen_idx = citizen_idx;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getLibrary() {
        return library;
    }

    public void setLibrary(String library) {
        this.library = library;
    }

    public String getUser_ci() {
        return user_ci;
    }

    public void setUser_ci(String user_ci) {
        this.user_ci = user_ci;
    }

    public String getApply_date() {
        return apply_date;
    }

    public void setApply_date(String apply_date) {
        this.apply_date = apply_date;
    }

    public String getUser_key() {
        return user_key;
    }

    public void setUser_key(String user_key) {
        this.user_key = user_key;
    }

    public String getUser_number() {
        return user_number;
    }

    public void setUser_number(String user_number) {
        this.user_number = user_number;
    }
}
