package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibLocker;

import java.util.List;

/**
 * @author ttkaz
 * 2022. 10. 12.
 *
 */
public interface NearbyLibLockerDao {

	int addNeighborhoodLibraryLocker(NearbyLibLocker neighborhoodLibraryLocker);
	
	NearbyLibLocker getNeighborhoodLibraryLockerOne(NearbyLibLocker neighborhoodLibraryLocker);

	int addNeighborhoodLibraryLockerEach(NearbyLibLocker neighborhoodLibraryLocker);

	List<NearbyLibLocker> getNeighborhoodLibraryLockerEachOneList(NearbyLibLocker neighborhoodLibraryLocker);

	int modifyNeighborhoodLibraryLocker(NearbyLibLocker neighborhoodLibraryLocker);

	int getNeighborhoodLibraryLockerEachOneListCount(NearbyLibLocker neighborhoodLibraryLocker);

	int getNeighborhoodLibraryLockerCount(int device_idx);
}
