package kr.co.whalesoft.app.cms.archiveStatistics;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = {"/cms/archiveStatistics"})
public class ArchiveStatisticsController extends BaseController {
	
	private final String basePath = "/cms/archiveStatistics/";
	
	@Autowired
	private ArchiveStatisticsService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ArchiveStatistics archiveStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		archiveStatistics.setHomepage_id(getAsideHomepageId(request));
		
		if(StringUtils.isEmpty(archiveStatistics.getSearch_date())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			archiveStatistics.setSearch_date(sdf.format(new Date()));
		}
		
		model.addAttribute("archiveStatistics", archiveStatistics);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/accessTable.*"})
	public String accessTable(Model model, ArchiveStatistics archiveStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("archiveStatistics", archiveStatistics);
		model.addAttribute("statisticsList", service.getArchiveStatistics(archiveStatistics));
		model.addAttribute("total_count", service.getStatisticsTotalCount(archiveStatistics));
		return basePath + "accessTable_ajax";
	}

}
