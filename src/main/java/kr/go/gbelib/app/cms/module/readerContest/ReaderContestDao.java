package kr.go.gbelib.app.cms.module.readerContest;

import java.util.List;

public interface ReaderContestDao {
	
	public List<ReaderContest> readerContestList(ReaderContest readerContest);
	
	public ReaderContest getReaderContest(ReaderContest readerContest);
	
	public int readerContestCount(ReaderContest readerContest);

	public int addReaderContest(ReaderContest readerContest);

	public int deleteReaderContest(ReaderContest readerContest);
	
	public int statusChangeReaderContest(ReaderContest readerContest);

}
