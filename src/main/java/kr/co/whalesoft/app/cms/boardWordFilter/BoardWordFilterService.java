package kr.co.whalesoft.app.cms.boardWordFilter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardWordFilterService extends BaseService {
	
	@Autowired
	private BoardWordFilterDao dao;

	@Transactional
	public int addBoardWordFilter(BoardWordFilter boardWordFilter) {
		dao.deleteBoardWordFilter();
		return dao.addBoardWordFilter(boardWordFilter);
	}
	
	public BoardWordFilter getBoardWordFilterOne() {
		return dao.getBoardWordFilterOne();
	}
	
}