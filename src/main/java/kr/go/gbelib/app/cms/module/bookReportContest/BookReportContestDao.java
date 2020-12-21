package kr.go.gbelib.app.cms.module.bookReportContest;

import java.util.List;

public interface BookReportContestDao {

	public List<BookReportContest> bookReportContestList(BookReportContest bookReportContest);
	
	public List<BookReportContest> getExcelList(BookReportContest bookReportContest);
	
	public BookReportContest getBookReportContest(BookReportContest bookReportContest);
	
	public int bookReportContestCount(BookReportContest bookReportContest);

	public int addBookReportContest(BookReportContest bookReportContest);
	
	public int modifyBookReportContest(BookReportContest bookReportContest);

	public int deleteBookReportContest(BookReportContest bookReportContest);
	
	public int statusChangeBookReportContest(BookReportContest bookReportContest);
	
}
