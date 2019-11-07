package kr.co.whalesoft.app.board;

import java.util.List;
import java.util.Map;

import kr.co.whalesoft.app.board.boardFile.BoardFile;
import kr.co.whalesoft.app.cms.module.boardAccess.BoardAccess;
import kr.co.whalesoft.app.cms.module.boardFileAccess.BoardFileAccess;
import kr.co.whalesoft.app.cms.module.calendarStatus.CalendarStatus;
import kr.co.whalesoft.framework.utils.PagingUtils;

public interface BoardDao {

	public List<Board> getBoard(Board board);
	
	public List<Board> getDeleteBoard(Board board);
	
	public List<Board> getQnABoard(Board board);
		
	public List<Board> selectBoardToMainOrderBy(Board board);
	
	public List<Board> getCustomBoard(Board board);
	
	public List<Board> getCustomQnaBoard(Board board);
	
	public List<Board> getBoardByMain(Board board);
	
	public List<Board> getBoardByMainAll(Board board);
	
	public List<Board> getBoardByDepMain(Board board);
	
	public List<Board> getQnaBoardByDepMain(Board board);
	
	public List<Board> getAllHomepageBoardListByMain(PagingUtils pagingUtils);
	
	public int getBoardCount(Board board);
	
	public int getDeleteBoardCount(Board board);
	
	public int getQnABoardCount(Board board);
	
	public int getBOOKBoardCount(Board board);
	
	public int getReplyCount(Board board);
	
	public List<Board> getBoardNotice(Board board);

	public List<Board> getBoardNotice2(Board board);

	public List<Board> getBoardNews2(Board board);
	
	public int addViewCount(Board board);
	
	public Board getBoardOne(Board board);
	
	public Board getMoviewBoardOne(Board board);
	
	public Board getBoardTitle(Board board);
	
//	public List<Board> getQnaBoard(Board board);
	
	public Board getPrevBoardOne(Board board);
	
	public Board getNextBoardOne(Board board);
	
	public int getBoardIdx(Board board);
	
	public int addBoard(Board board);
	
	public int modifyBoard(Board board);
	
	public int deleteBoard(Board board);
	
	public int modifyQnaBoard(Board board);
	
	public int modifyPreviewImg(Board board);
	
	public int modifyBoardFileCount(Board board);
	
	public int addParentBoardUpdate(Board board);
	
	public int recoveryBoard(Board board);
	
	public int moveBoard(Board board);
	
	public List<Board> getMyCivilList(Board board);
	
	/********************* ******/
	public List<Board> selectArchBoard();
	
	public int updatePreviewImg(int board_idx, String preview_img);
	
	public int updatePreviewImg(Board board);
	
	public int modifyApprovalCount(int board_idx);
	
	public int modifyContraryCount(int board_idx);

	public List<Board> getBoardMovie(Board board);//calander

	public int checkPassword(Board board);

	public List<Board> getBOOKBoard(Board board);

	public List<Board> getMovieBoard(Board board);
	
	public List<Board> getLostCardBoard(Board board);
	
	public List<CalendarStatus> getBoardStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getBoardMonthStatus(CalendarStatus calendarStatus);
	
	public List<CalendarStatus> getBoardYearStatus(CalendarStatus calendarStatus);
	
	public List<BoardFileAccess> getBoardFileAccess(BoardFileAccess boardFileAccess);

	public List<Board> getQnABoardOne(Board boardData);

	public List<Board> getBoardApi(Board board);

	public int dropBoard(Board board);

	public List<BoardAccess> getBoardAccessResult(BoardAccess boardAccess);

	public List<Board> getTotalSearchByType(Board board);

	public int getTotalSearchByTypeCount(Board board);

	public int moveBoardCategory(Board board);

	public List<Map<String, String>> getRequestBoardStateCount(Board board);

	public List<Board> getBoardRelayExcel(Board board);
	
	public int addFileDownloadCount(BoardFile boardFile);
	
	/*************/
	
	public int modifyLostCardBoard(Board board);
	
	public int checkLostCardBoard(Board board);
}