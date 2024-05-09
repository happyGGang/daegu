package kr.go.gbelib.app.module.excursions;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.app.cms.module.excursions.Excursions;
import kr.co.whalesoft.app.cms.module.excursions.ExcursionsService;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.app.cms.module.excursions.apply.ApplyService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.file.FileStorage;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.co.whalesoft.framework.utils.WebFilterCheckUtils;

@Controller(value="userExcursions")
@RequestMapping(value = {"/{homepagePath}/module/excursions"})
public class ExcursionsController extends BaseController {

	private String basePath = "/homepage/%s/module/excursions/";

	@Autowired
	private ExcursionsService service;

	@Autowired
	private ApplyService applyService;

	@Autowired
	private TermsService termsService;

	@Autowired
	private CalendarManageService calendarManageService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	@Qualifier("excursionsStorage")
	private FileStorage excursionsStorage;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Excursions excursions, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

//		excursions.setHomepage_id(homepage.getHomepage_id());

		if ((homepage.getHomepage_id().equals("h37") || homepage.getHomepage_id().equals("h49") || homepage.getHomepage_id().equals("h45") || homepage.getHomepage_id().equals("h53"))) {
			Homepage h = new Homepage();
			h.setHomepage_id(homepage.getHomepage_id());
			h.setHomepage_group(homepage.getHomepage_id());
			h.setTemp_use_yn("Y");
			List<Homepage> subHomepageList = homepageService.getSubHomepageList(h);
			if (StringUtils.isEmpty(excursions.getHomepage_id())) {
				if (subHomepageList != null && subHomepageList.size() > 0) {
					excursions.setHomepage_id(subHomepageList.get(0).getHomepage_id());
				}
			}
			model.addAttribute("subHomepageList", subHomepageList);
		} else {
			excursions.setHomepage_id(homepage.getHomepage_id());
		}

		if(excursions.getPlan_date() == null || excursions.getPlan_date().equals("")) {
			excursions.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}

		Apply apply = new Apply();
//		if (homepage.getHomepage_id().equals("h49")) {
//			homepage.setHomepage_id(excursions.getHomepage_id());
//		}
		apply.setHomepage_id(excursions.getHomepage_id());
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

	@RequestMapping(value = {"/cert.*"}, method = RequestMethod.GET)
	public String cert(Model model, Excursions excursions, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "cert";

	}

	@RequestMapping(value = {"/anonyCert.*"}, method = RequestMethod.GET)
	public String anonyCert(Model model, Excursions excursions, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage)request.getAttribute("homepage");

		return String.format(basePath, homepage.getFolder()) + "anonyCert";

	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (!apply.getEditMode().equals("MODIFY")) {
			checkAuth("C", model, request);
		}
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {

			if ("h94".equals(homepage.getHomepage_id())) {
				service.alertMessageAndUrl("본인인증 후 신청가능합니다.", String.format("module/excursions/cert.do?menu_idx=%s&editMode=ADD&excursions_idx=%d&homepage_id=%s", apply.getMenu_idx(), apply.getExcursions_idx(),apply.getHomepage_id()), request, response);
			}else {
				service.alertMessageAndUrl("본인인증 후 신청가능합니다.", String.format("cert.do?menu_idx=%s&editMode=ADD&excursions_idx=%d&homepage_id=%s", apply.getMenu_idx(), apply.getExcursions_idx(),apply.getHomepage_id()), request, response);

			}
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
			model.addAttribute("apply", service.copyObjectPaging(apply, applyService.getApplyOne(apply)));
		} else {
			model.addAttribute("apply", apply);
		}

		Excursions excursions = new Excursions();
		excursions.setHomepage_id(apply.getHomepage_id());
		excursions.setExcursions_idx(apply.getExcursions_idx());
		List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
		boolean isSeoguPrivatetour = allowedHomepageIds.contains(apply.getHomepage_id()) && "0011".equals(apply.getDate_type());

		model.addAttribute("isSeoguPrivatetour", isSeoguPrivatetour);
		//약관 연동부
		Menu menuOne = (Menu) request.getAttribute("menuOne");

		model.addAttribute("termsList", termsService.getTermsListInModule(new Terms(apply.getHomepage_id(), menuOne.getManage_idx(), "module")));
		model.addAttribute("excursions", service.getExcursionsOne(excursions));
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
		if ("h35".equals(apply.getHomepage_id())) {

			model.addAttribute("applyList", applyService.getUserExApply(apply));
			model.addAttribute("applySrList", applyService.getUserSrApply(apply));
		}else {

			model.addAttribute("applyList", applyService.getUserApply(apply));
		}


		if ( "ajax".equals(apply.getPageType()) ) {
			return String.format(basePath, homepage.getFolder()) + "apply_ajax";
		}
		else {
			return String.format(basePath, homepage.getFolder()) + "apply";
		}
	}

	@RequestMapping(value = {"/anonyApply.*"})
	public String anonyApply(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if ( !isLogin(request) && request.getSession().getAttribute("certMember") == null) {
			service.alertMessageAndUrl("본인인증 후 신청내역 확인이 가능합니다.", String.format("anonyCert.do?menu_idx=%s&editMode=MODIFY", apply.getMenu_idx()), request, response);
			return null;
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

		Member certMember = (Member) request.getSession().getAttribute("certMember");

		apply.setApply_id(certMember.getCi_value());
		if ("h35".equals(apply.getHomepage_id())) {

			model.addAttribute("applyList", applyService.getUserExApply(apply));
			model.addAttribute("applySrList", applyService.getUserSrApply(apply));
		}else {

			model.addAttribute("applyList", applyService.getUserApply(apply));
		}


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

			if (!("h35".equals(homepage.getHomepage_id()) && "0002".equals(apply.getDate_type())) && !apply.getIsSeoguPrivatetour()) {
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_1", "신청자 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
			}

			if (apply.getIsSeoguPrivatetour()) {
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_1", "신청자 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력해주세요.");
			}
			if ("h8".equals(apply.getHomepage_id()) && !apply.getEditMode().equals("MODIFY")) {
				ValidationUtils.rejectIfEmpty(result, "Desired_start_time", "체험희망 시작시간을 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "Desired_end_time", "체험희망 종료시간을 입력해주세요.");
			}
			ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력해주세요.");
			if ("h8".equals(apply.getHomepage_id()) && StringUtils.isNotEmpty(apply.getDesired_start_time()) && StringUtils.isNotEmpty(apply.getDesired_end_time()) && !apply.getEditMode().equals("MODIFY")) {
				SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
				sfTime.setLenient(false);
				try {
					sfTime.parse(apply.getDesired_start_time());
					sfTime.parse(apply.getDesired_end_time());
				} catch (Exception e) {
					ValidationUtils.rejectIfEmpty(result, "Desired_start_time", "시간입력은 00:00 ~ 23:59 범위 입니다.");
					ValidationUtils.rejectIfEmpty(result, "Desired_end_time", "시간입력은 00:00 ~ 23:59 범위 입니다.");
				}
			}
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

				Excursions excursions = service.getExcursionsOne(new Excursions(apply.getHomepage_id(), apply.getExcursions_idx()));

				if ( excursions.getMax_apply() > 0 ) {
					List<String> allowedHomepageIds = Arrays.asList("h77", "h61", "h62", "h63", "h64");
					List<String> allowedDateTypes = Arrays.asList("0010", "0011");
					if (allowedHomepageIds.contains(excursions.getHomepage_id()) &&	allowedDateTypes.contains(excursions.getDate_type())) {
						int applyCount = apply.getPersonnel() + excursions.getPersonnel_count();

						if (excursions.getMax_apply() < applyCount ) {
							res.setValid(false);
							res.setMessage("신청가능팀수가 가득찼습니다.");
							return res;
						}
					} else {
						if (excursions.getMax_apply() <= excursions.getApply_count() ) {
							res.setValid(false);
							res.setMessage("신청가능팀수가 가득찼습니다.");
							return res;
						}
					}
				}

				apply.setAdd_id(apply.getApply_id());
				apply.setStart_date(excursions.getStart_date());
				apply.setStart_time(excursions.getStart_time());
				apply.setEnd_date(excursions.getEnd_date());
				apply.setEnd_time(excursions.getEnd_time());


				MultipartFile mFile = apply.getApply_file();
				if (!apply.getIsSeoguPrivatetour()) {
				if ( mFile.getSize() > 0 ) {
						String serverFileName = Long.toString((System.currentTimeMillis()));
						String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
						String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
						String filePath = "/" + apply.getHomepage_id();

						File f = excursionsStorage.addFile(mFile, serverFileName, filePath);
						apply.setServer_file_name(serverFileName);
						apply.setOrigin_file_name(originFileName);
						apply.setFile_extension(fileExtension);
						apply.setFile_size(f.length());
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
					/*PushAPI.sendMessage(homepage, PushAPI.SMS_TYPE_SMS, apply.getApplicant_tel(), "도서관 견학 신청이 정상 처리 되었습니다.", homepage.getHomepage_send_tell(), true);*/
				}

			}
			else if(apply.getEditMode().equals("DELETE")) {
				applyService.deleteApply(apply);
				res.setValid(true);
				res.setMessage("신청 취소 되었습니다.");
			}
			else if(apply.getEditMode().equals("MODIFY")) {
				MultipartFile mFile = apply.getApply_file();
				if ( mFile.getSize() > 0 ) {
					String serverFileName = Long.toString((System.currentTimeMillis()));
					String originFileName = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf("."));
					String fileExtension = FilenameUtils.getExtension(mFile.getOriginalFilename());
					String filePath = "/" + apply.getHomepage_id();

					File f = excursionsStorage.addFile(mFile, serverFileName, filePath);
					apply.setServer_file_name(serverFileName);
					apply.setOrigin_file_name(originFileName);
					apply.setFile_extension(fileExtension);
					apply.setFile_size(f.length());
				}
				applyService.modifyApplyFile(apply);
				res.setValid(true);
				res.setResult(apply.getEditMode());
				res.setMessage("수정 되었습니다.");
			}

		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = "/download/{homepage_id}/{apply_idx}.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile(@PathVariable("homepage_id") String homepage_id,@PathVariable("apply_idx") int apply_idx,
			@RequestParam(required=false, value="file_type") String file_type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Apply apply = new Apply();
		HttpHeaders responseHeaders = new HttpHeaders();
		byte[] bytes = null;
		apply.setApply_idx(apply_idx);
		apply.setHomepage_id(homepage_id);
		apply = applyService.getApplyDownOne(apply);
		String serverName = "";
		String orgName = "";
		String extension = "";

		serverName = apply.getServer_file_name();
		orgName = apply.getOrigin_file_name();
		extension = apply.getFile_extension();
		String filePath = excursionsStorage.getRootPath()+ "/" + homepage_id + "/" + serverName;
		File file = new File(filePath);

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			responseHeaders.setContentType(MediaType.valueOf("text/html"));
			applyService.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

//		String fileName = "";
		String fileName = String.format("%s.%s", orgName, extension);

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");

	    return bytes;
    }

}
