
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.commons.lang.StringUtils;

import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class BannerTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<Banner> bannerList;
	
	@Override
	public int doEndTag() throws JspException {
		HtmlTag ul_tag = new HtmlTag("ul"); 
		ul_tag.setAttribute("class", "banner-roll");
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		if ( getBannerList() != null ) {
			for ( Banner one : getBannerList() ) {
				HtmlTag li_tag = new HtmlTag("li");
				HtmlTag span_tag = new HtmlTag("span");
				HtmlTag a_tag = new HtmlTag("a");
				HtmlTag img_tag = new HtmlTag("img");
				img_tag.setAttribute("src", String.format("/data/banner/%s/%s", one.getHomepage_id(), one.getReal_file_name()));
				img_tag.setAttribute("alt", one.getTitle());
				a_tag.addSubTag(img_tag);
				a_tag.setAttribute("href", one.getBanner_link());
				if (StringUtils.isNotEmpty(one.getBanner_link()) && !one.getBanner_link().startsWith("javascript:")) {
					a_tag.setAttribute("target", "_blank");
				}
				span_tag.addSubTag(a_tag);
				li_tag.addSubTag(span_tag);
				ul_tag.addSubTag(li_tag);
			}
			try {
				pageContext.getOut().println(ul_tag.toString().replaceAll("></img>", "/>"));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return EVAL_PAGE;
	}

	public List<Banner> getBannerList() {
		if(bannerList != null) {
			List<Banner> arrayList = new ArrayList<Banner>();
			arrayList.addAll(this.bannerList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setBannerList(List<Banner> bannerList) {
		if(bannerList != null) {
			this.bannerList = new ArrayList<Banner>();
			this.bannerList.addAll(bannerList);
		}
	}


}