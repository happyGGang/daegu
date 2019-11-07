package kr.co.whalesoft.app.cms.module.boardAccess;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardAccessService extends BaseService {

	@Autowired
	private BoardAccessDao dao;
	
	public List<BoardAccess> getBoardAccessCount(BoardAccess boardAccess) {
		return dao.getBoardAccessCount(boardAccess);
	}
	
	public int getBoardAccessTotalCount(BoardAccess boardAccess) {
		return dao.getBoardAccessTotalCount(boardAccess);
	}
	
}