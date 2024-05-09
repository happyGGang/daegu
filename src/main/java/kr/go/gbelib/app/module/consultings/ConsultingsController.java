package kr.go.gbelib.app.module.consultings;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.consultings.Consultings;
import kr.co.whalesoft.app.cms.module.consultings.ConsultingsService;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApply;
import kr.co.whalesoft.app.cms.module.consultings.apply.ConsultingApplyService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;

@Controller(value="userConsultings")
@RequestMapping(value = {"/{homepagePath}/module/consultings"})
public class ConsultingsController extends BaseController {

	private String basePath = "/homepage/%s/module/consultings/";

	@Autowired
	private ConsultingsService service;

	@Autowired
	private ConsultingApplyService applyService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Consultings consultings, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(consultings.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					consultings.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			consultings.setHomepage_id(homepage.getHomepage_id());
		}

		if(consultings.getPlan_date() == null || consultings.getPlan_date().equals("")) {
			consultings.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		ConsultingApply apply = new ConsultingApply();
		apply.setHomepage_id(homepage.getHomepage_id());
		apply.setApply_id(getSessionMemberId(request));

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(consultings.getPlan_date());

		model.addAttribute("applyList", applyService.getUserApply(apply));
		model.addAttribute("calendarList", service.getCalendar(consultings));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("consultings", consultings);
		model.addAttribute("consultingsList", service.getConsultings(consultings));
		if ( "ajax".equals(consultings.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";
		}

	}
	
	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, Consultings consultings, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {
			service.alertMessageAndUrl("본인인증 후 신청가능합니다.", String.format("cert.do?menu_idx=%s&editMode=ADD&consultings_idx=%d", apply.getMenu_idx(), apply.getConsultings_idx()), request, response);
			return null;
		}
		
		Member certMember = (Member) request.getSession().getAttribute("certMember");
		if (certMember != null) {
			apply.setApply_id(certMember.getCi_value());
		} else {
			apply.setApply_id(getSessionMemberId(request));
		}

		Member memberInfo = certMember == null ? getSessionMemberInfo(request) : certMember;
		model.addAttribute("member", memberInfo);

		if (StringUtils.isEmpty(apply.getHomepage_id())) {
			apply.setHomepage_id(homepage.getHomepage_id());

		}
		if(apply.getEditMode().equals("MODIFY")) {
			//model.addAttribute("facility", service.copyObjectPaging(facility, service.getFacilityOne(facilityReq)));
		} else {
			model.addAttribute("apply", apply);
		}

		Consultings consultings = new Consultings();
		consultings.setHomepage_id(apply.getHomepage_id());
		consultings.setConsultings_idx(apply.getConsultings_idx());

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(apply.getHomepage_id(), menuOne.getManage_idx(), "module")));
		model.addAttribute("consultings", service.getConsultingsOne(consultings));
		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}

	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
			if ( !isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				if("ajax".equals(apply.getPageType())) {
					apply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
				} else {
					apply.setBefore_url(String.format("/%s/module/consultings/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), apply.getMenu_idx()));
				}
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
				return null;
			}
		} else {
			if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				if("ajax".equals(apply.getPageType())) {
					apply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
				} else {
					apply.setBefore_url(String.format("/%s/module/consultings/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), apply.getMenu_idx()));
				}
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
				return null;
			}
		}

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(apply.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					apply.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			apply.setHomepage_id(homepage.getHomepage_id());
		}

		apply.setMember_key(getSessionMemberId(request));

		model.addAttribute("applyList", applyService.getUserApply(apply));

		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "apply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "apply";
		}
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ConsultingApply apply, BindingResult result, HttpServletRequest request) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		JsonResponse res = new JsonResponse(request);
		/* 유효성 검사 */

		if(!apply.getEditMode().equals("DELETE")) {
			if ( !"Y".equals(apply.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}

			ValidationUtils.rejectIfEmpty(result, "applicant_tel_1", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력해주세요.");

			CalendarManage calendarManage = new CalendarManage();
			calendarManage.setHomepage_id(apply.getHomepage_id());
			calendarManage.setStart_date(apply.getStart_date());
			calendarManage.setEnd_date(apply.getEnd_date());


			if (calendarManageService.closedDateCheck(calendarManage) > 0) {
				res.setValid(true);
				res.setMessage("휴관일에는 시설물 이용을 하실 수 없습니다.");
				return res;
			}
		}

		if(!result.hasErrors()) {
			StringBuilder sb = new StringBuilder();
			sb.append(apply.getEditMode() + "\n");
			sb.append(apply.getSelf_info_yn() + "\n");
			sb.append(apply.getHomepage_id() + "\n");
			sb.append(apply.getApply_idx() + "\n");
			sb.append(apply.getStart_date() + "\n");
			sb.append(apply.getApply_id() + "\n");
			sb.append(apply.getPageType() + "\n");
			sb.append(apply.getDate_type() + "\n");
			sb.append(apply.getApplicant_name() + "\n");
			sb.append(apply.getApplicant_tel() + "\n");
			sb.append(apply.getApplicant_tel_1() + "\n");
			sb.append(apply.getApplicant_tel_2() + "\n");
			sb.append(apply.getApplicant_tel_3() + "\n");
			sb.append(apply.getApplicant_address() + "\n");
			sb.append(apply.getAge() + "\n");
			sb.append(apply.getPersonnel() + "\n");
			sb.append(apply.getRemarks() + "\n");
			String filterResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
			if (filterResult != null) {
				res.setValid(false);
				res.setUrl(filterResult);
				res.setTargetOpener(true);
				return res;
			}
			
			Member certMember = (Member) request.getSession().getAttribute("certMember");
			if (certMember != null) {
				apply.setApply_id(certMember.getCi_value());
			} else {
				apply.setApply_id(getSessionMemberId(request));
			}

			apply.setApplicant_member_id(apply.getApply_id());
			apply.setMember_key(getSessionMemberInfo(request).getSeq_no());

			if(apply.getEditMode().equals("ADD")) {
				if ( applyService.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}

				Consultings consultings = service.getConsultingsOne(new Consultings(apply.getHomepage_id(), apply.getConsultings_idx()));

				if ( consultings.getMax_apply() > 0 ) {
					if (consultings.getMax_apply() <= consultings.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}
				
				apply.setAdd_id(apply.getApply_id());
				apply.setStart_date(consultings.getStart_date());
				apply.setStart_time(consultings.getStart_time());
				apply.setEnd_date(consultings.getEnd_date());
				apply.setEnd_time(consultings.getEnd_time());
				String addResult = applyService.addApply(apply, request);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("신청 되었습니다.");
				if (StringUtils.equals(getSessionMemberInfo(request).getSms_service_yn(), "Y")) {
					/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "도서관 견학 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);*/
				}

			}
			else if(apply.getEditMode().equals("DELETE")) {
				applyService.deleteApply(apply);
				res.setValid(true);
				res.setMessage("신청 취소 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

}
