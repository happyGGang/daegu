package kr.go.gbelib.app.cms.module.bookRelayIndividual;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class BookRelayIndividualService extends BaseService {
	
	@Autowired
	private BookRelayIndividualDao dao;
	
	@WorkingLogger(comment="독서릴레이-개인 조회", type="P")
	public List<BookRelayIndividual> bookRelayIndividualList(BookRelayIndividual bookRelayIndividual) {
		return dao.bookRelayIndividualList(bookRelayIndividual);
	}

	@WorkingLogger(comment="독서릴레이-개인 엑셀 저장", type="P")
	public List<BookRelayIndividual> getExcelList(BookRelayIndividual bookRelayIndividual) {
		return dao.getExcelList(bookRelayIndividual);
	}

	@WorkingLogger(comment="독서릴레이-개인 1건 조회", type="P")
	public BookRelayIndividual getBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.getBookRelayIndividual(bookRelayIndividual);
		
	}
	
	public int bookRelayIndividualCount(BookRelayIndividual bookRelayIndividual) {
		return dao.bookRelayIndividualCount(bookRelayIndividual);
		
	}

	public int addBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.addBookRelayIndividual(bookRelayIndividual);
	}

	@WorkingLogger(comment="독서릴레이-개인 1건 수정", type="P")
	public int modifyBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.modifyBookRelayIndividual(bookRelayIndividual);
	}

	@WorkingLogger(comment="독서릴레이-개인 1건 삭제", type="P")
	public int deleteBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.deleteBookRelayIndividual(bookRelayIndividual);
	}

	public int statusChangeBookRelayIndividual(BookRelayIndividual bookRelayIndividual) {
		return dao.statusChangeBookRelayIndividual(bookRelayIndividual);
	}

	public boolean checkDupRequest(BookRelayIndividual bookRelayIndividual) {
		return dao.checkDupRequest(bookRelayIndividual);
	}
	
}
