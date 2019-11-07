package kr.go.gbelib.app.module.accessHistory;

import java.util.List;

public interface AccessHistoryDao {

	public int getAccessHistoryCount(AccessHistory accessHistory);

	public List<AccessHistory> getAccessHistoryList(AccessHistory accessHistory);


}
