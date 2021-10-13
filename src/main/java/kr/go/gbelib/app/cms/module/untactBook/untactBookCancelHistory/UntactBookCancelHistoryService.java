package kr.go.gbelib.app.cms.module.untactBook.untactBookCancelHistory;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class UntactBookCancelHistoryService extends BaseService {

	@Autowired private UntactBookCancelHistoryDao dao;
	
	public int getUntactBookCancelHistoryCount(UntactBookCancelHistory untactBookCancelHistory) {
		return dao.getUntactBookCancelHistoryCount(untactBookCancelHistory);
	}

	public List<UntactBookCancelHistory> getUntactBookCancelHistoryList(UntactBookCancelHistory untactBookCancelHistory) {
		return dao.getUntactBookCancelHistoryList(untactBookCancelHistory);
	}

	public List<UntactBookCancelHistory> getUntactBookCancelHistoryExcelList(UntactBookCancelHistory untactBookCancelHistory) {
		return dao.getUntactBookCancelHistoryExcelList(untactBookCancelHistory);
	}
	
}
