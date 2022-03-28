package kr.co.whalesoft.app.cms.module.mediaFactory;

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
@RequestMapping(value = {"/cms/module/mediaFactory"})
public class MediaFactoryController extends BaseController {

	private final String basePath = "/cms/module/mediaFactory/";
	
	@Autowired
	private MediaFactoryService service;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CalendarManageService calendarManageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MediaFactory mediaFactory, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		mediaFactory.setHomepage_id(getAsideHomepageId(request));

		if ((getAsideHomepageId(request).equals("h37") || getAsideHomepageId(request).equals("h49") || getAsideHomepageId(request).equals("h45") || getAsideHomepageId(request).equals("h53"))) {
			Homepage sessionHomepageInfo = getSessionHomepageInfo(request);
			sessionHomepageInfo.setHomepage_group(getAsideHomepageId(request));
			sessionHomepageInfo.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(sessionHomepageInfo);
			if (StringUtils.isEmpty(mediaFactory.getHomepage_id())) {
				mediaFactory.setHomepage_id(subHomepageList.get(0).getHomepage_id());
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			mediaFactory.setHomepage_id(getAsideHomepageId(request));
		}

		if(mediaFactory.getPlan_date() == null || mediaFactory.getPlan_date().equals("")) {
			mediaFactory.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		model.addAttribute("calendarList", service.getCalendar(mediaFactory));
		model.addAttribute("mediaFactory", mediaFactory);
		model.addAttribute("mediaFactoryList", service.getMediaFactory(mediaFactory));
		model.addAttribute("monthList", codeService.getCode(mediaFactory.getHomepage_id(), "C0004"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, MediaFactory mediaFactory, HttpServletRequest request) throws AuthException {
		if(mediaFactory.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("editMode", mediaFactory.getEditMode());
			if(mediaFactory.getHomepage_id().equals("h50")) {
				model.addAttribute("mediaFactory", service.copyObjectPaging(mediaFactory, service.getMediaFactoryOne(mediaFactory)));
			}else {
				model.addAttribute("mediaFactory", service.copyObjectPaging(mediaFactory, service.getTimeMediaFactoryOne(mediaFactory)));
			}
		} else {
			checkAuth("C", model, request);
			model.addAttribute("editMode", mediaFactory.getEditMode());
			model.addAttribute("mediaFactory", mediaFactory);
		}
			model.addAttribute("dateTypeList", codeService.getCode(getAsideHomepageId(request), "M0001"));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MediaFactory mediaFactory, BindingResult result, HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);
		
		if(mediaFactory.getEditMode().equals("ADD") || mediaFactory.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "대관일자를 선택하세요.");
			if(mediaFactory.getHomepage_id().equals("h50")) {
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
				sfTime.parse(mediaFactory.getApply_start_time());
				sfTime.parse(mediaFactory.getApply_end_time());
				if(!mediaFactory.getHomepage_id().equals("h50")) {
					sfTime.parse(mediaFactory.getStart_time());
					sfTime.parse(mediaFactory.getEnd_time());
				}
			} catch (Exception e) {
				result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			}
		} else if (mediaFactory.getEditMode().equals("BATCHDELETE")) {
			ValidationUtils.rejectIfEmpty(result, "mediaFactory_idx_arr", "대관일자를 선택하세요.");
		}
		
		if(!result.hasErrors()) {
			if(mediaFactory.getEditMode().equals("ADD")) {
				mediaFactory.setAdd_id(getSessionMemberId(request));
				String weekday 		= mediaFactory.getWeekday(); // 매주 요일 입력값들
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate 		= sf.parse(mediaFactory.getStart_date());
				Date endDate 		= sf.parse(mediaFactory.getEnd_date());
				
				Calendar c = Calendar.getInstance(); //시작 날짜와 종료 날짜 가 같을때까지 반복한다.
				int addCount = 0;				
				
				CalendarManage calendarManage = new CalendarManage();
				calendarManage.setHomepage_id(request.getParameter("homepage_id"));				
				List<CalendarManage> cm = calendarManageService.getClosedDate5(calendarManage);
				for(int i = 0; i < cm.size(); i++) {
					if(mediaFactory.getStart_date().equals(cm.get(i).getStart_date()) || mediaFactory.getEnd_date().equals(cm.get(i).getStart_date())) {
						res.setValid(true);
						res.setMessage("휴관일은 대관등록을 할 수 없습니다.");
						return res;
					}
				}
			
				
				
				while( !startDate.after(endDate) ) {
					c.setTime(startDate);
					mediaFactory.setStart_date(sf.format(startDate));
					mediaFactory.setEnd_date(sf.format(startDate));
					if( StringUtils.isNotEmpty(mediaFactory.getWeekday()) && !mediaFactory.getWeekday().equals("")) {
						if ( weekday.indexOf(String.valueOf(c.get(Calendar.DAY_OF_WEEK))) > -1 ) {
							if ( service.countMediaFactory(mediaFactory) > 0 ) {
								res.setValid(true);
								res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
								return res;
							} 
							else {
								addCount ++;
								if (mediaFactory.getHomepage_id().equals("h50")) {
									service.addMediaFactory(mediaFactory);
								}
								else {
									service.addTimeMediaFactory(mediaFactory);
								}
							}
						}
					}
					else {
						if ( service.countMediaFactory(mediaFactory) > 0 ) {
							res.setValid(true);
							res.setMessage("해당 시간에 이미 등록된 대관신청이 있습니다.");
							return res;
						} 
						else {
							addCount ++;
							if (mediaFactory.getHomepage_id().equals("h50")) {
								service.addMediaFactory(mediaFactory);
							}else {
								service.addTimeMediaFactory(mediaFactory);
							}
						}
					}
					startDate = DateUtils.addDays(startDate, 1);	
				}
				
				res.setValid(true);
				res.setMessage(String.format("'%s건' 등록 되었습니다.", addCount));
					
			} else if(mediaFactory.getEditMode().equals("MODIFY")) {
				mediaFactory.setModify_id(getSessionMemberId(request));
				service.modifyCalendarManage(mediaFactory);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(mediaFactory.getEditMode().equals("DELETE")) {
				service.deleteMediaFactory(mediaFactory);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if(mediaFactory.getEditMode().equals("BATCHDELETE")) {
				service.deleteMediaFactoryBatch(mediaFactory);
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
