package kr.co.whalesoft.app.board.boardComment;

import java.util.List;

public interface BoardCommentDao {

	public List<BoardComment> getBoardComment(BoardComment boardComment);
	
	public int getBoardCommentCount(BoardComment boardComment);
	
	public int addBoardComment(BoardComment boardComment);
	
	public int modifyBoardComment(BoardComment boardComment);
	
	public int addBoardReplyComment(BoardComment boardComment);
	
	public int deleteBoardComment(BoardComment boardComment);

	public int getCommentIdx(BoardComment boardComment);

	public String getBoardCommentId(BoardComment boardComment);
	
}