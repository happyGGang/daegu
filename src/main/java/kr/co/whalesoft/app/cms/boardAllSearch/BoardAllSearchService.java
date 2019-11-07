package kr.co.whalesoft.app.cms.boardAllSearch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.framework.base.BaseService;

@Service
public class BoardAllSearchService extends BaseService {

	@Autowired
	private BoardAllSearchDao dao;
	
	public List<BoardAllSearch> getBoard(BoardAllSearch board) {
		List<BoardAllSearch> boardList = dao.getBoard(board);
		
		for(BoardAllSearch board1: boardList) {
			board1.setBoardFileList(getBoardFile(board1.getBoard_idx()));
		}
		
		return boardList;
	}
	
	public int getBoardCount(BoardAllSearch board) {
		return dao.getBoardCount(board);
	}
	
	public List<BoardFile> getBoardFile(int board_idx) {
		return dao.getBoardFile(board_idx);
	}
	
}