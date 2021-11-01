package kr.go.gbelib.app.cms.module.untactBook.statistics;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value="/cms/module/untactBook/statistics")
public class UntactBookStatisticsController extends BaseController {
	                                                          
	private final String basepath = "/cms/module/untactBook/statistics/";
	
	@Autowired
	private UntactBookStatisticsService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookStatistics untactBookStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(StringUtils.isEmpty(untactBookStatistics.getSearch_date())) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			untactBookStatistics.setSearch_date(sdf.format(new Date()));
		}
		
		model.addAttribute("untactBookStatistics", untactBookStatistics);
		
		return basepath + "index";
	}
	
	@RequestMapping(value = {"/accessTable.*"})
	public String accessTable(Model model, UntactBookStatistics untactBookStatistics, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("untactBookStatistics", untactBookStatistics);
		model.addAttribute("untactBookStatisticsList", service.getArchiveStatistics(untactBookStatistics));
		model.addAttribute("total_count", service.getStatisticsTotalCount(untactBookStatistics));
		return basepath + "accessTable_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookStatisticsSearchView excelDownload(Model model, UntactBookStatistics untactBookStatistics, HttpServletRequest request){
		model.addAttribute("untactBookStatistics", untactBookStatistics);
		//시간엑셀
		model.addAttribute("untactBookStatisticsList", service.getArchiveStatistics(untactBookStatistics));
//		if() {
//			
//		}
		
		return new UntactBookStatisticsSearchView();
	}
	
}
