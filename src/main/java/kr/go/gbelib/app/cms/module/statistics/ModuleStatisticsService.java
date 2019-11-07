package kr.go.gbelib.app.cms.module.statistics;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class ModuleStatisticsService extends BaseService {
	
	@Autowired
	private ModuleStatisticsDao dao;

	public List<ModuleStatistics> getLockerStatistics(ModuleStatistics moduleStatistics) {
		return dao.getLockerStatistics(moduleStatistics);
	}

	public List<ModuleStatistics> getExcursionsStatistics(ModuleStatistics moduleStatistics) {
		return dao.getExcursionsStatistics(moduleStatistics);
	}

	public List<ModuleStatistics> getExcursionsStatisticsMonth(ModuleStatistics moduleStatistics) {
		return dao.getExcursionsStatisticsMonth(moduleStatistics);
	} 
	
	public List<ModuleStatistics> getExcursionsStatisticsYear(ModuleStatistics moduleStatistics) {
		return dao.getExcursionsStatisticsYear(moduleStatistics);
	} 
	
	public List<ModuleStatistics> getFacilityStatistics(ModuleStatistics moduleStatistics) {
		return dao.getFacilityStatistics(moduleStatistics);
	}

	public List<ModuleStatistics> getFacilityStatisticsMonth(ModuleStatistics moduleStatistics) {
		return dao.getFacilityStatisticsMonth(moduleStatistics);
	} 
	
	public List<ModuleStatistics> getFacilityStatisticsYear(ModuleStatistics moduleStatistics) {
		return dao.getFacilityStatisticsYear(moduleStatistics);
	} 

}
