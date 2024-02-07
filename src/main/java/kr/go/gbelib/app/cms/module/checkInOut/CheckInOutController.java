package kr.go.gbelib.app.cms.module.checkInOut;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

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
	
	@RequestMapping (value = {"/indexAll.*"})
	public String indexAll(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		if (StringUtils.isEmpty(checkInOut.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			cal.add(Calendar.MONTH, -1);
			cal.set(Calendar.DAY_OF_MONTH, 1);
			
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(now);
			cal2.add(Calendar.MONTH, -1);
			cal2.set(Calendar.DAY_OF_MONTH, cal2.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			checkInOut.setStart_date(startDateFormat.format(cal.getTime()));
			checkInOut.setEnd_date(endDateFormat.format(cal2.getTime()));
		}
	
		Map<String, Integer> allUsers = new HashMap<String, Integer>();
		Map<String, Integer> allUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserAllList = service.getCheckInUserAll(checkInOut);
		for(CheckInOut cio : checkInUserAllList) {
			allUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserAllList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				allUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		Map<String, Integer> distinctUsers = new HashMap<String, Integer>();
		Map<String, Integer> distinctUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserdistinctList = service.getCheckInUserDistinct(checkInOut);
		for(CheckInOut cio : checkInUserdistinctList) {
			distinctUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserdistinctList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				distinctUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		Map<String, Integer> bringInUsers = new HashMap<String, Integer>();
		Map<String, Integer> bringInUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserbringInList = service.getCheckInUserBringIn(checkInOut);
		for(CheckInOut cio : checkInUserbringInList) {
			bringInUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserbringInList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				bringInUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		//전체
		model.addAttribute("allUsers", allUsers);
		model.addAttribute("allUsageHours", allUsageHours);
		//순이용자수
		model.addAttribute("distinctUsers", distinctUsers);
		model.addAttribute("distinctUsageHours", distinctUsageHours);
		//신규이용자수
		model.addAttribute("bringInUsers", bringInUsers);
		model.addAttribute("bringInUsageHours", bringInUsageHours);
		
		model.addAttribute("checkInOut", checkInOut);
		
		return basePath + "indexAll";
	}
	
	@RequestMapping (value = {"/indexAllExcel.*"})
	public String indexAllExcel(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		if (StringUtils.isEmpty(checkInOut.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			cal.add(Calendar.MONTH, -1);
			cal.set(Calendar.DAY_OF_MONTH, 1);
			
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(now);
			cal2.add(Calendar.MONTH, -1);
			cal2.set(Calendar.DAY_OF_MONTH, cal2.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			checkInOut.setStart_date(startDateFormat.format(cal.getTime()));
			checkInOut.setEnd_date(endDateFormat.format(cal2.getTime()));
		}
	
		Map<String, Integer> allUsers = new HashMap<String, Integer>();
		Map<String, Integer> allUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserAllList = service.getCheckInUserAll(checkInOut);
		for(CheckInOut cio : checkInUserAllList) {
			allUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserAllList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				allUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		Map<String, Integer> distinctUsers = new HashMap<String, Integer>();
		Map<String, Integer> distinctUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserdistinctList = service.getCheckInUserDistinct(checkInOut);
		for(CheckInOut cio : checkInUserdistinctList) {
			distinctUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserdistinctList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				distinctUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		Map<String, Integer> bringInUsers = new HashMap<String, Integer>();
		Map<String, Integer> bringInUsageHours = new HashMap<String, Integer>();
		
		List<CheckInOut> checkInUserbringInList = service.getCheckInUserBringIn(checkInOut);
		for(CheckInOut cio : checkInUserbringInList) {
			bringInUsers.put(cio.getCheckIn_time() + "." + cio.getMember_birth() + "." + cio.getMember_sex(), cio.getCnt());
		}
		
		for(CheckInOut cio : checkInUserbringInList) {
			if(StringUtils.isNotEmpty(cio.getCheckInOut_time())){
				bringInUsageHours.put(cio.getCheckIn_time() + "_" + cio.getMember_birth() + "_" + cio.getMember_sex(), Integer.parseInt(cio.getCheckInOut_time()));
			}
		}
		
		//전체
		model.addAttribute("allUsers", allUsers);
		model.addAttribute("allUsageHours", allUsageHours);
		//순이용자수
		model.addAttribute("distinctUsers", distinctUsers);
		model.addAttribute("distinctUsageHours", distinctUsageHours);
		//신규이용자수
		model.addAttribute("bringInUsers", bringInUsers);
		model.addAttribute("bringInUsageHours", bringInUsageHours);
		
		model.addAttribute("checkInOut", checkInOut);
		
		return basePath + "indexAllExcel_ajax";
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
	
	@RequestMapping (value = {"/usageRanking.*"})
	public String usageRanking(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
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
		model.addAttribute("usageRankingList", service.getUsageRankingList(checkInOut));
		
		return basePath + "usageRanking";
	}
	
	@RequestMapping (value = {"/hoursOfUse.*"})
	public String hoursOfUse(Model model, CheckInOut checkInOut, HttpServletRequest request) throws AuthException {
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
		model.addAttribute("hoursOfUseList", service.getHoursOfUse(checkInOut));
		model.addAttribute("total_count", service.getHoursOfUseCount(checkInOut));
		
		return basePath + "hoursOfUse";
	}
	
	@RequestMapping (value = {"/checkOutAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse checkOutAll(CheckInOut checkInOut, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
				service.checkOutAll(checkInOut);
				res.setValid(true);
				res.setMessage("체크아웃처리 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("체크아웃처리에 실패하였습니다.");
				res.setResult(result.getAllErrors());
			}
		
		return res;
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
	
	@RequestMapping (value = {"/usageExcelDownload.*"}, method = RequestMethod.POST)
	public UsageExcelView usageExcelDownload(Model model, CheckInOut checkInOut, HttpServletRequest request) {
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("checkInOut", checkInOut);
		model.addAttribute("checkInOutExcelList", service.getUsageExcelList(checkInOut));
		
		return new UsageExcelView();
	}
	
	@RequestMapping (value = {"/usageCsvDownload.*"}, method = RequestMethod.POST)
	public UsageExcelToCsv usageCsvDownload(Model model, CheckInOut checkInOut, HttpServletRequest request, HttpServletResponse response){
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		List<CheckInOut> cscList = service.getUsageExcelList(checkInOut);
		
		return new UsageExcelToCsv(checkInOut, cscList, request, response);
	}
	@RequestMapping (value = {"/hourOfUseExcelDownload.*"}, method = RequestMethod.POST)
	public HourOfUseExcelView hourOfUseExcelDownload(Model model, CheckInOut checkInOut, HttpServletRequest request) {
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("checkInOut", checkInOut);
		model.addAttribute("checkInOutExcelList", service.getHourOfUseExcelList(checkInOut));
		
		return new HourOfUseExcelView();
	}
	
	@RequestMapping (value = {"/hourOfUseCsvDownload.*"}, method = RequestMethod.POST)
	public HourOfUseExcelToCsv hourOfUseCsvDownload(Model model, CheckInOut checkInOut, HttpServletRequest request, HttpServletResponse response){
		checkInOut.setHomepage_id(getAsideHomepageId(request));
		
		List<CheckInOut> cscList = service.getHourOfUseExcelList(checkInOut);
		
		return new HourOfUseExcelToCsv(checkInOut, cscList, request, response);
	}
	
}
