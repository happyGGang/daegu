package kr.go.gbelib.app.module.librarianPickBook;

import kr.co.whalesoft.framework.utils.PagingUtils;

public class LibrarianPickBook extends PagingUtils{
	private String book_name;
	private String author;
	private String isbn;
	private String bookimgUrl;
	
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getBookimgUrl() {
		return bookimgUrl;
	}
	public void setBookimgUrl(String bookimgUrl) {
		this.bookimgUrl = bookimgUrl;
	}
	
}
