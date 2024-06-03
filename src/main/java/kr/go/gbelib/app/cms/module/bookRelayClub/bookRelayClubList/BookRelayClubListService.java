package kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class BookRelayClubListService extends BaseService {
	
	@Autowired
	private BookRelayClubListDao dao;
	
	@WorkingLogger(comment="독서릴레이-동아리 릴레이명단 조회", type="P")
	public List<BookRelayClubList> bookRelayList(BookRelayClubList bookRelayClubList) {
		return dao.bookRelayList(bookRelayClubList);
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 릴레이명단 엑셀 저장", type="P")
	public List<BookRelayClubList> getExcelList(BookRelayClubList bookRelayClubList) {
		return dao.getExcelList(bookRelayClubList);
	}
 	
	public int bookRelayClubListIdx(BookRelayClubList bookRelayClubList) {
		return dao.bookRelayClubListIdx(bookRelayClubList);
	}
	
	public int addBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.addBookRelayClubList(bookRelayClubList);
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 릴레이명단 수정", type="P", tableName = "BOOK_RELAY_CLUB_RELAYLIST")
	public int modifyBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.modifyBookRelayClubList(bookRelayClubList);
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 릴레이명단 삭제", type="P")
	public int deleteBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.deleteBookRelayClubList(bookRelayClubList);
	}
		
}
