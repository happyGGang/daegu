package kr.go.gbelib.app.module.accessHistory;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class AccessHistoryService extends BaseService {

	@Autowired
	private AccessHistoryDao dao;

	public int getAccessHistoryCount(AccessHistory accessHistory) {
		return dao.getAccessHistoryCount(accessHistory);
	}

	public List<AccessHistory> getAccessHistoryList(AccessHistory accessHistory) {
		return dao.getAccessHistoryList(accessHistory);
	}

}
