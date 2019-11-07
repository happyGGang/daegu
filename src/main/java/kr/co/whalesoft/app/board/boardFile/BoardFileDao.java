package kr.co.whalesoft.app.board.boardFile;

import java.util.List;

public interface BoardFileDao {

	public List<BoardFile> getBoardFile(int board_idx);

	public BoardFile getBoardFileOne(BoardFile boardFile);
	
	public int addBoardFile(BoardFile boardFile);
	
	public int addBoardFileCount(int file_idx);
	
	public int deleteBoardFile(int board_idx);

	public int addBoardFileCount(BoardFile boardFile);

}