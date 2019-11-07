
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class SiteLinkTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private List<Homepage> homepageList;

	private List<Site> siteList;
	
	private String width;
	
	private String type;
	
	private String defaultStr;
	
	private String notIncludeHomepageId;
	
	@Override
	public int doEndTag() throws JspException {
		//HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		defaultStr = StringUtils.isEmpty(defaultStr) ? "선택" : defaultStr;
		
		HtmlTag div_tag = new HtmlTag("div");
		HtmlTag a_tag = new HtmlTag("a");
		HtmlTag ul_tag = new HtmlTag("ul");
		ul_tag.setAttribute("style", "display:none");

		if ( StringUtils.isNotEmpty(width) ) {
			div_tag.setAttribute("style", "width:" + width);	
		}
		
		div_tag.addSubTag(a_tag);
		div_tag.addSubTag(ul_tag);
		
		HtmlTag span_tag1 = new HtmlTag("span");
		HtmlTag span_tag2 = new HtmlTag("span");
		span_tag1.setContent(defaultStr);
		span_tag1.setAttribute("class", "f1");
		span_tag2.setAttribute("class", "f2");
		span_tag2.setContent("<i></i>");
		a_tag.addSubTag(span_tag1);
		a_tag.addSubTag(span_tag2);
		
		type = StringUtils.isEmpty(type)? "type1" : type;
		a_tag.setAttribute("class", String.format("fsite %s", type));
		
		HtmlTag li_default_tag = new HtmlTag("li");
		li_default_tag.setAttribute("class", "disabled");
		
		li_default_tag.setContent(String.format("<a href=\"#\">%s</a>", defaultStr));
		
		ul_tag.addSubTag(li_default_tag);
		
		String[] notIncludeHomepageIdList = null;
		if (StringUtils.isNotEmpty(notIncludeHomepageId)) {
			notIncludeHomepageIdList = notIncludeHomepageId.split(",");
		}
		
		if(getHomepageList() != null) {
			for(Homepage oneHomepage : getHomepageList()) {
				boolean pass = true;
				if (notIncludeHomepageIdList != null) {
					for ( String str : notIncludeHomepageIdList ) {
						if (oneHomepage.getHomepage_id().equals(str)) {
							pass = false;
							break;
						}
					}
				}
				
				if (pass) {
					String domain = oneHomepage.getDomain();
					String contextPath = oneHomepage.getContext_path();
					String hrefStr = "";
					if ( StringUtils.isEmpty(contextPath) ) {
						hrefStr = String.format("%s/index.do", domain);
					}
					else {
						hrefStr = String.format("%s/%s/index.do", domain, contextPath);
					}
					
					HtmlTag li_tag = new HtmlTag("li");
					li_tag.setAttribute("class", "disabled");
					li_tag.setContent(String.format("<a title=\"%s\" href=\"%s\">%s</a>", oneHomepage.getHomepage_name(), hrefStr, oneHomepage.getHomepage_name()));
					ul_tag.addSubTag(li_tag);
				}
			}
		}
		
		if ( getSiteList() != null ) {
			for(Site oneSite : getSiteList()) {
				String hrefStr = oneSite.getLink_target();
				HtmlTag li_tag = new HtmlTag("li");
				li_tag.setAttribute("class", "disabled");
				li_tag.setContent(String.format("<a title=\"%s\" href=\"%s\">%s</a>", oneSite.getSite_name(), hrefStr, oneSite.getSite_name()));
				ul_tag.addSubTag(li_tag);
			}
		}
		
		HtmlTag go_tag = new HtmlTag("a");
		go_tag.setContent("이동");
		go_tag.setAttribute("href", "#");
		go_tag.setAttribute("class", "btn");
			
		try {
			pageContext.getOut().println(div_tag.toString());
			pageContext.getOut().println(go_tag.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public List<Homepage> getHomepageList() {
		if(homepageList != null) {
			List<Homepage> arrayList = new ArrayList<Homepage>();
			arrayList.addAll(this.homepageList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setHomepageList(List<Homepage> homepageList) {
		if(homepageList != null) {
			this.homepageList = new ArrayList<Homepage>();
			this.homepageList.addAll(homepageList);
		}
	}

	public List<Site> getSiteList() {
		if(siteList != null) {
			List<Site> arrayList = new ArrayList<Site>();
			arrayList.addAll(this.siteList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setSiteList(List<Site> siteList) {
		if(siteList != null) {
			this.siteList = new ArrayList<Site>();
			this.siteList.addAll(siteList);
		}
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDefaultStr() {
		return defaultStr;
	}

	public void setDefaultStr(String defaultStr) {
		this.defaultStr = defaultStr;
	}

	
	public String getNotIncludeHomepageId() {
		return notIncludeHomepageId;
	}

	
	public void setNotIncludeHomepageId(String notIncludeHomepageId) {
		this.notIncludeHomepageId = notIncludeHomepageId;
	}
}