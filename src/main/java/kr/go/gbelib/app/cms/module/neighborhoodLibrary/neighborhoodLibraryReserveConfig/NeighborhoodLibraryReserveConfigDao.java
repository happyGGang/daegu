package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryReserveConfig;

import java.util.List;

/**
 * @author ttkaz
 * 2022. 10. 17.
 *
 */
public interface NeighborhoodLibraryReserveConfigDao {

	List<NeighborhoodLibraryReserveConfig> getNeighborhoodLibraryReserveConfigAll(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

	int getNeighborhoodLibraryReserveConfigCount(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

	int addNeighborhoodLibraryReserveConfig(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

	int modifyNeighborhoodLibraryDevice(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

	NeighborhoodLibraryReserveConfig getNeighborhoodLibraryReserveConfigOne(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

	List<NeighborhoodLibraryReserveConfig> getNeighborhoodLibraryReserveConfigList(NeighborhoodLibraryReserveConfig neighborhoodLibraryReserveConfig);

}
