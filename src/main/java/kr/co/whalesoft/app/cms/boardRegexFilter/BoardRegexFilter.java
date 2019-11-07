package kr.co.whalesoft.app.cms.boardRegexFilter;

import java.util.Date;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BoardRegexFilter extends PagingUtils {

	private int	regex_idx; //일련번호
	private String regex_str; //정규표현식
	private String use_yn; //사용여부
	private String remark; //설명
	private Date add_date; //등록일
	private String add_id; //등록ID
	
	public String getRegex_str() {
		return regex_str;
	}
	public void setRegex_str(String regex_str) {
		this.regex_str = regex_str;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getAdd_date() {
		return add_date;
	}
	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}
	public String getAdd_id() {
		return add_id;
	}
	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}
	public int getRegex_idx() {
		return regex_idx;
	}
	public void setRegex_idx(int regex_idx) {
		this.regex_idx = regex_idx;
	}
	
}