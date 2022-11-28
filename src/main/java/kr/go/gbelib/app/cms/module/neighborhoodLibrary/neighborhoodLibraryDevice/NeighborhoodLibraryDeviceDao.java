package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryDevice;

import java.util.List;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */
public interface NeighborhoodLibraryDeviceDao {

	int addNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	List<NeighborhoodLibraryDevice> getNeighborhoodLibraryDeviceAll(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	int getNeighborhoodLibraryDeviceCount(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	NeighborhoodLibraryDevice getNeighborhoodLibraryDeviceOne(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	int modifyNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	int deleteNeighborhoodLibraryDevice(NeighborhoodLibraryDevice neighborhoodLibraryDevice);

	List<NeighborhoodLibraryDevice> getNeighborhoodLibraryDeviceList(NeighborhoodLibraryDevice neighborhoodLibraryDevice);
}
