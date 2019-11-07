package kr.go.gbelib.app.module.boardHistory;

import java.util.List;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.boardComment.BoardComment;
import kr.go.gbelib.app.cms.module.elib.comment.Comment;

public interface BoardHistoryDao {

	public int getBoardHistoryCount(BoardHistory boardHistory);

	public List<Board> getBoardHistoryList(BoardHistory boardHistory);

	public int getReplyHistoryCount(BoardHistory boardHistory);

	public List<BoardComment> getReplyHistoryList(BoardHistory boardHistory);

	public int getElibCommentHistoryCount(BoardHistory boardHistory);
	
	public List<Comment> getElibCommentHistoryList(BoardHistory boardHistory);
	
}
