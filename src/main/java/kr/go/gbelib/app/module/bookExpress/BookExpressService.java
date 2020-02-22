package kr.go.gbelib.app.module.bookExpress;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookExpressService extends BaseService {
	
	@Autowired
	private BookExpressDao dao;
	
	public List<BookExpress> getInterestBookList(BookExpress bookExpress) {
		return dao.getInterestBookList(bookExpress);
	}
	
	public int getInterestBookCount(BookExpress bookExpress) {
		return dao.getInterestBookCount(bookExpress);
	}
	
	public int interestBookCheck(BookExpress bookExpress) {
		return dao.interestBookCheck(bookExpress);
	}

	public int addInterestBook(BookExpress bookExpress) {
		return dao.addInterestBook(bookExpress);
	}
	
	public int modifyBookExpress(BookExpress bookExpress) {
		return dao.modifyBookExpress(bookExpress);
	}

	public List<BookExpress> getBookExpressList(BookExpress bookExpress) {
		return dao.getBookExpressList(bookExpress);
	}

	public int getBookExpressCount(BookExpress bookExpress) {
		return dao.getBookExpressCount(bookExpress);
	}

	public int setReason(BookExpress bookExpress) {
		return dao.setReason(bookExpress);
	}

	public int setRequestExpress(BookExpress bookExpress) {
		return dao.setRequestExpress(bookExpress);
	}

}
