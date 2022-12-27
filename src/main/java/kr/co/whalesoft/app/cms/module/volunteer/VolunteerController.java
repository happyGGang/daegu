package kr.co.whalesoft.app.cms.module.volunteer;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.volunteer.Volunteer;
import kr.co.whalesoft.app.cms.module.volunteer.VolunteerService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/cms/module/volunteer"})
public class VolunteerController extends BaseController {

	private final String basePath = "/cms/module/volunteer/";
	
	@Autowired
	private VolunteerService service;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CalendarManageService calendarManageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Volunteer volunteer, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		volunteer.setHomepage_id(getAsideHomepageId(request));

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(volunteer.getHomepage_id())) {
				volunteer.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			volunteer.setHomepage_id(getAsideHomepageId(request));
		}

		if(volunteer.getPlan_date() == null || volunteer.getPlan_date().equals("")) {
			volunteer.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		model.addAttribute("calendarList", service.getCalendar(volunteer));
		model.addAttribute("volunteer", volunteer);
		model.addAttribute("volunteerList", service.getVolunteer(volunteer));
		model.addAttribute("monthList", codeService.getCode(volunteer.getHomepage_id(), "C0004"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Volunteer volunteer, HttpServletRequest request) throws AuthException {
		if(volunteer.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("editMode", volunteer.getEditMode());
			if(volunteer.getHomepage_id().equals("h50")) {
				model.addAttribute("volunteer", service.copyObjectPaging(volunteer, service.getVolunteerOne(volunteer)));
			}else {
				model.addAttribute("volunteer", service.copyObjectPaging(volunteer, service.getTimeVolunteerOne(volunteer)));
			}
		} else {
			checkAuth("C", model, request);
			model.addAttribute("editMode", volunteer.getEditMode());
			model.addAttribute("volunteer", volunteer);
		}
			model.addAttribute("dateTypeList", codeService.getCode(getAsideHomepageId(request), "J0001"));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Volunteer volunteer, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(volunteer.getEditMode().equals("ADD") || volunteer.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "대관일자를 선택하세요.");
			if(volunteer.getHomepage_id().equals("h50")) {
				ValidationUtils.rejectIfEmpty(result, "use_time", "대관시간을 선택하세요.");
			}else {
				ValidationUtils.rejectIfEmpty(result, "start_time", "대관가능시작시간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_time", "대관가능종료시간을 선택하세요.");
			}
			ValidationUtils.rejectIfEmpty(result, "end_date", "대관일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_date", "신청시작일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_time", "신청시작시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_date", "신청종료일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_time", "신청종료시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "max_apply", "최대신청팀수를 입력하세요.");
			
			SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
			sfTime.setLenient(false);
			try {
				sfTime.parse(volunteer.getApply_start_time());
				sfTime.parse(volunteer.getApply_end_time());
				if(!volunteer.getHomepage_id().equals("h50")) {
					sfTime.parse(volunteer.getStart_time());
					sfTime.parse(volunteer.getEnd_time());
				}
			} catch (Exception e) {
				result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			}
		} else if (volunteer.getEditMode().equals("BATCHDELETE")) {
			ValidationUtils.rejectIfEmpty(result, "volunteer_idx_arr", "대관일자를 선택하세요.");
		}
		
		if(!result.hasErrors()) {
			if(volunteer.getEditMode().equals("ADD")) {
				volunteer.setAdd_id(getSessionMemberId(request));
				String weekday 		= volunteer.getWeekday(); // 매주 요일 입력값들
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate 		= sf.parse(volunteer.getStart_date());
				Date endDate 		= sf.parse(volunteer.getEnd_date());
				
				Calendar c = Calendar.getInstance(); //시작 날짜와 종료 날짜 가 같을때까지 반복한다.
				int addCount = 0;				
				
				CalendarManage calendarManage = new CalendarManage();
				calendarManage.setHomepage_id(request.getParameter("homepage_id"));				
				List<CalendarManage> cm = calendarManageService.getClosedDate5(calendarManage);
				for(int i = 0; i < cm.size(); i++) {
					if(volunteer.getStart_date().equals(cm.get(i).getStart_date()) || volunteer.getEnd_date().equals(cm.get(i).getStart_date())) {
						res.setValid(true);
						res.setMessage("휴관일은 대관등록을 할 수 없습니다.");
						return res;
					}
				}
			
				
				
				while( !startDate.after(endDate) ) {
					c.setTime(startDate);
					volunteer.setStart_date(sf.format(startDate));
					volunteer.setEnd_date(sf.format(startDate));
					if( StringUtils.isNotEmpty(volunteer.getWeekday()) && !volunteer.getWeekday().equals("")) {
						if ( weekday.indexOf(String.valueOf(c.get(Calendar.DAY_OF_WEEK))) > -1 ) {
							if ( service.countVolunteer(volunteer) > 0 ) {
								res.setValid(true);
								res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
								return res;
							} 
							else {
								addCount ++;
								if (volunteer.getHomepage_id().equals("h50")) {
									service.addVolunteer(volunteer);
								}
								else {
									service.addTimeVolunteer(volunteer);
								}
							}
						}
					}
					else {
						if ( service.countVolunteer(volunteer) > 0 ) {
							res.setValid(true);
							res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
							return res;
						} 
						else {
							addCount ++;
							if (volunteer.getHomepage_id().equals("h50")) {
								service.addVolunteer(volunteer);
							}else {
								service.addTimeVolunteer(volunteer);
							}
						}
					}
					startDate = DateUtils.addDays(startDate, 1);	
				}
				
				res.setValid(true);
				res.setMessage(String.format("'%s건' 등록 되었습니다.", addCount));
					
			} else if(volunteer.getEditMode().equals("MODIFY")) {
				volunteer.setModify_id(getSessionMemberId(request));
				service.modifyCalendarManage(volunteer);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(volunteer.getEditMode().equals("DELETE")) {
				service.deleteVolunteer(volunteer);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if(volunteer.getEditMode().equals("BATCHDELETE")) {
				service.deleteVolunteerBatch(volunteer);
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
