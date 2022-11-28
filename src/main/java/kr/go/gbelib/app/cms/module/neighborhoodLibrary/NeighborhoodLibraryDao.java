package kr.go.gbelib.app.cms.module.neighborhoodLibrary;

import java.util.List;
import java.util.Map;

/**
 * @author SeongHyeon
 * 2022. 9. 27.
 *
 */
public interface NeighborhoodLibraryDao {

	List<NeighborhoodLibrary> getNeighborhoodLibraryList(NeighborhoodLibrary neigborhoodLibrary);

	int insertNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary);

	List<NeighborhoodLibrary> getNeighborhoodLibraryUseList(NeighborhoodLibrary neighborhoodLibrary);

	int addNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary);

	int getNeighborhoodLibraryBundleIdx(NeighborhoodLibrary neighborhoodLibrary);
	
	int getNeighborhoodLibraryCount(NeighborhoodLibrary neighborhoodLibrary);

	List<NeighborhoodLibrary> getNeighborhoodLibraryListAll(NeighborhoodLibrary neighborhoodLibrary);

	int updateNeighborhoodLibrary(NeighborhoodLibrary neighborhoodLibrary);

	NeighborhoodLibrary sameNeighborhoodLibraryForUser(NeighborhoodLibrary neighborhoodLibrary);
	
	NeighborhoodLibrary getSameNeighborhoodLibraryBundle_idx(NeighborhoodLibrary neighborhoodLibrary);

	int updateNeighborhoodLibrarySms(NeighborhoodLibrary neighborhoodLibrary);

	List<NeighborhoodLibrary> getSameNeighborhoodLibraryBundleList(NeighborhoodLibrary neighborhoodLibrary);

	NeighborhoodLibrary getNeighborhoodLibraryBookOne(NeighborhoodLibrary neighborhoodLibrary);

	int getSameNeighborhoodLibraryReserveCallIdx(NeighborhoodLibrary neighborhoodLibrary);

	int updateNeighborhoodLibraryPK(NeighborhoodLibrary neighborhoodLibrary);

	NeighborhoodLibrary getSameNeighborhoodLibraryPkData(NeighborhoodLibrary neighborhoodLibrary);

	NeighborhoodLibrary checkReserveLocker(NeighborhoodLibrary neighborhoodLibrary);
}
