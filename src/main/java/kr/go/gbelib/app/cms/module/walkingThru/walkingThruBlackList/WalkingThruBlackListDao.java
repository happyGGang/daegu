package kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList;

import java.util.List;

public interface WalkingThruBlackListDao {

	public int grantPenalty(WalkingThruBlackList walkingThruBlackList);

	public int penaltyCount(WalkingThruBlackList walkingThruBlackList);

	public int getWalkingThruBlackListCount(WalkingThruBlackList walkingThruBlackList);

	public List<WalkingThruBlackList> getWalkingThruBlackListList(WalkingThruBlackList walkingThruBlackList);

	public int deleteAllWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList);

	public int deleteWalkingThruBlackList(WalkingThruBlackList walkingThruBlackList);

	public int getPenaltyCount(WalkingThruBlackList walkingThruBlackList);

	public List<WalkingThruBlackList> getWalkingThruBlackListExcelList(WalkingThruBlackList walkingThruBlackList);


}
