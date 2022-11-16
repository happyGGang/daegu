package kr.go.gbelib.app.cms.module.specializedServices;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class SpecializedServices extends PagingUtils {

    private int specialized_services_idx;
    private String service_homepage_id;
    private String service_homepage_name;
    private String service_name;
    private String description;
    private String link_url;
    private String view_yn = "Y";
    private String org_file_name;
    private String server_file_name;
    private String file_extension;
    private long file_size;
    private String add_id;
    private Date add_date;
    private String modify_id;
    private Date modify_date;

    private String search_view_yn;

    public int getSpecialized_services_idx() {
        return specialized_services_idx;
    }

    public void setSpecialized_services_idx(int specialized_services_idx) {
        this.specialized_services_idx = specialized_services_idx;
    }

    public String getService_homepage_id() {
        return service_homepage_id;
    }

    public void setService_homepage_id(String service_homepage_id) {
        this.service_homepage_id = service_homepage_id;
    }

    public String getService_homepage_name() {
        return service_homepage_name;
    }

    public void setService_homepage_name(String service_homepage_name) {
        this.service_homepage_name = service_homepage_name;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLink_url() {
        return link_url;
    }

    public void setLink_url(String link_url) {
        this.link_url = link_url;
    }

    public String getView_yn() {
        return view_yn;
    }

    public void setView_yn(String view_yn) {
        this.view_yn = view_yn;
    }

    public String getOrg_file_name() {
        return org_file_name;
    }

    public void setOrg_file_name(String org_file_name) {
        this.org_file_name = org_file_name;
    }

    public String getServer_file_name() {
        return server_file_name;
    }

    public void setServer_file_name(String server_file_name) {
        this.server_file_name = server_file_name;
    }

    public String getFile_extension() {
        return file_extension;
    }

    public void setFile_extension(String file_extension) {
        this.file_extension = file_extension;
    }

    public long getFile_size() {
        return file_size;
    }

    public void setFile_size(long file_size) {
        this.file_size = file_size;
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

    public String getSearch_view_yn() {
        return search_view_yn;
    }

    public void setSearch_view_yn(String search_view_yn) {
        this.search_view_yn = search_view_yn;
    }
}
