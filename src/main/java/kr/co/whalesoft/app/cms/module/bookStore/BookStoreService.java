package kr.co.whalesoft.app.cms.module.bookStore;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookStoreService extends BaseService {
	
	@Autowired
	private BookStoreDao dao;
	
	public List<BookStore> getBookStoreList(BookStore bookStore) {
		return dao.getBookStoreList(bookStore);
	}
	
	public List<BookStore> getBookStoreListAll(BookStore bookStore) {
		return dao.getBookStoreListAll(bookStore);
	}	
	
	public BookStore getBookStoreOne(BookStore bookStore) {
		return dao.getBookStoreOne(bookStore);
	}
	
	public int getBookStoreListCount(BookStore bookStore) {
		return dao.getBookStoreListCount(bookStore);
	}
	
	public int addBookStore(BookStore bookStore) {
		
		return dao.addBookStore(bookStore);
	}
	
	public int bookStoreCount(BookStore bookStore) {
		return dao.getBookStoreCount(bookStore);
	}
	
	public int deleteBookStore(BookStore bookStore) {
		return dao.deleteBookStore(bookStore);
	}
	
	public int modifyBookStore(BookStore bookStore) {
		return dao.modifyBookStore(bookStore);
	}
	
	public int checkApplyCount(BookStore bookStore) {
		return dao.checkApplyCount(bookStore);
	}
	
	public List<BookStore> getBookStoreListUser(BookStore bookStore) {
		return dao.getBookStoreListUser(bookStore);
	}
	
	public int getBookStoreListCntUser(BookStore bookStore) {
		return dao.getBookStoreListCntUser(bookStore);
	}
	
}
