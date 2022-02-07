package kr.go.gbelib.app.cms.module.walkingThru.walkingThruPenalty;

import java.util.List;

public interface WalkingThruPenaltyDao {

	public int getWalkingThruPenaltyCount(WalkingThruPenalty penalty);
	
	public List<WalkingThruPenalty> getWalkingThruPenaltyList(WalkingThruPenalty penalty);
	
	public WalkingThruPenalty getWalkingThruPenaltyOne(WalkingThruPenalty penalty);
	
	public int addWalkingThruPenalty(WalkingThruPenalty penalty);
	
	public int modifyWalkingThruPenalty(WalkingThruPenalty penalty);

	public int deleteWalkingThruPenalty(WalkingThruPenalty penalty);
	
	public int duplicateCheck(WalkingThruPenalty penalty);

	public int getPenaltyCount(String homepage_id);

	public String getEndDate(String homepage_id);
	
}
