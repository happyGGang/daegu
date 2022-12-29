package kr.go.gbelib.app.cms.module.nearbyLib;

import java.util.List;

import kr.go.gbelib.app.cms.module.neighborhoodLibrary.NeighborhoodLibrary;

/**
 * @author SeongHyeon
 * 2022. 9. 27.
 *
 */
public interface NearbyLibDao {

	List<NearbyLib> getNeighborhoodLibraryList(NearbyLib neigborhoodLibrary);

	int insertNeighborhoodLibrary(NearbyLib neighborhoodLibrary);

	List<NearbyLib> getNeighborhoodLibraryUseList(NearbyLib neighborhoodLibrary);

	int addNeighborhoodLibrary(NearbyLib neighborhoodLibrary);

	int getNeighborhoodLibraryBundleIdx(NearbyLib neighborhoodLibrary);
	
	int getNeighborhoodLibraryCount(NearbyLib neighborhoodLibrary);

	List<NearbyLib> getNeighborhoodLibraryListAll(NearbyLib neighborhoodLibrary);

	int updateNeighborhoodLibrary(NearbyLib neighborhoodLibrary);

	NearbyLib sameNeighborhoodLibraryForUser(NearbyLib neighborhoodLibrary);
	
	NearbyLib getSameNeighborhoodLibraryBundle_idx(NearbyLib neighborhoodLibrary);

	int updateNeighborhoodLibrarySms(NearbyLib neighborhoodLibrary);

	List<NearbyLib> getSameNeighborhoodLibraryBundleList(NearbyLib neighborhoodLibrary);

	NearbyLib getNeighborhoodLibraryBookOne(NearbyLib neighborhoodLibrary);

	int getSameNeighborhoodLibraryReserveCallIdx(NearbyLib neighborhoodLibrary);

	int updateNeighborhoodLibraryPK(NearbyLib neighborhoodLibrary);

	NearbyLib getSameNeighborhoodLibraryPkData(NearbyLib neighborhoodLibrary);

	List<NearbyLib> checkReserveLocker(NearbyLib neighborhoodLibrary);

	int updateNeighborhoodLibraryBookSize(NearbyLib nearbyLib);

	int updateNeighborhoodLibraryLocker_idx(NearbyLib nearbyLib);

	NearbyLib getSearchNeighborhoodLibraryOne(NearbyLib neighborhoodLibrary);

	NearbyLib getSearchNeighborhoodLibraryApiOne(NearbyLib neighborhoodLibrary);

	NearbyLib getReturnReserveBookOne(NearbyLib nearbyLib);
}
