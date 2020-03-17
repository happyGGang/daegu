package kr.co.whalesoft.app.cms.archiveStatistics;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ArchiveStatisticsService extends BaseService {
	
	@Autowired
	private ArchiveStatisticsDao dao;

	public List<ArchiveStatistics> getArchiveStatistics(ArchiveStatistics archiveStatistics) {
		List<ArchiveStatistics> result = new ArrayList<ArchiveStatistics>();
		
		if(archiveStatistics.getDate_type().equals("TIME")) {
			result = dao.getTimeStatistics(archiveStatistics);
		} else {
			if(archiveStatistics.getDate_type().equals("DAY") || archiveStatistics.getDate_type().equals("WEEK")) {
				String serach_date = archiveStatistics.getYear() + "-" + archiveStatistics.getMonth();
				archiveStatistics.setSearch_date(serach_date);
			}
			
			result = dao.getArchiveStatistics(archiveStatistics);
		}
		
		return result;
	}

	public int getStatisticsTotalCount(ArchiveStatistics archiveStatistics) {
		return dao.getStatisticsTotalCount(archiveStatistics);
	}

}
