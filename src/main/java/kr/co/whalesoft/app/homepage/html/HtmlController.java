package kr.co.whalesoft.app.homepage.html;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
public class HtmlController extends BaseController {

	private final String basePath = "/homepage/";
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private MenuHtmlService menuHtmlService;

	@RequestMapping(value = {"/{contextPath}/html.*"})
	public String index(Model model, Menu menu, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
//		model.addAttribute("siteList", siteService.getSiteListAll(new Site(homepage.getHomepage_id())));
		if("Y".equals(menu.getTemp_yn())) {
			model.addAttribute("html", menuHtmlService.getMenuTempHtml((new MenuHtml(homepage.getHomepage_id(), menu.getMenu_idx()))));
		} else {
			model.addAttribute("html", menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage.getHomepage_id(), menu.getMenu_idx())));
		}
		return basePath + homepage.getFolder() + "/html";
	}
}
