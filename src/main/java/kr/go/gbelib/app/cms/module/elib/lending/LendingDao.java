package kr.go.gbelib.app.cms.module.elib.lending;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.go.gbelib.app.cms.module.elib.book.Book;

public interface LendingDao {

	public List<Lending> getLendMemberList(Lending lending);
	
	public int getLendMemberListCnt(Lending lending);

	public List<Lending> getAudioMemberList(Lending lending);

	public int getAudioMemberListCnt(Lending lending);

	public List<Lending> getReserveMemberList(Lending lending);

	public int getReserveMemberListCnt(Lending lending);
	
	public List<Lending> getLendMemberListAll(Lending lending);
	
	public List<Lending> getReserveMemberListAll(Lending lending);
	
	public Lending getLending(Lending lending);
	
	public int returnLending(Lending lending);
	
	public List<Lending> getBookReserveList(Lending lending);
	
	public int getUserBorrowCnt(Lending lending);
	
	public int getBookLendCnt(Lending lending);
	
	public int getNotReturnedCnt(Lending lending);
	
	public int getDupReserveCnt(Lending lending);
	
	public int getDupLendingCnt(Lending lending);
	
	public int addLending(Lending lending);
	
	public int updateLendReserveCnt(Lending lending);
	
	public List<Lending> getNotReturnedList(Lending lending);
	
	public int updateLendableDt(Lending lending);
	
	public int getReserveCnt(Lending lending);
	
	public Lending getReserve(Lending lending);
	
	public int deleteReserve(Lending lending);
	
	/**
	 * 책 기준 예약건수 
	 * @param lending.book_idx
	 * @return
	 */
	public int getBookReserveCnt(Lending lending);
	
	public int getMemberReserveCnt(Lending lending);
	
	public int addReserve(Lending lending);
	
	public List<Lending> getFavoritesList(Lending lending);
	
	public int getFavoritesListCnt(Lending lending);
	
	public int getDupFavoritesCnt(Lending lending);
	
	public int addFavorite(Lending lending);
	
	public int deleteFavorite(Lending lending);
	
	public List<Lending> getBooksToAutoReturn();
	
	public List<Lending> getReservesLendable();
	
	public List<Lending> getBookstoAutoUpdateLendableDt();
	
	public int extendLending(Lending lending);
	
	public int reserveToLending(Lending lending);
	
	public int setMsgConfirmN(Lending lending);

	public int addLendingWithReturn(Lending lending);

	public int addAutdioBookStat(Lending lending);

	public Lending getLendingByLendIdx(Lending lending);

	/**
	 * 이러닝 통계 수집
	 * @author YONGJU 2017. 10. 31.
	 * @param lending
	 * @return
	 */
	public int addElearnStat(Lending lending);
	
	public int addExtlinkStat(Book book);

	public String getBookName(Lending lending);

	/**
	 * 뷰어 이용 이력
	 * @author YONGJU 2022. 09. 19.
	 * @param lending
	 * @return
	 */
	public int addBookViewerAccess(Lending lending);
	
}
