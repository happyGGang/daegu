package kr.co.whalesoft.app.cms.archiveStatistics;

import java.util.List;

public interface ArchiveStatisticsDao {

	public List<ArchiveStatistics> getTimeStatistics(ArchiveStatistics archiveStatistics);

	public List<ArchiveStatistics> getArchiveStatistics(ArchiveStatistics archiveStatistics);
	
	public int getStatisticsTotalCount(ArchiveStatistics archiveStatistics);

}
