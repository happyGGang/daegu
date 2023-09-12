package kr.go.gbelib.app.cms.module.checkInOut;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value={"/cms/module/checkInOut"})
public class CheckInOutController extends BaseController {

private final String basePath = "/cms/module/checkInOut/";
	
	@Autowired
	private CheckInOutService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		if (StringUtils.isEmpty(checkInOut.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			checkInOut.setStart_date(startDateFormat.format(now));
			checkInOut.setEnd_date(endDateFormat.format(now));
		}
		
		service.setPaging(model, service.getCheckInOutCount(checkInOut), checkInOut);
		
		model.addAttribute("checkInOut", checkInOut);
		model.addAttribute("checkInOutList", service.getCheckInOutList(checkInOut));
		
		model.addAttribute("checkInCount", service.getCheckInCount(checkInOut));
		model.addAttribute("checkOutCount", service.getCheckOutCount(checkInOut));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/chartIndex.*"})
	public String chartIndex(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		if (StringUtils.isEmpty(checkInOut.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			checkInOut.setStart_date(startDateFormat.format(now));
			checkInOut.setEnd_date(endDateFormat.format(now));
		}
		
		model.addAttribute("checkInOut", checkInOut);
		
		return basePath + "chartIndex";
	}
	
	@RequestMapping (value = {"/getChartData.*"}, method = RequestMethod.POST)
	@ResponseBody
	public String getChartData(Model model, CheckInOut checkInOut, HttpServletRequest request) {
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		
		if (StringUtils.isEmpty(checkInOut.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			checkInOut.setStart_date(startDateFormat.format(now));
			checkInOut.setEnd_date(endDateFormat.format(now));
		}
		
		return gson.toJson(service.getChartData(checkInOut));
	}
	
	@RequestMapping (value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public CheckInOutExcelView excelDownload(Model model, CheckInOut checkInOut, HttpServletRequest request) {
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("checkInOut", checkInOut);
		model.addAttribute("checkInOutExcelList", service.getCheckInOutExcelList(checkInOut));
		
		return new CheckInOutExcelView();
	}
	
	@RequestMapping (value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public CheckInOutExcelToCsv csvDownload(Model model, CheckInOut checkInOut, HttpServletRequest request, HttpServletResponse response){
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		List<CheckInOut> cscList = service.getCheckInOutExcelList(checkInOut);
		
		return new CheckInOutExcelToCsv(checkInOut, cscList, request, response);
	}
	
}
