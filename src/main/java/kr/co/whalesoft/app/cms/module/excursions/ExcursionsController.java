package kr.co.whalesoft.app.cms.module.excursions;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
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
@RequestMapping(value = {"/cms/module/excursions"})
public class ExcursionsController extends BaseController {

	private final String basePath = "/cms/module/excursions/";
	
	@Autowired
	private ExcursionsService service;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Excursions excursions, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		excursions.setHomepage_id(getAsideHomepageId(request));

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(excursions.getHomepage_id())) {
				excursions.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			excursions.setHomepage_id(getAsideHomepageId(request));
		}

		if(excursions.getPlan_date() == null || excursions.getPlan_date().equals("")) {
			excursions.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		model.addAttribute("calendarList", service.getCalendar(excursions));
		model.addAttribute("excursions", excursions);
		model.addAttribute("excursionsList", service.getExcursions(excursions));
		model.addAttribute("monthList", codeService.getCode(excursions.getHomepage_id(), "C0004"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Excursions excursions, HttpServletRequest request) throws AuthException {
		if(excursions.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("excursions", service.copyObjectPaging(excursions, service.getExcursionsOne(excursions)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("excursions", excursions);
		}
		
		model.addAttribute("dateTypeList", codeService.getCode(getAsideHomepageId(request), "H0001"));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Excursions excursions, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(excursions.getEditMode().equals("ADD") || excursions.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "견학일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "start_time", "견학시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "견학일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_time", "견학시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_date", "신청시작일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_time", "신청시작시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_date", "신청종료일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_time", "신청종료시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "max_apply", "최대신청팀수를 입력하세요.");

			// 날짜 및 시간 포맷터 초기화
			SimpleDateFormat sfDate = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
			sfDate.setLenient(false);
			sdfTime.setLenient(false);

			try {
				// 접수일보다 강의 시작일이 빠를수 없다.
				Date start_join_date 	= sfDate.parse(excursions.getApply_start_date());
				Date end_join_date 		= sfDate.parse(excursions.getApply_end_date());
				Date start_date 		= sfDate.parse(excursions.getStart_date());
				Date end_date 			= sfDate.parse(excursions.getEnd_date());

				if ( start_join_date.after(start_date) ) {
					result.reject("신청 기간은 견학 시작일보다 빨라야 합니다.");
				}

				if ( start_date.before(end_join_date) ) {
					result.reject("신청 종료일은 견학 시작일보다 빨라야 합니다.");
				}

				Date startTime = sdfTime.parse(excursions.getStart_time());
				Date endTime = sdfTime.parse(excursions.getEnd_time());
				Date applyStartTime = sdfTime.parse(excursions.getApply_start_time());
				Date applyEndTime = sdfTime.parse(excursions.getApply_end_time());

				if (!isTimeWithinRange(startTime) || !isTimeWithinRange(endTime)) {
					result.reject("date_format_error", "시간입력은 00:00 ~ 23:59 범위 내여야 합니다.");
				}

				if (!isTimeWithinRange(applyStartTime) || !isTimeWithinRange(applyEndTime)) {
					result.reject("date_format_error", "시간입력은 00:00 ~ 23:59 범위 내여야 합니다.");
				}

				if (excursions.getStart_date().equals(excursions.getEnd_date())) {
					if (startTime.getTime() > endTime.getTime()) {
						result.reject("종료시간은 시작시간 보다 빠를 수 없습니다. ", "종료시간은 시작시간 보다 빠를 수 없습니다.");
					}
				}
			} catch (ParseException e) {
				result.reject("date_format_error", "날짜 또는 시간 형식이 잘못되었습니다.");
			} catch (Exception e) {
				result.reject("date_format_error", "날짜 또는 시간 형식이 잘못되었습니다.");
			}

		} else if (excursions.getEditMode().equals("BATCHDELETE")) {
			ValidationUtils.rejectIfEmpty(result, "excursions_idx_arr", "견학일자를 선택하세요.");
		}
		
		if(!result.hasErrors()) {
			if(excursions.getEditMode().equals("ADD")) {
				excursions.setAdd_id(getSessionMemberId(request));
				String weekday 		= excursions.getWeekday(); // 매주 요일 입력값들
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate 		= sf.parse(excursions.getStart_date());
				Date endDate 		= sf.parse(excursions.getEnd_date());
				
				Calendar c = Calendar.getInstance(); //시작 날짜와 종료 날짜 가 같을때까지 반복한다.
				int addCount = 0;
				while( !startDate.after(endDate) ) {
					c.setTime(startDate);
					excursions.setStart_date(sf.format(startDate));
					excursions.setEnd_date(sf.format(startDate));
					if( StringUtils.isNotEmpty(excursions.getWeekday()) && !excursions.getWeekday().equals("")) {
						if ( weekday.indexOf(String.valueOf(c.get(Calendar.DAY_OF_WEEK))) > -1 ) {
							if ( service.countExcursions(excursions) > 0 ) {
								res.setValid(true);
								res.setMessage("해당 시간에 이미 등록된 도서관견학이 있습니다.");
								return res;
							} 
							else {
								addCount ++;
								service.addExcursions(excursions);
							}
						}
					}
					else {
						if ( service.countExcursions(excursions) > 0 ) {
							res.setValid(true);
							res.setMessage("해당 시간에 이미 등록된 도서관견학이 있습니다.");
							return res;
						} 
						else {
							addCount ++;
							service.addExcursions(excursions);
						}
					}
					startDate = DateUtils.addDays(startDate, 1);	
				}
				
				res.setValid(true);
				res.setMessage(String.format("'%s건' 등록 되었습니다.", addCount));
					
			} else if(excursions.getEditMode().equals("MODIFY")) {
				excursions.setModify_id(getSessionMemberId(request));
				service.modifyCalendarManage(excursions);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(excursions.getEditMode().equals("DELETE")) {
				service.deleteExcursions(excursions);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if(excursions.getEditMode().equals("BATCHDELETE")) {
				service.deleteExcursionsBatch(excursions);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	private boolean isTimeWithinRange(Date time) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(time);
		int hours = calendar.get(Calendar.HOUR_OF_DAY);
		System.out.println("hours = " + hours);
		int minutes = calendar.get(Calendar.MINUTE);
		System.out.println("minutes = " + minutes);
		boolean b = hours >= 0 && hours < 24 && minutes >= 0 && minutes < 60;
		System.out.println("b = " + b);
		return b;
	}
}
