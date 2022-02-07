package kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class WalkingThruBlackListService extends BaseService {

	@Autowired
	WalkingThruBlackListDao dao;
	
	public int grantPenalty(WalkingThruBlackList walkingThruBlackList) {
		return dao.grantPenalty(walkingThruBlackList);
	}

	public int penaltyCount(WalkingThruBlackList walkingThruBlackList) {
		return dao.penaltyCount(walkingThruBlackList);
	}

	public int getWalkingThruBlackListCount(WalkingThruBlackList walkingThruBlackList) {
		return dao.getWalkingThruBlackListCount(walkingThruBlackList);
	}

	public List<WalkingThruBlackList> getWalkingThruBlackListList(WalkingThruBlackList walkingThruBlackList) {
		return dao.getWalkingThruBlackListList(walkingThruBlackList);
	}

	public int deleteAllWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList) {
		return dao.deleteAllWalkingThruBlackList(walkingThruBlackList);
	}

	public int deleteWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList) {
		return dao.deleteWalkingThruBlackList(walkingThruBlackList);
	}

	public int getPenaltyCount(WalkingThruBlackList walkingThruBlackList) {
		return dao.getPenaltyCount(walkingThruBlackList);
	}

	public List<WalkingThruBlackList> getWalkingThruBlackListExcelList(WalkingThruBlackList walkingThruBlackList) {
		return dao.getWalkingThruBlackListExcelList(walkingThruBlackList);
	}
}
