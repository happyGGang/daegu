package kr.go.gbelib.app.cms.module.walkingThru.walkingThruCancelHistory;

import java.util.List;

public interface WalkingThruCancelHistoryDao {

	public int getWalkingThruCancelHistoryCount(WalkingThruCancelHistory walkingThruCancelHistory);

	public List<WalkingThruCancelHistory> getWalkingThruCancelHistoryList(WalkingThruCancelHistory walkingThruCancelHistory);

	public List<WalkingThruCancelHistory> getWalkingThruCancelHistoryExcelList(WalkingThruCancelHistory walkingThruCancelHistory);
}
