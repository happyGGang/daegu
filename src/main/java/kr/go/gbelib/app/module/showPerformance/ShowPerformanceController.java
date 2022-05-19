package kr.go.gbelib.app.module.showPerformance;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformance;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformanceService;
import kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApply;
import kr.co.whalesoft.app.cms.module.showPerformance.apply.ShowApplyService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller(value="userShowPerformance")
@RequestMapping(value = {"/{homepagePath}/module/showPerformance"})
public class ShowPerformanceController extends BaseController {

	private String basePath = "/homepage/%s/module/showPerformance/";

	@Autowired
	private ShowPerformanceService service;

	@Autowired
	private ShowApplyService showApplyService;
	
	@Autowired
	private CodeService codeService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ShowPerformance showPerformance, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");


		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(showPerformance.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					showPerformance.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			showPerformance.setHomepage_id(homepage.getHomepage_id());
		}

		if(showPerformance.getPlan_date() == null || showPerformance.getPlan_date().equals("")) {
			showPerformance.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		ShowApply showApply = new ShowApply();
		showApply.setHomepage_id(homepage.getHomepage_id());
		showApply.setApply_id(getSessionMemberId(request));

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(showPerformance.getPlan_date());

		model.addAttribute("showApplyList", showApplyService.getUserApply(showApply));
		model.addAttribute("calendarList", service.getCalendar(showPerformance));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("showPerformance", showPerformance);
		model.addAttribute("showPerformanceList", service.getShowPerformance(showPerformance));
		if ( "ajax".equals(showPerformance.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";
		}

	}
	
	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, ShowPerformance showPerformance, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {
			showApply.setMember_check("n");
		
		} else {
			
			Member certMember = (Member) request.getSession().getAttribute("certMember");
			if (certMember != null) {
				showApply.setApply_id(certMember.getCi_value());
			} else {
				showApply.setApply_id(getSessionMemberId(request));
			}
			
			Member memberInfo = certMember == null ? getSessionMemberInfo(request) : certMember;
			model.addAttribute("member", memberInfo);
			showApply.setMember_check("y");
		}

		
		if (StringUtils.isEmpty(showApply.getHomepage_id())) {
			showApply.setHomepage_id(homepage.getHomepage_id());

		}
		if(showApply.getEditMode().equals("MODIFY")) {
			//model.addAttribute("facility", service.copyObjectPaging(facility, service.getFacilityOne(facilityReq)));
		} else {
			model.addAttribute("showApply", showApply);
		}
		ShowPerformance showPerformance = new ShowPerformance();
		showPerformance.setHomepage_id(showApply.getHomepage_id());
		showPerformance.setShowPerformance_idx(showApply.getShowPerformance_idx());
		model.addAttribute("dateTypeList", codeService.getCode(showPerformance.getHomepage_id(), "S0001"));
		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(showApply.getHomepage_id(), menuOne.getManage_idx(), "module")));
		model.addAttribute("showPerformance", service.getShowPerformanceOne(showPerformance));
		if ( "ajax".equals(showApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}
	
	// 비회원 신청
	@RequestMapping(value = {"/noMemberApply.*"})
	public String noMemberApply(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if (StringUtils.isEmpty(showApply.getHomepage_id())) {
			showApply.setHomepage_id(homepage.getHomepage_id());
			
		}
		ShowPerformance showPerformance = new ShowPerformance();
		showPerformance.setHomepage_id(showApply.getHomepage_id());
		showPerformance.setShowPerformance_idx(showApply.getShowPerformance_idx());
		
		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(showApply.getHomepage_id(), menuOne.getManage_idx(), "module")));
		model.addAttribute("showPerformance", service.getShowPerformanceOne(showPerformance));
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		if ( "ajax".equals(showApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}

	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {

			if("ajax".equals(showApply.getPageType())) {
				showApply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), showApply.getMenu_idx()));
			} else {
				showApply.setBefore_url(String.format("/%s/module/showPerformance/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), showApply.getMenu_idx()));
			}

			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), showApply.getMenu_idx(), showApply.getBefore_url()), request, response);
			return null;
	    }

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(showApply.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					showApply.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			showApply.setHomepage_id(homepage.getHomepage_id());
		}

		showApply.setMember_key(getSessionMemberId(request));
		showApply.setMember_check("y");
		model.addAttribute("showApplyList", showApplyService.getUserApply(showApply));

		if ( "ajax".equals(showApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "apply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "apply";
		}
	}
	
	@RequestMapping(value = {"/noMemberCheck.*"})
	public String noMemberCheck(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "noMemberApplyCheck";
	}
	
	//비회원 신청목록 확인
	@RequestMapping(value = {"/noMemberApplyList.*"})
	public String noMemberApplyList(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		
			if("ajax".equals(showApply.getPageType())) {
				showApply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), showApply.getMenu_idx()));
			} else {
				showApply.setBefore_url(String.format("/%s/module/showPerformance/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), showApply.getMenu_idx()));
			}

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(showApply.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					showApply.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			showApply.setHomepage_id(homepage.getHomepage_id());
		}

		showApply.setMember_check("n");
		
		model.addAttribute("showApplyList", showApplyService.getNoMemberApply(showApply));

		if ( "ajax".equals(showApply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "noMemberApplyList_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "noMemberApplyList";
		}
	}
	

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ShowApply showApply, BindingResult result, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);
		/* 유효성 검사 */

		if(!showApply.getEditMode().equals("DELETE")) {
			if ( !"Y".equals(showApply.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}

			ValidationUtils.rejectIfEmpty(result, "applicant_tel_1", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "total_peple", "관람인원을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_address", "주소를 입력해주세요.");
			if(showApply.getMember_check().equals("n")) {
				ValidationUtils.rejectIfEmpty(result, "password", "패스워드를 입력해주세요.");
				
			}

			CalendarManage calendarManage = new CalendarManage();
			calendarManage.setHomepage_id(showApply.getHomepage_id());
			calendarManage.setStart_date(showApply.getStart_date());
			calendarManage.setEnd_date(showApply.getEnd_date());


			/*if (calendarManageService.closedDateCheck(calendarManage) > 0) {
				res.setValid(true);
				res.setMessage("휴관일에는 시설물 이용을 하실 수 없습니다.");
				return res;
			}*/
		}

		if(!result.hasErrors()) {
			StringBuilder sb = new StringBuilder();
			sb.append(showApply.getEditMode() + "\n");
			sb.append(showApply.getSelf_info_yn() + "\n");
			sb.append(showApply.getHomepage_id() + "\n");
			sb.append(showApply.getApply_idx() + "\n");
			sb.append(showApply.getShowPerformance_idx() + "\n");
			sb.append(showApply.getStart_date() + "\n");
			sb.append(showApply.getApply_id() + "\n");
			sb.append(showApply.getPageType() + "\n");
			sb.append(showApply.getDate_type() + "\n");
			sb.append(showApply.getApplicant_name() + "\n");
			sb.append(showApply.getApplicant_tel() + "\n");
			sb.append(showApply.getApplicant_tel_1() + "\n");
			sb.append(showApply.getApplicant_tel_2() + "\n");
			sb.append(showApply.getApplicant_tel_3() + "\n");
			sb.append(showApply.getApplicant_email() + "\n");
			sb.append(showApply.getAgency_name() + "\n");
			sb.append(showApply.getAgency_tel() + "\n");
			sb.append(showApply.getAgency_tel_1() + "\n");
			sb.append(showApply.getAgency_tel_2() + "\n");
			sb.append(showApply.getAgency_tel_3() + "\n");
			sb.append(showApply.getAgency_address() + "\n");
			sb.append(showApply.getRemarks() + "\n");
			String filterResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
			if (filterResult != null) {
				res.setValid(false);
				res.setUrl(filterResult);
				res.setTargetOpener(true);
				return res;
			}
			
			Member certMember = (Member) request.getSession().getAttribute("certMember");
			if (certMember != null) {
				showApply.setApply_id(certMember.getCi_value());
			} else {
				showApply.setApply_id(getSessionMemberId(request));
			}

			showApply.setApplicant_member_id(showApply.getApply_id());
			showApply.setMember_key(getSessionMemberInfo(request).getSeq_no());

			if(showApply.getEditMode().equals("ADD")) {
				if ( showApplyService.checkApply(showApply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}

				ShowPerformance showPerformance = service.getShowPerformanceOne(new ShowPerformance(showApply.getHomepage_id(), showApply.getShowPerformance_idx()));

				if ( showPerformance.getMax_apply() > 0 ) {
					if (showPerformance.getMax_apply() <= showPerformance.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}
				
				showApply.setAdd_id(showApply.getApply_id());
				showApply.setStart_date(showPerformance.getStart_date());
				showApply.setStart_time(showPerformance.getStart_time());
				showApply.setEnd_date(showPerformance.getEnd_date());
				showApply.setEnd_time(showPerformance.getEnd_time());
				String addResult;
				if(showApply.getMember_check().equals("n")) {
					addResult = showApplyService.addNoMemberApply(showApply, request);
				}else {
					addResult = showApplyService.addApply(showApply, request);
				}
				
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("신청 되었습니다.");
				if (StringUtils.equals(getSessionMemberInfo(request).getSms_service_yn(), "Y")) {
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, showApply.getApplicant_tel(), "도서관 견학 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);
				}

			}
			else if(showApply.getEditMode().equals("DELETE")) {
				showApplyService.deleteApply(showApply);
				res.setValid(true);
				res.setMessage("신청 취소 되었습니다.");
			}
			/*else if(apply.getEditMode().equals("STATEMODIFY")) {
				applyService.modifyApplyState(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			*/
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

}
