package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManage;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
@Service
public class NearbyLibReserveConfigService extends BaseService{
	
	@Autowired
	private NearbyLibReserveConfigDao dao;
	
	public List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigAll(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigAll(neighborhoodLibraryReserveConfig);
	}

	public int getNeighborhoodLibraryReserveConfigCount(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigCount(neighborhoodLibraryReserveConfig);
	}
	
	public NearbyLibReserveConfig getNeighborhoodLibraryReserveConfigOne(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigOne(neighborhoodLibraryReserveConfig);
	}

	public int addNeighborhoodLibraryReserveConfig(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.addNeighborhoodLibraryReserveConfig(neighborhoodLibraryReserveConfig);
	}

	public int modifyNeighborhoodLibraryDevice(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.modifyNeighborhoodLibraryDevice(neighborhoodLibraryReserveConfig);
	}

	public List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigList(NearbyLibReserveConfig neighborhoodLibraryReserveConfig) {
		return dao.getNeighborhoodLibraryReserveConfigList(neighborhoodLibraryReserveConfig);
	}

	public int getTakeTermOfReserveConfig() {
		return dao.getTakeTermOfReserveConfig();
	}

	public List<NearbyLibReserveConfig> getReserveConfigCalendar(NearbyLibManage nearbyLibManage) {
		return dao.getReserveConfigCalendar(nearbyLibManage);
	}

	public int getReserveConfigTodayCount(String nearbyLibHomepageId) {
		return dao.getReserveConfigTodayCount(nearbyLibHomepageId);
	}

	public NearbyLibReserveConfig getReserveConfigToday(String nearbyLibHomepageId) {
		return dao.getReserveConfigToday(nearbyLibHomepageId);
	}

	public int checkReserveTime(NearbyLibReserveConfig nearbyLibReserveConfig) {
		return dao.checkReserveTime(nearbyLibReserveConfig);
	}

}
