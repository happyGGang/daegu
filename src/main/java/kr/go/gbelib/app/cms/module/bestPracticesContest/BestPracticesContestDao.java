package kr.go.gbelib.app.cms.module.bestPracticesContest;

import java.util.List;

public interface BestPracticesContestDao {

	public List<BestPracticesContest> bestPracticesContestList(BestPracticesContest bestPracticesContest);
	
	public List<BestPracticesContest> getExcelList(BestPracticesContest bestPracticesContest);
	
	public BestPracticesContest getBestPracticesContest(BestPracticesContest bestPracticesContest);
	
	public int bestPracticesContestCount(BestPracticesContest bestPracticesContest);

	public int addBestPracticesContest(BestPracticesContest bestPracticesContest);
	
	public int modifyBestPracticesContest(BestPracticesContest bestPracticesContest);

	public int deleteBestPracticesContest(BestPracticesContest bestPracticesContest);
	
	public int addViewCount(BestPracticesContest bestPracticesContest);
	
	public int deleteFile(BestPracticesContest bestPracticesContest);
	
	public int deleteFile2(BestPracticesContest bestPracticesContest);
	
	public int deleteFile3(BestPracticesContest bestPracticesContest);
	
}
