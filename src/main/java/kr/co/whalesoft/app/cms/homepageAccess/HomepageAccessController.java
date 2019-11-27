package kr.co.whalesoft.app.cms.homepageAccess;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/homepageAccess" })
public class HomepageAccessController extends BaseController {
	private final String basePath = "/cms/homepageAccess/";

	@Autowired
	private HomepageAccessService homepageAccessService;

	private static final DateTimeFormatter DTF = DateTimeFormat.forPattern("yyyy-MM-dd");

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		String today = DTF.print(new DateTime());
		HomepageAccess homepageAccess = new HomepageAccess();
		homepageAccess.setStart_date(today);
		homepageAccess.setEnd_date(today);
		model.addAttribute("homepageAccess", homepageAccess);
		return basePath + "index";
	}

	@RequestMapping(value = { "/index_old.*" })
	public String index_old(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		HomepageAccess homepageAccess = new HomepageAccess();
		Calendar c = Calendar.getInstance();
		String today = sf.format(c.getTime());
		homepageAccess.setStart_date(today);
		homepageAccess.setEnd_date(today);
		homepageAccess.setEnd_date(today);
		model.addAttribute("homepageAccess", homepageAccess);
		return basePath + "indexOld";
	}

	@RequestMapping(value = { "/accessGraph.*" })
	public String getHomepageAccessDataByChart(Model model, HomepageAccess homepageAccess) {
		model.addAttribute("homepageAccessResult", homepageAccessService.getHomepageStatisticsResult(homepageAccess));
		model.addAttribute("homepageAccess", homepageAccess);
		
		return basePath + "accessGraph_ajax";
	}

	@RequestMapping(value = { "/accessTable.*" })
	public String getHomepageAccessDataByTable(Model model, HomepageAccess homepageAccess) {
		model.addAttribute("homepageAccess", homepageAccess);
		model.addAttribute("homepageAccessResult", homepageAccessService.getHomepageStatisticsResult(homepageAccess));
		return basePath + "accessTable_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public HomepageAccessSearchView excelDownload(Model model, HomepageAccess homepageAccess, HttpServletRequest request){
		model.addAttribute("homepageAccess", homepageAccess);
		model.addAttribute("homepageAccessList", homepageAccessService.getHomepageStatisticsResult(homepageAccess));

		return new HomepageAccessSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, HomepageAccess homepageAccess, HttpServletRequest request, HttpServletResponse response){
		List<HomepageAccess> homepageAccessList = homepageAccessService.getHomepageStatisticsResult(homepageAccess);

		new HomepageAccessXlsToCsv(homepageAccess, homepageAccessList, request, response);
	}

	//2019 신규 통계기능 추가
	@RequestMapping(value = { "/index_new.*" })
	public String indexnew(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		HomepageAccess homepageAccess = new HomepageAccess();
		Calendar c = Calendar.getInstance();
		String today = sf.format(c.getTime());
		homepageAccess.setStart_date(today);
		homepageAccess.setEnd_date(today);
		homepageAccess.setSearch_year(today.substring(0, 4));
		model.addAttribute("homepageAccess", homepageAccess);
		return basePath + "index_new";
	}
	
	@RequestMapping(value = { "/index_view.*" })
	public String indexview(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		HomepageAccess homepageAccess = new HomepageAccess();
		Calendar c = Calendar.getInstance();
		String today = sf.format(c.getTime());
		homepageAccess.setStart_date(today);
		homepageAccess.setEnd_date(today);
		homepageAccess.setSearch_year(today.substring(0, 4));
		model.addAttribute("homepageAccess", homepageAccess);
		return basePath + "index_view";
	}

	@RequestMapping (value = {"/getChartData.*"}, method = RequestMethod.POST)
	@ResponseBody
	public String getChartData(Model model, HomepageAccess homepageAccess, HttpServletRequest request) {

		Gson gson = new GsonBuilder().setPrettyPrinting().create();

		return gson.toJson(homepageAccessService.getChartData(homepageAccess));

	}

	@RequestMapping (value = {"/getChartViewData.*"}, method = RequestMethod.POST)
	@ResponseBody
	public String getChartViewData(Model model, HomepageAccess homepageAccess, HttpServletRequest request) {

		Gson gson = new GsonBuilder().setPrettyPrinting().create();

		return gson.toJson(homepageAccessService.getChartViewData(homepageAccess));

	}


	@RequestMapping(value = {"/excelDownload2019.*"}, method = RequestMethod.POST)
	public HomepageAccessSearchView2019 excelDownload2019(Model model, HomepageAccess homepageAccess, HttpServletRequest request){
		model.addAttribute("homepageAccess", homepageAccess);
		model.addAttribute("homepageAccessList", homepageAccessService.getChartDivData(homepageAccess));

		return new HomepageAccessSearchView2019();
	}


	@RequestMapping(value = {"/csvDownload2019.*"}, method = RequestMethod.POST)
	public void csvDownload2019(Model model, HomepageAccess homepageAccess, HttpServletRequest request, HttpServletResponse response){
		List<HomepageAccess> homepageAccessList = homepageAccessService.getChartDivData(homepageAccess);

		new HomepageAccessXlsToCsv(homepageAccess, homepageAccessList, 2019, request, response);
	}


	@RequestMapping(value = {"/excelViewDownload2019.*"}, method = RequestMethod.POST)
	public HomepageAccessSearchView2019 excelViewDownload2019(Model model, HomepageAccess homepageAccess, HttpServletRequest request){
		model.addAttribute("homepageAccess", homepageAccess);
		model.addAttribute("homepageAccessList", homepageAccessService.getChartViewDivData(homepageAccess));

		return new HomepageAccessSearchView2019();
	}


	@RequestMapping(value = {"/csvViewDownload2019.*"}, method = RequestMethod.POST)
	public void csvViewDownload2019(Model model, HomepageAccess homepageAccess, HttpServletRequest request, HttpServletResponse response){
		List<HomepageAccess> homepageAccessList = homepageAccessService.getChartViewDivData(homepageAccess);

		new HomepageAccessXlsToCsv(homepageAccess, homepageAccessList, 2019, request, response);
	}
}
