package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class BannerMapTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private List<Banner> bannerList;

	@Override
	public int doEndTag() throws JspException {
		HtmlTag ulTag = new HtmlTag("ul");
		
		if(bannerList != null) {
			int count = 1;
			for(Banner banner : bannerList) {
				HtmlTag liTag = new HtmlTag("li");
				HtmlTag aTag = new HtmlTag("a");
				HtmlTag imgTag = new HtmlTag("img");
				aTag.setAttribute("href", banner.getBanner_link());
				aTag.setAttribute("target", "_blank");
				imgTag.setAttribute("src", String.format("/data/banner/%s/%s", banner.getHomepage_id(), banner.getServer_file_name()));
				aTag.addSubTag(imgTag);
				liTag.addSubTag(aTag);
				ulTag.addSubTag(liTag);
				count++;
			}
		}
			
		try {
			pageContext.getOut().println(ulTag.toString().replaceAll("></img>", "/>"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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