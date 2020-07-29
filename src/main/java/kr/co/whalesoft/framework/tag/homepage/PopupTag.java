
package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;

import kr.co.whalesoft.app.cms.popup.Popup;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class PopupTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private List<Popup> popupList;

	@Override
	public int doEndTag() throws JspException {
//		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();

		if ( getPopupList() != null ) {
			for ( Popup one : getPopupList() ) {
				String popup_id = String.format("popup_%s_%s", one.getHomepage_id(), one.getPopup_idx());
				HtmlTag div_tag_1 = new HtmlTag("div");
				HtmlTag div_tag_2 = new HtmlTag("div");

				HtmlTag div_tag_3 = new HtmlTag("div");

				div_tag_1.setAttribute("id", popup_id);
				div_tag_1.setAttribute("style", String.format("display:none;position:absolute;z-index:999999;width:%spx;top:%spx;left:%spx", one.getWidth(), one.getY_position(), one.getX_position()));

				// 팝업 내용 부분
				if ( one.getHtml_use_yn().equals("N") ) {
					div_tag_2.setAttribute("class", "popup-cont type1");
					HtmlTag a_tag_1 = new HtmlTag("a");
					a_tag_1.setAttribute("href", one.getLink_url());

					if ( one.getLink_target().equals("BLANK") ) {
						a_tag_1.setAttribute("target", "_blank");
					}

					HtmlTag img_tag = new HtmlTag("img");
					img_tag.setAttribute("style", String.format("width:%spx;height:%spx", one.getWidth(), one.getHeight()));
					img_tag.setAttribute("src", String.format("/data/popup/%s/%s", one.getHomepage_id(), one.getServer_file_name()));
					img_tag.setAttribute("alt", one.getAlt_text());
					img_tag.setAttribute("title", one.getPopup_name());
					a_tag_1.addSubTag(img_tag);
					div_tag_2.addSubTag(a_tag_1);
				}
				else {
					div_tag_2.setContent(one.getHtml());
				}

				//팝업 하단 버튼 부분
				div_tag_3.setAttribute("class", "popup-func");
				String checkboxId = "pop" + one.getHomepage_id() + "_" + one.getPopup_idx();
				HtmlTag div_tag_4 = new HtmlTag("div");
				div_tag_4.setAttribute("class", "checkbox");
				HtmlTag checkbox_tag = new HtmlTag("input");
				checkbox_tag.setAttribute("type", "checkbox");
				checkbox_tag.setAttribute("id", checkboxId);
				checkbox_tag.setAttribute("name", popup_id);
				checkbox_tag.setAttribute("value", popup_id);
				checkbox_tag.setAttribute("data-day", "1");
				HtmlTag label_tag = new HtmlTag("label");
				label_tag.setAttribute("style", "line-height: 34px;");
				label_tag.setAttribute("for", checkboxId);
				label_tag.setAttribute("title", "오늘하루 열지않음");
				label_tag.setContent("오늘하루 열지않음");
				div_tag_4.addSubTag(checkbox_tag);
				div_tag_4.addSubTag(label_tag);
				
				checkbox_tag = new HtmlTag("input");
				checkbox_tag.setAttribute("type", "checkbox");
				checkbox_tag.setAttribute("id", checkboxId + "_7");
				checkbox_tag.setAttribute("name", popup_id + "_7");
				checkbox_tag.setAttribute("value", popup_id);
				checkbox_tag.setAttribute("data-day", "7");
				label_tag = new HtmlTag("label");
				label_tag.setAttribute("style", "line-height: 34px;");
				label_tag.setAttribute("for", checkboxId + "_7");
				label_tag.setAttribute("title", "7일간 보지 않기");
				label_tag.setContent("7일간 보지 않기");
				div_tag_4.addSubTag(checkbox_tag);
				div_tag_4.addSubTag(label_tag);
				
				div_tag_3.addSubTag(div_tag_4);

				HtmlTag a_tag_2 = new HtmlTag("a");
				a_tag_2.setAttribute("class", "btn close-btn");
				a_tag_2.setAttribute("tabindex", "1"); //텝을 눌렀을때 팝업닫기로 바로 가도록
				a_tag_2.setAttribute("data-day", "1");
				HtmlTag i_tag = new HtmlTag("i");
				i_tag.setAttribute("class", "fa fa-close");
				HtmlTag span_tag = new HtmlTag("span");
				span_tag.setAttribute("class", "blind");
				span_tag.setContent("닫기");
				a_tag_2.addSubTag(i_tag);
				a_tag_2.addSubTag(span_tag);
				div_tag_3.addSubTag(a_tag_2);

				div_tag_1.addSubTag(div_tag_2);
				div_tag_1.addSubTag(div_tag_3);
				try {
					pageContext.getOut().println(div_tag_1.toString().replaceAll("></img>", "/>"));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return EVAL_PAGE;
	}

	public List<Popup> getPopupList() {
		if(popupList != null) {
			List<Popup> arrayList = new ArrayList<Popup>();
			arrayList.addAll(this.popupList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setPopupList(List<Popup> popupList) {
		if(popupList != null) {
			this.popupList = new ArrayList<Popup>();
			this.popupList.addAll(popupList);
		}
	}

}