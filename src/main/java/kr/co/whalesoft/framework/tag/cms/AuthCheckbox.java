package kr.co.whalesoft.framework.tag.cms;

import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class AuthCheckbox extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private String	id;
	private String	name;
	private String	value;
	private String	auth;
	private String	cssClass;
	private String	disabled;
	
	@Override
	public int doEndTag() throws JspException {
		try {
			String checked = "";
			
			StringTokenizer st = new StringTokenizer(auth, ",");
			
			while(st.hasMoreTokens() && !checked.equals("checked")) {
				String token = st.nextToken();
				
				if(token.equals(value)) {
					checked = "checked";
					break;
				}
			}
			String checkbox = String.format("<input type='checkbox' id='%s' name='%s' value='%s' %s %s /> ", id, name, value, disabled, checked);
			
			pageContext.getOut().println(checkbox);
		} catch (IOException e) {
			throw new JspException( e );
		}
		return EVAL_PAGE;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getAuth() {
		return auth;
	}

	public void setAuth(String auth) {
		this.auth = auth;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String getDisabled() {
		return disabled;
	}

	public void setDisabled(String disabled) {
		this.disabled = disabled;
	} 

}