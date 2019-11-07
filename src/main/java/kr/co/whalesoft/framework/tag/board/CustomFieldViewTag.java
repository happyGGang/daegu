package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class CustomFieldViewTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private int manage_idx;
	private String board_content;
	private String board_value;
	private String column_type;
	private String code_mapping; 
	
	private boolean check_type;

	@Override
	public int doEndTag() throws JspException {
		String return_str = board_value;
		
		if(column_type.equals("category") || column_type.equals("checkbox") || column_type.equals("radio")) {
			if(code_mapping != null && !code_mapping.equals("") && board_value != null && !board_value.equals("")) {
				CodeService codeService = (CodeService)BeanFinder.getBean(pageContext.getRequest(), CodeService.class);
				return_str = codeService.getCodeOne(new Code(code_mapping, board_value)).getCode_name();
			}
		}
		
		return_str = "<i>" + board_content + "</i><span>" + return_str + "</span>";
		
		try {
			pageContext.getOut().println(return_str);
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

	public String getCode_mapping() {
		return code_mapping;
	}

	public void setCode_mapping(String code_mapping) {
		this.code_mapping = code_mapping;
	}

	public String getColumn_type() {
		return column_type;
	}

	public void setColumn_type(String column_type) {
		this.column_type = column_type;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

}