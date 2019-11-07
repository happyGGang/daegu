package kr.co.whalesoft.app.cms.boardRegexFilter;

import java.util.List;

public interface BoardRegexFilterDao {

	public List<BoardRegexFilter> getBoardRegexFilter();
	
	public BoardRegexFilter getBoardRegexFilterOne(BoardRegexFilter boardRegexFilter);
	
	public int addBoardRegexFilter(BoardRegexFilter boardRegexFilter);
	
	public int modifyBoardRegexFilter(BoardRegexFilter boardRegexFilter);
	
	public int deleteBoardRegexFilter(BoardRegexFilter boardRegexFilter);
	
}