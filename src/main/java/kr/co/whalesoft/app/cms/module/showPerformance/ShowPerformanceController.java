package kr.co.whalesoft.app.cms.module.showPerformance;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/showPerformance"})
public class ShowPerformanceController extends BaseController {

	private final String basePath = "/cms/module/showPerformance/";
	
	@Autowired
	private ShowPerformanceService service;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CalendarManageService calendarManageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ShowPerformance showPerformance, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(showPerformance.getHomepage_id())) {
				showPerformance.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			showPerformance.setHomepage_id(getAsideHomepageId(request));
		}

		if(showPerformance.getPlan_date() == null || showPerformance.getPlan_date().equals("")) {
			showPerformance.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		model.addAttribute("calendarList", service.getCalendar(showPerformance));
		model.addAttribute("showPerformance", showPerformance);
		model.addAttribute("showPerformanceList", service.getShowPerformance(showPerformance));
		model.addAttribute("monthList", codeService.getCode(showPerformance.getHomepage_id(), "C0004"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ShowPerformance showPerformance, HttpServletRequest request) throws AuthException {
		if(showPerformance.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("editMode", showPerformance.getEditMode());
			model.addAttribute("showPerformance", service.copyObjectPaging(showPerformance, service.getTimeShowPerformanceOne(showPerformance)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("editMode", showPerformance.getEditMode());
			model.addAttribute("showPerformance", showPerformance);
		}
			model.addAttribute("dateTypeList", codeService.getCode(getAsideHomepageId(request), "S0001"));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(ShowPerformance showPerformance, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(showPerformance.getEditMode().equals("ADD") || showPerformance.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "공연일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "start_time", "공연가능시작시간을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_time", "공연가능종료시간을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "공연일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_date", "신청시작일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_time", "신청시작시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_date", "신청종료일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_time", "신청종료시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "max_apply", "최대신청팀수를 입력하세요.");
			
			SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
			sfTime.setLenient(false);
			try {
				sfTime.parse(showPerformance.getApply_start_time());
				sfTime.parse(showPerformance.getApply_end_time());
				if(!showPerformance.getHomepage_id().equals("h50")) {
					sfTime.parse(showPerformance.getStart_time());
					sfTime.parse(showPerformance.getEnd_time());
				}
			} catch (Exception e) {
				result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			}
		} else if (showPerformance.getEditMode().equals("BATCHDELETE")) {
			ValidationUtils.rejectIfEmpty(result, "showPerformance_idx_arr", "공연일자를 선택하세요.");
		}
		
		if(!result.hasErrors()) {
			if(showPerformance.getEditMode().equals("ADD")) {
				showPerformance.setAdd_id(getSessionMemberId(request));
				String weekday 		= showPerformance.getWeekday(); // 매주 요일 입력값들
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate 		= sf.parse(showPerformance.getStart_date());
				Date endDate 		= sf.parse(showPerformance.getEnd_date());
				
				Calendar c = Calendar.getInstance(); //시작 날짜와 종료 날짜 가 같을때까지 반복한다.
				int addCount = 0;				
				
				CalendarManage calendarManage = new CalendarManage();
				calendarManage.setHomepage_id(request.getParameter("homepage_id"));				
				List<CalendarManage> cm = calendarManageService.getClosedDate5(calendarManage);
				for(int i = 0; i < cm.size(); i++) {
					if(showPerformance.getStart_date().equals(cm.get(i).getStart_date()) || showPerformance.getEnd_date().equals(cm.get(i).getStart_date())) {
						res.setValid(true);
						res.setMessage("휴관일은 대관등록을 할 수 없습니다.");
						return res;
					}
				}
			
				
				
				while( !startDate.after(endDate) ) {
					c.setTime(startDate);
					showPerformance.setStart_date(sf.format(startDate));
					showPerformance.setEnd_date(sf.format(startDate));
					if( StringUtils.isNotEmpty(showPerformance.getWeekday()) && !showPerformance.getWeekday().equals("")) {
						if ( weekday.indexOf(String.valueOf(c.get(Calendar.DAY_OF_WEEK))) > -1 ) {
							if ( service.countShowPerformance(showPerformance) > 0 ) {
								res.setValid(true);
								res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
								return res;
							} 
							else {
								addCount ++;
								service.addShowPerformance(showPerformance);
							}
						}
					}
					else {
						if ( service.countShowPerformance(showPerformance) > 0 ) {
							res.setValid(true);
							res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
							return res;
						} 
						else {
							addCount ++;
							service.addShowPerformance(showPerformance);
						}
					}
					startDate = DateUtils.addDays(startDate, 1);	
				}
				
				res.setValid(true);
				res.setMessage(String.format("'%s건' 등록 되었습니다.", addCount));
					
			} else if(showPerformance.getEditMode().equals("MODIFY")) {
				showPerformance.setModify_id(getSessionMemberId(request));
				service.modifyCalendarManage(showPerformance);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(showPerformance.getEditMode().equals("DELETE")) {
				service.deleteShowPerformance(showPerformance);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if(showPerformance.getEditMode().equals("BATCHDELETE")) {
				service.deleteShowPerformanceBatch(showPerformance);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
