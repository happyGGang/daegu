
package kr.co.whalesoft.framework.tag.homepage;

import kr.co.whalesoft.app.cms.popupZone.PopupZone;
import kr.co.whalesoft.app.cms.popupZoneTop.PopupZoneTop;
import kr.co.whalesoft.framework.tag.HtmlTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PopupZoneTopTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<PopupZoneTop> popupZoneList;

	@Override
	public int doEndTag() throws JspException {
		HtmlTag ul_tag = new HtmlTag("ul");
		if (getPopupZoneList() != null) {
			for (PopupZoneTop one : getPopupZoneList()) {
				HtmlTag li_tag = new HtmlTag("li");
				HtmlTag a_tag = new HtmlTag("a");
				HtmlTag img_tag = new HtmlTag("img");
				img_tag.setAttribute("src", String.format("/data/popupZoneTop/%s/%s", one.getHomepage_id(), one.getServer_file_name()));
				img_tag.setAttribute("title", one.getPopup_zone_name());
				img_tag.setAttribute("alt", one.getAlt_text());
				a_tag.addSubTag(img_tag);

				a_tag.setAttribute("href", one.getLink_url());
				if (one.getLink_target().equals("BLANK")) {
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

	public List<PopupZoneTop> getPopupZoneList() {
		if (popupZoneList != null) {
			List<PopupZoneTop> arrayList = new ArrayList<PopupZoneTop>();
			arrayList.addAll(this.popupZoneList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setPopupZoneList(List<PopupZoneTop> popupZoneList) {
		if (popupZoneList != null) {
			this.popupZoneList = new ArrayList<PopupZoneTop>();
			this.popupZoneList.addAll(popupZoneList);
		}
	}

}
