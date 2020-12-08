package kr.go.gbelib.app.cms.module.bookRelayGroup;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class BookRelayGroupService extends BaseService {
	
	@Autowired
	private BookRelayGroupDao dao;
	
	@WorkingLogger(comment="독서릴레이-기관 조회", type="P")
	public List<BookRelayGroup> bookRelayGroupList(BookRelayGroup bookRelayGroup) {
		return dao.bookRelayGroupList(bookRelayGroup);
	}

	@WorkingLogger(comment="독서릴레이-기관 엑셀 저장", type="P")
	public List<BookRelayGroup> getExcelList(BookRelayGroup bookRelayGroup) {
		return dao.getExcelList(bookRelayGroup);
	}

	@WorkingLogger(comment="독서릴레이-기관 1건 조회", type="P")
	public BookRelayGroup getBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.getBookRelayGroup(bookRelayGroup);
		
	}
	
	public int bookRelayGroupCount(BookRelayGroup bookRelayGroup) {
		return dao.bookRelayGroupCount(bookRelayGroup);
		
	}

	public int addBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.addBookRelayGroup(bookRelayGroup);
	}

	@WorkingLogger(comment="독서릴레이-기관 1건 수정", type="P")
	public int modifyBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.modifyBookRelayGroup(bookRelayGroup);
	}

	@WorkingLogger(comment="독서릴레이-기관 1건 삭제", type="P")
	public int deleteBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.deleteBookRelayGroup(bookRelayGroup);
	}

	public int statusChangeBookRelayGroup(BookRelayGroup bookRelayGroup) {
		return dao.statusChangeBookRelayGroup(bookRelayGroup);
	}
	
}
