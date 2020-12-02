package kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList;

import java.util.List;

public interface BookRelayClubListDao {

	public List<BookRelayClubList> bookRelayList(BookRelayClubList bookRelayClubList);
	
	public List<BookRelayClubList> getExcelList(BookRelayClubList bookRelayClubList);
	
	public int bookRelayClubListIdx(BookRelayClubList bookRelayClubList);

	public int addBookRelayClubList(BookRelayClubList bookRelayClubList);

	public int modifyBookRelayClubList(BookRelayClubList bookRelayClubList);
	
	public int deleteBookRelayClubList(BookRelayClubList bookRelayClubList);
	
}
