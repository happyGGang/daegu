package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.framework.tag.HtmlTag;

public class CustomBidFieldIndexTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private String board_value;
	

	@Override
	public int doEndTag() throws JspException {
		String return_str = board_value;
		
		HtmlTag tdTag = new HtmlTag("td");
		
		String[] arr = board_value.split(",");
		if(arr != null && arr.length > 4) {
			return_str = arr[0]+"년"+arr[1]+"월"+arr[2]+"일  "+arr[3]+"시"+arr[4]+"분";
		}
		
		tdTag.setContent(return_str);
		
		try {
			pageContext.getOut().println(tdTag.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	public String getBoard_value() {
		return board_value;
	}

	public void setBoard_value(String board_value) {
		this.board_value = board_value;
	}

}