package kr.co.whalesoft.app.cms.cmsTag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang3.StringUtils;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class AsideMenuTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	
	private List<AdminMenu> adminMenuList;

	@Override
	public int doEndTag() throws JspException {
		
		HtmlTag ulTag = new HtmlTag("ul");
		HtmlTag liTag_lvl1 = null;
		
		HtmlTag ulTag_lvl2 = null;
		HtmlTag liTag_lvl2 = null;
		boolean check_lvl2 = false;
		
		HtmlTag ulTag_lvl3 = null;
		HtmlTag liTag_lvl3 = null;
		boolean check_lvl3 = false;
		
		if(adminMenuList != null && adminMenuList.size() > 0) {
			for(AdminMenu adminMenu : adminMenuList) {
				if(adminMenu.getMenu_level() == 1) {
					check_lvl2 = false;
					check_lvl3 = false;
					liTag_lvl1 = new HtmlTag("li");
					liTag_lvl1.setContent("<a href=\"\" class='code2'>" + "<i class=\"fa fa-desktop\"></i><span>" + adminMenu.getMenu_name() + "</span></a>");
					ulTag.addSubTag(liTag_lvl1);
				} else if(adminMenu.getMenu_level() == 2) {
					check_lvl3 = false;
					if(!check_lvl2) {
						check_lvl2 = true;
						ulTag_lvl2 = new HtmlTag("ul");
						liTag_lvl1.addSubTag(ulTag_lvl2);
					}
					liTag_lvl2 = new HtmlTag("li");
					String url = adminMenu.getMenu_url();
					if (StringUtils.equals(adminMenu.getMenu_type(), "module")) {
						url = adminMenu.getLink_url();
					}
					if (StringUtils.equals(adminMenu.getMenu_type(), "changePage")) {
						liTag_lvl2.setContent("<a href='#' onclick='javascript:parent.location.href=\""+url+"\"; return false;'>" + adminMenu.getMenu_name() + "</a>");
					} else {
						liTag_lvl2.setContent("<a href='" + url + "' target='container'>" + adminMenu.getMenu_name() + "</a>");
					}
					ulTag_lvl2.addSubTag(liTag_lvl2);
				} else if(adminMenu.getMenu_level() == 3) {
					if(!check_lvl3) {
						check_lvl3 = true;
						ulTag_lvl3 = new HtmlTag("ul");
						liTag_lvl2.addSubTag(ulTag_lvl3);
					}
					liTag_lvl3 = new HtmlTag("li");
					String url = adminMenu.getMenu_url();
					if (StringUtils.equals(adminMenu.getMenu_type(), "module")) {
						url = adminMenu.getLink_url();
					}
					if (StringUtils.equals(adminMenu.getMenu_type(), "changePage")) {
						liTag_lvl3.setContent("<a href='#' onclick='javascript:parent.location.href='"+url+"'; return false;'>" + adminMenu.getMenu_name() + "</a>");
					} else {
						liTag_lvl3.setContent("<a href='" + url + "' target='container'>" + adminMenu.getMenu_name() + "</a>");
					}
					ulTag_lvl3.addSubTag(liTag_lvl3);
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

	public List<AdminMenu> getAdminMenuList() {
		if(adminMenuList != null) {
			List<AdminMenu> arrayList = new ArrayList<AdminMenu>();
			arrayList.addAll(this.adminMenuList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setAdminMenuList(List<AdminMenu> adminMenuList) {
		if(adminMenuList != null) {
			this.adminMenuList = new ArrayList<AdminMenu>();
			this.adminMenuList.addAll(adminMenuList);
		}
	}
	
}
