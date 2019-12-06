package kr.co.whalesoft.app.cms.module.calendarManage;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.board.Board;
import kr.co.whalesoft.app.board.BoardService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;
import kr.go.gbelib.app.cms.module.teach.TeachService;

@Controller
@RequestMapping(value = { "/cms/module/calendarManage" })
public class CalendarManageController extends BaseController {

	private final String basePath = "/cms/module/calendarManage/";

	@Autowired
	private CalendarManageService service;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private TeachService teachService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private FacilityReqService facilityReqService;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping(value = { "/index{url}.*" })
	public String index(Model model, CalendarManage calendarManage,HttpServletRequest request, @PathVariable("url") String url ) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			calendarManage.setHomepage_id(getAsideHomepageId(request));
//		}

		if (calendarManage.getPlan_date() == null || calendarManage.getPlan_date().equals("")) {
			calendarManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		if (StringUtils.isNotEmpty(calendarManage.getPlan_date()) && calendarManage.getPlan_date().toLowerCase().contains("nan")) {
			calendarManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		Board board = new Board();
		board.setHomepage_id(calendarManage.getHomepage_id());
		board.setImsi_v_1(calendarManage.getPlan_date());
		
		//TODO 게시판 완료시 null 삭제
//		model.addAttribute("moveList", boardService.getBoardMovie(board));
		model.addAttribute("moveList", null);

		model.addAttribute("calendarList", service.getCalendar(calendarManage));
		model.addAttribute("calendarListType", service.getCalendarListType(calendarManage));
		model.addAttribute("calendarManage", calendarManage);
		model.addAttribute("calendarManageList",service.getCalendarManage(calendarManage));
//		model.addAttribute("okApplyList",applyService.getOkApply(calendarManage));
//		model.addAttribute("teachList",teachService.getTeachListForCalendar(calendarManage));
//		model.addAttribute("facilityReqList",facilityReqService.getFacilityReqCalendar(calendarManage));
		//TODO 강좌완료시 null 삭재
		model.addAttribute("okApplyList", new ArrayList<Apply>());
		model.addAttribute("teachList", null);
		model.addAttribute("facilityReqList", null);
		model.addAttribute("url", url);
		return basePath + "index" + url;
	}

	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, CalendarManage calendarManage, HttpServletRequest request) throws AuthException {

		if (calendarManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			CalendarManage one = service.getCalendarManageOne(calendarManage);
			CalendarManage one2 = service.getCalendarManageOne2(one);
			model.addAttribute("calendarManage",service.copyObjectPaging(calendarManage,one));
			model.addAttribute("calendarManage2",one2);
		} else {
			checkAuth("C", model, request);
			model.addAttribute("calendarManage", calendarManage);
		}
		
		model.addAttribute("weekdayList", service.getDefaultWeekDay());

		model.addAttribute("dateTypeList",codeService.getCode(calendarManage.getHomepage_id(), "C0006"));
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody
	JsonResponse save(CalendarManage calendarManage, BindingResult result,HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);

		if (calendarManage.getEditMode().equals("ADD") || calendarManage.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "start_date","일정의 시작일자 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "일정의 종료일자 입력하세요.");
		}

		if (!result.hasErrors()) {
			if (calendarManage.getEditMode().equals("ADD")) {
				
				String startDate = calendarManage.getStart_date();
				String endDate = calendarManage.getEnd_date();
				
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date startDay = dateFormat.parse(startDate);
				Date endDay = dateFormat.parse(endDate);
				
				Calendar start = Calendar.getInstance();
				Calendar end = Calendar.getInstance();
				
				start.setTime(startDay);
				end.setTime(endDay);
				
				if (calendarManage.getWeekdayArr() == null || StringUtils.equals(calendarManage.getWeekdayArr().get(0), "0")) {
					calendarManage.setWeekday("1,2,3,4,5,6,7");
				} else {
					calendarManage.setWeekday(StringUtils.join(calendarManage.getWeekdayArr(), ","));
				}
				
				String[] weekday = calendarManage.getWeekday().split(",");
				
				int nextIdx = service.getNextCmIdx(calendarManage);
				calendarManage.setGroup_idx(nextIdx);
				
				while( start.compareTo( end ) !=1 ){
					for(int i = 0; i < weekday.length; i++) {
						int day = getDateDay(start, "yyyy-MM-dd");
						
						if(Integer.parseInt(weekday[i]) == day) {
							
							calendarManage.setStart_date(dateFormat.format(start.getTime()));
							calendarManage.setEnd_date(dateFormat.format(start.getTime()));
							
							service.addCalendarManage(calendarManage);
						}
					}
					start.add(Calendar.DATE, 1);
				}
					
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (calendarManage.getEditMode().equals("MODIFY")) {
				service.modifyCalendarManage(calendarManage);				
				
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (calendarManage.getEditMode().equals("DELETE")) {
				calendarManage.setIndividual_yn2(calendarManage.getIndividual_yn());
				if (StringUtils.equals(calendarManage.getIndividual_yn(), "E")) {
					calendarManage.setIndividual_yn("N");	
				}
				if (calendarManage.getIndividual_yn().equals("Y")) {
					service.deleteCalendarManage(calendarManage);
				} else {
					service.deleteCalendarManageGroup(calendarManage);
				}
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/getIlusHolidays.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveIlusHolidays(CalendarManage calendarManage, Homepage homepage, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			homepage = homepageService.getHomepageOne(homepage);
			int resultRow = service.addCalendarManageFromILUS(calendarManage, homepage);
			res.setValid(true);
			res.setMessage(resultRow+"건 등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	public int getDateDay(Calendar date, String dateType) throws Exception {
//	    String day = "" ;
	     
	    int dayNum = date.get(Calendar.DAY_OF_WEEK) ;
	     
//	    switch(dayNum){
//	        case 1:
//	            day = "일";
//	            break ;
//	        case 2:
//	            day = "월";
//	            break ;
//	        case 3:
//	            day = "화";
//	            break ;
//	        case 4:
//	            day = "수";
//	            break ;
//	        case 5:
//	            day = "목";
//	            break ;
//	        case 6:
//	            day = "금";
//	            break ;
//	        case 7:
//	            day = "토";
//	            break ;
//	    }
	    return dayNum ;
	}

}
