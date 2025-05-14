package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.framework.tag.HtmlTag;
import org.apache.commons.lang.StringUtils;

public class NewBannerTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<Banner> bannerList;

	@Override
	public int doEndTag() throws JspException {

		List<Banner> banners = getBannerList();
		if (banners != null && !banners.isEmpty()) {
			HtmlTag container = new HtmlTag("div");
			container.setAttribute("class", "banner-slide");

			for (Banner one : banners) {
				HtmlTag aTag = new HtmlTag("a");
				aTag.setAttribute("class", "banner-slide-item");
				aTag.setAttribute("href", one.getBanner_link());
				if (StringUtils.isNotEmpty(one.getBanner_link()) && !one.getBanner_link().startsWith("javascript:")) {
					aTag.setAttribute("target", "_blank");
				}

				HtmlTag imgTag = new HtmlTag("img");
				imgTag.setAttribute("src", String.format("/data/banner/%s/%s", one.getHomepage_id(), one.getServer_file_name()));
				imgTag.setAttribute("alt", one.getBanner_name());

				aTag.addSubTag(imgTag);
				container.addSubTag(aTag);
			}

			try {
				pageContext.getOut().println(container.toString());
			} catch (IOException e) {
				throw new JspException(e);
			}
		}

		return EVAL_PAGE;
	}

	public List<Banner> getBannerList() {
		return (bannerList != null)	? new ArrayList<>(bannerList)	: null;
	}

	public void setBannerList(List<Banner> bannerList) {
		if (bannerList != null) {
			this.bannerList = new ArrayList<>(bannerList);
		}
	}
}
