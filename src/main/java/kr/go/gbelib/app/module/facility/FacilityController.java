package kr.go.gbelib.app.module.facility;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.gbelib.app.cms.module.facilityEquipment.FacilityEquipment;
import kr.go.gbelib.app.cms.module.facilityEquipment.FacilityEquipmentService;
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
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.facility.Facility;
import kr.go.gbelib.app.cms.module.facility.FacilityService;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;

@Controller(value="userFacility")
@RequestMapping(value = {"/{homepagePath}/module/facility"})
public class FacilityController extends BaseController {

	private String basePath = "/homepage/%s/module/facility/";

	@Autowired
	private FacilityService service;

	@Autowired
	private FacilityEquipmentService equipmentService;

	@Autowired
	private FacilityReqService facilityReqService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private TermsService termsService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Facility facility, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		facility.setHomepage_id(homepage.getHomepage_id());

		if ( StringUtils.isEmpty(facility.getPlan_date()) ) {
			facility.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

//		FacilityReq facilityReq = new FacilityReq();
//		facilityReq.setHomepage_id(homepage.getHomepage_id());

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(facility.getPlan_date());

		model.addAttribute("calendarList", service.getCalendar(facility));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate2(calendarManage));
		model.addAttribute("facility", facility);
		model.addAttribute("facilityRepo", service.convertToRepo(service.getFacilityListByUser(facility)));
//		model.addAttribute("facilityReq", facilityReq);
//		model.addAttribute("facilityReqList", facilityReqService.getFacilityReqList(facilityReq));

		FacilityReq facilityReq = new FacilityReq();
		facilityReq.setHomepage_id(homepage.getHomepage_id());
		facilityReq.setApply_id(getSessionMemberId(request));
		model.addAttribute("applyList", facilityReqService.getApplyList(facilityReq));

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, FacilityReq facilityReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, FacilityReq facilityReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {
			service.alertMessageAndUrl("본인인증 후 신청가능합니다.", String.format("cert.do?menu_idx=%s&editMode=ADD&facility_idx=%d", facilityReq.getMenu_idx(), facilityReq.getFacility_idx()), request, response);
			return null;
		}

//		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
//
//			facilityReq.setBefore_url(String.format("/%s/module/facility/index.do?menu_idx=%s", homepage.getContext_path(), facilityReq.getMenu_idx()));
//			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), facilityReq.getMenu_idx(), facilityReq.getBefore_url()), request, response);
//			return null;
//	    }

//		if ( blackListService.checkBlackList(new BlackList(homepage.getHomepage_id(), getSessionMemberId(request)), "30")) {
//			service.alertMessage("신청이 불가능합니다.\\n도서관에 문의해주세요.", request, response);
//			return null;
//		}

		Facility facility = new Facility();
		facility.setHomepage_id(homepage.getHomepage_id());
		facility.setFacility_idx(facilityReq.getFacility_idx());
		model.addAttribute("facility",service.getFacilityOne(facility));

		FacilityEquipment equipment = new FacilityEquipment();
		equipment.setHomepage_id(homepage.getHomepage_id());
		equipment.setFacility_idx(facilityReq.getFacility_idx());

		model.addAttribute("facilityEquipmentList",equipmentService.getFacilityEquipmentList(equipment));

		Member certMember = (Member) request.getSession().getAttribute("certMember");
		if (certMember != null) {
			facilityReq.setApply_id(certMember.getCi_value());

		} else {
			facilityReq.setApply_id(getSessionMemberId(request));

		}

		Member memberInfo = certMember == null ? getSessionMemberInfo(request) : certMember;
		model.addAttribute("member", memberInfo);
		facilityReq.setHomepage_id(homepage.getHomepage_id());
		model.addAttribute("facilityReq", facilityReq);

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(homepage.getHomepage_id(), menuOne.getManage_idx(), "module")));

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, FacilityReq facilityReq, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
			if ( !isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				facilityReq.setBefore_url(String.format("/%s/module/facility/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), facilityReq.getMenu_idx()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), facilityReq.getMenu_idx(), facilityReq.getBefore_url()), request, response);
				return null;
			}
		} else {
			if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				facilityReq.setBefore_url(String.format("/%s/module/facility/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), facilityReq.getMenu_idx()));
				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), facilityReq.getMenu_idx(), facilityReq.getBefore_url()), request, response);
				return null;
			}
		}

		facilityReq.setHomepage_id(homepage.getHomepage_id());
		facilityReq.setApply_id(getSessionMemberId(request));

		model.addAttribute("facilityReq", facilityReq);
		model.addAttribute("applyList", facilityReqService.getApplyList(facilityReq));

		return String.format(basePath, homepage.getFolder()) + "apply";
	}

	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, FacilityReq facilityReq,BindingResult result, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		JsonResponse res = new JsonResponse(request);
		String editMode = facilityReq.getEditMode();

		if ( facilityReq.getEditMode().equals("ADD") ) {
			ValidationUtils.rejectIfEmpty(result, "apply_name", "신청자명을 입력해주세요");
			ValidationUtils.rejectIfEmpty(result, "apply_phone1", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_phone2", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_phone3", "휴대번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_desc", "사용목적을 입력하세요.");
		}

		if (!result.hasErrors()) {

			StringBuilder sb = new StringBuilder();
			sb.append(facilityReq.getSelf_info_yn() + "\n");
			sb.append(facilityReq.getHomepage_id() + "\n");
			sb.append(facilityReq.getEditMode() + "\n");
			sb.append(facilityReq.getFacility_req_idx() + "\n");
			sb.append(facilityReq.getFacility_idx() + "\n");
			sb.append(facilityReq.getApply_id() + "\n");
			sb.append(facilityReq.getMember_key() + "\n");
			sb.append(facilityReq.getApply_name() + "\n");
			sb.append(facilityReq.getApply_phone() + "\n");
			sb.append(facilityReq.getApply_phone1() + "\n");
			sb.append(facilityReq.getApply_phone2() + "\n");
			sb.append(facilityReq.getApply_phone3() + "\n");
			sb.append(facilityReq.getApply_desc() + "\n");
			String addResult = WebFilterCheckUtils.webFilterCheck("신청자", "신청", sb.toString());
			if (addResult != null) {
				res.setValid(false);
				res.setUrl(addResult);
				res.setTargetOpener(true);
				return res;
			}

			if ( editMode.equals("ADD") ) {
				CalendarManage calendarManage = new CalendarManage();
				calendarManage.setHomepage_id(facilityReq.getHomepage_id());
				calendarManage.setStart_date(facilityReq.getUse_date());
				calendarManage.setEnd_date(facilityReq.getUse_date());
				// 휴관일 체크
				if ( calendarManageService.closedDateCheck(calendarManage) > 0 ) {
					res.setValid(false);
					res.setMessage("휴관일에는 시설물 이용을 하실 수 없습니다.");
					return res;
				}

				Facility oneFacility = service.getFacilityOne(new Facility(facilityReq.getHomepage_id(), facilityReq.getFacility_idx()));

				if ( oneFacility.getLimit_count() <= oneFacility.getApply_count() ) {
					res.setValid(false);
					res.setMessage("정원 마감 되었습니다.");
					return res;
				}
			}

			Member certMember = (Member) request.getSession().getAttribute("certMember");
			if (certMember != null) {
				facilityReq.setApply_id(certMember.getCi_value());

			} else {
				facilityReq.setApply_id(getSessionMemberId(request));

			}

			if ( editMode.equals("ADD") ) {
				if ( facilityReqService.checkFacilityReq(facilityReq) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}

				facilityReq.setAdd_id(facilityReq.getApply_id());
				facilityReqService.addFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("정상 신청 되었습니다.");
				res.setUrl("index.do?menu_idx=" + facilityReq.getMenu_idx());
//				if (StringUtils.equals(getSessionMemberInfo(request).getSms_service_yn(), "Y")) {
//					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, facilityReq.getApply_phone(), "시설물 이용 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);
//				}

			}
			else if ( editMode.equals("CANCEL") ) {
				facilityReq.setModify_id(facilityReq.getApply_id());
				facilityReq.setApply_status("3");
				facilityReqService.changeStatus(facilityReq);
				res.setValid(true);
				res.setMessage("정상 취소 되었습니다.");
			}
			/*else if (editMode.equals("MODIFY")) {
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.modifyFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
				res.setUrl("index.do?menu_idx=" + facilityReq.getMenu_idx());
			} else if (editMode.equals("DELETE")) {
				facilityReqService.deleteFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}*/
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
