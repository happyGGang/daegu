package kr.go.gbelib.app.cms.module.teach.statistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class TeachStatisticsService extends BaseService {
	
	@Autowired
	private TeachStatisticsDao dao;
	
	public List<TeachStatistics> getTeachStatistics(TeachStatistics teachStatistics) {
		return dao.getTeachStatistics(teachStatistics);
	}
	
}
