package kr.go.gbelib.app.module.myLibrary;

import java.util.Date;
import kr.co.whalesoft.framework.base.BaseBean;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class MyLibrary extends PagingUtils {
    // 나만의도서관
    private int library_idx;
    private String manage_codes;
    private String member_id;
    private String login_type;
    private String add_id;
    private String add_ip;
    private Date add_date;

    public MyLibrary(){

    }
    public MyLibrary(String login_type, String member_id) {
        this.login_type = login_type;
        this.member_id = member_id;
    }

    public int getLibrary_idx() {
        return library_idx;
    }

    public void setLibrary_idx(int library_idx) {
        this.library_idx = library_idx;
    }

    public String getManage_codes() {
        return manage_codes;
    }

    public void setManage_codes(String manage_codes) {
        this.manage_codes = manage_codes;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getLogin_type() {
        return login_type;
    }

    public void setLogin_type(String login_type) {
        this.login_type = login_type;
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

    public Date getAdd_date() {
        return add_date;
    }

    public void setAdd_date(Date add_date) {
        this.add_date = add_date;
    }
}
