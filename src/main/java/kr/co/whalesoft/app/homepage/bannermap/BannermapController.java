package kr.co.whalesoft.app.homepage.bannermap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.banner.Banner;
import kr.co.whalesoft.app.cms.banner.BannerService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
public class BannermapController extends BaseController {
	
	private final String basePath = "/homepage/";

	@Autowired
	private BannerService bannerService;
	
	@RequestMapping(value = {"/{contextPath}/bannermap/index.*"})
	public String index(Model model, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		String filePath = "";
		
		if(homepage != null) {
			filePath = homepage.getFolder() + "/bannermap/index";
		}
		
		model.addAttribute("bannerList", bannerService.getBannerAll(new Banner(homepage.getHomepage_id())));
		
		return basePath + filePath;
	}
	
}