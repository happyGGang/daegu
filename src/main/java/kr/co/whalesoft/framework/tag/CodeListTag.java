package kr.co.whalesoft.framework.tag;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.utils.BeanFinder;

public class CodeListTag extends RequestContextAwareTag {

	private static final long serialVersionUID = 1L;

	private String attibuteName;
	private String group_id;

	@Override
	public int doStartTagInternal() throws JspException {
		CodeService codeService = (CodeService) BeanFinder.getBean(pageContext.getRequest(), CodeService.class);

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		request.setAttribute(attibuteName, codeService.getCode(homepage.getHomepage_id(), group_id));

		return SKIP_BODY;
	}

	public String getAttibuteName() {
		return attibuteName;
	}

	public void setAttibuteName(String attibuteName) {
		this.attibuteName = attibuteName;
	}

	public String getGroup_id() {
		return group_id;
	}

	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}

}
