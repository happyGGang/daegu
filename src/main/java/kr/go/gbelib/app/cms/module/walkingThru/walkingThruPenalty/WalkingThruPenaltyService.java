package kr.go.gbelib.app.cms.module.walkingThru.walkingThruPenalty;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class WalkingThruPenaltyService extends BaseService {

	@Autowired
	WalkingThruPenaltyDao dao;
	
	public int getWalkingThruPenaltyCount(WalkingThruPenalty penalty) {
		return dao.getWalkingThruPenaltyCount(penalty);
	}
	
	public List<WalkingThruPenalty> getWalkingThruPenaltyList(WalkingThruPenalty penalty){
		return dao.getWalkingThruPenaltyList(penalty);
	}
	
	public WalkingThruPenalty getWalkingThruPenaltyOne(WalkingThruPenalty penalty) {
		return dao.getWalkingThruPenaltyOne(penalty);
	}
	
	public int addWalkingThruPenalty(WalkingThruPenalty penalty) {
		return dao.addWalkingThruPenalty(penalty);
	}

	public int modifyWalkingThruPenalty(WalkingThruPenalty penalty) {
		return dao.modifyWalkingThruPenalty(penalty);
	}
	
	public int deleteWalkingThruPenalty(WalkingThruPenalty penalty) {
		return dao.deleteWalkingThruPenalty(penalty);
	}
	
	public int duplicateCheck(WalkingThruPenalty penalty) {
		return dao.duplicateCheck(penalty);
	}
	
	public int getPenaltyCount(String homepage_id) {
		return dao.getPenaltyCount(homepage_id);
	}

	public String getEndDate(String homepage_id) {
		return dao.getEndDate(homepage_id);
	}
}
