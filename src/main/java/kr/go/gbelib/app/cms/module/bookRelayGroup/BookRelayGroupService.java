package kr.go.gbelib.app.cms.module.bookRelayGroup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BookRelayGroupService extends BaseService {
	
	@Autowired
	private BookRelayGroupDao dao;

	public List<BookRelayGroup> bookRelayGroupList(BookRelayGroup bookRelayGroup) {
		return dao.bookRelayGroupList(bookRelayGroup);
	}
	
	public BookRelayGroup getBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.getBookRelayGroup(bookRelayGroup);
		
	}
	
	public int bookRelayGroupCount(BookRelayGroup bookRelayGroup) {
		return dao.bookRelayGroupCount(bookRelayGroup);
		
	}

	public int addBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.addBookRelayGroup(bookRelayGroup);
	}
	
	public int modifyBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.modifyBookRelayGroup(bookRelayGroup);
	}

	public int deleteBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.deleteBookRelayGroup(bookRelayGroup);
	}

	public int statusChangeBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.statusChangeBookRelayGroup(bookRelayGroup);
	}
	
}
