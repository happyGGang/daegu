package kr.go.gbelib.app.cms.module.blackList;

import java.util.Date;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class BlackList extends PagingUtils {

	private String homepage_id; // 홈페이지ID
	private int black_idx; // 블랙IDX
	// private String member_key; //사용자구분
	private String member_id; // 사용자ID
	private String member_name; //사용자명
	private String reason; // 사유
	private String black_type; // 블랙 구분
	private Date add_date; // 등록일
	private String add_id; // 등록ID
	private Date modify_date; // 수정일
	private String modify_id; // 수정ID
	private String delete_yn; // 삭제여부

	private String homepage_name;

	private String after_click_btn;

	private String search_api_type = "WEBID";

	public BlackList() {
	}

	public BlackList(String homepage_id, String member_id) {
		this.homepage_id = homepage_id;
		this.member_id = member_id;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public String getReason() {
		return reason;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}

	public String getHomepage_name() {
		return homepage_name;
	}

	public void setHomepage_name(String homepage_name) {
		this.homepage_name = homepage_name;
	}

	public String getAfter_click_btn() {
		return after_click_btn;
	}

	public void setAfter_click_btn(String after_click_btn) {
		this.after_click_btn = after_click_btn;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

//	public String getMember_key() {
//		return member_key;
//	}
//
//	public void setMember_key(String member_key) {
//		this.member_key = member_key;
//	}

	public String getBlack_type() {
		return black_type;
	}

	public void setBlack_type(String black_type) {
		this.black_type = black_type;
	}

	public int getBlack_idx() {
		return black_idx;
	}

	public void setBlack_idx(int black_idx) {
		this.black_idx = black_idx;
	}

	public String getSearch_api_type() {
		return search_api_type;
	}

	public void setSearch_api_type(String search_api_type) {
		this.search_api_type = search_api_type;
	}

}
