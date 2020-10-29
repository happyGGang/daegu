package kr.go.gbelib.app.cms.module.bookRelayClub;

import java.util.List;

public interface BookRelayClubDao {

	public List<BookRelayClub> bookRelayClubList(BookRelayClub bookRelayClub);
	
	public BookRelayClub getBookRelayClub(BookRelayClub bookRelayClub);
	
	public int bookRelayClubCount(BookRelayClub bookRelayClub);
	
	public int bookRelayClubIdx(BookRelayClub bookRelayClub);

	public int addBookRelayClub(BookRelayClub bookRelayClub);
	
	public int modifyBookRelayClub(BookRelayClub bookRelayClub);

	public int deleteBookRelayClub(BookRelayClub bookRelayClub);

	public int statusChangeBookRelayClub(BookRelayClub bookRelayClub);
	
}
