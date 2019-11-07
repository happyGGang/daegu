package kr.go.gbelib.app.cms.module.themeBook;

import java.util.Date;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class ThemeBook extends PagingUtils {
	
	private String homepage_id;  //홈페이지ID
	private int manage_idx;  //게시판IDX
	private String board_name;  //게시판명
	private String yearmonth;  //년월
	private String subject;  //주제
	private String remark;  //비고
	private String add_id;  //등록자
	private Date add_date;  //등록일
	private String modify_id;  //수정자
	private Date modify_date;  //수정일
	private String category1;	//게시판 카테고리
	
	private String searchYear;
	
	public ThemeBook() {}

	public ThemeBook(String homepage_id, int manage_idx) {
		this.homepage_id = homepage_id;
		this.manage_idx = manage_idx;
	}

	public ThemeBook(Board board) {
		this.homepage_id = board.getHomepage_id();
		this.manage_idx = board.getManage_idx();
		this.yearmonth = board.getPlan_date();
		this.category1 = board.getCategory1();
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public String getYearmonth() {
		return yearmonth;
	}

	public void setYearmonth(String yearmonth) {
		this.yearmonth = yearmonth;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getAdd_id() {
		return add_id;
	}

	public void setAdd_id(String add_id) {
		this.add_id = add_id;
	}

	public Date getAdd_date() {
		return add_date;
	}

	public void setAdd_date(Date add_date) {
		this.add_date = add_date;
	}

	public String getModify_id() {
		return modify_id;
	}

	public void setModify_id(String modify_id) {
		this.modify_id = modify_id;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public String getBoard_name() {
		return board_name;
	}

	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}

	public String getSearchYear() {
		return searchYear;
	}

	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}

	
	public String getCategory1() {
		return category1;
	}

	
	public void setCategory1(String category1) {
		this.category1 = category1;
	}
	
	
}
