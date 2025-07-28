package kr.go.gbelib.app.cms.module.blackListDetail;

import kr.co.whalesoft.framework.utils.PagingUtils;

import java.util.Date;

public class BlackListDetail extends PagingUtils {

	private int detail_idx; // 블랙IDX
	private String homepage_id; // 홈페이지ID
	private int black_idx; // 블랙IDX
	private String member_id; // 사용자ID
	private String member_name; //사용자명
	private String black_type; // 블랙 구분
	private Date add_date; // 등록일
	private String add_id; // 등록ID
	private Date modify_date; // 수정일
	private String modify_id; // 수정ID
	private int teach_code;
	private int group_idx;
	private int category_idx;

	private String teach_codes;
	private String group_ids;
	private String category_ids;

	public String getTeach_codes() {
		return teach_codes;
	}

	public void setTeach_codes(String teach_codes) {
		this.teach_codes = teach_codes;
	}

	public String getGroup_ids() {
		return group_ids;
	}

	public void setGroup_ids(String group_ids) {
		this.group_ids = group_ids;
	}

	public String getCategory_ids() {
		return category_ids;
	}

	public void setCategory_ids(String category_ids) {
		this.category_ids = category_ids;
	}

	public BlackListDetail() {
	}

	public int getDetail_idx() {
		return detail_idx;
	}

	public void setDetail_idx(int detail_idx) {
		this.detail_idx = detail_idx;
	}

	public BlackListDetail(String homepage_id, String member_id) {
		this.homepage_id = homepage_id;
		this.member_id = member_id;
	}

	public int getTeach_code() {
		return teach_code;
	}

	public void setTeach_code(int teach_code) {
		this.teach_code = teach_code;
	}

	public int getGroup_idx() {
		return group_idx;
	}

	public void setGroup_idx(int group_idx) {
		this.group_idx = group_idx;
	}

	public int getCategory_idx() {
		return category_idx;
	}

	public void setCategory_idx(int category_idx) {this.category_idx = category_idx;}

	public String getHomepage_id() {
		return homepage_id;
	}

	public String getMember_id() {
		return member_id;
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

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

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


}
