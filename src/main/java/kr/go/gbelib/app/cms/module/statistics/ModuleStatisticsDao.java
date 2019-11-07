package kr.go.gbelib.app.cms.module.statistics;

import java.util.List;

public interface ModuleStatisticsDao {

	public List<ModuleStatistics> getLockerStatistics(ModuleStatistics moduleStatistics);

	public List<ModuleStatistics> getExcursionsStatistics(ModuleStatistics moduleStatistics);

	public List<ModuleStatistics> getExcursionsStatisticsMonth(ModuleStatistics moduleStatistics);

	public List<ModuleStatistics> getExcursionsStatisticsYear(ModuleStatistics moduleStatistics);
	
	public List<ModuleStatistics> getFacilityStatistics(ModuleStatistics moduleStatistics);

	public List<ModuleStatistics> getFacilityStatisticsMonth(ModuleStatistics moduleStatistics);

	public List<ModuleStatistics> getFacilityStatisticsYear(ModuleStatistics moduleStatistics);
}
