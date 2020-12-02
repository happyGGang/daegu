package kr.go.gbelib.app.cms.module.bookRelayIndividual;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookRelayIndividualService extends BaseService {
	
	@Autowired
	private BookRelayIndividualDao dao;

	public List<BookRelayIndividual> bookRelayIndividualList(BookRelayIndividual bookRelayIndividual) {
		return dao.bookRelayIndividualList(bookRelayIndividual);
	}
	
	public List<BookRelayIndividual> getExcelList(BookRelayIndividual bookRelayIndividual) {
		return dao.getExcelList(bookRelayIndividual);
	}
	
	public BookRelayIndividual getBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.getBookRelayIndividual(bookRelayIndividual);
		
	}
	
	public int bookRelayIndividualCount(BookRelayIndividual bookRelayIndividual) {
		return dao.bookRelayIndividualCount(bookRelayIndividual);
		
	}

	public int addBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.addBookRelayIndividual(bookRelayIndividual);
	}
	
	public int modifyBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.modifyBookRelayIndividual(bookRelayIndividual);
	}

	public int deleteBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.deleteBookRelayIndividual(bookRelayIndividual);
	}

	public int statusChangeBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.statusChangeBookRelayIndividual(bookRelayIndividual);
	}
	
}
