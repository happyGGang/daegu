package kr.co.whalesoft.app.cms.cmsTag;

import java.io.IOException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.framework.tag.HtmlTag;

public class AsideMenuTag extends BodyTagSupport {

    private static final long serialVersionUID = 1L;
    private List<AdminMenu> adminMenuList;

    @Override
    public int doEndTag() throws JspException {
        StringBuilder sb = new StringBuilder();
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String asideHomepageId = String.valueOf(request.getSession().getAttribute("asideHomepageId"));

        Set<Integer> access_set = new HashSet<>();

        if (adminMenuList != null && !adminMenuList.isEmpty()) {
            Map<Integer, HtmlTag> tagMap = new HashMap<>();
            Map<Integer, HtmlTag> contentMap = new HashMap<>();

            for (AdminMenu menu : adminMenuList) {
                if (menu.getAccess_homepage_id_arr() != null) {
                    String[] ids = menu.getAccess_homepage_id_arr();
                    Arrays.sort(ids);
                    if (Arrays.binarySearch(ids, asideHomepageId) < 0) {
                        access_set.add(menu.getMenu_idx());
                        continue;
                    }
                }
                if (access_set.contains(menu.getParent_menu_idx())) {
                    access_set.add(menu.getMenu_idx());
                    continue;
                }

                int level = menu.getMenu_level();
                String url = StringUtils.equals(menu.getMenu_type(), "module") ? menu.getLink_url() : menu.getMenu_url();
                boolean hasChildren = adminMenuList.stream().anyMatch(child -> Objects.equals(child.getParent_menu_idx(), menu.getMenu_idx()));
                String anchor = buildAnchor(menu, url, hasChildren);

                if (level == 1) {
                    HtmlTag container = new HtmlTag("div");
                    container.setAttribute("class", "one-depth");
                    container.setAttribute("id", menu.getMenu_name());

                    HtmlTag btn = new HtmlTag("div");
                    btn.setAttribute("class", "one-depth-btn");

                    HtmlTag iconDiv = new HtmlTag("div");
                    iconDiv.setContent("<img src='/resources/cms/img/sideMenu/cms-manage.svg' alt=''><div>" + menu.getMenu_name() + "</div>");

                    HtmlTag expandIcon = new HtmlTag("img");
                    expandIcon.setAttribute("src", "/resources/cms/img/sideMenu/expansion.svg");
                    expandIcon.setAttribute("alt", "");

                    btn.addSubTag(iconDiv);
                    btn.addSubTag(expandIcon);
                    container.addSubTag(btn);

                    tagMap.put(menu.getMenu_idx(), container);
                    contentMap.put(menu.getMenu_idx(), container);
                } else {
                    HtmlTag parent = contentMap.get(menu.getParent_menu_idx());
                    if (parent != null) {
                        HtmlTag ul = getOrCreateUlTag(parent);
                        HtmlTag li = new HtmlTag("li");
                        li.setContent(anchor);
                        ul.addSubTag(li);

                        // 다음 레벨을 위한 저장
                        tagMap.put(menu.getMenu_idx(), li);
                        contentMap.put(menu.getMenu_idx(), li);
                    }
                }
            }

            // 출력 순서를 유지하려면 adminMenuList를 기준으로 depth=1만 출력
            for (AdminMenu menu : adminMenuList) {
                if (menu.getMenu_level() == 1 && tagMap.containsKey(menu.getMenu_idx())) {
                    sb.append(tagMap.get(menu.getMenu_idx()).toString());
                }
            }
        }

        try {
            pageContext.getOut().println(sb.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    private String buildAnchor(AdminMenu menu, String url, boolean hasChildren) {
        String name = "· " + menu.getMenu_name();

        String anchor = "<a href='" + url + "'";

        if (hasChildren) {
            anchor += " class='has-sub' data-has-children='true'";
        }

        if (StringUtils.equals(menu.getMenu_type(), "changePage")) {
            anchor += " onclick=\"javascript:parent.location.href='" + url + "'; return false;\"";
        } else if (StringUtils.equals(menu.getMenu_type(), "_blank")) {
            anchor += " target='_blank'";
        }
        anchor += ">" + name + "</a>";

        return anchor;
    }

    private HtmlTag getOrCreateUlTag(HtmlTag parent) {
        for (HtmlTag child : parent.getSubTags()) {
            if ("ul".equals(child.getName())) {
                return child;
            }
        }
        HtmlTag ul = new HtmlTag("ul");
        parent.addSubTag(ul);
        return ul;
    }

    public List<AdminMenu> getAdminMenuList() {
        return adminMenuList != null ? new ArrayList<>(adminMenuList) : null;
    }

    public void setAdminMenuList(List<AdminMenu> adminMenuList) {
        this.adminMenuList = adminMenuList != null ? new ArrayList<>(adminMenuList) : null;
    }
}