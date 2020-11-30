package kr.go.gbelib.app.cms.module.bookRelayIndividual;

import java.util.List;

public interface BookRelayIndividualDao {

	public List<BookRelayIndividual> bookRelayIndividualList(BookRelayIndividual bookRelayIndividual);
	
	public List<BookRelayIndividual> getExcelList(BookRelayIndividual bookRelayIndividual);
	
	public BookRelayIndividual getBookRelayIndividual(BookRelayIndividual bookRelayIndividual);
	
	public int bookRelayIndividualCount(BookRelayIndividual bookRelayIndividual);

	public int addBookRelayIndividual(BookRelayIndividual bookRelayIndividual);
	
	public int modifyBookRelayIndividual(BookRelayIndividual bookRelayIndividual);

	public int deleteBookRelayIndividual(BookRelayIndividual bookRelayIndividual);

	public int statusChangeBookRelayIndividual(BookRelayIndividual bookRelayIndividual);
	
}
