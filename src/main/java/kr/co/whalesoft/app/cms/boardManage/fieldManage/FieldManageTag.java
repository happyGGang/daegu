package kr.co.whalesoft.app.cms.boardManage.fieldManage;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class FieldManageTag extends BodyTagSupport {
	
	private static final long serialVersionUID = 1L;
	
	private String field;
	private String field_type;
	private String field_str;
	private int manage_idx;
	
	private final int board_type1_array[] = {1, 19, 23, 28, 100, 366};

	@Override
	public int doEndTag() throws JspException {
		String return_str = field_str;
		
		if(field.equals("add_date")) {
			
		} else if(field.equals("user_name")) {
			for(int board_type1 : board_type1_array) {
				if(manage_idx == board_type1) {
					return_str = field_str.substring(0, 1) + "○○";
					break;
				}
			}
		}

		try {
			pageContext.getOut().println(return_str);
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return EVAL_PAGE;
	}

	public String getField_type() {
		return field_type;
	}

	public void setField_type(String field_type) {
		this.field_type = field_type;
	}

	public String getField_str() {
		return field_str;
	}

	public void setField_str(String field_str) {
		this.field_str = field_str;
	}

	public int getManage_idx() {
		return manage_idx;
	}

	public void setManage_idx(int manage_idx) {
		this.manage_idx = manage_idx;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}
}
