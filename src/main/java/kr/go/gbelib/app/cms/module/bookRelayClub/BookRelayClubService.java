package kr.go.gbelib.app.cms.module.bookRelayClub;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;
import kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList.BookRelayClubList;
import kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList.BookRelayClubListDao;

@Service
public class BookRelayClubService extends BaseService {
	
	@Autowired
	private BookRelayClubDao dao;

	@Autowired
	private BookRelayClubListDao bookRelayClubListDao;
	
	@WorkingLogger(comment="독서릴레이-동아리 조회", type="P")
	public List<BookRelayClub> bookRelayClubList(BookRelayClub bookRelayClub) {
		return dao.bookRelayClubList(bookRelayClub);
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 엑셀 저장", type="P")
	public List<BookRelayClub> getExcelList(BookRelayClub bookRelayClub) {
		return dao.getExcelList(bookRelayClub);
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 1건 조회", type="P")
	public BookRelayClub getBookRelayClub(BookRelayClub bookRelayClub) {
		return dao.getBookRelayClub(bookRelayClub);
	}
	
	public int bookRelayClubCount(BookRelayClub bookRelayClub) {
		return dao.bookRelayClubCount(bookRelayClub);
		
	}

	public int addBookRelayClub(BookRelayClub bookRelayClub) {
		bookRelayClub.setClub_idx(dao.bookRelayClubIdx(bookRelayClub));
		dao.addBookRelayClub(bookRelayClub);
		
		for (BookRelayClubList list: bookRelayClub.getRelayList()) {
			list.setClub_idx(bookRelayClub.getClub_idx());
			list.setRelaylist_idx(bookRelayClubListDao.bookRelayClubListIdx(list));
			bookRelayClubListDao.addBookRelayClubList(list);
		}
		
		return 1;
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 1건 수정", type="P")
	public int modifyBookRelayClub(BookRelayClub bookRelayClub) {
		dao.modifyBookRelayClub(bookRelayClub);
		//1. 기존 명단 데이터 모두 삭제
		BookRelayClubList bookRelayClubList = new BookRelayClubList();
		bookRelayClubList.setClub_idx(bookRelayClub.getClub_idx());
		bookRelayClubListDao.deleteBookRelayClubList(bookRelayClubList);
 		for (BookRelayClubList list: bookRelayClub.getRelayList()) {
 			list.setClub_idx(bookRelayClub.getClub_idx());
			list.setRelaylist_idx(bookRelayClubListDao.bookRelayClubListIdx(list));
			//2. 전달받은 데이터 모두 입력 (수정은 없음)
			bookRelayClubListDao.addBookRelayClubList(list);
		}
		
		return 1;
	}
	
	@WorkingLogger(comment="독서릴레이-동아리 1건 삭제", type="P")
	public int deleteBookRelayClub(BookRelayClub bookRelayClub) {
		return dao.deleteBookRelayClub(bookRelayClub);
	}

	public int statusChangeBookRelayClub(BookRelayClub bookRelayClub) {
		return dao.statusChangeBookRelayClub(bookRelayClub);
	}
	
}
