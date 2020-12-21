package kr.go.gbelib.app.cms.module.writingContest;

import java.util.List;

public interface WritingContestDao {
	
	public List<WritingContest> writingContestList(WritingContest writingContest);
	
	public List<WritingContest> getExcelList(WritingContest writingContest);
	
	public WritingContest getWritingContest(WritingContest writingContest);
	
	public int writingContestCount(WritingContest writingContest);

	public int addWritingContest(WritingContest writingContest);

	public int deleteWritingContest(WritingContest writingContest);
	
	public int statusChangeWritingContest(WritingContest writingContest);

}
