package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

public class UntactBookSetting {

	private String homepage_id;
	private String locker_use_yn;
	private Integer row_count;
	private Integer total_count;

	public String getLocker_use_yn() {
		return locker_use_yn;
	}

	public void setLocker_use_yn(String locker_use_yn) {
		this.locker_use_yn = locker_use_yn;
	}

	public String getHomepage_id() {
		return homepage_id;
	}

	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}

	public Integer getRow_count() {
		return row_count;
	}

	public void setRow_count(Integer row_count) {
		this.row_count = row_count;
	}

	public Integer getTotal_count() {
		return total_count;
	}

	public void setTotal_count(Integer total_count) {
		this.total_count = total_count;
	}
}