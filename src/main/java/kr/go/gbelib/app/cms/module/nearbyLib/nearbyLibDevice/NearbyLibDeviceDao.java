package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibDevice;

import java.util.List;

/**
 * @author ttkaz
 * 2022. 9. 29.
 *
 */
public interface NearbyLibDeviceDao {

	int addNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice);

	List<NearbyLibDevice> getNeighborhoodLibraryDeviceAll(NearbyLibDevice neighborhoodLibraryDevice);

	int getNeighborhoodLibraryDeviceCount(NearbyLibDevice neighborhoodLibraryDevice);

	NearbyLibDevice getNeighborhoodLibraryDeviceOne(NearbyLibDevice neighborhoodLibraryDevice);

	int modifyNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice);

	int deleteNeighborhoodLibraryDevice(NearbyLibDevice neighborhoodLibraryDevice);

	List<NearbyLibDevice> getNeighborhoodLibraryDeviceList(NearbyLibDevice neighborhoodLibraryDevice);

	List<NearbyLibDevice> getNearbyLibDeviceList(NearbyLibDevice neighborhoodLibraryDevice);
}
