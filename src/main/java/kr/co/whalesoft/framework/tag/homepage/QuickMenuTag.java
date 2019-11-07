
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.quickMenu.QuickMenu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class QuickMenuTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<QuickMenu> quickMenuList;
	
	@Override
	public int doEndTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		int count = 0;
		if ( getQuickMenuList() != null ) {
			for ( QuickMenu one : getQuickMenuList() ) {
				
				count = count+1;
				HtmlTag li_tag 		= new HtmlTag("li");
				HtmlTag div_tag		= new HtmlTag("div");
				HtmlTag a_tag 		= new HtmlTag("a");
				HtmlTag span_tag 	= new HtmlTag("span");

				String link_url = "";
				if ( StringUtils.isEmpty(one.getLink_url())) {
					link_url = "javascript:alert('준비중입니다.');";
				}
				else {
					if ( one.getLink_use_yn().trim().equals("N") ) {
						link_url = one.getLink_url();
					}
					else {
						link_url = String.format("/%s%s", homepage.getContext_path(), one.getLink_url());
					}	
				}
				if ( StringUtils.isNotEmpty(one.getLink_target()) && one.getLink_target().equals("BLANK") ) {
					a_tag.setAttribute("target", "_blank");
				}
				a_tag.setAttribute("href", link_url);
				a_tag.setAttribute("style", String.format("background-image:url('/data/quickMenu/%s/%s')", one.getHomepage_id(), one.getReal_file_name()));
				li_tag.setAttribute("class", "qm"+count);
				span_tag.setContent(one.getMenu_name());
				a_tag.addSubTag(span_tag);
				if( homepage.getHomepage_id().equals("h17")){
					div_tag.addSubTag(a_tag);
					li_tag.addSubTag(div_tag);
				} else {
					li_tag.addSubTag(a_tag);
				}

				try {
					pageContext.getOut().println(li_tag.toString());
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return EVAL_PAGE;
	}

	public List<QuickMenu> getQuickMenuList() {
		if(quickMenuList != null) {
			List<QuickMenu> arrayList = new ArrayList<QuickMenu>();
			arrayList.addAll(this.quickMenuList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setQuickMenuList(List<QuickMenu> quickMenuList) {
		if(quickMenuList != null) {
			this.quickMenuList = new ArrayList<QuickMenu>();
			this.quickMenuList.addAll(quickMenuList);
		}
	}

}