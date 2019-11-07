package kr.go.gbelib.app.cms.module.statistics;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/module/statistics" })
public class ModuleStatisticsController extends BaseController {

	private final String basePath = "/cms/module/statistics/";
	
	@Autowired
	private ModuleStatisticsService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ModuleStatistics moduleStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
		if(StringUtils.isEmpty(moduleStatistics.getHomepage_id())) {
			moduleStatistics.setHomepage_id(getAsideHomepageId(request));
		}
//		}
		
		model.addAttribute("moduleStatistics", moduleStatistics);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/locker.*" })
	public String locker(Model model, ModuleStatistics moduleStatistics, HttpServletRequest request) {
		model.addAttribute("statisticsList", service.getLockerStatistics(moduleStatistics));
		
		return basePath + "locker_ajax";
	}
	
	@RequestMapping(value = { "/excursions.*" })
	public String excursions(Model model, ModuleStatistics moduleStatistics, HttpServletRequest request) {
		model.addAttribute("statisticsList", service.getExcursionsStatistics(moduleStatistics));
		model.addAttribute("statisticsListMonth", service.getExcursionsStatisticsMonth(moduleStatistics));
		model.addAttribute("statisticsListYear", service.getExcursionsStatisticsYear(moduleStatistics));
		return basePath + "excursions_ajax";
	}
	
	@RequestMapping(value = { "/facility.*" })
	public String facility(Model model, ModuleStatistics moduleStatistics, HttpServletRequest request) {
		model.addAttribute("statisticsList", service.getFacilityStatistics(moduleStatistics));
		model.addAttribute("statisticsListMonth", service.getFacilityStatisticsMonth(moduleStatistics));
		model.addAttribute("statisticsListYear", service.getFacilityStatisticsYear(moduleStatistics));
		return basePath + "facility_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.GET)
	public ModuleStatisticsSearchView excelDownload(Model model, ModuleStatistics moduleStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("moduleStatistics", moduleStatistics);
		
		if ( "LOCKER".equals(moduleStatistics.getModule_type()) ) {
			model.addAttribute("statisticsList", service.getLockerStatistics(moduleStatistics));	
		}
		else if ( "EXCURSIONS".equals(moduleStatistics.getModule_type()) ) {
			model.addAttribute("statisticsList", service.getExcursionsStatistics(moduleStatistics));
			model.addAttribute("statisticsListMonth", service.getExcursionsStatisticsMonth(moduleStatistics));
			model.addAttribute("statisticsListYear", service.getExcursionsStatisticsYear(moduleStatistics));	
		}
		else if ( "FACILITY".equals(moduleStatistics.getModule_type()) ) {
			model.addAttribute("statisticsList", service.getFacilityStatistics(moduleStatistics));
			model.addAttribute("statisticsListMonth", service.getFacilityStatisticsMonth(moduleStatistics));
			model.addAttribute("statisticsListYear", service.getFacilityStatisticsYear(moduleStatistics));	
		}
		
		return new ModuleStatisticsSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.GET)
	public void csvDownload(ModuleStatistics moduleStatistics, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<ModuleStatistics> statisticsList = null;
		List<ModuleStatistics> statisticsListMonth 	= null;
        List<ModuleStatistics> statisticsListYear 	= null;
		
		if ( "LOCKER".equals(moduleStatistics.getModule_type()) ) {
			statisticsList = service.getLockerStatistics(moduleStatistics);
		}
		else if ( "EXCURSIONS".equals(moduleStatistics.getModule_type()) ) {
			statisticsList = service.getExcursionsStatistics(moduleStatistics);
			statisticsListMonth = service.getExcursionsStatisticsMonth(moduleStatistics);
			statisticsListYear = service.getExcursionsStatisticsYear(moduleStatistics);
		}
		else if ( "FACILITY".equals(moduleStatistics.getModule_type()) ) {
			statisticsList = service.getFacilityStatistics(moduleStatistics);
			statisticsListMonth = service.getFacilityStatisticsMonth(moduleStatistics);
			statisticsListYear = service.getFacilityStatisticsYear(moduleStatistics);
		}
		
		new ModuleStatisticsXlsToCsv(moduleStatistics, statisticsList, statisticsListMonth, statisticsListYear, request, response);
	}
}