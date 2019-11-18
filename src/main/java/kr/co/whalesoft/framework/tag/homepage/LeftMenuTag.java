package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;
import kr.co.whalesoft.framework.utils.StaticVariables;

public class LeftMenuTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Menu> menuList;

	private int startDeps = 2;

	private boolean teacherMenu = false;

	@Override
	public int doEndTag() throws JspException {
		HttpServletRequest request = (HttpServletRequest)pageContext.getRequest();
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		List<HtmlTag> ulTag = new ArrayList<HtmlTag>();
		List<HtmlTag> liTag_lvl = new ArrayList<HtmlTag>();

		for(int i = 0 ; i < startDeps-1 ; i++){
			ulTag.add(i,null);
			liTag_lvl.add(i,null);
		}
		ulTag.add(startDeps-1,new HtmlTag("ul"));
		liTag_lvl.add(startDeps-1,new HtmlTag("li"));

		int preMenuLevel = startDeps;

		if(menuList != null) {
			for(Menu menu : menuList) {
				String link_url = "";

				if ( menu.getMenu_type().equals("HTML") ) {
					link_url = "/" + homepage.getContext_path() + "/html.do?menu_idx=" + menu.getMenu_idx();
				}
				else if ( menu.getMenu_type().equals("PROGRAM") ) {
					if (menu.getManage_idx() == 31) {
						Member sessionMember = (Member)request.getSession().getAttribute(StaticVariables.MEMBER);
//						if (StringUtils.equals(sessionMember.getTeacher_yn(), "Y")) {
//							link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx());
//							if ( !StringUtils.isEmpty(menu.getMenu_url_param()) ) {
//								link_url = String.format("/%s%s?menu_idx=%s&%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx(), menu.getMenu_url_param());
//							}
//							teacherMenu = true;
//						}
					} else {
						link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx());
						if ( !StringUtils.isEmpty(menu.getMenu_url_param()) ) {
							link_url = String.format("/%s%s?menu_idx=%s&%s", homepage.getContext_path(), menu.getMenu_url(), menu.getMenu_idx(), menu.getMenu_url_param());
						}
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
					link_url = "/" + homepage.getContext_path() + "/html.do?menu_idx=" + menu.getMenu_idx();
				}

				String targetStr = "";

				if(menu.getMenu_level() >= startDeps){
					if (StringUtils.isNotEmpty(link_url)) {
						if ( menu.getMenu_type().equals("LINK_OUTER") ) {
							targetStr = "target=\"_blank\"";
						}

						if(preMenuLevel < menu.getMenu_level()){
							HtmlTag ul =  new HtmlTag("ul");
							ul.setAttribute("class", "SubMenu");
							liTag_lvl.get(menu.getMenu_level()-1).addSubTag(ul);
							ulTag.add(menu.getMenu_level()-1,ul);
						}
						HtmlTag li = new HtmlTag("li");
						li.setAttribute("id", "menu_"+menu.getMenu_idx());
						li.setContent("<a href=\"" + link_url + "\" "+targetStr+"><span>" + menu.getMenu_name() + "</span></a>");
						liTag_lvl.add(menu.getMenu_level(),li);
						ulTag.get(menu.getMenu_level()-1).addSubTag(li);;
					}
				}

				preMenuLevel = menu.getMenu_level();
			}
		}

		try {
			pageContext.getOut().println(ulTag.get(startDeps-1).toString());
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

	public int getStartDeps() {
		return startDeps;
	}

	public void setStartDeps(int startDeps) {
		this.startDeps = startDeps;
	}



}