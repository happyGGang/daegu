package kr.go.gbelib.app.cms.module.teach.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroup;
import kr.go.gbelib.app.cms.module.category.group.CategoryGroupService;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2;
import kr.go.gbelib.app.cms.module.teach.teachCode2.TeachCode2Service;

@Controller
@RequestMapping(value = { "/cms/module/teach/statistics" })
public class TeachStatisticsController extends BaseController {

	private final String basePath = "/cms/module/teach/statistics/";
	
	@Autowired
	private CategoryGroupService categoryGroupService;
	
	@Autowired
	private TeachStatisticsService service;
	
	@Autowired
	private TeachCode2Service teachCode2Service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, TeachStatistics teachStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		if ( !getSessionIsAdmin(request) ) {
			teachStatistics.setHomepage_id(getAsideHomepageId(request));
		}
		

		
		TeachCode2 teachCode2 = new TeachCode2(1);
		teachCode2.setTeach_code(15);
		model.addAttribute("teachLargeCategoryList", teachCode2Service.getSubcategories(teachCode2));
		
		model.addAttribute("groupList", categoryGroupService.getCategoryGroupListAll(new CategoryGroup(teachStatistics.getHomepage_id())));
		model.addAttribute("teachStatistics", teachStatistics);
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/statistics.*" })
	public String statistics(Model model, TeachStatistics teachStatistics, HttpServletRequest request) {
		
		model.addAttribute("statisticsList", service.getTeachStatistics(teachStatistics));
		
		return basePath + "statistics_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public TeachStatisticsSearchView excel(Model model, TeachStatistics teachStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("teachStatistics", teachStatistics); 
		model.addAttribute("statisticsList", service.getTeachStatistics(teachStatistics));
		return new TeachStatisticsSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(TeachStatistics teachStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<TeachStatistics> statisticsList = service.getTeachStatistics(teachStatistics);
		
		new TeachStatisticsXlsToCsv(teachStatistics, statisticsList, request, response);
	}
}