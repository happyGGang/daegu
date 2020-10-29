package kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookRelayClubListService extends BaseService {
	
	@Autowired
	private BookRelayClubListDao dao;

	public List<BookRelayClubList> bookRelayList(BookRelayClubList bookRelayClubList) {
		return dao.bookRelayList(bookRelayClubList);
	}
 	
	public int bookRelayClubListIdx(BookRelayClubList bookRelayClubList) {
		return dao.bookRelayClubListIdx(bookRelayClubList);
	}
	
	public int addBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.addBookRelayClubList(bookRelayClubList);
	}
	
	public int modifyBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.modifyBookRelayClubList(bookRelayClubList);
	}
	
	public int deleteBookRelayClubList(BookRelayClubList bookRelayClubList) {
		return dao.deleteBookRelayClubList(bookRelayClubList);
	}
		
}
