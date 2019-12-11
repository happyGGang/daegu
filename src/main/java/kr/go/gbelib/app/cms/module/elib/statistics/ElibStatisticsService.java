package kr.go.gbelib.app.cms.module.elib.statistics;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ElibStatisticsService extends BaseService {
	
	@Autowired
	private ElibStatisticsDao dao;
	
	public List<Map<String, Object>> getStatisticsByCategory(ElibStatistics elibStatistics) {
		return dao.getStatisticsByCategory(elibStatistics);
	}
	
	public int getStatisticsByBookCnt(ElibStatistics elibStatistics) {
		return dao.getStatisticsByBookCnt(elibStatistics);
	}
	
	public List<ElibStatistics> getStatisticsByBook(ElibStatistics elibStatistics) {
		return dao.getStatisticsByBook(elibStatistics);
	}
	
	public List<ElibStatistics> getStatisticsByBookAll(ElibStatistics elibStatistics) {
		return dao.getStatisticsByBookAll(elibStatistics);
	}
	
	public int getStatisticsByMemberCnt(ElibStatistics elibStatistics) {
		return dao.getStatisticsByMemberCnt(elibStatistics);
	}
	
	public List<ElibStatistics> getStatisticsByMember(ElibStatistics elibStatistics) {
		return dao.getStatisticsByMember(elibStatistics);
	}
	
	public List<ElibStatistics> getStatisticsByMemberAll(ElibStatistics elibStatistics) {
		return dao.getStatisticsByMemberAll(elibStatistics);
	}
	
	/**
	 * 소장자료별 통계의 총합계
	 * @author YONGJU 2017. 10. 31.
	 * @param elibStatistics
	 * @return
	 */
	public ElibStatistics getStatisticsByBookTotal(ElibStatistics elibStatistics) {
		return dao.getStatisticsByBookTotal(elibStatistics);
	}

	/**
	 * 회원별 통계의 총 합계
	 * @author YONGJU 2017. 10. 31.
	 * @param elibStatistics
	 * @return
	 */
	public ElibStatistics getStatisticsByMemberTotal(ElibStatistics elibStatistics) {
		return dao.getStatisticsByMemberTotal(elibStatistics);
	}
	
	public List<ElibStatistics> getStatisticsSummaryList(ElibStatistics elibStatistics) {
		return dao.getStatisticsSummaryList(elibStatistics);
	}

	public List<ElibStatistics> getStatisticsUniqueSummaryList(ElibStatistics elibStatistics) {
		return dao.getStatisticsUniqueSummaryList(elibStatistics);
	}
	
	public List<Map<String, Object>> getStatisticsByCompany(ElibStatistics elibStatistics) {
		return dao.getStatisticsByCompany(elibStatistics);
	}
	
}
