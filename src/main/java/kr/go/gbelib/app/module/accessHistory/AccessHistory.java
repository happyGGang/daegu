package kr.go.gbelib.app.module.accessHistory;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AccessHistory extends PagingUtils {

	private long access_idx; //접속 IDX
	private String homepage_id; //홈페이지 ID
	private String homepage_name; // 홈페이지 이름
	private String browser_type; //접속 브라우져
	private String browser_version; //브라우져 버젼
	private String access_system; //접속기기
	private String operating_system;
	private String access_ip; //접속 IP
	private String referer_url; //유입경로
	private Date access_date; //접속시간
	private String login_id;

	private String date_type;
	private String search_type;

	private String start_date;
	private String end_date;

	private String start_month;
	private String end_month;
	private String month_count;

	private String start_year;
	private String end_year;
	private String year_count;

	private String result_date;
	private long result_count;
	private long total_count;
	private long max_count;
	private long min_count;

	private String session_id;
	private String member_id;
	private String member_seq_no;

	private String search_year;

	public long getAccess_idx() {
		return access_idx;
	}

	public void setAccess_idx(long access_idx) {
		this.access_idx = access_idx;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public String getHomepage_name() {
		return homepage_name;
	}

	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}

	public String getBrowser_type() {
		return browser_type;
	}

	public void setBrowser_type(String browser_type) {
		this.browser_type = browser_type;
	}

	public String getBrowser_version() {
		return browser_version;
	}

	public void setBrowser_version(String browser_version) {
		this.browser_version = browser_version;
	}

	public String getAccess_system() {
		return access_system;
	}

	public void setAccess_system(String access_system) {
		this.access_system = access_system;
	}

	public String getOperating_system() {
		return operating_system;
	}

	public void setOperating_system(String operating_system) {
		this.operating_system = operating_system;
	}

	public String getAccess_ip() {
		return access_ip;
	}

	public void setAccess_ip(String access_ip) {
		this.access_ip = access_ip;
	}

	public String getReferer_url() {
		return referer_url;
	}

	public void setReferer_url(String referer_url) {
		this.referer_url = referer_url;
	}

	public Date getAccess_date() {
		return access_date;
	}

	public void setAccess_date(Date access_date) {
		this.access_date = access_date;
	}

	public String getLogin_id() {
		return login_id;
	}

	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	public String getDate_type() {
		return date_type;
	}

	public void setDate_type(String date_type) {
		this.date_type = date_type;
	}

	public String getSearch_type() {
		return search_type;
	}

	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getStart_month() {
		return start_month;
	}

	public void setStart_month(String start_month) {
		this.start_month = start_month;
	}

	public String getEnd_month() {
		return end_month;
	}

	public void setEnd_month(String end_month) {
		this.end_month = end_month;
	}

	public String getMonth_count() {
		return month_count;
	}

	public void setMonth_count(String month_count) {
		this.month_count = month_count;
	}

	public String getStart_year() {
		return start_year;
	}

	public void setStart_year(String start_year) {
		this.start_year = start_year;
	}

	public String getEnd_year() {
		return end_year;
	}

	public void setEnd_year(String end_year) {
		this.end_year = end_year;
	}

	public String getYear_count() {
		return year_count;
	}

	public void setYear_count(String year_count) {
		this.year_count = year_count;
	}

	public String getResult_date() {
		return result_date;
	}

	public void setResult_date(String result_date) {
		this.result_date = result_date;
	}

	public long getResult_count() {
		return result_count;
	}

	public void setResult_count(long result_count) {
		this.result_count = result_count;
	}

	public long getTotal_count() {
		return total_count;
	}

	public void setTotal_count(long total_count) {
		this.total_count = total_count;
	}

	public long getMax_count() {
		return max_count;
	}

	public void setMax_count(long max_count) {
		this.max_count = max_count;
	}

	public long getMin_count() {
		return min_count;
	}

	public void setMin_count(long min_count) {
		this.min_count = min_count;
	}

	public String getSession_id() {
		return session_id;
	}

	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_seq_no() {
		return member_seq_no;
	}

	public void setMember_seq_no(String member_seq_no) {
		this.member_seq_no = member_seq_no;
	}


	public String getSearch_year() {
		return search_year;
	}


	public void setSearch_year(String search_year) {
		this.search_year = search_year;
	}

}
