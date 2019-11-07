package kr.co.whalesoft.app.cms.boardWordFilter;

public interface BoardWordFilterDao {

	public int deleteBoardWordFilter();
	
	public int addBoardWordFilter(BoardWordFilter boardWordFilter);
	
	public BoardWordFilter getBoardWordFilterOne();
	
}