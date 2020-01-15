package kr.go.gbelib.app.cms.module.menuRating;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/cms/module/menuRating"})
public class MenuRatingController extends BaseController {
	
	private final String basePath = "/cms/module/menuRating/";
	
	@Autowired
	private MenuRatingService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MenuRating menuRating, HttpServletRequest request) {
		String homepage_id = getAsideHomepageId(request);
		menuRating.setHomepage_id(homepage_id);
		
		if(StringUtils.isEmpty(menuRating.getSearch_date_type())) {
			menuRating.setSearch_date_type("DAY");
		}
		
		if(StringUtils.isEmpty(menuRating.getSearch_start_date())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(new Date());
			
			menuRating.setSearch_start_date(today);
			menuRating.setSearch_end_date(today);
		}
		
		model.addAttribute("menuRating", menuRating);

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/searchTable.*"}, method = RequestMethod.GET)
	public String searchTable(Model model, MenuRating menuRating, HttpServletRequest request) {
		
		List<MenuRating> menuRatingAverageList = service.getMenuRatingAverageScore(menuRating);
		service.setPaging(model, menuRatingAverageList.size(), menuRating);
		
		model.addAttribute("menuRatingAverageList", menuRatingAverageList);
		
		return basePath + "searchTable_ajax";
	}

}
