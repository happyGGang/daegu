package kr.go.gbelib.app.module.bookKeyword;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class BookKeyword extends PagingUtils {
	
	private int keyword_idx;
	private String keyword_name;
	private int limit_keyword_count = 20;
	
	public int getKeyword_idx() {
		return keyword_idx;
	}
	
	public void setKeyword_idx(int keyword_idx) {
		this.keyword_idx = keyword_idx;
	}
	
	public String getKeyword_name() {
		return keyword_name;
	}
	
	public void setKeyword_name(String keyword_name) {
		this.keyword_name = keyword_name;
	}
	
	public int getLimit_keyword_count() {
		return limit_keyword_count;
	}
	
	public void setLimit_keyword_count(int limit_keyword_count) {
		this.limit_keyword_count = limit_keyword_count;
	}
	
}
