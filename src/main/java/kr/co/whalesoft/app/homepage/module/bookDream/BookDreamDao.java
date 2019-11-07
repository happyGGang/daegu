package kr.co.whalesoft.app.homepage.module.bookDream;

import java.util.List;
import kr.go.gbelib.app.cms.module.newBookDream.NewBookDream;

public interface BookDreamDao {

	public String getTotalPrice();

	public int getCurrentTotalPrice();

	public String getDayCount();

	public int getRequestCountByMember(BookDream bookDream);

	public String getPriCount();

	public int getMonthRequestCountByMember(BookDream bookDream);

	public int addBookDream(BookDream bookDream);

	public int getRequestListCount(BookDream bookDream);

	public List<BookDream> getRequestList(BookDream bookDream);

	public int getRequestListCountCMS(BookDream bookDream);
	
	public List<BookDream> getRequestListCMS(BookDream bookDream);
	public List<BookDream> getRequestListCMS2(BookDream bookDream);

	public List<BookDream> getRequestListOne(BookDream bookDream2);

	public BookDream getBookDreamOne(BookDream bookDream);

	//이력 남기기
	public int addBookDreamHistory(BookDream bookDream);

	public BookDream getMyRequestOne(BookDream bookDream);

	public int modifyBookDream(BookDream bookDream);

	public int cancelBookDream(BookDream bookDream);

	public int haveBookDream(BookDream bookDream);

	public int getMyRequestListCount(BookDream bookDream);

	public List<BookDream> getMyRequestList(BookDream bookDream);

	public List<BookDream> getNewBookConfig();

	public void modifyBookDreamConfig(BookDream bookDream);

	public List<BookDream> getNewBookStore();

	public BookDream getNewBookStoreOne(NewBookDream bookDream);

	public int modifyBookDreamStore(NewBookDream newBookDream);

	public int deleteBookDreamStore(NewBookDream newBookDream);

	public List<BookDream> getBookDreamOneHistory(NewBookDream bookDream);

	public BookDream getNewBookStoreAdmin(BookDream bookDream);

	public String getBookDreamConfigOne(BookDream bookDream);

	public BookDream getBookDreamConfigByState(BookDream bookDream);
	
	public List<BookDream> getD3List();

	public List<BookDream> getDdayList();

	public int sendedMessage(BookDream bookDream);

	public List<BookDream> getRequestListExcel(NewBookDream bookDream);

	public int getRequestCountByIsbn(BookDream bookDream);
	
	public int modifyState(NewBookDream newBookDream);

}
