package kr.go.gbelib.app.cms.module.bookReportClub;

import java.util.List;

public interface BookReportClubDao {

	public List<BookReportClub> bookReportClubList(BookReportClub bookReportClub);
	
	public List<BookReportClub> getExcelList(BookReportClub bookReportClub);
	
	public BookReportClub getBookReportClub(BookReportClub bookReportClub);
	
	public int bookReportClubCount(BookReportClub bookReportClub);

	public int addBookReportClub(BookReportClub bookReportClub);
	
	public int modifyBookReportClub(BookReportClub bookReportClub);

	public int deleteBookReportClub(BookReportClub bookReportClub);
	
	public int statusChangeBookReportClub(BookReportClub bookReportClub);
	
}
