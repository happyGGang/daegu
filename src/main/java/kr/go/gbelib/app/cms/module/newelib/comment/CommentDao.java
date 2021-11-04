package kr.go.gbelib.app.cms.module.newelib.comment;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.go.gbelib.app.cms.module.newelib.book.Book;

@Mapper(value = "commentDaoNew")
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
