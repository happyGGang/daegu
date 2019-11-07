package kr.co.whalesoft.app.cms.snsStatistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/snsStatistics" })
public class SnsStatisticsController extends BaseController {

	private final String basePath = "/cms/snsStatistics/";
	
	@Autowired
	private SnsStatisticsService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, SnsStatistics snsStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
		if(StringUtils.isEmpty(snsStatistics.getHomepage_id())) {
			snsStatistics.setHomepage_id(getAsideHomepageId(request));
		}
//		}
		if ( StringUtils.isEmpty(snsStatistics.getEndDate()) ) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyyMM");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyyMMdd");
			Date now = new Date();
			snsStatistics.setStartDate(startDateFormat.format(now) + "01");
			snsStatistics.setEndDate(endDateFormat.format(now));
		}
		if ( snsStatistics.getHomepage_id() != null ) {
			model.addAttribute("snsStatistics", snsStatistics);
			model.addAttribute("statisticsList", service.getSnsStatistics(snsStatistics));	
		}
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"})
	public SnsStatisticsSearchView excelDownload(Model model, SnsStatistics snsStatistics, HttpServletRequest request){
		model.addAttribute("snsStatistics", snsStatistics);
		model.addAttribute("statisticsList", service.getSnsStatistics(snsStatistics));
		
		return new SnsStatisticsSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"})
	public void csvDownload(SnsStatistics snsStatistics, HttpServletRequest request, HttpServletResponse response){
		List<SnsStatistics> statisticsList = service.getSnsStatistics(snsStatistics);
		
		new SnsStatisticsXlsToCsv(snsStatistics, statisticsList, request, response);
	}
	
}