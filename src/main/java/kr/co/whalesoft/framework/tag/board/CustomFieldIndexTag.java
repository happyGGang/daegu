package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.tag.HtmlTag;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class CustomFieldIndexTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private int manage_idx;
	private int board_idx;
	private int parent_idx;
	private String board_column;
	private String board_value;
	private String column_type;
	private String content_link_yn = "N";
	private String code_mapping;

	private int comment_count;

	private final int manage_idx_type1[] = {19, 23, 28, 100, 366};
	private boolean check_type;

	@Override
	public int doEndTag() throws JspException {
		String return_str = board_value;

		HtmlTag tdTag = new HtmlTag("td");

		for (int i = 0; i < manage_idx_type1.length; i++) {
			if (manage_idx == manage_idx_type1[i]) {
				check_type = true;
			}
		}

		if (board_column.equals("user_name")) {
			if (check_type) {
				return_str = board_value.substring(0, 1) + "○○";
			}
		} else if (board_column.equals("view_count")) {
			NumberFormat nf = NumberFormat.getInstance();
			return_str = nf.format(Integer.parseInt(board_value));
			tdTag.setAttribute("class", "num");
		} else if (board_column.equals("add_date")) {
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
			if (column_type.equals("cate") || column_type.equals("chec") || column_type.equals("radi")) {
				if (code_mapping != null && !code_mapping.equals("") && board_value != null && !board_value.equals("")) {
					CodeService codeService = (CodeService) BeanFinder.getBean(pageContext.getRequest(), CodeService.class);
					HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
					Homepage homepage = (Homepage) request.getAttribute("homepage");
					Code c = new Code();
					c.setHomepage_id(homepage.getHomepage_id());
					c.setGroup_id(code_mapping);
					c.setCode_id(board_value);
					try {
						return_str = codeService.getCodeOne(c).getCode_name();
					} catch (Exception e) {
						System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" );
						System.out.println("@@@@@@@@@@@@@@@@ custom board code mapping error" );
						System.out.println("@@@@@@@@@@@@@@@@ manage_idx : " + manage_idx);
						System.out.println("@@@@@@@@@@@@@@@@ board_idx : " + board_idx);
						System.out.println("@@@@@@@@@@@@@@@@ code_mapping : " + code_mapping);
						System.out.println("@@@@@@@@@@@@@@@@ board_value : " + board_value);
						System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" );
					}
				}
			}
		}

		if (content_link_yn.equals("Y")) {
			tdTag.setAttribute("class", "important left");
			String url = String.format("view.do?manage_idx=%d&board_idx=%d", manage_idx, board_idx);
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
			String menu_idx = request.getParameter("menu_idx");
			if (StringUtils.isNotBlank(menu_idx)) {
				url += String.format("&menu_idx=%s", menu_idx);
			}

			if (board_column.equals("title") && comment_count > 0) {
				return_str += ("<span class=\"comment\"><em>댓글</em> <i>"+comment_count+"</i></span>");
			}

			if (board_column.equals("title") && parent_idx > 0) {
				return_str = "<i class=\"fa fa-reply\"></i>" + return_str;
			}
			tdTag.setContent(String.format("<a href=\"%s\">%s</a>", url, return_str));
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


	public int getComment_count() {
		return comment_count;
	}


	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}


	public int getParent_idx() {
		return parent_idx;
	}


	public void setParent_idx(int parent_idx) {
		this.parent_idx = parent_idx;
	}



}
