package kr.go.gbelib.app.cms.module.newelib.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.framework.base.BaseService;

@Service(value = "commentServiceNew")
public class CommentService extends BaseService {

	@Autowired
	private CommentDao dao;
	
	public int getCommentListCnt(Comment comment) {
		return dao.getCommentListCnt(comment);
	}
	
	public int getCommentListCmsCnt(Comment comment) {
		return dao.getCommentListCmsCnt(comment);
	}
	
	public Comment getComment(Comment comment) {
		return dao.getComment(comment);
	}
	
	public List<Comment> getCommentList(Comment comment) {
		return dao.getCommentList(comment);
	}
	
	public List<Comment> getCommentListCms(Comment comment) {
		return dao.getCommentListCms(comment);
	}
	
	public List<Comment> getCommentListAll(Comment comment) {
		return dao.getCommentListAll(comment);
	}
	
	public int addComment(Comment comment) {
		return dao.addComment(comment);
	}

	public int modifyComment(Comment comment) {
		return dao.modifyComment(comment);
	}
	
	public int deleteComment(Comment comment) {
		return dao.deleteComment(comment);
	}
	
	public int deleteCommentCms(Comment comment) {
		return dao.deleteCommentCms(comment);
	}
	
	public int deleteCommentsByBook(Comment comment) {
		return dao.deleteCommentsByBook(comment);
	}
	
}
