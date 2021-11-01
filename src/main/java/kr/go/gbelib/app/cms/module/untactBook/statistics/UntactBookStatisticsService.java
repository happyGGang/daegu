package kr.go.gbelib.app.cms.module.untactBook.statistics;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class UntactBookStatisticsService extends BaseService {
	
	@Autowired
	private UntactBookStatisticsDao dao;

	public List<UntactBookStatistics> getArchiveStatistics(UntactBookStatistics untactBookStatistics) {
		List<UntactBookStatistics> result = new ArrayList<UntactBookStatistics>();
		
		if(untactBookStatistics.getDate_type().equals("TIME")) {
			result = dao.getTimeStatistics(untactBookStatistics);
		} else {
			if(untactBookStatistics.getDate_type().equals("DAY") || untactBookStatistics.getDate_type().equals("WEEK")) {
				String serach_date = untactBookStatistics.getYear() + "-" + untactBookStatistics.getMonth();
				untactBookStatistics.setSearch_date(serach_date);
			}
			
			result = dao.getArchiveStatistics(untactBookStatistics);
		}
		
		return result;
	}

	public int getStatisticsTotalCount(UntactBookStatistics untactBookStatistics) {
		return dao.getStatisticsTotalCount(untactBookStatistics);
	}

	public List<UntactBookStatistics> getUntactBookStatisticsExcelList(UntactBookStatistics untactBookStatistics) {
		return dao.getUntactBookStatisticsExcelList(untactBookStatistics);
	}

}
