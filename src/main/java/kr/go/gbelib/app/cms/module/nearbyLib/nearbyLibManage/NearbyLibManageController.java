package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = { "/cms/module/nearbyLib/nearbyLibManage" })
public class NearbyLibManageController extends BaseController {

	private final String basePath = "/cms/module/nearbyLib/nearbyLibManage/";
	
	@Autowired
	private NearbyLibManageService service;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = { "/index{url}.*" })
	public String index(Model model, NearbyLibManage nearbyLibManage, HttpServletRequest request, @PathVariable("url") String url ) throws AuthException {
		checkAuth("R", model, request);

		nearbyLibManage.setHomepage_id(getAsideHomepageId(request));

		if (nearbyLibManage.getPlan_date() == null || nearbyLibManage.getPlan_date().equals("")) {
			nearbyLibManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		if (StringUtils.isNotEmpty(nearbyLibManage.getPlan_date()) && nearbyLibManage.getPlan_date().toLowerCase().contains("nan")) {
			nearbyLibManage.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		model.addAttribute("calendarList", service.getCalendar(nearbyLibManage));
		model.addAttribute("calendarListType", service.getCalendarListType(nearbyLibManage));
		model.addAttribute("nearbyLibManage", nearbyLibManage);
		model.addAttribute("nearbyLibManageList",service.getNearbyLibManage(nearbyLibManage));

		model.addAttribute("url", url);
		return basePath + "index" + url;
	}
	
	@RequestMapping(value = { "/edit.*" })
	public String edit(Model model, NearbyLibManage nearbyLibManage, HttpServletRequest request) throws AuthException {

		if (nearbyLibManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			NearbyLibManage one = service.getNearbyLibManageOne(nearbyLibManage);
			NearbyLibManage one2 = service.getNearbyLibManageOne2(one);
			model.addAttribute("nearbyLibManage",service.copyObjectPaging(nearbyLibManage,one));
			model.addAttribute("nearbyLibManage2",one2);
		} else {
			checkAuth("C", model, request);
			model.addAttribute("nearbyLibManage", nearbyLibManage);
		}

		model.addAttribute("weekdayList", service.getDefaultWeekDay());

		model.addAttribute("dateTypeList",codeService.getCode(nearbyLibManage.getHomepage_id(), "C0006"));
		Homepage h = new Homepage();
		h.setHomepage_id(getSessionHomepageInfo(request).getHomepage_id());
		h.setHomepage_group(getSessionHomepageInfo(request).getHomepage_group());
		h.setTemp_use_yn("Y");
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = { "/timeSetting.*" })
	public String timeSetting(Model model, NearbyLibManage nearbyLibManage, HttpServletRequest request) throws AuthException {

		if (nearbyLibManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			NearbyLibManage one = service.getNearbyLibManageOne(nearbyLibManage);
			NearbyLibManage one2 = service.getNearbyLibManageOne2(one);
			model.addAttribute("nearbyLibManage",service.copyObjectPaging(nearbyLibManage,one));
			model.addAttribute("nearbyLibManage2",one2);
		} else {
			checkAuth("C", model, request);
			model.addAttribute("nearbyLibManage", nearbyLibManage);
		}

		model.addAttribute("weekdayList", service.getDefaultWeekDay());

		model.addAttribute("dateTypeList",codeService.getCode(nearbyLibManage.getHomepage_id(), "C0006"));
		Homepage h = new Homepage();
		h.setHomepage_id(getSessionHomepageInfo(request).getHomepage_id());
		h.setHomepage_group(getSessionHomepageInfo(request).getHomepage_group());
		h.setTemp_use_yn("Y");
		return basePath + "timeSetting_ajax";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody
	JsonResponse save(NearbyLibManage nearbyLibManage, BindingResult result,HttpServletRequest request) throws Exception {
		JsonResponse res = new JsonResponse(request);

		if (nearbyLibManage.getEditMode().equals("ADD") || nearbyLibManage.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "title", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "start_date","일정의 시작일자 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "일정의 종료일자 입력하세요.");
		}

		if (!result.hasErrors()) {
			if (nearbyLibManage.getEditMode().equals("ADD")) {

				if (StringUtils.isNotEmpty(nearbyLibManage.getSubHomepageId())) {
					nearbyLibManage.setHomepage_id(nearbyLibManage.getSubHomepageId());
				}

				String startDate = nearbyLibManage.getStart_date();
				String endDate = nearbyLibManage.getEnd_date();

				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date startDay = dateFormat.parse(startDate);
				Date endDay = dateFormat.parse(endDate);

				Calendar start = Calendar.getInstance();
				Calendar end = Calendar.getInstance();

				start.setTime(startDay);
				end.setTime(endDay);

				if (nearbyLibManage.getWeekdayArr() == null || StringUtils.equals(nearbyLibManage.getWeekdayArr().get(0), "0")) {
					nearbyLibManage.setWeekday("1,2,3,4,5,6,7");
				} else {
					nearbyLibManage.setWeekday(StringUtils.join(nearbyLibManage.getWeekdayArr(), ","));
				}

				String[] weekday = nearbyLibManage.getWeekday().split(",");

				int nextIdx = service.getNextCmIdx(nearbyLibManage);
				nearbyLibManage.setGroup_idx(nextIdx);

				while( start.compareTo( end ) !=1 ){
					for(int i = 0; i < weekday.length; i++) {
						int day = getDateDay(start, "yyyy-MM-dd");

						if(Integer.parseInt(weekday[i]) == day) {

							nearbyLibManage.setStart_date(dateFormat.format(start.getTime()));
							nearbyLibManage.setEnd_date(dateFormat.format(start.getTime()));

							service.addNearbyLibManage(nearbyLibManage);
						}
					}
					start.add(Calendar.DATE, 1);
				}

				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if (nearbyLibManage.getEditMode().equals("MODIFY")) {
				service.modifyNearbyLibManage(nearbyLibManage);

				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if (nearbyLibManage.getEditMode().equals("DELETE")) {
				nearbyLibManage.setIndividual_yn2(nearbyLibManage.getIndividual_yn());
				if (StringUtils.equals(nearbyLibManage.getIndividual_yn(), "E")) {
					nearbyLibManage.setIndividual_yn("N");
				}
				if (nearbyLibManage.getIndividual_yn().equals("Y")) {
					service.deleteNearbyLibManage(nearbyLibManage);
				} else {
					service.deleteNearbyLibManageGroup(nearbyLibManage);
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

	@RequestMapping(value = { "/getLasHolidays.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveIlusHolidays(NearbyLibManage nearbyLibManage, Homepage homepage, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			homepage = homepageService.getHomepageOne(homepage);
			int resultRow = service.addNearbyLibManageFromLas(nearbyLibManage, homepage);
			res.setValid(true);
			res.setMessage(resultRow+"건 등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = { "/getLasHolidaysYear.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveIlusHolidaysYear(NearbyLibManage nearbyLibManage, Homepage homepage, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			homepage = homepageService.getHomepageOne(homepage);
			int resultRow = service.addNearbyLibManageFromLasYear(nearbyLibManage, homepage);
			res.setValid(true);
			res.setMessage(resultRow+"건 등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	public int getDateDay(Calendar date, String dateType) throws Exception {
	    int dayNum = date.get(Calendar.DAY_OF_WEEK) ;

	    return dayNum ;
	}
}
