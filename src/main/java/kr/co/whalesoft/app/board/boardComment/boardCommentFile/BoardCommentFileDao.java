package kr.co.whalesoft.app.board.boardComment.boardCommentFile;

import java.util.List;

public interface BoardCommentFileDao {

	public BoardCommentFile getBoardCommentFileOne(BoardCommentFile boardCommentFile);

	public int addBoardCommentFileCount(BoardCommentFile boardCommentFile);

	public List<BoardCommentFile> getBoardCommentFile(int comment_idx);

	public int addBoardCommentFile(BoardCommentFile boardCommentFile);

}
