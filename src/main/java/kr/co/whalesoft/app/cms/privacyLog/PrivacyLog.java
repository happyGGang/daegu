/**
 *
 */
package kr.co.whalesoft.app.cms.privacyLog;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

/**
 * @author whaleesoft YONGJU 2019. 12. 4.
 *
 */
public class PrivacyLog extends PagingUtils {

	private int privacy_log_idx; //
	private String privacy_log_query; //
	private String privacy_log_id; //
	private String privacy_log_ip; //
	private Date privacy_log_date;

	public PrivacyLog() {
	}

	public PrivacyLog(String query, String id, String ip) {
		this.privacy_log_query = query;
		this.privacy_log_id = id;
		this.privacy_log_ip = ip;
	}

	public int getPrivacy_log_idx() {
		return privacy_log_idx;
	}

	public void setPrivacy_log_idx(int privacy_log_idx) {
		this.privacy_log_idx = privacy_log_idx;
	}

	public String getPrivacy_log_query() {
		return privacy_log_query;
	}

	public void setPrivacy_log_query(String privacy_log_query) {
		this.privacy_log_query = privacy_log_query;
	}

	public String getPrivacy_log_id() {
		return privacy_log_id;
	}

	public void setPrivacy_log_id(String privacy_log_id) {
		this.privacy_log_id = privacy_log_id;
	}

	public String getPrivacy_log_ip() {
		return privacy_log_ip;
	}

	public void setPrivacy_log_ip(String privacy_log_ip) {
		this.privacy_log_ip = privacy_log_ip;
	}

	public Date getPrivacy_log_date() {
		return privacy_log_date;
	}

	public void setPrivacy_log_date(Date privacy_log_date) {
		this.privacy_log_date = privacy_log_date;
	}

}
