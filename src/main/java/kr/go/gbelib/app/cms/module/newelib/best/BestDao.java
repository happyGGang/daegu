package kr.go.gbelib.app.cms.module.newelib.best;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.go.gbelib.app.cms.module.newelib.book.Book;

@Mapper(value = "bestDaoNew")
public interface BestDao {

	public List<BestBook> getMainBestBookList(Book book);

	public List<BestBook> getBestBookListCms(BestBook bestBook);

	public int addBestBook(Book book);

	public int deleteBestBook(Book book);

	public int getBestBookListCnt(Book book);

	public int getBestBookDupCnt(Book book);

	public Book getCategoryBestBook(Book book);

	public int addCategoryBestBook(Book book);

	public int deleteCategoryBestBook(Book book);

	public int deleteCategoryBestBookByPrintSeq(Book book);

	public List<Book> getCategoryBestBookList(Book book);

	public Book getLowerBestBook(Book book);

	public Book getHigherBestBook(Book book);

	public int modifyBestBookBookIdx(Book book);

	public List<Book> getNewBookList(Book book);

	public int getNewBookListCnt(Book book);

	public Book getLowerCategoryBestBook(Book book);

	public Book getHigherCategoryBestBook(Book book);

	public int modifyCategoryBestBookPrintSeq(Book book);

	public int getCategoryBestBookDupCnt(Book book);

	public int getBookListCnt(Book book);

	public List<BestBook> getBookList(Book book);

	/**
	 * @author whalesoft 2019. 12. 13.
	 * @param book
	 */
	public List<Book> getMainBookList(Book book);
}
