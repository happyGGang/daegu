package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibReserveConfig;

import java.util.List;

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

	NearbyLibReserveConfig getNeighborhoodLibraryReserveConfigOne(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	List<NearbyLibReserveConfig> getNeighborhoodLibraryReserveConfigList(NearbyLibReserveConfig neighborhoodLibraryReserveConfig);

	int getTakeTermOfReserveConfig();

}
