package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class TopMenuTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Menu> menuList;

	private boolean isAddTitle = false;

	@Override
	public int doEndTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		HtmlTag ulTag = new HtmlTag("ul");
		ulTag.setAttribute("class", "gnb-menu");

		HtmlTag liTag_lvl1 = null;

		HtmlTag ulTag_lvl2 = null;
		HtmlTag liTag_lvl2 = null;
		boolean check_lvl2 = false;

		HtmlTag ulTag_lvl3 = null;
		HtmlTag liTag_lvl3 = null;
		boolean check_lvl3 = false;

		int ulMenuCount = 1;
		if(menuList != null) {
			for(Menu menu : menuList) {
				String link_url = "";

				if ( menu.getMenu_type().equals("HTML") ) {
					link_url = "/" + homepage.getContext_path() + "/html.do?menu_idx=" + menu.getMenu_idx();
				}
				else if ( menu.getMenu_type().equals("PROGRAM") ) {
					link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx());
					if ( !StringUtils.isEmpty(menu.getMenu_url_param()) ) {
						link_url = String.format("/%s%s?menu_idx=%s&%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx(), menu.getMenu_url_param());
					}
				}
				else if ( menu.getMenu_type().equals("BOARD") ) {
					link_url = String.format("/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getContext_path(), menu.getMenu_idx(), menu.getManage_idx());
				}
				else if ( menu.getMenu_type().equals("LINK") ) {
					if (!StringUtils.isEmpty(menu.getLink_url()) && menu.getLink_url().contains("menu_idx")) {
						link_url = menu.getLink_url();
					} else {
						link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getLink_url(), menu.getMenu_idx());
					}
				}
				else if ( menu.getMenu_type().equals("LINK_OUTER") ) {
					link_url = menu.getLink_url();
				}
				else {
					link_url = String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), menu.getMenu_idx());
				}

				String targetStr = "";
				if(menu.getMenu_level() == 1) {
					check_lvl2 = false;
					check_lvl3 = false;
					liTag_lvl1 = new HtmlTag("li");
					if(menu.getMenu_type().equals("LINK_OUTER")) {
						targetStr = "target=\"_blank\"";
						liTag_lvl1.setAttribute("class", String.format("List ss 1Depth menu%s menu_%s", ulMenuCount, menu.getMenu_idx()));
					} else {
						liTag_lvl1.setAttribute("class", String.format("List 1Depth menu%s menu_%s", ulMenuCount, menu.getMenu_idx()));
					}
					liTag_lvl1.setContent("<a href=\"" + link_url + "\" " + targetStr + "><span>" + menu.getMenu_name() + "</span></a>");
					ulTag.addSubTag(liTag_lvl1);
					ulMenuCount += 1;

					if ( !"Y".equals(menu.getView_yn()) ) {
						liTag_lvl1.setAttribute("style", "display:none");
					}
				} else if(menu.getMenu_level() == 2) {
					check_lvl3 = false;
					if(!check_lvl2) {
						check_lvl2 = true;
						ulTag_lvl2 = new HtmlTag("ul");
						ulTag_lvl2.setAttribute("class", "SubMenu");
						liTag_lvl1.addSubTag(ulTag_lvl2);

						/*if ( isAddTitle ) {
							ulTag_lvl2.addSubTag(titleRepo.get(menu.getParent_menu_idx()));
						}*/
					}
					if(menu.getMenu_type().equals("LINK_OUTER")) {
						targetStr = "target=\"_blank\"";
					}
					liTag_lvl2 = new HtmlTag("li");
					liTag_lvl2.setAttribute("class", "2Depth menu_"+menu.getMenu_idx());
					liTag_lvl2.setContent("<a href=\"" + link_url + "\" " + targetStr + "><span>" + menu.getMenu_name() + "</span></a>");
					ulTag_lvl2.addSubTag(liTag_lvl2);
					if ( !"Y".equals(menu.getView_yn()) ) {
						liTag_lvl2.setAttribute("style", "display:none");
					}
				} else if(menu.getMenu_level() == 3) {
					if(!check_lvl3) {
						check_lvl3 = true;
						ulTag_lvl3 = new HtmlTag("ul");
						liTag_lvl2.addSubTag(ulTag_lvl3);
					}
					if(menu.getMenu_type().equals("LINK_OUTER")) {
						targetStr = "target=\"_blank\"";
					}
					liTag_lvl3 = new HtmlTag("li");
					liTag_lvl3.setAttribute("class", "3Depth menu_"+menu.getMenu_idx());
					liTag_lvl3.setContent("<a href=\"" + link_url + "\" " + targetStr + "><span>" + menu.getMenu_name() + "</span></a>");
					ulTag_lvl3.addSubTag(liTag_lvl3);
					if ( !"Y".equals(menu.getView_yn()) ) {
						liTag_lvl3.setAttribute("style", "display:none");
					}
				}
			}
		}

		try {
			pageContext.getOut().println(ulTag.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public List<Menu> getMenuList() {
		if(menuList != null) {
			List<Menu> arrayList = new ArrayList<Menu>();
			arrayList.addAll(this.menuList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMenuList(List<Menu> menuList) {
		if(menuList != null) {
			this.menuList = new ArrayList<Menu>();
			this.menuList.addAll(menuList);
		}
	}

	public boolean getIsAddTitle() {
		return isAddTitle;
	}

	public void setIsAddTitle(boolean isAddTitle) {
		this.isAddTitle = isAddTitle;
	}


}