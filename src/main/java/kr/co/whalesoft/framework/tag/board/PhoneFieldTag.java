package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.framework.tag.HtmlTag;

public class PhoneFieldTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private String name;
	private String value;

	@Override
	public int doEndTag() throws JspException {
		String phone1 = "";
		String phone2 = "";
		String phone3 = "";
		String phone_array[] = null;
		
		HtmlTag phone_tag = new HtmlTag("input");
		HtmlTag phone1_tag = new HtmlTag("input");
		HtmlTag phone2_tag = new HtmlTag("input");
		HtmlTag phone3_tag = new HtmlTag("input");
		
		phone_array = value.split("-");

		if(phone_array.length > 2) {
			phone1 = phone_array[0];
			phone2 = phone_array[1];
			phone3 = phone_array[2];
		}
		
		phone_tag.setAttribute("type", "hidden");
		phone_tag.setAttribute("id", name);
		phone_tag.setAttribute("name", name);
		phone_tag.setAttribute("value", value);
		
		phone1_tag.setAttribute("type", "text");
		phone1_tag.setAttribute("id", name+"_1");
		phone1_tag.setAttribute("value", phone1);
		phone1_tag.setAttribute("size", "4");
		phone1_tag.setAttribute("maxlength", "4");
		phone1_tag.setAttribute("class", "text custom_phone1");
		phone1_tag.setAttribute("targetFieldId", name);
		
		phone2_tag.setAttribute("type", "text");
		phone2_tag.setAttribute("id", name+"_2");
		phone2_tag.setAttribute("value", phone2);
		phone2_tag.setAttribute("size", "4");
		phone2_tag.setAttribute("maxlength", "4");
		phone2_tag.setAttribute("class", "text custom_phone2");
		phone2_tag.setAttribute("targetFieldId", name);
		
		phone3_tag.setAttribute("type", "text");
		phone3_tag.setAttribute("id", name+"_3");
		phone3_tag.setAttribute("value", phone3);
		phone3_tag.setAttribute("size", "4");
		phone3_tag.setAttribute("maxlength", "4");
		phone3_tag.setAttribute("class", "text custom_phone3");
		phone3_tag.setAttribute("targetFieldId", name);
		
		try {
			pageContext.getOut().println(phone_tag);
			pageContext.getOut().println(phone1_tag.toString() + " - " + phone2_tag.toString() + " - " + phone3_tag.toString());
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