package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibRaffle;

import java.util.List;

public interface NearbyLibRaffleDao {

	public int getNearbyLibRaffleCount(NearbyLibRaffle nearbyLibRaffle);

	public List<NearbyLibRaffle> getNearbyLibRaffleList(NearbyLibRaffle nearbyLibRaffle);
	
	public int getToShuffleNearbyLibRaffleCount(NearbyLibRaffle nearbyLibRaffle);

	public List<NearbyLibRaffle> getToShuffleNearbyLibRaffleList(NearbyLibRaffle nearbyLibRaffle);

	public void saveWinnerList(NearbyLibRaffle nearbyLibRaffle);

	public int getRaffleIdx();

	public void saveRaffleSetting(NearbyLibRaffle nearbyLibRaffle);

	public List<NearbyLibRaffle> getWinnerNearbyLibRaffle(NearbyLibRaffle nearbyLibRaffle);

	public int deleteRaffleSetting(NearbyLibRaffle nearbyLibRaffle);

	public int deleteRaffle(NearbyLibRaffle nearbyLibRaffle);

	public List<NearbyLibRaffle> getNearbyLibRaffleExcelList(NearbyLibRaffle nearbyLibRaffle);

}
