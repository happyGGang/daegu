package kr.co.whalesoft.app.cms.libSvcStatistics;

import java.util.List;

public interface LibSvcStatisticsDao {
	
	public LibSvcStatistics getCategoryCnt(LibSvcStatistics libSvcStatistics);

	public List<LibSvcStatistics> getMemberCnt(LibSvcStatistics libSvcStatistics);

}
