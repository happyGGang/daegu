package kr.co.whalesoft.app.cms.module.boardAccess;

public class BoardAccess {

	private String homepage_id;
	private String homepage_name;
	private String board_type;
	private String board_name;
	
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
	
	private long total_count;
	private long count;
	
	public long getTotal_count() {
		return total_count;
	}
	public void setTotal_count(long total_count) {
		this.total_count = total_count;
	}
	public long getCount() {
		return count;
	}
	public void setCount(long count) {
		this.count = count;
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
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
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
	
}