package kr.go.gbelib.app.module.boardHistory;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.boardComment.BoardComment;
import kr.co.whalesoft.framework.base.BaseService;
import kr.go.gbelib.app.cms.module.elib.comment.Comment;

@Service
public class BoardHistoryService extends BaseService {

	@Autowired
	private BoardHistoryDao dao;

	public int getBoardHistoryCount(BoardHistory boardHistory) {
		return dao.getBoardHistoryCount(boardHistory);
	}

	public List<Board> getBoardHistoryList(BoardHistory boardHistory) {
		return dao.getBoardHistoryList(boardHistory);
	}

	public int getReplyHistoryCount(BoardHistory boardHistory) {
		return dao.getReplyHistoryCount(boardHistory);
	}

	public List<BoardComment> getReplyHistoryList(BoardHistory boardHistory) {
		return dao.getReplyHistoryList(boardHistory);
	}
	
	public int getElibCommentHistoryCount(BoardHistory boardHistory) {
		return dao.getElibCommentHistoryCount(boardHistory);
	}

	public List<Comment> getElibCommentHistoryList(BoardHistory boardHistory) {
		return dao.getElibCommentHistoryList(boardHistory);
	}
}
