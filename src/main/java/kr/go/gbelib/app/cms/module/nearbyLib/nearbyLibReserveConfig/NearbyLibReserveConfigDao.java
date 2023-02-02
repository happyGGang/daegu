package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import java.util.List;

import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManage;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
public interface NearbyLibReserveConfigDao {

	List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigAll(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int getNeighborhoodLibraryReserveConfigCount(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int addNeighborhoodLibraryReserveConfig(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int modifyNeighborhoodLibraryDevice(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int modifyNearbyLibReserveConfig(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	NearbyLibReserveConfig getNeighborhoodLibraryReserveConfigOne(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigList(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int getTakeTermOfReserveConfig();

	List<NearbyLibReserveConfig> getReserveConfigCalendar(NearbyLibManage nearbyLibManage);

	NearbyLibReserveConfig getReserveConfigToday(String nearbyLibManageCode);

	int checkReserveTime(NearbyLibReserveConfig nearbyLibReserveConfig);

	List<NearbyLibReserveConfig> getReserveConfigCalendarAll(NearbyLibManage nearbyLibManage);

	boolean checkTime(NearbyLibReserveConfig referenceConfig);

	NearbyLibReserveConfig getNearbyLibConfigOne(NearbyLibReserveConfig reserveConfig);

	boolean checkTimeYesterday(NearbyLibReserveConfig referenceConfig);

	boolean checkTimeToday(NearbyLibReserveConfig referenceConfig);

}
