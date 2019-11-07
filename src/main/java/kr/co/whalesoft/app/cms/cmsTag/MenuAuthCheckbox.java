package kr.co.whalesoft.app.cms.cmsTag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class MenuAuthCheckbox extends BodyTagSupport{

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String name;
	private String value;
	private String[] auth_id_array;
	private String cssClass;
	
	@Override
	public int doEndTag() throws JspException {
		try {
			String checked = "";
			
			if (auth_id_array != null && auth_id_array.length > 0) {
				for(String auth_id_one : auth_id_array) {
					if(auth_id_one.equals(value)) {
						checked = "checked";
						break;
					}
				}
			}
			
			String checkbox = String.format("<input type='checkbox' id='%s' name='%s' value='%s' class='%s' %s/> ", id, name, value, cssClass, checked);
			
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

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	public String[] getAuth_id_array() {
		String[] ret = null;
		if(this.auth_id_array != null) {
			ret = new String[this.auth_id_array.length];
			for(int i=0; i<this.auth_id_array.length; i++) {
				ret[i] = this.auth_id_array[i];
			}
		}
		return ret;
	}

	public void setAuth_id_array(String[] auth_id_array) {
		this.auth_id_array = new String[auth_id_array.length];
		for(int i=0; i<auth_id_array.length; i++) {
			this.auth_id_array[i] = auth_id_array[i];
		}
	}

}