package kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList;

import kr.co.whalesoft.framework.base.BaseService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UntactBookBlackListService extends BaseService {
	
	@Autowired
	private UntactBookBlackListDao dao;

	public int grantPenalty(UntactBookBlackList untactBookBlackList) {
		return dao.grantPenalty(untactBookBlackList);
	}

	public int penaltyCount(UntactBookBlackList untactBookBlackList) {
		return dao.penaltyCount(untactBookBlackList);
	}

	public int getUntactBookBlackListCount(UntactBookBlackList untactBookBlackList) {
		return dao.getUntactBookBlackListCount(untactBookBlackList);
	}

	public List<UntactBookBlackList> getUntactBookBlackListList(UntactBookBlackList untactBookBlackList) {
		return dao.getUntactBookBlackListList(untactBookBlackList);
	}

	public int deleteAllUntactBookBlackList(UntactBookBlackList untactBookBlackList) {
		return dao.deleteAllUntactBookBlackList(untactBookBlackList);
	}

	public int deleteUntactBookBlackList(UntactBookBlackList untactBookBlackList) {
		return dao.deleteUntactBookBlackList(untactBookBlackList);
	}

	public int getPenaltyCount(UntactBookBlackList untactBookBlackList) {
		return dao.getPenaltyCount(untactBookBlackList);
	}

	public List<UntactBookBlackList> getUntactBookBlackListExcelList(UntactBookBlackList untactBookBlackList) {
		return dao.getUntactBookBlackListExcelList(untactBookBlackList);
	}

}