package kr.co.whalesoft.framework.tag.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class BoardListByDepTag extends RequestContextAwareTag {

	private static final long serialVersionUID = 1L;
	
	private String attibuteName;
	private int manage_idx;
	private int count;
	private String dept_cd;
	
	@Override
	public int doStartTagInternal() throws JspException {
		BoardService boardService = (BoardService)BeanFinder.getBean(pageContext.getRequest(), BoardService.class);
		BoardManageService boardManageService = (BoardManageService)BeanFinder.getBean(pageContext.getRequest(), BoardManageService.class);
		
		BoardManage boardManage = boardManageService.getBoardManageOne(new BoardManage(null, manage_idx));
		
		List<Board> result = null;
		if (boardManage.getBoard_type().equals("CUSTOM_QNA")) {
			result = boardService.getQnaBoardByDepMain(manage_idx, count, dept_cd);
		} else {
			result = boardService.getBoardByDepMain(manage_idx, count, dept_cd);
		}
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute(attibuteName, result);
		
		return SKIP_BODY;
	}

	public String getAttibuteName() {
		return attibuteName;
	}

	public void setAttibuteName(String attibuteName) {
		this.attibuteName = attibuteName;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	
}