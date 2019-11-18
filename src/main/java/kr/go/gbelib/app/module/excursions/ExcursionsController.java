package kr.go.gbelib.app.module.excursions;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.Excursions;
import kr.co.whalesoft.app.cms.module.excursions.ExcursionsService;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.app.cms.site.Site;
import kr.co.whalesoft.app.cms.site.SiteService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.blackList.BlackList;
import kr.go.gbelib.app.cms.module.blackList.BlackListService;
import kr.go.gbelib.app.common.api.MemberAPI;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller(value="userExcursions")
@RequestMapping(value = {"/{homepagePath}/module/excursions"})
public class ExcursionsController extends BaseController {

	private String basePath = "/homepage/%s/module/excursions/";

	@Autowired
	private ExcursionsService service;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private SiteService siteService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private BlackListService blackListService;

	@Autowired
	private CalendarManageService calendarManageService;

	@ModelAttribute("siteList")
	public List<Site> getAreaCdList(HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		return siteService.getSiteListAll(new Site(homepage.getHomepage_id()));
	}

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Excursions excursions, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		excursions.setHomepage_id(homepage.getHomepage_id());
		if(excursions.getPlan_date() == null || excursions.getPlan_date().equals("")) {
			excursions.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		Apply apply = new Apply();
		apply.setHomepage_id(homepage.getHomepage_id());
		apply.setApply_id(getSessionMemberId(request));

		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(excursions.getPlan_date());

		model.addAttribute("applyList", applyService.getUserApply(apply));
		model.addAttribute("calendarList", service.getCalendar(excursions));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("excursions", excursions);
		model.addAttribute("excursionsList", service.getExcursions(excursions));
		if ( "ajax".equals(excursions.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";
		}

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			apply.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
			return null;
	    }

		if ( blackListService.checkBlackList(new BlackList(homepage.getHomepage_id(), getSessionUserSeqNo(request)), "40")) {
			service.alertMessage("신청이 불가능합니다.\\n도서관에 문의해주세요.", request, response);
			return null;
		}

		apply.setApply_id(getSessionMemberId(request));
		apply.setHomepage_id(homepage.getHomepage_id());
		if(apply.getEditMode().equals("MODIFY")) {
			//model.addAttribute("facility", service.copyObjectPaging(facility, service.getFacilityOne(facilityReq)));
		} else {
			model.addAttribute("apply", apply);
		}

		Excursions excursions = new Excursions();
		excursions.setHomepage_id(homepage.getHomepage_id());
		excursions.setExcursions_idx(apply.getExcursions_idx());

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(menuOne.getManage_idx())));

		model.addAttribute("excursions", service.getExcursionsOne(excursions));
		model.addAttribute("member", getSessionMemberInfo(request));
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}

	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {

			if("ajax".equals(apply.getPageType())) {
				apply.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
			} else {
				apply.setBefore_url(String.format("http://www.gbelib.kr/%s/module/excursions/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), apply.getMenu_idx()));
			}

			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
			return null;
	    }

		apply.setHomepage_id(homepage.getHomepage_id());
		apply.setMember_key(getSessionUserSeqNo(request));

		model.addAttribute("applyList", applyService.getUserApply(apply));

		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "apply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "apply";
		}
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Apply apply, BindingResult result, HttpServletRequest request) throws Exception {
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
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력해주세요.");
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
			sb.append(apply.getExcursions_idx() + "\n");
			sb.append(apply.getStart_date() + "\n");
			sb.append(apply.getApply_id() + "\n");
			sb.append(apply.getPageType() + "\n");
			sb.append(apply.getDate_type() + "\n");
			sb.append(apply.getApplicant_name() + "\n");
			sb.append(apply.getApplicant_tel() + "\n");
			sb.append(apply.getApplicant_tel_1() + "\n");
			sb.append(apply.getApplicant_tel_2() + "\n");
			sb.append(apply.getApplicant_tel_3() + "\n");
			sb.append(apply.getApplicant_email() + "\n");
			sb.append(apply.getAgency_name() + "\n");
			sb.append(apply.getAgency_tel() + "\n");
			sb.append(apply.getAgency_tel_1() + "\n");
			sb.append(apply.getAgency_tel_2() + "\n");
			sb.append(apply.getAgency_tel_3() + "\n");
			sb.append(apply.getAgency_address() + "\n");
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

			apply.setApplicant_member_id(getSessionMemberId(request));
			apply.setMember_key(getSessionMemberInfo(request).getSeq_no());

			if(apply.getEditMode().equals("ADD")) {
				if ( applyService.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}

				Excursions excursions = service.getExcursionsOne(new Excursions(apply.getHomepage_id(), apply.getExcursions_idx()));

				if ( excursions.getMax_apply() > 0 ) {
					if (excursions.getMax_apply() <= excursions.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}

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
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "도서관 견학 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);
				}

			}
			else if(apply.getEditMode().equals("DELETE")) {
				applyService.deleteApply(apply);
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
