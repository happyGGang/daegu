package kr.go.gbelib.app.cms.module.readerContest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.mybatis.interceptor.WorkingLogger;

@Service
public class ReaderContestService extends BaseService {
	
	@Autowired
	private ReaderContestDao dao;
	
	@WorkingLogger(comment="다독자공모 조회", type="P")
	public List<ReaderContest> readerContestList(ReaderContest readerContest) {
		return dao.readerContestList(readerContest);
	}
	
	@WorkingLogger(comment="다독자공모 엑셀 저장", type="P")
	public List<ReaderContest> getExcelList(ReaderContest readerContest) {
		return dao.getExcelList(readerContest);
	}
	
	@WorkingLogger(comment="다독자공모 1건 조회", type="P")
	public ReaderContest getReaderContest(ReaderContest readerContest) {
		return dao.getReaderContest(readerContest);
	}
	
	public int readerContestCount(ReaderContest readerContest) {
		return dao.readerContestCount(readerContest);
	}

	public int addReaderContest(ReaderContest readerContest) {
		return dao.addReaderContest(readerContest);
	}
	
	@WorkingLogger(comment="다독자공모 1건 삭제", type="P")
	public int deleteReaderContest(ReaderContest readerContest) {
		return dao.deleteReaderContest(readerContest);
	}
	
	public int statusChangeReaderContest(ReaderContest readerContest) {
		return dao.statusChangeReaderContest(readerContest);
	}
	
}
