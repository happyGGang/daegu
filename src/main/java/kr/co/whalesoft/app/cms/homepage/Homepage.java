package kr.co.whalesoft.app.cms.homepage;

import java.io.Serializable;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class Homepage extends PagingUtils implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = -6146959548929640807L;

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
	private int print_seq;
	private String manage_code;
	private String lib_code;

	public Homepage() {
	}

	public Homepage(String homepage_id) {
		super.setHomepage_id(homepage_id);
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

	public String getManage_code() {
		return manage_code;
	}

	public void setManage_code(String manage_code) {
		this.manage_code = manage_code;
	}

	public String getLib_code() {
		return lib_code;
	}

	public void setLib_code(String lib_code) {
		this.lib_code = lib_code;
	}

	@Override
	public String toString() {
		return "Homepage [homepage_group=" + homepage_group + ", homepage_name=" + homepage_name + ", homepage_eng_name=" + homepage_eng_name + ", homepage_alias=" + homepage_alias + ", homepage_tell=" + homepage_tell + ", homepage_fax=" + homepage_fax + ", homepage_send_tell=" + homepage_send_tell + ", zipcode=" + zipcode + ", address1=" + address1 + ", address2=" + address2 + ", eng_address=" + eng_address + ", blog_url=" + blog_url + ", facebook_url=" + facebook_url + ", twitter_url=" + twitter_url + ", kakao_url=" + kakao_url + ", homepage_type=" + homepage_type + ", domain=" + domain + ", context_path=" + context_path + ", folder=" + folder + ", remark=" + remark + ", temp_use_yn=" + temp_use_yn + ", temp_start_date=" + temp_start_date + ", temp_start_date_1=" + temp_start_date_1 + ", temp_start_date_2=" + temp_start_date_2 + ", temp_start_date_3=" + temp_start_date_3 + ", temp_end_date=" + temp_end_date + ", temp_end_date_1=" + temp_end_date_1 + ", temp_end_date_2=" + temp_end_date_2 + ", temp_end_date_3=" + temp_end_date_3 + ", print_seq=" + print_seq + ", manage_code=" + manage_code + ", lib_code=" + lib_code + "]";
	}

}
