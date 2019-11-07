package kr.co.whalesoft.app.cms.module.boardAccess;

import java.util.List;

public interface BoardAccessDao {

	public List<BoardAccess> getBoardAccessCount(BoardAccess boardAccess);
	
	public int getBoardAccessTotalCount(BoardAccess boardAccess);
}