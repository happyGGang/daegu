package kr.co.whalesoft.app.cms.workingLog;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

/**
 * @author whalesoft
 * @date 2020.08.27
 *
 */
public class WorkingLog extends PagingUtils {

	private int work_idx; // 작업IDX
	private String site_id; // 사이트ID
	private String work_type; // 작업구분 W:일반작업, P:개인정보
	private String work_comment; // 작업내용
	private String work_command; // 작업명령어 SQL명령어 UNKNOWN, INSERT, UPDATE, DELETE, SELECT, FLUSH;
	private String work_query; // 작업쿼리
	private int work_result_count; // 작업쿼리결과수
	private Date work_date; // 작업일시
	private String work_ip; // 작업IP
	private String member_id; // 사용자ID
	private String work_reason; // 작업사유(개인정보인경우 필수)

	private String siteName;

	public WorkingLog() {}

	/**
	 *
	 * 작업이력 로그
	 *
	 * @param site_id
	 *        사이트ID
	 * @param work_type
	 *        작업구분. W:일반작업, P:개인정보
	 * @param member_id
	 *        사용자ID
	 * @param work_ip
	 *        작업자IP ipv4 or ipv6
	 * @param work_query
	 *        SQL명령어 UNKNOWN, INSERT, UPDATE, DELETE, SELECT, FLUSH
	 * @param log_query
	 *        작업쿼리
	 * @param work_result_count
	 *        작업쿼리결과수
	 * @param work_reason
	 *        작업사유
	 */
	public WorkingLog(String site_id, String work_type, String work_comment, String work_command, String work_query, int work_result_count, String work_reason, String member_id, String work_ip) {
		this.site_id = site_id;
		this.work_type = work_type;
		this.work_comment = work_comment;
		this.work_command = work_command;
		this.work_query = work_query;
		this.work_result_count = work_result_count;
		this.work_reason = work_reason;
		this.member_id = member_id;
		this.work_ip = work_ip;
	}

	public int getWork_idx() {
		return work_idx;
	}

	public String getSite_id() {
		return site_id;
	}

	public String getWork_type() {
		return work_type;
	}

	public String getWork_comment() {
		return work_comment;
	}

	public String getWork_command() {
		return work_command;
	}

	public String getWork_query() {
		return work_query;
	}

	public int getWork_result_count() {
		return work_result_count;
	}

	public Date getWork_date() {
		return work_date;
	}

	public String getWork_ip() {
		return work_ip;
	}

	public String getMember_id() {
		return member_id;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setWork_idx(int work_idx) {
		this.work_idx = work_idx;
	}

	public void setSite_id(String site_id) {
		this.site_id = site_id;
	}

	public void setWork_type(String work_type) {
		this.work_type = work_type;
	}

	public void setWork_comment(String work_comment) {
		this.work_comment = work_comment;
	}

	public void setWork_command(String work_command) {
		this.work_command = work_command;
	}

	public void setWork_query(String work_query) {
		this.work_query = work_query;
	}

	public void setWork_result_count(int work_result_count) {
		this.work_result_count = work_result_count;
	}

	public void setWork_date(Date work_date) {
		this.work_date = work_date;
	}

	public void setWork_ip(String work_ip) {
		this.work_ip = work_ip;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getWork_reason() {
		return work_reason;
	}

	public void setWork_reason(String work_reason) {
		this.work_reason = work_reason;
	}

}
