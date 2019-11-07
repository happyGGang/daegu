package kr.co.whalesoft.app.cms.module.calendarStatus;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.ExcursionsService;
import kr.co.whalesoft.app.cms.module.support.SupportService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.facility.FacilityService;
import kr.go.gbelib.app.cms.module.locker.LockerService;

@Controller
@RequestMapping(value = { "/cms/calendarStatus" })
public class CalendarStatusController extends BaseController {
	
	private final String basePath = "/cms/calendarStatus/";
	
	@Autowired
	private CalendarManageService service;

	@Autowired
	private ExcursionsService excursionsService;
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private LockerService lockerService;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private FacilityService facilityService;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request, CalendarStatus calendarStatus) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			calendarStatus.setHomepage_id(getAsideHomepageId(request));
//		}
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		
		String today = sf.format(new Date());
		
		if(calendarStatus.getStart_date() == null || calendarStatus.getEnd_date() == null) {
			calendarStatus.setStart_date(today);
			calendarStatus.setEnd_date(today);
		}
		
		//dateType
		if(calendarStatus.getDate_type() != null) {
			if(calendarStatus.getDate_type().equals("DAY")) {
				model.addAttribute("calendarList", service.getCalendarStatus(calendarStatus));
				model.addAttribute("excursionsList", excursionsService.getExcursionsStatus(calendarStatus));
				model.addAttribute("supportList", supportService.getSupportStatus(calendarStatus));
				model.addAttribute("facilityList", facilityService.getFacilityStatus(calendarStatus));
				model.addAttribute("lockerList", lockerService.getLockerStatus(calendarStatus));
				model.addAttribute("boardList", boardService.getBoardStatus(calendarStatus));
				
			} else if(calendarStatus.getDate_type().equals("MONTH")) {
				model.addAttribute("calendarList", service.getCalendarMonthStatus(calendarStatus));
				model.addAttribute("excursionsList", excursionsService.getExcursionsMonthStatus(calendarStatus));
				model.addAttribute("supportList", supportService.getSupportMonthStatus(calendarStatus));
				model.addAttribute("facilityList", facilityService.getFacilityMonthStatus(calendarStatus));
				model.addAttribute("lockerList", lockerService.getLockerStatus(calendarStatus));
				model.addAttribute("boardList", boardService.getBoardMonthStatus(calendarStatus));
				
			} else if(calendarStatus.getDate_type().equals("YEAR")) {
				model.addAttribute("calendarList", service.getCalendarYearStatus(calendarStatus));
				model.addAttribute("excursionsList", excursionsService.getExcursionsYearStatus(calendarStatus));
				model.addAttribute("supportList", supportService.getSupportYearStatus(calendarStatus));
				model.addAttribute("facilityList", facilityService.getFacilityYearStatus(calendarStatus));
				model.addAttribute("lockerList", lockerService.getLockerStatus(calendarStatus));
				model.addAttribute("boardList", boardService.getBoardYearStatus(calendarStatus));
				
			} else {
				model.addAttribute("calendarList", service.getCalendarStatus(calendarStatus));
				model.addAttribute("excursionsList", excursionsService.getExcursionsStatus(calendarStatus));
				model.addAttribute("supportList", supportService.getSupportStatus(calendarStatus));
				model.addAttribute("facilityList", facilityService.getFacilityStatus(calendarStatus));
				model.addAttribute("lockerList", lockerService.getLockerStatus(calendarStatus));
				model.addAttribute("boardList", boardService.getBoardStatus(calendarStatus));
			}
		}
		
		model.addAttribute("calendarStatus", calendarStatus);		
		model.addAttribute("member", getSessionMemberInfo(request));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public CalendarStatusView excelDownload(Model model, CalendarStatus calendarStatus, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Homepage homepage = homepageService.getHomepageOne(new Homepage(calendarStatus.getHomepage_id()));
		model.addAttribute("homepage", homepage);
		model.addAttribute("calendarStatus", calendarStatus);
		if(calendarStatus.getDate_type() != null) {
			if(calendarStatus.getDate_type().equals("DAY")) {
				List<CalendarManage> calendarList = service.getCalendarStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else if(calendarStatus.getDate_type().equals("MONTH")) {
				List<CalendarManage> calendarList = service.getCalendarMonthStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsMonthStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportMonthStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityMonthStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardMonthStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else if(calendarStatus.getDate_type().equals("YEAR")) {
				
				List<CalendarManage> calendarList = service.getCalendarYearStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsYearStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportYearStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityYearStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardYearStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else {
				List<CalendarManage> calendarList = service.getCalendarStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
			}
		}
		
		return new CalendarStatusView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, CalendarStatus calendarStatus, HttpServletRequest request, HttpServletResponse response) throws Exception{
		Homepage homepage = homepageService.getHomepageOne(new Homepage(calendarStatus.getHomepage_id()));
		model.addAttribute("homepage", homepage);
		model.addAttribute("calendarStatus", calendarStatus);
		
		List<CalendarManage> calendarList = null;
		List<CalendarStatus> excursionsList = null;
		List<CalendarStatus> supportList = null;
		List<CalendarStatus> facilityList = null;
		List<CalendarStatus> lockerList = null;
		List<CalendarStatus> boardList = null;
		
		if(calendarStatus.getDate_type() != null) {
			if(calendarStatus.getDate_type().equals("DAY")) {
				calendarList = service.getCalendarStatus(calendarStatus);
				excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				supportList = supportService.getSupportStatus(calendarStatus);
				facilityList = facilityService.getFacilityStatus(calendarStatus);
				lockerList = lockerService.getLockerStatus(calendarStatus);
				boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
//					return null;
				}
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else if(calendarStatus.getDate_type().equals("MONTH")) {
				calendarList = service.getCalendarMonthStatus(calendarStatus);
				excursionsList = excursionsService.getExcursionsMonthStatus(calendarStatus);
				supportList = supportService.getSupportMonthStatus(calendarStatus);
				facilityList = facilityService.getFacilityMonthStatus(calendarStatus);
				lockerList = lockerService.getLockerStatus(calendarStatus);
				boardList = boardService.getBoardMonthStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
//					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else if(calendarStatus.getDate_type().equals("YEAR")) {
				
				calendarList = service.getCalendarYearStatus(calendarStatus);
				excursionsList = excursionsService.getExcursionsYearStatus(calendarStatus);
				supportList = supportService.getSupportYearStatus(calendarStatus);
				facilityList = facilityService.getFacilityYearStatus(calendarStatus);
				lockerList = lockerService.getLockerStatus(calendarStatus);
				boardList = boardService.getBoardYearStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
//					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
				
			} else {
				calendarList = service.getCalendarStatus(calendarStatus);
				excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				supportList = supportService.getSupportStatus(calendarStatus);
				facilityList = facilityService.getFacilityStatus(calendarStatus);
				lockerList = lockerService.getLockerStatus(calendarStatus);
				boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					service.alertMessage("조회된 결과가 없습니다.", request, response);
//					return null;
				}
				
				model.addAttribute("calendarList", calendarList);
				model.addAttribute("excursionsList", excursionsList);
				model.addAttribute("supportList", supportList);
				model.addAttribute("facilityList", facilityList);
				model.addAttribute("lockerList", lockerList);
				model.addAttribute("boardList", boardList);
			}
		}
		
		new CalendarStatusXlsToCsv(homepage, calendarStatus, calendarList, excursionsList, supportList, facilityList, lockerList, boardList, request, response);
	}
	
	@RequestMapping(value = {"/excelDownloadTest.*"}, method = RequestMethod.GET)
	public @ResponseBody JsonResponse excelDownloadTest(Model model, CalendarStatus calendarStatus, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		JsonResponse res = new JsonResponse();
		
		Homepage homepage = homepageService.getHomepageOne(new Homepage(calendarStatus.getHomepage_id()));
		model.addAttribute("homepage", homepage);
		model.addAttribute("calendarStatus", calendarStatus);
		if(calendarStatus.getDate_type() != null) {
			if(calendarStatus.getDate_type().equals("DAY")) {
				List<CalendarManage> calendarList = service.getCalendarStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					res.setValid(false);
					res.setMessage("조회된 결과가 없습니다");
					return res;
				}
				
			} else if(calendarStatus.getDate_type().equals("MONTH")) {
				List<CalendarManage> calendarList = service.getCalendarMonthStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsMonthStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportMonthStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityMonthStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardMonthStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					res.setValid(false);
					res.setMessage("조회된 결과가 없습니다");
					return res;
				}
				
				
			} else if(calendarStatus.getDate_type().equals("YEAR")) {
				
				List<CalendarManage> calendarList = service.getCalendarYearStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsYearStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportYearStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityYearStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardYearStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					res.setValid(false);
					res.setMessage("조회된 결과가 없습니다");
					return res;
				}
				
				
			} else {
				List<CalendarManage> calendarList = service.getCalendarStatus(calendarStatus);
				List<CalendarStatus> excursionsList = excursionsService.getExcursionsStatus(calendarStatus);
				List<CalendarStatus> supportList = supportService.getSupportStatus(calendarStatus);
				List<CalendarStatus> facilityList = facilityService.getFacilityStatus(calendarStatus);
				List<CalendarStatus> lockerList = lockerService.getLockerStatus(calendarStatus);
				List<CalendarStatus> boardList = boardService.getBoardStatus(calendarStatus);
				
				int calendarListSize = calendarList == null ? 0 : calendarList.size();
				int excursionsListSize = excursionsList == null ? 0 : excursionsList.size();
				int supportListSize = supportList == null ? 0 : supportList.size();
				int facilityListSize = facilityList == null ? 0 : facilityList.size();
				int lockerListSize = lockerList == null ? 0 : lockerList.size();
				int boardListSize = boardList == null ? 0 : boardList.size();
				
				if (calendarListSize+excursionsListSize+supportListSize+facilityListSize+lockerListSize+boardListSize == 0) {
					res.setValid(false);
					res.setMessage("조회된 결과가 없습니다");
					return res;
				}
				
			}
			
			res.setValid(true);
		}
		return res;
	}

}
