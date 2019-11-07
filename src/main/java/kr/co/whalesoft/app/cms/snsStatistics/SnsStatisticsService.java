package kr.co.whalesoft.app.cms.snsStatistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class SnsStatisticsService extends BaseService {
	
	@Autowired
	private SnsStatisticsDao dao;
	
	public List<SnsStatistics> getSnsStatistics(SnsStatistics snsStatistics) {
		return dao.getSnsStatistics(snsStatistics);
	}
	
}
