
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.popupZone.PopupZone;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class PopupZoneTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<PopupZone> popupZoneList;

	@Override
	public int doEndTag() throws JspException {
		HtmlTag ul_tag = new HtmlTag("ul");
//		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		if ( getPopupZoneList() != null ) {
			for ( PopupZone one : getPopupZoneList() ) {
				HtmlTag li_tag = new HtmlTag("li");
				HtmlTag a_tag = new HtmlTag("a");
				HtmlTag img_tag = new HtmlTag("img");
				img_tag.setAttribute("src", String.format("/data/popupZone/%s/%s", one.getHomepage_id(), one.getServer_file_name()));
				img_tag.setAttribute("title", one.getPopup_zone_name());
				img_tag.setAttribute("alt", one.getAlt_text());
				a_tag.addSubTag(img_tag);

				a_tag.setAttribute("href", one.getLink_url());
				if ( one.getLink_target().equals("BLANK") ) {
					a_tag.setAttribute("target", "_blank");
				}
				li_tag.addSubTag(a_tag);
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

	public List<PopupZone> getPopupZoneList() {
		if(popupZoneList != null) {
			List<PopupZone> arrayList = new ArrayList<PopupZone>();
			arrayList.addAll(this.popupZoneList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setPopupZoneList(List<PopupZone> popupZoneList) {
		if(popupZoneList != null) {
			this.popupZoneList = new ArrayList<PopupZone>();
			this.popupZoneList.addAll(popupZoneList);
		}
	}

}