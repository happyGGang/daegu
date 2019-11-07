package kr.co.whalesoft.app.cms.boardAllSearch;

import java.util.List;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.boardFile.BoardFile;

public interface BoardAllSearchDao {

	public List<BoardAllSearch> getBoard(BoardAllSearch board);
	
	public int getBoardCount(BoardAllSearch board);
	
	public List<BoardFile> getBoardFile(int board_idx);
	
}