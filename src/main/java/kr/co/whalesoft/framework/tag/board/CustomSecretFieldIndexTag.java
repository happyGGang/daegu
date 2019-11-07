package kr.co.whalesoft.framework.tag.board;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.login.LoginService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.tag.HtmlTag;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class CustomSecretFieldIndexTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private String board_value;

	@Override
	public int doEndTag() throws JspException {
		LoginService loginService = (LoginService)BeanFinder.getBean(pageContext.getRequest(), LoginService.class);
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Member member = (Member)loginService.getSessionMember(request);
		
		String return_str = board_value;
		
//		if(!member.isSuperAdmin()) {
//			return_str = "게시물이 등록되었습니다.";
//		}
		
		HtmlTag tdTag = new HtmlTag("td");
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