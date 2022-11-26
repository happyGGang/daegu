package kr.go.gbelib.app.cms.module.culture;

import kr.co.whalesoft.framework.base.BaseBean;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Culture extends PagingUtils {
    private int idx;
    private String name;
    private String catename;
    private String catecode;
    private String address;
    private String areaname;
    private String areacode;
    private String tel;
    private String locationx;
    private String locationy;
    private String url;
    private String contents;
    private String etc;
    private String use_yn;
    private String img_url;
    private String search_area;

    private String search_cate;
    private String keyword;

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCatename() {
        return catename;
    }

    public void setCatename(String catename) {
        this.catename = catename;
    }

    public String getCatecode() {
        return catecode;
    }

    public void setCatecode(String catecode) {
        this.catecode = catecode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAreaname() {
        return areaname;
    }

    public void setAreaname(String areaname) {
        this.areaname = areaname;
    }

    public String getAreacode() {
        return areacode;
    }

    public void setAreacode(String areacode) {
        this.areacode = areacode;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getLocationx() {
        return locationx;
    }

    public void setLocationx(String locationx) {
        this.locationx = locationx;
    }

    public String getLocationy() {
        return locationy;
    }

    public void setLocationy(String locationy) {
        this.locationy = locationy;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getEtc() {
        return etc;
    }

    public void setEtc(String etc) {
        this.etc = etc;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getImg_url() {
        return img_url;
    }

    public String getSearch_area() {
        return search_area;
    }

    public void setSearch_area(String search_area) {
        this.search_area = search_area;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;

    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSearch_cate() {
        return search_cate;
    }

    public void setSearch_cate(String search_cate) {
        this.search_cate = search_cate;
    }
}
