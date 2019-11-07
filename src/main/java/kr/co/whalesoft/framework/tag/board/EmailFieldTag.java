package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.framework.tag.HtmlTag;

public class EmailFieldTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String value;

	@Override
	public int doEndTag() throws JspException {
		String email1 = "";
		String email2 = "";
		String email_array[] = null;
		
		HtmlTag email_tag = new HtmlTag("input");
		HtmlTag email1_tag = new HtmlTag("input");
		HtmlTag email2_tag = new HtmlTag("input");
		
		email_array = value.split("-");

		if(email_array.length > 2) {
			email1 = email_array[0];
			email2 = email_array[1];
		}
		
		email_tag.setAttribute("type", "hidden");
		email_tag.setAttribute("id", name);
		email_tag.setAttribute("name", name);
		email_tag.setAttribute("value", value);
		
		email1_tag.setAttribute("type", "text");
		email1_tag.setAttribute("id", name+"_1");
		email1_tag.setAttribute("value", email1);
		email1_tag.setAttribute("size", "10");
		email1_tag.setAttribute("maxlength", "20");
		email1_tag.setAttribute("class", "text custom_email1");
		email1_tag.setAttribute("targetFieldId", name);
		
		email2_tag.setAttribute("type", "text");
		email2_tag.setAttribute("id", name+"_2");
		email2_tag.setAttribute("value", email2);
		email2_tag.setAttribute("size", "10");
		email2_tag.setAttribute("maxlength", "20");
		email2_tag.setAttribute("class", "text custom_email2");
		email2_tag.setAttribute("targetFieldId", name);
		
		try {
			pageContext.getOut().println(email_tag.toString());
			pageContext.getOut().println(email1_tag.toString() + " @ " + email2_tag.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}