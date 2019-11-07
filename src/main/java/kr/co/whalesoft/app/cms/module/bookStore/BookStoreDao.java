package kr.co.whalesoft.app.cms.module.bookStore;

import java.util.List;

public interface BookStoreDao {
	
	public List<BookStore> getBookStoreList(BookStore bookStore);
	
	public List<BookStore> getBookStoreListAll(BookStore bookStore);
	
	public BookStore getBookStoreOne(BookStore bookStore);
	
	public int getBookStoreListCount(BookStore bookStore);
	
	public int addBookStore(BookStore bookStore);
	
	public int getBookStoreCount(BookStore bookStore);
	
	public int deleteBookStore(BookStore bookStore);
	
	public int modifyBookStore(BookStore bookStore);
	
	public int checkApplyCount(BookStore bookStore);
	
	public List<BookStore> getBookStoreListUser(BookStore bookStore);
	
	public int getBookStoreListCntUser(BookStore bookStore);
	
}
