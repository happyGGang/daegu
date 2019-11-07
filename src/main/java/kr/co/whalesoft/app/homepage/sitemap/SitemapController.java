package kr.co.whalesoft.app.homepage.sitemap;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
public class SitemapController extends BaseController {
	
	private final String basePath = "/homepage/";

	@Autowired
	private SiteService siteService;
	
	@Autowired
	private HomepageService homepageService;
	
	
	@RequestMapping(value = {"/{contextPath}/sitemap/index.*"})
	public String index(Model model, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		String filePath = "";
		
		if(homepage != null) {
			filePath = homepage.getFolder() + "/sitemap/index";
		}
		
		
		model.addAttribute("siteList", siteService.getSiteListAll(new Site(homepage.getHomepage_id())));
		
		return basePath + filePath;
	}
	
}