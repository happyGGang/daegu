package kr.co.whalesoft.app.cms.module.bookStoreReq;

import java.util.List;

import kr.co.whalesoft.framework.base.BaseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookStoreReqService extends BaseService {
	
	@Autowired
	private BookStoreReqDao dao;
	
	public boolean getBookStoreReqCount(String loan_seq) {
		
		boolean flag = false;
		
		int count = dao.getBookStoreReqCount(loan_seq);
		
		if(count > 0) {
			flag = true; 
		} 
		
		return flag;
	}
	
	public List<BookStoreReq> getBookStoreReqList(BookStoreReq bookStoreReq) {
		return dao.getBookStoreReqList(bookStoreReq);
	}
	
	public BookStoreReq getBookStoreReqOne(BookStoreReq bookStoreReq) {
		return dao.getBookStoreReqOne(bookStoreReq);
	}
	
	public int getBookStoreReqListCount(BookStoreReq bookStoreReq) {
		return dao.getBookStoreReqListCount(bookStoreReq);
	}
	
	public int addBookStoreReq(BookStoreReq bookStoreReq) {
		return dao.addBookStoreReq(bookStoreReq);
	}
	
	public int modifyBookStoreReq(BookStoreReq bookStoreReq) {
		return dao.modifyBookStoreReq(bookStoreReq);
	}
	
	public int deleteBookStoreReq(BookStoreReq bookStoreReq) {
		return dao.deleteBookStoreReq(bookStoreReq);
	}

}
