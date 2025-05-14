package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class NewTopMenuTag extends BodyTagSupport {

    private static final long serialVersionUID = 1L;
    private List<Menu> menuList;
    private boolean isAddTitle = false;

    @Override
    public int doEndTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        Homepage homepage = (Homepage) request.getAttribute("homepage");

        HtmlTag header = new HtmlTag("div");
        header.setAttribute("class", "homepage-header");

        HtmlTag logoH1 = new HtmlTag("h1");
        logoH1.setAttribute("class", "library-logo");
        logoH1.setContent(String.format(
            "<a href=\"/%s/index.do\">" +
                "<img src=\"/resources/homepage/" + homepage.getContext_path() + "/img/logo.png\" alt=\"\"/>" +
						"</a>",
            homepage.getContext_path()
        ));
        header.addSubTag(logoH1);

        HtmlTag oneDepth = new HtmlTag("div");
        oneDepth.setAttribute("class", "one-depth-menu");
        if (menuList != null) {
            for (Menu menu : menuList) {
                if (menu.getMenu_level() == 1 && "Y".equals(menu.getView_yn())) {
                    String url = buildLinkUrl(menu, homepage);
                    HtmlTag aTag = new HtmlTag("a");
                    aTag.setAttribute("href", url);
                    aTag.setContent(menu.getMenu_name());
                    oneDepth.addSubTag(aTag);
                }
            }
        }
        header.addSubTag(oneDepth);

        try {
            pageContext.getOut().println(header.toString());
        } catch (IOException e) {
            throw new JspException(e);
        }

        Map<Integer, List<Menu>> levelTwoDepth = new LinkedHashMap<>();
        if (menuList != null) {
            for (Menu menu : menuList) {
                if (menu.getMenu_level() == 2 && "Y".equals(menu.getView_yn())) {
                    levelTwoDepth.computeIfAbsent(menu.getParent_menu_idx(), k -> new ArrayList<>()).add(menu);
                }
            }
        }

        HtmlTag twoWrapper = new HtmlTag("div");
        twoWrapper.setAttribute("class", "two-depth-menu-wrapper");
        for (List<Menu> submenuList : levelTwoDepth.values()) {
            HtmlTag twoContainer = new HtmlTag("div");
            twoContainer.setAttribute("class", "two-depth-menu");
            for (Menu menu : submenuList) {
                String url = buildLinkUrl(menu, homepage);
                HtmlTag aTag = new HtmlTag("a");
                aTag.setAttribute("href", url);
                aTag.setContent(menu.getMenu_name());
                twoContainer.addSubTag(aTag);
            }
            twoWrapper.addSubTag(twoContainer);
        }
        try {
            pageContext.getOut().println(twoWrapper.toString());
        } catch (IOException e) {
            throw new JspException(e);
        }

        return EVAL_PAGE;
    }

    private String buildLinkUrl(Menu menu, Homepage homepage) {
        String link;
        String ctx = homepage.getContext_path();
        switch (menu.getMenu_type()) {
            case "HTML":
                link = String.format("/%s/html.do?menu_idx=%d", ctx, menu.getMenu_idx());
                break;
            case "PROGRAM":
                if (StringUtils.isEmpty(menu.getMenu_url_param())) {
                    link = String.format("/%s%s?menu_idx=%d", ctx, menu.getMenu_url(), menu.getMenu_idx());
                } else {
                    link = String.format("/%s%s?menu_idx=%d&%s", ctx, menu.getMenu_url(), menu.getMenu_idx(), menu.getMenu_url_param());
                }
                break;
            case "BOARD":
                link = String.format("/%s/board/index.do?menu_idx=%d&manage_idx=%d", ctx, menu.getMenu_idx(), menu.getManage_idx());
                break;
            case "LINK":
                if (!StringUtils.isEmpty(menu.getLink_url()) && menu.getLink_url().contains("menu_idx")) {
                    link = menu.getLink_url();
                } else {
                    link = String.format("/%s%s?menu_idx=%d", ctx, menu.getLink_url(), menu.getMenu_idx());
                }
                break;
            case "LINK_OUTER":
                link = menu.getLink_url();
                break;
            default:
                link = String.format("/%s/html.do?menu_idx=%d", ctx, menu.getMenu_idx());
                break;
        }
        return link;
    }

    public List<Menu> getMenuList() {
        return menuList != null ? new ArrayList<>(menuList) : null;
    }

    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList != null ? new ArrayList<>(menuList) : null;
    }

    public boolean getIsAddTitle() {
        return isAddTitle;
    }

    public void setIsAddTitle(boolean isAddTitle) {
        this.isAddTitle = isAddTitle;
    }
}
