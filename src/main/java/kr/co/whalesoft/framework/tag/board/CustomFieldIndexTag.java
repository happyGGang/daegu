package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.tag.HtmlTag;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class CustomFieldIndexTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private int manage_idx;
	private int board_idx;
	private String board_column;
	private String board_value;
	private String column_type;
	private String content_link_yn = "N";
	private String code_mapping; 
	
	private final int manage_idx_type1[] = {19, 23, 28, 100, 366};
	private boolean check_type;

	@Override
	public int doEndTag() throws JspException {
		String return_str = board_value;
		
		HtmlTag tdTag = new HtmlTag("td");
		
		for(int i=0; i<manage_idx_type1.length; i++) {
			if(manage_idx == manage_idx_type1[i]) {
				check_type = true;	
			}
		}
		
		if(board_column.equals("user_name")) {
			if(check_type) {
				return_str = board_value.substring(0, 1) + "○○";
			}
		} else if(board_column.equals("view_count")) {
			NumberFormat nf = NumberFormat.getInstance();
			return_str = nf.format(Integer.parseInt(board_value));
			tdTag.setAttribute("class", "num");
		} else if(board_column.equals("add_date")) {
			SimpleDateFormat recvSimpleFormat = new SimpleDateFormat("E MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
			SimpleDateFormat tranSimpleFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
			Date data = null;
			try {
				data = recvSimpleFormat.parse(board_value);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			return_str = tranSimpleFormat.format(data);
			tdTag.setAttribute("class", "num");
		} else {
			if(column_type.equals("category") || column_type.equals("checkbox") || column_type.equals("radio")) {
				if(code_mapping != null && !code_mapping.equals("") && board_value != null && !board_value.equals("")) {
					CodeService codeService = (CodeService)BeanFinder.getBean(pageContext.getRequest(), CodeService.class);
					return_str = codeService.getCodeOne(new Code(code_mapping, board_value)).getCode_name();
				}
			}
		}
		
		if(content_link_yn.equals("Y")) {
			tdTag.setAttribute("class", "important left");
			tdTag.setContent("<a href=\"\" keyValue=\"" + board_idx + "\">" + return_str + "</a>");
		} else {
			tdTag.setContent(return_str);
		}
		
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

}