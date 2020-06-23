package kr.go.gbelib.app.module.bookExpress;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;

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
	
	public int deleteCheckBookExpress(BookExpress bookExpress) {
		return dao.deleteCheckBookExpress(bookExpress);
	}

	public List<BookExpress> getBookExpressList(BookExpress bookExpress) {
		return dao.getBookExpressList(bookExpress);
	}

	public int getBookExpressCount(BookExpress bookExpress) {
		return dao.getBookExpressCount(bookExpress);
	}
	
	public Map<String, Integer> getStatusCount(BookExpress bookExpress) {
		return dao.getStatusCount(bookExpress);
	}

	public int setReason(BookExpress bookExpress) {
		return dao.setReason(bookExpress);
	}

	public int setRequestExpress(BookExpress bookExpress) {
		return dao.setRequestExpress(bookExpress);
	}

	public List<BookExpress> getBookExpressXls(BookExpress bookExpress) {
		return dao.getBookExpressXls(bookExpress);
	}

	@DataSource(DataSourceType.SLAVE1)
	public List<Map<String, Object>> getBookExpressMySQL() {
		return dao.getBookExpressMySQL();
	}

	public int addMyGration(BookExpress bookExpress) {
		return dao.addMyGration(bookExpress);
	}

	public int cancelBookExpress(BookExpress bookExpress) {
		return dao.cancelBookExpress(bookExpress);
	}

}
