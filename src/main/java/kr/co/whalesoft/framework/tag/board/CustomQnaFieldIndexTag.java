package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.framework.tag.HtmlTag;

public class CustomQnaFieldIndexTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private int manage_idx;
	private int board_idx;
	private String board_column;
	private String board_value;
	private String content_link_yn = "N";
	
	private boolean check_type;

	@Override
	public int doEndTag() throws JspException {
		String return_str = board_value;
		
		HtmlTag tdTag = new HtmlTag("td");
		
		if(board_value.equals("10")) {
			return_str = "대기";
			tdTag.setAttribute("class", "process wait");
			return_str = "대기";
		} else if(board_value.equals("20")) {
			return_str = "접수";
			tdTag.setAttribute("class", "process accept");
		} else if(board_value.equals("30")) {
			return_str = "완료";
			tdTag.setAttribute("class", "process finish");
		}
		
		tdTag.setContent("<i class=\"fa\"></i><span>" + return_str + "</span>");
		
		try {
			pageContext.getOut().println(tdTag.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public String getBoard_column() {
		return board_column;
	}

	public void setBoard_column(String board_column) {
		this.board_column = board_column;
	}

	public String getContent_link_yn() {
		return content_link_yn;
	}

	public void setContent_link_yn(String content_link_yn) {
		this.content_link_yn = content_link_yn;
	}

	public String getBoard_value() {
		return board_value;
	}

	public void setBoard_value(String board_value) {
		this.board_value = board_value;
	}

	public boolean isCheck_type() {
		return check_type;
	}

	public void setCheck_type(boolean check_type) {
		this.check_type = check_type;
	}

	public int getBoard_idx() {
		return board_idx;
	}

	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}

}