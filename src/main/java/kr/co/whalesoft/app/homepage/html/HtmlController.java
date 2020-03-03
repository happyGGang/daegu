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
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
public class HtmlController extends BaseController {

	private final String basePath = "/homepage/";

	@Autowired
	private RecommendSiteService recommendSiteService;

	@Autowired
	private MenuHtmlService menuHtmlService;

	@RequestMapping(value = {"/{contextPath}/html.*"})
	public String index(Model model, Menu menu, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		model.addAttribute("siteList", recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage.getHomepage_id())));
		if("Y".equals(menu.getTemp_yn())) {
			model.addAttribute("html", menuHtmlService.getMenuTempHtml((new MenuHtml(homepage.getHomepage_id(), menu.getMenu_idx()))));
		} else {
			model.addAttribute("html", menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage.getHomepage_id(), menu.getMenu_idx())));
		}
		return basePath + homepage.getFolder() + "/html";
	}

	@RequestMapping(value = {"/{contextPath}/elibsso.*"})
	public String elibsso(Model model, Menu menu, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		return basePath + homepage.getFolder() + "/elibsso";
	}

	@RequestMapping(value = {"/{contextPath}/elib.*"})
	public String elib(Model model, Menu menu, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		return basePath + homepage.getFolder() + "/elib";
	}
}
