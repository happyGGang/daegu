package kr.go.gbelib.app.cms.module.elib.book;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

public interface BookDao {

	public int getBookListCnt(Book book);
	
	public int getBookListCntCms(Book book);
	
	public int getBookListCntUpload(Book book);
	
	public List<Book> getBookList(Book book);
	
	public List<Book> getBookListCms(Book book);
	
	public List<Book> getBookListUpload(Book book);
	
	public List<Book> getBookListAll(Book book);

	public List<Book> getCompList(Book book);
	
	public Book getBookInfo(Book book);
	
	public int codeDupCheck(Book book);

	public int elearningCodeDupCheck(Book book);

	public int audiobookCodeDupCheck(Book book);
	
	public int addBook(Book book);

	public int addBookInfo(Book book);

	public int modifyBook(Book book);
	
	public int modifyBookInfo(Book book);

	public int dupCnt(Book book);
	
	public int deleteBook(Book book);
	
	public int deleteUnapprovedBook(Book book);
	
	public int deleteBookInfo(Book book);
	
	public int addAudiobook(Book book);
	
	public int modifyAudiobook(Book book);
	
	public int deleteAudiobook(Book book);
	
	public int recommendBook(Book book);
	
	public int addRecommendLog(Book book);
	
	public int deleteRecommendLog(Book book);
	
	public int recommendDupCheck(Book book);
	
	public int recommendsCnt(Book book);
	
	public List<Book> getBookSearchedList(Book book);
	
	public int getBookSearchedListCnt(Book book);
	
	public List<Book> getBookCountByType(Book book);
	
	public List<Book> getBookCountByAuthor(Book book);
	
	public List<Book> getBookCountByPublisher(Book book);
	
	public List<Book> getBookCountByYear(Book book);
	
	public int getBookCountByTypeCnt(Book book);
	
	public int getBookCountByAuthorCnt(Book book);
	
	public int getBookCountByPublisherCnt(Book book);
	
	public int getBookCountByYearCnt(Book book);
	
	public List<Book> getCategoryBestBookList(Book book);
	
	public int getBookCountByDeviceCnt(Book book);
	
	public List<Book> getBookCountByDevice(Book book);
	
	public List<Book> getCourseList(Book book);
	
	public List<Book> getAudioList(Book book);
	
	public int addElearning(Book book);
	
	public int modifyElearning(Book book);
	
	public int deleteElearning(Book book);
	
	public Integer getBookIdx(Book book);
	
	public Integer getLessonNo(Book book);
	
	public Integer getCourseIdx(Book book);
	
	public Integer getAudioIdx(Book book);
	
	public int addBookList(Book book);
	
	public int approveBook(Book book);
	
	public int disapproveBook(Book book);
	
	public int approveBookAll(Book book);

	public List<Book> getLendingBookListState(Book book);

	public List<Book> getBookInterestList(Book book);
	
}
