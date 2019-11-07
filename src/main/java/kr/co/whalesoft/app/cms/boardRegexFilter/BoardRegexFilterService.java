package kr.co.whalesoft.app.cms.boardRegexFilter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardRegexFilterService extends BaseService {
	
	@Autowired
	private BoardRegexFilterDao dao;

	public List<BoardRegexFilter> getBoardRegexFilter() {
		return dao.getBoardRegexFilter();
	}
	
	public BoardRegexFilter getBoardRegexFilterOne(BoardRegexFilter boardRegexFilter) {
		return dao.getBoardRegexFilterOne(boardRegexFilter);
	}
	
	public int addBoardRegexFilter(BoardRegexFilter boardRegexFilter) {
		return dao.addBoardRegexFilter(boardRegexFilter);
	}
	
	public int modifyBoardRegexFilter(BoardRegexFilter boardRegexFilter) {
		return dao.modifyBoardRegexFilter(boardRegexFilter);
	}
	
	public int deleteBoardRegexFilter(BoardRegexFilter boardRegexFilter) {
		return dao.deleteBoardRegexFilter(boardRegexFilter);
	}
}
