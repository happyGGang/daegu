package kr.co.whalesoft.framework.tag.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class BoardListTag extends RequestContextAwareTag {

	private static final long serialVersionUID = 1L;
	
	private String attibuteName;
	private int manage_idx;
	private int count;
	
	@Override
	public int doStartTagInternal() throws JspException {
		BoardService boardService = (BoardService)BeanFinder.getBean(pageContext.getRequest(), BoardService.class);
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute(attibuteName, boardService.getBoardByMain(manage_idx, count));
		
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
}