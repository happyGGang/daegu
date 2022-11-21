package kr.co.whalesoft.framework.tag.homepage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Stack;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.tag.HtmlTag;
import org.apache.commons.lang.StringUtils;

public class DocInfoTopTag extends BodyTagSupport {
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
                    if (menu.getMenu_level() == 1 || menu.getMenu_level() == 2) {
                        firstMenuRepo.put(menu.getParent_menu_idx(), menu);
                    } else {
                        if (oneMenu.getParent_menu_idx() == menu.getParent_menu_idx()) {
                            firstMenuRepo.put(menu.getParent_menu_idx(), menu);
                        }
                    }
                } else {
                    Menu childMenu = firstMenuRepo.get(menu.getParent_menu_idx());

                    if (menu.getPrint_seq() < childMenu.getPrint_seq()) {
                        firstMenuRepo.put(menu.getParent_menu_idx(), menu);
                    }
                }
            }
            // firstMenuRepo 이걸로 댑스 갯수를 셀수 있음

            int menu_depth = 1;
            boolean first_yn = true;
            Queue<HtmlTag> docQueue = new LinkedList<HtmlTag>();

            for (Map.Entry<Integer, Menu> parent_menu : firstMenuRepo.entrySet()) {
                HtmlTag li_tag1 = new HtmlTag("li");
                int key = parent_menu.getKey();
                Menu menu = parent_menu.getValue();
                StringBuilder sb = new StringBuilder();

                //해당 댑스의 최상위 정보를 얻어 저장하기 위함
                int count = 0;
                String topMenu = ""; // li의 최상위 메뉴
                for (Menu one : menuList) {
                     if (key == one.getParent_menu_idx()) {
                         ++count;
                         if (count == 1) {
                             topMenu = "<a href=\"javascript:void(0);\" class=\"de_menu"+menu_depth+"\">"+one.getMenu_name()+"</a>";
                         } else if (one.getMenu_idx() == oneMenu.getMenu_idx()) {
                             topMenu = "<a href=\"javascript:void(0);\" class=\"de_menu"+menu_depth+"\">"+one.getMenu_name()+"</a>";
                         } else if (one.getMenu_idx() == oneMenu.getParent_menu_idx()) {
                             topMenu = "<a href=\"javascript:void(0);\" class=\"de_menu"+menu_depth+"\">"+one.getMenu_name()+"</a>";
                         }
                    }
                }

                sb.append(topMenu);

                if (count > 1) {
                    first_yn = false;
                }

                if (!first_yn) {
                    // 첫번째에대한정보
                    int menu_count = 1;

                    for (Menu one : menuList) {

                        if (one.getMenu_idx() != oneMenu.getMenu_idx() && one.getMenu_idx() != oneMenu.getParent_menu_idx()) {
                            if (key == one.getParent_menu_idx()) {
                                if (menu_count == 1) {
                                    sb.append("<ul class=\"L2_Items\">");
                                }

                                String link_url;
                                if (one.getMenu_type().equals("HTML")) {
                                    link_url = "/" + homepageContextPath + "/html.do?menu_idx=" + one.getMenu_idx();
                                } else if (one.getMenu_type().equals("PROGRAM")) {
                                    link_url = String.format("/%s%s?menu_idx=%s", homepageContextPath, one.getMenu_url(), one.getMenu_idx());
                                    if (!StringUtils.isEmpty(menu.getMenu_url_param())) {
                                        link_url = String.format("/%s%s?menu_idx=%s&%s", homepageContextPath, one.getMenu_url(), one.getMenu_idx(), one.getMenu_url_param());
                                    }
                                } else if (one.getMenu_type().equals("BOARD")) {
                                    link_url = String.format("/%s/board/index.do?menu_idx=%s&manage_idx=%s", homepage.getContext_path(), one.getMenu_idx(), one.getManage_idx());
                                } else if (one.getMenu_type().equals("LINK")) {
                                    link_url = String.format("/%s%s", homepage.getContext_path(), one.getLink_url());
                                } else if (one.getMenu_type().equals("LINK_OUTER")) {
                                    link_url = one.getLink_url();
                                } else {
                                    link_url = String.format("#", homepageContextPath, one.getMenu_url(), one.getMenu_idx());
                                }

                                sb.append("<li><a href=\""+link_url+"\">"+one.getMenu_name()+"</a></li>");

                                menu_count++;
                            }
                        }
                    }
                    sb.append("</ul>");
                }

                li_tag1.setContent(sb.toString());
                docQueue.add(li_tag1);
                menu_depth++;
            }

            int count = docQueue.size();
            for (int i = 0; i < count; i++) {
                try {
                    pageContext.getOut().println(docQueue.poll().toString());
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
