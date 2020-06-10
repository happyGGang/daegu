package kr.go.gbelib.app.module.bookExpress;

import java.util.List;
import java.util.Map;

public interface BookExpressDao {

	public List<BookExpress> getInterestBookList(BookExpress bookExpress);
	
	public int getInterestBookCount(BookExpress bookExpress);
	
	public int interestBookCheck(BookExpress bookExpress);
	
	public int addInterestBook(BookExpress bookExpress);
	
	public int modifyBookExpress(BookExpress bookExpress);
	
	public int deleteCheckBookExpress(BookExpress bookExpress);

	public List<BookExpress> getBookExpressList(BookExpress bookExpress);

	public int getBookExpressCount(BookExpress bookExpress);
	
	public Map<String, Integer> getStatusCount(BookExpress bookExpress);

	public int setReason(BookExpress bookExpress);

	public int setRequestExpress(BookExpress bookExpress);

	public List<BookExpress> getBookExpressXls(BookExpress bookExpress);

	public List<Map<String, Object>> getBookExpressMySQL();

	public int addMyGration(BookExpress bookExpress);

	public int cancelBookExpress(BookExpress bookExpress);

}
