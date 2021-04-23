package kr.go.gbelib.app.cms.module.marathonType;

import java.util.Date;
import java.util.List;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class MarathonType extends PagingUtils{

	private String homepage_id; //홈페이지ID
	private int contest_idx; //대회번호
	private String contest_name; //대회명
	private int contest_type_idx; //대회종목번호
	private String contest_type; //대회종목
	private int page_count; //쪽수
	private String application_subject; //대상
	private Date add_date; //등록일자
	private String add_id; //등록인
	private Date modify_date; //수정일자
	private String modify_id; //수정인
	private String del_yn = "N"; //삭제 여부
	
	private List<MarathonType> typeList;
	
	public int getContest_idx() {
		return contest_idx;
	}
	public void setContest_idx(int contest_idx) {
		this.contest_idx = contest_idx;
	}
	public String getContest_name() {
		return contest_name;
	}
	public void setContest_name(String contest_name) {
		this.contest_name = contest_name;
	}
	public int getContest_type_idx() {
		return contest_type_idx;
	}
	public void setContest_type_idx(int contest_type_idx) {
		this.contest_type_idx = contest_type_idx;
	}
	public String getContest_type() {
		return contest_type;
	}
	public void setContest_type(String contest_type) {
		this.contest_type = contest_type;
	}
	public int getPage_count() {
		return page_count;
	}
	public void setPage_count(int page_count) {
		this.page_count = page_count;
	}
	public String getApplication_subject() {
		return application_subject;
	}
	public void setApplication_subject(String application_subject) {
		this.application_subject = application_subject;
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
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public List<MarathonType> getTypeList() {
		return typeList;
	}
	public void setTypeList(List<MarathonType> typeList) {
		this.typeList = typeList;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
}
