package kr.go.gbelib.app.module.circlesRoom;

import kr.co.whalesoft.app.cms.code.Code;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoom;
import kr.go.gbelib.app.cms.module.circlesRoom.CirclesRoomService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller(value="userCirclesRoom")
@RequestMapping(value={"/{homepagePath}/module/circlesRoom"})
public class CirclesRoomController extends BaseController {
	
	private String basePath = "/homepage/%s/module/circlesRoom/";
	
	@Autowired
	private CirclesRoomService service;
	
	@Autowired
	private CalendarManageService calendarManageService;
	
	@Autowired
	private CodeService codeService;



	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CirclesRoom circlesRoom, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		circlesRoom.setHomepage_id(homepage.getHomepage_id());
		
		if (getSessionMemberInfo(request).isLogin()) {
			circlesRoom.setUser_id(getSessionMemberId(request));
		}
		
		if(circlesRoom.getPlan_date() == null || circlesRoom.getPlan_date().equals("")) {
			circlesRoom.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		if(StringUtils.isNotEmpty(circlesRoom.getPlan_date()) && circlesRoom.getPlan_date().toLowerCase().contains("nan")) {
			circlesRoom.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
		
		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(circlesRoom.getHomepage_id());
		calendarManage.setPlan_date(circlesRoom.getPlan_date());
		
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("circlesRoomList", service.getCirclesRoomList(circlesRoom));
		model.addAttribute("calendarList", calendarManageService.getCalendar(calendarManage));
		model.addAttribute("calendarManageList",calendarManageService.getCalendarManage(calendarManage));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, CirclesRoom circlesRoom, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		if ( !isLogin(request) ||  !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			circlesRoom.setBefore_url(String.format("/%s/module/circlesRoom/index.do?menu_idx=%s", homepage.getContext_path(), circlesRoom.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), circlesRoom.getMenu_idx(), circlesRoom.getBefore_url()), request, response);
			return null;
		}
		
		circlesRoom.setHomepage_id(homepage.getHomepage_id());
		
		Member member = getSessionMemberInfo(request);
		
		if(StringUtils.isEmpty(member.getUser_no())) {
			service.alertMessage("정회원만 신청이 가능합니다.", request, response);
			return null;
		}
		
		if(member != null) {
			circlesRoom.setUser_name(member.getMember_name());
			circlesRoom.setUser_id(member.getMember_id());
			circlesRoom.setUser_ci(member.getCi_value());
		}
		
		List<Code> circlesDivList = codeService.getCode(circlesRoom.getHomepage_id(), "H0006"); // 도서관 구분
		
		if (StringUtils.isEmpty(circlesRoom.getCircles_div())) {
			circlesRoom.setCircles_div(circlesDivList.get(0).getCode_id());
		}
		
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("circlesRoomReqList", service.getCirclesRoomReqView(circlesRoom));
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("circlesDivCode", circlesDivList); // 도서관 구분
		
		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping(value = {"/view.*"})
	public String view(Model model, CirclesRoom circlesRoom, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		List<Code> circlesDivList = codeService.getCode(circlesRoom.getHomepage_id(), "H0006"); // 도서관 구분
		
		if (StringUtils.isEmpty(circlesRoom.getCircles_div())) {
			circlesRoom.setCircles_div(circlesDivList.get(0).getCode_id());
		}
		List <CirclesRoom> userInfo = service.getCirclesRoomReqView(circlesRoom);
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("circlesRoomReqList", userInfo);
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("circlesDivCode", circlesDivList);
		
		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping(value = {"/list.*"})
	public String list(Model model, CirclesRoom circlesRoom, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		circlesRoom.setHomepage_id(homepage.getHomepage_id());
		
		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request)) ) {
			circlesRoom.setBefore_url(String.format("/%s/intro/search/hope/req.do?menu_idx=%s", homepage.getContext_path(), circlesRoom.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), circlesRoom.getMenu_idx(), circlesRoom.getBefore_url()), request, response);
			return null;
		}
		
		Member member = getSessionMemberInfo(request);
		
		if(StringUtils.isEmpty(member.getUser_no())) {
			service.alertMessage("정회원만 신청이 가능합니다.", request, response);
			return null;
		}
		
		if(member != null) {
			circlesRoom.setUser_name(member.getMember_name());
			circlesRoom.setUser_id(member.getMember_id());
			circlesRoom.setUser_ci(member.getCi_value());
		}
		
		model.addAttribute("circlesRoom", circlesRoom);
		model.addAttribute("reqTimeCode", codeService.getCode("CMS", "C0018")); // 사용시간
		model.addAttribute("myCirclesRoom", service.getCirclesRoomMyList(circlesRoom));
		model.addAttribute("circlesDivCode", codeService.getCode(circlesRoom.getHomepage_id(), "H0006")); // 도서관 구분
		
		return String.format(basePath, homepage.getFolder()) + "list";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, CirclesRoom circlesRoom, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = circlesRoom.getEditMode();
		if(!circlesRoom.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "user_name", "기증자명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "visit_num", "신청인원을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "visit_date", "사용 희망일을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "etc", "사용목적을 입력하세요.");
		}

		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				Member sessionMemberInfo = getSessionMemberInfo(request);

				if(StringUtils.isEmpty(sessionMemberInfo.getUser_no())) {
					res.setValid(false);
					res.setMessage("정회원만 신청이 가능합니다.");
					return res;
				}
				
				circlesRoom.setIp(request.getRemoteAddr());
				circlesRoom.setAdd_id(getSessionMemberId(request));
				circlesRoom.setVisit_time(StringUtils.join(circlesRoom.getVisit_time_list(), ","));
				circlesRoom.setRec_key(sessionMemberInfo.getRec_key());
				
				// 동아리방 주 1회 신청가능
				int weekCount = service.getWeekCount(circlesRoom);
				if(weekCount >= 1) {
					res.setValid(false);
					res.setMessage("주 1회만 신청 가능합니다.");
					return res;
				}

				// 동아리방 월 3회 신청가능
				int monthCount = service.getMonthCount(circlesRoom);
				if(monthCount >= 3) {
					res.setValid(false);
					res.setMessage("월 3회만 신청 가능합니다.");
					return res;
				}

				//check중복시간
				List<CirclesRoom> chk_arr = service.getCirclesRoomReqView(circlesRoom);
				for (String value_arr : circlesRoom.getVisit_time_list()) {
					for(int i=0; i<chk_arr.size(); i++) {
						if(value_arr.equals(chk_arr.get(i).getVisit_time())) {
							res.setValid(false);
							res.setMessage("이용시간이 이미 신청되었습니다.");
							return res;
						}
					}
				}

				if(circlesRoom.getCircles_file() != null) {
					circlesRoom = service.addCirclesFile(circlesRoom);
					if(circlesRoom.getServer_file_name() == null) {
						res.setValid(false);
						res.setMessage("잘못된 파일 입니다.");
						return res;
					}
				}

				service.addCirclesRoom(circlesRoom);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
				res.setUrl("index.do?menu_idx=" + circlesRoom.getMenu_idx());

				// 문자 전송
				service.getSendSms(circlesRoom, sessionMemberInfo, request);

			} else if(editMode.equals("DELETE")) {
				service.deleteCirclesRoom(circlesRoom);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
				res.setReload(true);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping (value = {"/divByTime.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse divByTime(CirclesRoom circlesRoom, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			res.setValid(true);
			res.setData(service.getCirclesRoomReqView(circlesRoom));
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = { "/rss.*" })
	public String rss(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		
		return String.format(basePath, homepage.getFolder()) + "rss_ajax";
	}





}