package kr.co.whalesoft.app.cms.module.boardFileAccess;

public class BoardFileAccess {
	
	private String homepage_id;
	private String homepage_name;
	private String board_name;
	private long total_count;
	private long count;
	
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
}
