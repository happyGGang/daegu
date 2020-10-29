package kr.go.gbelib.app.cms.module.readerContest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ReaderContestService extends BaseService {
	
	@Autowired
	private ReaderContestDao dao;
	
	public List<ReaderContest> readerContestList(ReaderContest readerContest) {
		return dao.readerContestList(readerContest);
	}
	
	public ReaderContest getReaderContest(ReaderContest readerContest) {
		return dao.getReaderContest(readerContest);
	}
	
	public int readerContestCount(ReaderContest readerContest) {
		return dao.readerContestCount(readerContest);
	}

	public int addReaderContest(ReaderContest readerContest) {
		return dao.addReaderContest(readerContest);
	}

	public int deleteReaderContest(ReaderContest readerContest) {
		return dao.deleteReaderContest(readerContest);
	}
	
	public int statusChangeReaderContest(ReaderContest readerContest) {
		return dao.statusChangeReaderContest(readerContest);
	}
	
}
