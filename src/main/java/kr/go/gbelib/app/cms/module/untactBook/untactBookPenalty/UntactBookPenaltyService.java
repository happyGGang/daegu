package kr.go.gbelib.app.cms.module.untactBook.untactBookPenalty;

import kr.co.whalesoft.framework.base.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UntactBookPenaltyService extends BaseService {
	
	@Autowired
	private UntactBookPenaltyDao dao;

	public int mergePenaltySetting(UntactBookPenalty untactBookPenalty) {
		return dao.mergePenaltySetting(untactBookPenalty);
	}

	public int penaltyCount(String homepage_id) {
		return dao.penaltyCount(homepage_id);
	}

}