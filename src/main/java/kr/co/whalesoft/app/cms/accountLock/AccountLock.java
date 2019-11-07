package kr.co.whalesoft.app.cms.accountLock;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.utils.PagingUtils;

public class AccountLock extends PagingUtils {
	
	private long account_lock_idx;
	private String homepage_id;
	private String member_id;
	private String login_type;
	private int count;
	private String last_fail_date;
	private String last_fail_ip;
	public AccountLock() { }
	public AccountLock(Member member, String last_fail_ip) {
		if(member == null) return;
		
		this.homepage_id = member.getHomepage_id();
		this.member_id = member.getMember_id();
		this.login_type = member.getLoginType();
		this.last_fail_ip = last_fail_ip;
	}
	public long getAccount_lock_idx() {
		return account_lock_idx;
	}
	public void setAccount_lock_idx(long account_lock_idx) {
		this.account_lock_idx = account_lock_idx;
	}
	public String getHomepage_id() {
		return homepage_id;
	}
	public void setHomepage_id(String homepage_id) {
		this.homepage_id = homepage_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getLogin_type() {
		return login_type;
	}
	public void setLogin_type(String login_type) {
		this.login_type = login_type;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getLast_fail_date() {
		return last_fail_date;
	}
	public void setLast_fail_date(String last_fail_date) {
		this.last_fail_date = last_fail_date;
	}
	public String getLast_fail_ip() {
		return last_fail_ip;
	}
	public void setLast_fail_ip(String last_fail_ip) {
		this.last_fail_ip = last_fail_ip;
	}
	@Override
	public String toString() {
		return String.format(
				"AccountLock [account_lock_idx=%s, homepage_id=%s, member_id=%s, login_type=%s, count=%s, last_fail_date=%s, last_fail_ip=%s]",
				account_lock_idx, homepage_id, member_id, login_type, count, last_fail_date, last_fail_ip);
	}
	
}