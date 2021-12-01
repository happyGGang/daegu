package kr.go.gbelib.app.cms.module.elib.statistics;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

public interface ElibStatisticsDao {
	
	public List<Map<String, Object>> getStatisticsByCategory(ElibStatistics elibStatistics);
	
	public int getStatisticsByBookCnt(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsByBook(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsByBookAll(ElibStatistics elibStatistics);

	public int getStatisticsByMemberCnt(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsByMember(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsByMemberAll(ElibStatistics elibStatistics);
	
	/**
	 * 소장자료별 통계의 총합계
	 * @author YONGJU 2017. 10. 31.
	 * @param elibStatistics
	 * @return
	 */
	public ElibStatistics getStatisticsByBookTotal(ElibStatistics elibStatistics);

	/**
	 * 회원별 통계의 총 합계
	 * @author YONGJU 2017. 10. 31.
	 * @param elibStatistics
	 * @return
	 */
	public ElibStatistics getStatisticsByMemberTotal(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsSummaryList(ElibStatistics elibStatistics);
	
	public List<ElibStatistics> getStatisticsUniqueSummaryList(ElibStatistics elibStatistics);
	
	public List<Map<String, Object>> getStatisticsByCompany(ElibStatistics elibStatistics);
	
}
