package kr.go.gbelib.app.intro.facility;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.whalesoft.framework.base.BaseController;

@Controller(value="introFacility")
@RequestMapping(value = {"/intro/{context_path}/module/facility"})
public class FacilityController extends BaseController {
		
	/*private final String basePath = "/intro/module/facility/";
	
	@Autowired
	private FacilityService service;
	
	@Autowired
	private FacilityReqService facilityReqService;
	
	@Autowired
	private CalendarManageService calendarManageService;
	
	@Autowired
	private SiteService siteService;
	
	@Autowired
	private HomepageService homepageService;
	
	
	@ModelAttribute("recommendSiteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}
	
	
	@RequestMapping(value = {"/index.*"})
	public String index(@PathVariable String context_path, Model model, Facility facility, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		facility.setHomepage_id(homepage.getHomepage_id());				
		
		if(facility.getPlan_date() == null || facility.getPlan_date().equals("")) {
			facility.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		FacilityReq facilityReq = new FacilityReq();
		facilityReq.setHomepage_id(homepage.getHomepage_id());
		facilityReq.setApply_id(getSessionMemberId(request));
		facilityReq.setPlan_date(facility.getPlan_date());
		
		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(facility.getPlan_date());
		
		model.addAttribute("calendarList", service.getCalendar(facility));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("facility", facility);
		model.addAttribute("facilityList", service.getFacilityListAll(facility));
		model.addAttribute("facilityReq", facilityReq);
		model.addAttribute("facilityReqList", facilityReqService.getFacilityReqCalendarList(facilityReq));
		model.addAttribute("homepage", homepage);
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(@PathVariable String context_path, Model model, FacilityReq facilityReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/intro/" + homepage.getContext_path() + "/login/index.do", request, response);
			return null;
		}
		
		Facility facility = new Facility();
		facility.setHomepage_id(homepage.getHomepage_id());
		facility.setFacility_idx(facilityReq.getFacility_idx());
		model.addAttribute("facility",service.getFacilityOne(facility));
		
		facilityReq.setApply_id(getSessionMemberId(request));
		facilityReq.setHomepage_id(homepage.getHomepage_id());
		if(facilityReq.getEditMode().equals("MODIFY")) {
			//model.addAttribute("facility", service.copyObjectPaging(facility, service.getFacilityOne(facilityReq)));
		} else {
			model.addAttribute("facilityReq", facilityReq);
		}
		
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("homepage", homepage);
		return basePath + "edit";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(@PathVariable String context_path, Model model, FacilityReq facilityReq,BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);
		String editMode = facilityReq.getEditMode();
		
		if(!facilityReq.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "phone1", "전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "phone2", "전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "phone3", "전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone1", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone2", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "cell_phone3", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "purpose", "사용목적을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "visits", "방문자수를 입력해주세요.");		
			
		}
		
		if (!result.hasErrors()) {
			
			CalendarManage calendarManage = new CalendarManage();
			calendarManage.setHomepage_id(facilityReq.getHomepage_id());
			calendarManage.setStart_date(facilityReq.getStart_date());
			calendarManage.setEnd_date(facilityReq.getEnd_date());

			if (!editMode.equals("DELETE")) {
				// 휴관일 체크
				if (calendarManageService.closedDateCheck(calendarManage) > 0) {
					res.setValid(true);
					res.setMessage("휴관일에는 시설물 이용을 하실 수 없습니다.");
					return res;
				}

				// 신청이용일, 신청이용시간 체크
				if (facilityReqService.getFacilityCheck(facilityReq) < 1) {
					res.setValid(true);
					res.setMessage("신청이용일, 신청이용시간을 확인해주세요..");
					return res;
				}
			}

			if (editMode.equals("ADD")) {
				model.addAttribute("homepage", homepage);
				facilityReq.setAdd_id(getSessionMemberId(request));
				facilityReqService.addFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
				res.setUrl("index.do?menu_idx=" + facilityReq.getMenu_idx());
				PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, facilityReq.getCell_phone(), homepage.getHomepage_send_tell(), "시설물 신청이 완료 되었습니다.", true);
			} else if (editMode.equals("MODIFY")) {
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.modifyFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
				res.setUrl("index.do?menu_idx=" + facilityReq.getMenu_idx());
			} else if (editMode.equals("DELETE")) {
				facilityReqService.deleteFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	public static String[] getDiffDays(String fromDate, String toDate) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();

		try {
			cal.setTime(sdf.parse(fromDate));
		} catch (Exception e) {
			e.printStackTrace();
		}

		int count = getDiffDayCount(fromDate, toDate);
		// 시작일부터
		cal.add(Calendar.DATE, -1);
		// 데이터 저장
		List list = new ArrayList();
		for (int i = 0; i <= count; i++) {
			cal.add(Calendar.DATE, 1);
			list.add(sdf.format(cal.getTime()));
		}
		String[] result = new String[list.size()];
		list.toArray(result);
		return result;
	}

	public static int getDiffDayCount(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return (int) ((sdf.parse(toDate).getTime() - sdf.parse(fromDate).getTime()) / 1000 / 60 / 60 / 24);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}*/

}
