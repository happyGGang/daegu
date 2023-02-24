package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibPenalty;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class NearbyLibPenaltyService extends BaseService{
	
	@Autowired
	private NearbyLibPenaltyDao dao;

	public int getNearbyLibPenaltyCount(NearbyLibPenalty nearbyLibPenalty) {
		return dao.getNearbyLibPenaltyCount(nearbyLibPenalty);
	}
	
	public List<NearbyLibPenalty> getNearbyLibPenaltyList(NearbyLibPenalty nearbyLibPenalty) {
		return dao.getNearbyLibPenaltyList(nearbyLibPenalty);
	}

	public NearbyLibPenalty getNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty) {
		return dao.getNearbyLibPenaltySetting(nearbyLibPenalty);
	}

	public int addNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty) {
		return dao.addNearbyLibPenaltySetting(nearbyLibPenalty);
	}

	public int modifyNearbyLibPenaltySetting(NearbyLibPenalty nearbyLibPenalty) {
		return dao.modifyNearbyLibPenaltySetting(nearbyLibPenalty);
	}

	public NearbyLibPenalty getNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty) {
		return dao.getNearbyLibPenaltyMember(nearbyLibPenalty);
	}

	public int addNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty) {
		return dao.addNearbyLibPenaltyMember(nearbyLibPenalty);
	}

	public int modifyNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty) {
		return dao.modifyNearbyLibPenaltyMember(nearbyLibPenalty);
	}

	public int deleteNearbyLibPenaltyMember(NearbyLibPenalty nearbyLibPenalty) {
		return dao.deleteNearbyLibPenaltyMember(nearbyLibPenalty);
	}

	public int getPenaltyMemberCount(NearbyLibPenalty nearbyLibPenalty) {
		return dao.getPenaltyMemberCount(nearbyLibPenalty);
	}
}
