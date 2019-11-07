package kr.go.gbelib.app.cms.module.bookReview;

import java.util.List;

public interface BookReviewDao {
	
	public List<BookReview> getBookReviewLocaList(BookReview bookReview);
	
	public int getBookReviewLocaListCnt(BookReview bookReview);
	
	public List<BookReview> getBookReviewList(BookReview bookReview);

	public int addBookReview(BookReview bookReview);
	
	public int modBookReview(BookReview bookReview);

	public int delBookReview(BookReview bookReview);

	public int duplBookReviewUserCnt(BookReview bookReview);

	public List<BookReview> getBookReviewAll(BookReview bookReview);

	public int getbookReviewAllCnt(BookReview bookReview);
	
	public List<BookReview> getBookReviewXlsAndCsv(BookReview bookReview);

	public BookReview getBookReviewOne(BookReview bookReview);

}
