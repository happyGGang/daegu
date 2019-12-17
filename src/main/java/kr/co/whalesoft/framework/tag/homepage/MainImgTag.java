
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.mainImg.MainImg;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class MainImgTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<MainImg> mainImgList;
	
	@Override
	public int doEndTag() throws JspException {
		HtmlTag ul_tag = new HtmlTag("ul"); 
		ul_tag.setAttribute("class", "main_img");
//		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		if ( getMainImgList() != null ) {
			int count = 1;
			for ( MainImg one : getMainImgList() ) {
				HtmlTag li_tag = new HtmlTag("li");
				li_tag.setAttribute("class", "main_img" + count);
				li_tag.setAttribute("style", String.format("background:url('/data/mainImg/%s/%s') no-repeat 0 0", one.getHomepage_id(), one.getServer_file_name()));
				ul_tag.addSubTag(li_tag);
				HtmlTag div_tag = new HtmlTag("div");
				li_tag.addSubTag(div_tag);
				count += 1;
			}
			try {
				pageContext.getOut().println(ul_tag.toString());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return EVAL_PAGE;
	}

	public List<MainImg> getMainImgList() {
		if(mainImgList != null) {
			List<MainImg> arrayList = new ArrayList<MainImg>();
			arrayList.addAll(this.mainImgList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMainImgList(List<MainImg> mainImgList) {
		if(mainImgList != null) {
			this.mainImgList = new ArrayList<MainImg>();
			this.mainImgList.addAll(mainImgList);
		}
	}
}