package kr.go.gbelib.app.cms.module.teachSetting;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class TeachSetting extends PagingUtils {

	private String use_yn = "N";
	private String term_type;
	private int term_count;
	
	private String userNo;
	
	private Date fromDate;
	private Date toDate;
	
	public TeachSetting() {}

	public TeachSetting(String homepageId, String member_key) {
		setHomepage_id(homepageId);
		this.userNo = member_key;
	}
	
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getTerm_type() {
		return term_type;
	}
	public void setTerm_type(String term_type) {
		this.term_type = term_type;
	}
	public int getTerm_count() {
		return term_count;
	}
	public void setTerm_count(int term_count) {
		this.term_count = term_count;
	}

	
	public String getUserNo() {
		return userNo;
	}

	
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	
	public Date getFromDate() {
		return fromDate;
	}

	
	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	
	public Date getToDate() {
		return toDate;
	}

	
	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}
	
}
