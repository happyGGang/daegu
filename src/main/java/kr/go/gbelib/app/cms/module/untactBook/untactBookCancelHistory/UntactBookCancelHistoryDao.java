package kr.go.gbelib.app.cms.module.untactBook.untactBookCancelHistory;

import java.util.List;

public interface UntactBookCancelHistoryDao {

	public int getUntactBookCancelHistoryCount(UntactBookCancelHistory untactBookCancelHistory);

	public List<UntactBookCancelHistory> getUntactBookCancelHistoryList(UntactBookCancelHistory untactBookCancelHistory);

	public List<UntactBookCancelHistory> getUntactBookCancelHistoryExcelList(UntactBookCancelHistory untactBookCancelHistory);

}
