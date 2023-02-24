package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibPenalty;

import java.util.List;

public interface NearbyLibPenaltyDao {

	int getNearbyLibPenaltyCount(NearbyLibPenalty nearbyLibPenalty);
	
	List<NearbyLibPenalty> getNearbyLibPenaltyList(NearbyLibPenalty nearbyLibPenalty);

	NearbyLibPenalty getNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty);

	int addNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty);

	int modifyNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty);

	NearbyLibPenalty getNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty);

	int addNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty);

	int modifyNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty);

	int deleteNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty);

	int getPenaltyMemberCount(NearbyLibPenalty nearbyLibPenalty);

}
