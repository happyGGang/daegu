package kr.go.gbelib.app.cms.module.neighborhoodLibrary.neighborhoodLibraryLocker;

import java.util.List;

/**
 * @author ttkaz
 * 2022. 10. 12.
 *
 */
public interface NeighborhoodLibraryLockerDao {

	int addNeighborhoodLibraryLocker(NeighborhoodLibraryLocker neighborhoodLibraryLocker);
	
	NeighborhoodLibraryLocker getNeighborhoodLibraryLockerOne(NeighborhoodLibraryLocker neighborhoodLibraryLocker);

	int getNeighborhoodLibraryLockerCount(NeighborhoodLibraryLocker neighborhoodLibraryLocker);
	
	int addNeighborhoodLibraryLockerEach(NeighborhoodLibraryLocker neighborhoodLibraryLocker);

	List<NeighborhoodLibraryLocker> getNeighborhoodLibraryLockerEachOneList(NeighborhoodLibraryLocker neighborhoodLibraryLocker);

	int modifyNeighborhoodLibraryLocker(NeighborhoodLibraryLocker neighborhoodLibraryLocker);

	int getNeighborhoodLibraryLockerEachOneListCount(NeighborhoodLibraryLocker neighborhoodLibraryLocker);
}
