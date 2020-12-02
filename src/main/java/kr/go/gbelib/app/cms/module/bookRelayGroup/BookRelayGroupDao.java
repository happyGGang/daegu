package kr.go.gbelib.app.cms.module.bookRelayGroup;

import java.util.List;

public interface BookRelayGroupDao {

	public List<BookRelayGroup> bookRelayGroupList(BookRelayGroup bookRelayGroup);
	
	public BookRelayGroup getBookRelayGroup(BookRelayGroup bookRelayGroup);
	
	public int bookRelayGroupCount(BookRelayGroup bookRelayGroup);

	public int addBookRelayGroup(BookRelayGroup bookRelayGroup);
	
	public int modifyBookRelayGroup(BookRelayGroup bookRelayGroup);

	public int deleteBookRelayGroup(BookRelayGroup bookRelayGroup);

	public int statusChangeBookRelayGroup(BookRelayGroup bookRelayGroup);

	public List<BookRelayGroup> getExcelList(BookRelayGroup bookRelayGroup);
	
}
