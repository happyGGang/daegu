package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class DocInfoTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	private List<Menu> menuList;
	private Menu oneMenu;

	@Override
	public int doEndTag() throws JspException {
		Map<Integer, Menu> menuRepo = new HashMap<Integer, Menu>();
		Map<Integer, Menu> firstMenuRepo = new HashMap<Integer, Menu>();

		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		String homepageContextPath = homepage.getContext_path();

		if (menuList != null) {
			for (Menu menu : menuList) {
				menuRepo.put(menu.getMenu_idx(), menu);

				if (!firstMenuRepo.containsKey(menu.getParent_menu_idx())) {
					firstMenuRepo.put(menu.getParent_menu_idx(), menu);
				} else {
					Menu childMenu = firstMenuRepo.get(menu.getParent_menu_idx());
					if (menu.getPrint_seq() < childMenu.getPrint_seq()) {
						firstMenuRepo.put(menu.getParent_menu_idx(), menu);
					}
				}
			}

			Stack<HtmlTag> docStack = new Stack<HtmlTag>();
			int menuIdx = 0;
			if (oneMenu != null) {
				menuIdx = oneMenu.getMenu_idx();
			}
			while (menuIdx != 0) {
				if (menuRepo.containsKey(menuIdx)) {
					HtmlTag li_tag = new HtmlTag("li");
					Menu menu = menuRepo.get(menuIdx);

					Menu childMenu = menu;
					while (firstMenuRepo.containsKey(childMenu.getMenu_idx())) {
						childMenu = firstMenuRepo.get(childMenu.getMenu_idx());
					}

					String link_url;
					if (childMenu.getMenu_type().equals("HTML")) {
						link_url = "/" + homepageContextPath + "/html.do?menu_idx=" + childMenu.getMenu_idx();
					} else if (childMenu.getMenu_type().equals("PROGRAM")) {
						link_url = String.format("/%s%s?menu_idx=%s", homepageContextPath, childMenu.getMenu_url(), childMenu.getMenu_idx());
						if (homepageContextPath.equals("elib") || !StringUtils.isEmpty(menu.getMenu_url_param())) {
							link_url = String.format("/%s%s?menu_idx=%s&%s", homepageContextPath, childMenu.getMenu_url(), childMenu.getMenu_idx(), childMenu.getMenu_url_param());
						}
					} else if (childMenu.getMenu_type().equals("BOARD")) {
						link_url = String.format("/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getContext_path(), childMenu.getMenu_idx(), childMenu.getManage_idx());
					} else if (childMenu.getMenu_type().equals("LINK")) {
						link_url = String.format("/%s%s?menu_idx=%s", homepage.getContext_path(), childMenu.getLink_url(), childMenu.getMenu_idx());
					} else if (childMenu.getMenu_type().equals("LINK_OUTER")) {
						link_url = childMenu.getLink_url();
					} else {
						link_url = String.format("#", homepageContextPath, childMenu.getMenu_url(), childMenu.getMenu_idx());
					}

					li_tag.setContent(String.format("<a href=\"%s\">%s</a>", link_url, menu.getMenu_name()));
					docStack.push(li_tag);
					menuIdx = menu.getParent_menu_idx();
				} else {
					menuIdx = 0;
				}
			}
			int count = docStack.size();
			for (int i = 0; i < count; i++) {
				try {
					pageContext.getOut().println(docStack.pop().toString());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return EVAL_PAGE;
	}

	public List<Menu> getMenuList() {
		if (menuList != null) {
			List<Menu> arrayList = new ArrayList<Menu>();
			arrayList.addAll(this.menuList);
			return arrayList;
		} else {
			return null;
		}
	}

	public void setMenuList(List<Menu> menuList) {
		if (menuList != null) {
			this.menuList = new ArrayList<Menu>();
			this.menuList.addAll(menuList);
		}
	}

	public Menu getOneMenu() {
		return oneMenu;
	}

	public void setOneMenu(Menu oneMenu) {
		this.oneMenu = oneMenu;
	}

}
