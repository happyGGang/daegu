package kr.go.gbelib.app.cms.module.elib.comment;

import java.util.List;

import kr.go.gbelib.app.cms.module.elib.book.Book;

public interface CommentDao {
	
	public int getCommentListCnt(Comment comment);
	
	public int getCommentListCmsCnt(Comment comment);
	
	public Comment getComment(Comment comment);
	
	public List<Comment> getCommentList(Comment comment);
	
	public List<Comment> getCommentListCms(Comment comment);
	
	public List<Comment> getCommentListAll(Comment comment);
	
	public int addComment(Comment comment);

	public int modifyComment(Comment comment);
	
	public int deleteComment(Comment comment);
	
	public int deleteCommentCms(Comment comment);
	
	public int deleteCommentsByBook(Comment comment);
	
}
