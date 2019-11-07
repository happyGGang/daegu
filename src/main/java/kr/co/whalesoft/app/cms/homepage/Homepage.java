package kr.co.whalesoft.app.cms.homepage;

import java.io.Serializable;
import org.apache.commons.lang3.StringUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Homepage extends PagingUtils implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -6146959548929640807L;

	private String homepage_id;
	private String homepage_group;
	private String homepage_name;
	private String homepage_eng_name;
	private String homepage_alias;
	private String homepage_tell;
	private String homepage_fax;
	private String homepage_send_tell;
	private String zipcode;
	private String address1;
	private String address2;
	private String eng_address;
	private String blog_url;
	private String facebook_url;
	private String twitter_url;
	private String kakao_url;
	private String homepage_type;
	private String homepage_code;
	private String domain;
	private String context_path;
	private String folder;
	private String remark;
	private String temp_use_yn = "N";
	private String temp_start_date;
	private String temp_start_date_1;
	private String temp_start_date_2;
	private String temp_start_date_3;
	private String temp_end_date;
	private String temp_end_date_1;
	private String temp_end_date_2;
	private String temp_end_date_3;
	private int mystorage_limit_count;
	private int print_seq;


	private int tid;
	private String lib_name;
	private String lib_url;
	private String lib_picture_url;
	private String lib_address;
	private String lib_latitude;
	private String lib_longitude;
	private String lib_tel;
	private String lib_email;
	private String lib_holiday_info;
	private String lib_use_time;
	private String lib_cabinet_yn;
	private String lib_cabinet_url;
	private String lib_reg_cource_yn;
	private String lib_reg_cource_url;
	private String lib_webbooking_yn;
	private String lib_webbooking_url;
	private String lib_etc_yn;
	private String lib_etc_url;

	public Homepage() {}

	public Homepage(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getHomepage_group() {
		return homepage_group;
	}
	public void setHomepage_group(String homepage_group) {
		this.homepage_group = homepage_group;
	}
	public String getHomepage_name() {
		return homepage_name;
	}
	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}
	public String getHomepage_type() {
		return homepage_type;
	}
	public void setHomepage_type(String homepage_type) {
		this.homepage_type = homepage_type;
	}
	public String getDomain() {
		return domain;
	}
	public String getDomainWithoutProtocol() {
		return StringUtils.isEmpty(domain) ? null : domain.replaceAll("http://", "");
	}
	public String getDomain(String mode) {
		if (StringUtils.equals(mode, "http")) {
			return domain;
		} else if (StringUtils.equals(mode, "https")) {
			return domain.replaceAll("http", "https");
		}
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getContext_path() {
		return context_path;
	}
	public void setContext_path(String context_path) {
		this.context_path = context_path;
	}
	public String getFolder() {
		return folder;
	}
	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getTemp_use_yn() {
		return temp_use_yn;
	}

	public void setTemp_use_yn(String temp_use_yn) {
		this.temp_use_yn = temp_use_yn;
	}

	public String getTemp_start_date() {
		return temp_start_date;
	}

	public void setTemp_start_date(String temp_start_date) {
		this.temp_start_date = temp_start_date;
	}

	public String getTemp_end_date() {
		return temp_end_date;
	}

	public void setTemp_end_date(String temp_end_date) {
		this.temp_end_date = temp_end_date;
	}

	public String getTemp_start_date_1() {
		return temp_start_date_1;
	}

	public void setTemp_start_date_1(String temp_start_date_1) {
		this.temp_start_date_1 = temp_start_date_1;
	}

	public String getTemp_start_date_2() {
		return temp_start_date_2;
	}

	public void setTemp_start_date_2(String temp_start_date_2) {
		this.temp_start_date_2 = temp_start_date_2;
	}

	public String getTemp_start_date_3() {
		return temp_start_date_3;
	}

	public void setTemp_start_date_3(String temp_start_date_3) {
		this.temp_start_date_3 = temp_start_date_3;
	}

	public String getTemp_end_date_1() {
		return temp_end_date_1;
	}

	public void setTemp_end_date_1(String temp_end_date_1) {
		this.temp_end_date_1 = temp_end_date_1;
	}

	public String getTemp_end_date_2() {
		return temp_end_date_2;
	}

	public void setTemp_end_date_2(String temp_end_date_2) {
		this.temp_end_date_2 = temp_end_date_2;
	}

	public String getTemp_end_date_3() {
		return temp_end_date_3;
	}

	public void setTemp_end_date_3(String temp_end_date_3) {
		this.temp_end_date_3 = temp_end_date_3;
	}

	public String getHomepage_code() {
		return homepage_code;
	}

	public String[] getHomepage_codeList() {
		if ( homepage_code == null ) {
			return null;
		}
		else {
			return homepage_code.split(",");
		}
	}

	public void setHomepage_code(String homepage_code) {
		this.homepage_code = homepage_code;
	}

	public String getHomepage_eng_name() {
		return homepage_eng_name;
	}

	public void setHomepage_eng_name(String homepage_eng_name) {
		this.homepage_eng_name = homepage_eng_name;
	}

	public String getHomepage_tell() {
		return homepage_tell;
	}

	public void setHomepage_tell(String homepage_tell) {
		this.homepage_tell = homepage_tell;
	}

	public String getHomepage_fax() {
		return homepage_fax;
	}

	public void setHomepage_fax(String homepage_fax) {
		this.homepage_fax = homepage_fax;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getEng_address() {
		return eng_address;
	}

	public void setEng_address(String eng_address) {
		this.eng_address = eng_address;
	}

	public String getBlog_url() {
		return blog_url;
	}

	public void setBlog_url(String blog_url) {
		this.blog_url = blog_url;
	}

	public String getFacebook_url() {
		return facebook_url;
	}

	public void setFacebook_url(String facebook_url) {
		this.facebook_url = facebook_url;
	}

	public String getTwitter_url() {
		return twitter_url;
	}

	public void setTwitter_url(String twitter_url) {
		this.twitter_url = twitter_url;
	}

	public String getKakao_url() {
		return kakao_url;
	}

	public void setKakao_url(String kakao_url) {
		this.kakao_url = kakao_url;
	}

	public String getLib_name() {
		return lib_name;
	}

	public void setLib_name(String lib_name) {
		this.lib_name = lib_name;
	}

	public String getLib_url() {
		return lib_url;
	}

	public void setLib_url(String lib_url) {
		this.lib_url = lib_url;
	}

	public String getLib_picture_url() {
		return lib_picture_url;
	}

	public void setLib_picture_url(String lib_picture_url) {
		this.lib_picture_url = lib_picture_url;
	}

	public String getLib_address() {
		return lib_address;
	}

	public void setLib_address(String lib_address) {
		this.lib_address = lib_address;
	}

	public String getLib_latitude() {
		return lib_latitude;
	}

	public void setLib_latitude(String lib_latitude) {
		this.lib_latitude = lib_latitude;
	}

	public String getLib_longitude() {
		return lib_longitude;
	}

	public void setLib_longitude(String lib_longitude) {
		this.lib_longitude = lib_longitude;
	}

	public String getLib_tel() {
		return lib_tel;
	}

	public void setLib_tel(String lib_tel) {
		this.lib_tel = lib_tel;
	}

	public String getLib_email() {
		return lib_email;
	}

	public void setLib_email(String lib_email) {
		this.lib_email = lib_email;
	}

	public String getLib_holiday_info() {
		return lib_holiday_info;
	}

	public void setLib_holiday_info(String lib_holiday_info) {
		this.lib_holiday_info = lib_holiday_info;
	}

	public String getLib_use_time() {
		return lib_use_time;
	}

	public void setLib_use_time(String lib_use_time) {
		this.lib_use_time = lib_use_time;
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getLib_cabinet_yn() {
		return lib_cabinet_yn;
	}

	public void setLib_cabinet_yn(String lib_cabinet_yn) {
		this.lib_cabinet_yn = lib_cabinet_yn;
	}

	public String getLib_cabinet_url() {
		return lib_cabinet_url;
	}

	public void setLib_cabinet_url(String lib_cabinet_url) {
		this.lib_cabinet_url = lib_cabinet_url;
	}

	public String getLib_reg_cource_yn() {
		return lib_reg_cource_yn;
	}

	public void setLib_reg_cource_yn(String lib_reg_cource_yn) {
		this.lib_reg_cource_yn = lib_reg_cource_yn;
	}

	public String getLib_reg_cource_url() {
		return lib_reg_cource_url;
	}

	public void setLib_reg_cource_url(String lib_reg_cource_url) {
		this.lib_reg_cource_url = lib_reg_cource_url;
	}

	public String getLib_webbooking_yn() {
		return lib_webbooking_yn;
	}

	public void setLib_webbooking_yn(String lib_webbooking_yn) {
		this.lib_webbooking_yn = lib_webbooking_yn;
	}

	public String getLib_webbooking_url() {
		return lib_webbooking_url;
	}

	public void setLib_webbooking_url(String lib_webbooking_url) {
		this.lib_webbooking_url = lib_webbooking_url;
	}

	public String getLib_etc_yn() {
		return lib_etc_yn;
	}

	public void setLib_etc_yn(String lib_etc_yn) {
		this.lib_etc_yn = lib_etc_yn;
	}

	public String getLib_etc_url() {
		return lib_etc_url;
	}

	public void setLib_etc_url(String lib_etc_url) {
		this.lib_etc_url = lib_etc_url;
	}

	public int getMystorage_limit_count() {
		return mystorage_limit_count;
	}

	public void setMystorage_limit_count(int mystorage_limit_count) {
		this.mystorage_limit_count = mystorage_limit_count;
	}

	public String getHomepage_alias() {
		return homepage_alias;
	}

	public void setHomepage_alias(String homepage_alias) {
		this.homepage_alias = homepage_alias;
	}

	public String getHomepage_send_tell() {
		return homepage_send_tell;
	}

	public void setHomepage_send_tell(String homepage_send_tell) {
		this.homepage_send_tell = homepage_send_tell;
	}


	public int getPrint_seq() {
		return print_seq;
	}


	public void setPrint_seq(int print_seq) {
		this.print_seq = print_seq;
	}

}