package kr.go.gbelib.app.cms.module.elib.comment;

import kr.co.whalesoft.framework.utils.PagingUtils;
import kr.go.gbelib.app.cms.module.elib.book.Book;

public class Comment extends PagingUtils {

	private int comment_idx;
	private String regdt;
	private int book_idx;
	private int user_idx;
	private String member_id;
	private String user_comment;
	private String library_code;
	private String book_name;
	private String author_name;
	private String book_pubname;
	private String type;
	private String parent_id;
	private String cate_id;
	private String parent_name;
	private String cate_name;
	private String search_sdt;
	private String search_edt;
	private String last_lend_dt;
	private String last_return_dt;
	public Comment() { }
	public Comment(Book book) {
		super(book);
		this.book_idx = book.getBook_idx();
	}
	public int getComment_idx() {
		return comment_idx;
	}
	public String getRegdt() {
		return regdt;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
	}
	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getUser_comment() {
		return user_comment;
	}
	public void setUser_comment(String user_comment) {
		this.user_comment = user_comment;
	}
	public String getLibrary_code() {
		return library_code;
	}
	public void setLibrary_code(String library_code) {
		this.library_code = library_code;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getAuthor_name() {
		return author_name;
	}
	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}
	public String getBook_pubname() {
		return book_pubname;
	}
	public void setBook_pubname(String book_pubname) {
		this.book_pubname = book_pubname;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getParent_id() {
		return parent_id;
	}
	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}
	public String getCate_id() {
		return cate_id;
	}
	public void setCate_id(String cate_id) {
		this.cate_id = cate_id;
	}
	public String getSearch_sdt() {
		return search_sdt;
	}
	public void setSearch_sdt(String search_sdt) {
		this.search_sdt = search_sdt;
	}
	public String getSearch_edt() {
		return search_edt;
	}
	public void setSearch_edt(String search_edt) {
		this.search_edt = search_edt;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getParent_name() {
		return parent_name;
	}
	public void setParent_name(String parent_name) {
		this.parent_name = parent_name;
	}
	public String getLast_lend_dt() {
		return last_lend_dt;
	}
	public void setLast_lend_dt(String last_lend_dt) {
		this.last_lend_dt = last_lend_dt;
	}
	public String getLast_return_dt() {
		return last_return_dt;
	}
	public void setLast_return_dt(String last_return_dt) {
		this.last_return_dt = last_return_dt;
	}

}
