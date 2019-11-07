package kr.co.whalesoft.app.cms.module.bookStoreReq;

import java.util.List;

public interface BookStoreReqDao {
	
	public int getBookStoreReqCount(String loan_seq);
	
	public List<BookStoreReq> getBookStoreReqList(BookStoreReq bookStoreReq);
	
	public BookStoreReq getBookStoreReqOne(BookStoreReq bookStoreReq);
	
	public int getBookStoreReqListCount(BookStoreReq bookStoreReq);
	
	public int addBookStoreReq(BookStoreReq bookStoreReq);
	
	public int modifyBookStoreReq(BookStoreReq bookStoreReq);
	
	public int deleteBookStoreReq(BookStoreReq bookStoreReq);

}
