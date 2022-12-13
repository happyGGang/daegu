package kr.go.gbelib.app.module.mediaFactory;

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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.mediaFactory.MediaFactory;
import kr.co.whalesoft.app.cms.module.mediaFactory.MediaFactoryService;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApply;
import kr.co.whalesoft.app.cms.module.mediaFactory.apply.MediaFactoryApplyService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.common.api.PushAPI;

@Controller(value="userMediaFactory")
@RequestMapping(value = {"/{homepagePath}/module/mediaFactory"})
public class MediaFactoryController extends BaseController {

	private String basePath = "/homepage/%s/module/mediaFactory/";

	@Autowired
	private MediaFactoryService service;

	@Autowired
	private MediaFactoryApplyService mediaFactoryApplyService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private HomepageService homepageService;	

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MediaFactory mediaFactory, HttpServletRequest request) throws AuthException {
		/* checkAuth("R", model, request); */
		Homepage homepage = (Homepage) request.getAttribute("homepage");

//		excursions.setHomepage_id(homepage.getHomepage_id());

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(mediaFactory.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					mediaFactory.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			mediaFactory.setHomepage_id(homepage.getHomepage_id());
		}

		if(mediaFactory.getPlan_date() == null || mediaFactory.getPlan_date().equals("")) {
			mediaFactory.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		MediaFactoryApply apply = new MediaFactoryApply();
		apply.setHomepage_id(homepage.getHomepage_id());
		apply.setApply_id(getSessionMemberId(request));		
		
		CalendarManage calendarManage = new CalendarManage();
		calendarManage.setHomepage_id(homepage.getHomepage_id());
		calendarManage.setPlan_date(mediaFactory.getPlan_date());
		
		Member sessionMemberInfo = getSessionMemberInfo(request);
		model.addAttribute("member_id", sessionMemberInfo.getMember_id());
		model.addAttribute("applyList", mediaFactoryApplyService.getUserApply(apply));
		model.addAttribute("calendarList", service.getCalendar(mediaFactory));
		model.addAttribute("calendarManageList", calendarManageService.getClosedDate(calendarManage));
		model.addAttribute("mediaFactory", mediaFactory);
		model.addAttribute("mediaFactoryList", service.getMediaFactory(mediaFactory));
		if ( "ajax".equals(mediaFactory.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "index_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "index";
		}

	}
	
	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, MediaFactory mediaFactory, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, MediaFactoryApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
//		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

//		if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
//			apply.setBefore_url(String.format("http://www.gbelib.kr/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
//			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("http://www.gbelib.kr/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
//			return null;
//		}
		
		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", "/"+homepage.getContext_path()+"/intro/login/index.do?menu_idx=69", request, response);
			return null;
		}

//		if ( blackListService.checkBlackList(new BlackList(homepage.getHomepage_id(), getSessionMemberId(request)), "40")) {
//			service.alertMessage("신청이 불가능합니다.\\n도서관에 문의해주세요.", request, response);
//			return null;
//		}
		
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

		MediaFactory mediaFactory = new MediaFactory();
		mediaFactory.setHomepage_id(apply.getHomepage_id());
		mediaFactory.setMediaFactory_idx(apply.getMediaFactory_idx());

		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");
		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(apply.getHomepage_id(), menuOne.getManage_idx(), "module")));
		model.addAttribute("mediaFactory", service.getMediaFactoryOne(mediaFactory));
//		model.addAttribute("prtcNotice",MemberAPI.getPrtcNoticeList("WEB"));
		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "edit_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "edit";
		}
	}

	@RequestMapping(value = {"/apply.*"})
	public String apply(Model model, MediaFactoryApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if("h79".equals(homepage.getHomepage_id()) || "h80".equals(homepage.getHomepage_id()) || "h81".equals(homepage.getHomepage_id()) || "h82".equals(homepage.getHomepage_id()) || "h83".equals(homepage.getHomepage_id()) || "h84".equals(homepage.getHomepage_id()) || "h85".equals(homepage.getHomepage_id()) || "h86".equals(homepage.getHomepage_id()) || "h87".equals(homepage.getHomepage_id()) || "h88".equals(homepage.getHomepage_id())) {
			if ( !isLogin(request) || !"PRIVATEHOMEPAGE".equals(getSessionMemberLoginType(request))) {
				if("ajax".equals(apply.getPageType())) {
					apply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
				} else {
					apply.setBefore_url(String.format("/%s/module/excursions/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), apply.getMenu_idx()));
				}

				service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), apply.getMenu_idx(), apply.getBefore_url()), request, response);
				return null;
			}
		} else {
			if ( !isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
				if("ajax".equals(apply.getPageType())) {
					apply.setBefore_url(String.format("/%s/html.do?menu_idx=%s", homepage.getContext_path(), apply.getMenu_idx()));
				} else {
					apply.setBefore_url(String.format("/%s/module/excursions/index.do?menu_idx=%s&date_type=1", homepage.getContext_path(), apply.getMenu_idx()));
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

//		apply.setHomepage_id(homepage.getHomepage_id());
		apply.setMember_key(getSessionMemberId(request));

		model.addAttribute("apply", apply);
		model.addAttribute("applyList", mediaFactoryApplyService.getUserApply(apply));
		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "apply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "apply";
		}
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MediaFactoryApply apply, BindingResult result, HttpServletRequest request) throws Exception {
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
			if(!apply.getHomepage_id().equals("h73") && !apply.getHomepage_id().equals("h59") && !apply.getHomepage_id().equals("h60") ) {
				ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력해주세요.");
			}
			if(apply.getHomepage_id().equals("h73") || apply.getHomepage_id().equals("h59") || apply.getHomepage_id().equals("h60") ) {
				ValidationUtils.rejectIfEmpty(result, "age", "연령대를 선택해주세요.");
			}else {
				ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
			}
			if("h45".equals(apply.getHomepage_id()) || "h73".equals(apply.getHomepage_id()) || "h59".equals(apply.getHomepage_id()) || "h60".equals(apply.getHomepage_id())) {
				if("미성년자".equals(apply.getAge())) {
					ValidationUtils.rejectIfEmpty(result, "protector_name", "보호자동의서에 보호자이름을 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "protector_relation", "신청인과의 관계를 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "protector_address", "보호자 주소를 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "protector_tel_1", "보호자 전화번호를 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "protector_tel_2", "보호자 전화번호를 입력하세요.");
					ValidationUtils.rejectIfEmpty(result, "protector_tel_3", "보호자 전화번호를 입력하세요.");
				}
			}
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
			sb.append(apply.getMediaFactory_idx() + "\n");
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
			
			Member certMember = (Member) request.getSession().getAttribute("certMember");
			if (certMember != null) {
				apply.setApply_id(certMember.getCi_value());
			} else {
				apply.setApply_id(getSessionMemberId(request));
			}

			apply.setApplicant_member_id(apply.getApply_id());
			apply.setMember_key(getSessionMemberInfo(request).getSeq_no());

			if(apply.getEditMode().equals("ADD")) {
				if ( mediaFactoryApplyService.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}
				
				if (mediaFactoryApplyService.checkApplyDay(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("1일 1회만 신청 가능합니다." );
					return res;
				}
				
				String chekMonth = apply.getStart_date(); 
				apply.setCheckMonth(chekMonth.substring(0,7));
				
				if (mediaFactoryApplyService.checkApplyMonth(apply) > 3 ) {
					res.setValid(false);
					res.setMessage("월 4 회 까지만 신청 가능합니다.");
					return res;
				}

				MediaFactory mediaFactory; 
				if (apply.getHomepage_id().equals("h50")) {
					 mediaFactory = service.getMediaFactoryOne(new MediaFactory(apply.getHomepage_id(), apply.getMediaFactory_idx()));
				}
				else {
					 mediaFactory = service.getTimeMediaFactoryOne(new MediaFactory(apply.getHomepage_id(), apply.getMediaFactory_idx()));
				}
				if ( mediaFactory.getMax_apply() > 0 ) {
					if (mediaFactory.getMax_apply() <= mediaFactory.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}
				
				apply.setAdd_id(apply.getApply_id());
				apply.setStart_date(mediaFactory.getStart_date());
				apply.setUse_time(mediaFactory.getUse_time());
				apply.setEnd_date(mediaFactory.getEnd_date());				
				String addResult = mediaFactoryApplyService.addApply(apply, request);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("신청 되었습니다.");
				if (StringUtils.equals(getSessionMemberInfo(request).getSms_service_yn(), "Y")) {
					PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "미디어창작소 대관 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);
				}

			}
			else if(apply.getEditMode().equals("DELETE")) {
				mediaFactoryApplyService.deleteApply(apply);
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
