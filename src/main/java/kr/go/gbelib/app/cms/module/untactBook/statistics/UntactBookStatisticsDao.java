package kr.go.gbelib.app.cms.module.untactBook.statistics;

import java.util.List;

public interface UntactBookStatisticsDao {

	public List<UntactBookStatistics> getTimeStatistics(UntactBookStatistics untactBookStatistics);

	public List<UntactBookStatistics> getArchiveStatistics(UntactBookStatistics untactBookStatistics);
	
	public int getStatisticsTotalCount(UntactBookStatistics untactBookStatistics);

	public List<UntactBookStatistics> getUntactBookStatisticsExcelList(UntactBookStatistics untactBookStatistics);

}
