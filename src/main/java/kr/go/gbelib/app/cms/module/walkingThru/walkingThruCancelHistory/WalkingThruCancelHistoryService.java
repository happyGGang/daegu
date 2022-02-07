package kr.go.gbelib.app.cms.module.walkingThru.walkingThruCancelHistory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class WalkingThruCancelHistoryService extends BaseService {

	@Autowired private WalkingThruCancelHistoryDao dao;
	
	public int getWalkingThruCancelHistoryCount(WalkingThruCancelHistory walkingThruCancelHistory) {
		return dao.getWalkingThruCancelHistoryCount(walkingThruCancelHistory);
	}

	public List<WalkingThruCancelHistory> getWalkingThruCancelHistoryList(WalkingThruCancelHistory walkingThruCancelHistory) {
		return dao.getWalkingThruCancelHistoryList(walkingThruCancelHistory);
	}

	public List<WalkingThruCancelHistory> getWalkingThruCancelHistoryExcelList(WalkingThruCancelHistory walkingThruCancelHistory) {
		return dao.getWalkingThruCancelHistoryExcelList(walkingThruCancelHistory);
	}
	
}
