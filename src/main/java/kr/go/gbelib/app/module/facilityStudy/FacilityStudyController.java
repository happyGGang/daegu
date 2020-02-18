/**
 *
 */
package kr.go.gbelib.app.module.facilityStudy;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.facilityStudy.FacilityStudy;
import kr.go.gbelib.app.cms.module.facilityStudy.FacilityStudyService;

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
@Controller(value = "userFacilityStudy")
@RequestMapping(value = {"/{homepagePath}/module/facilityStudy"})
public class FacilityStudyController extends BaseController {

	private final String basePath = "/homepage/%s/module/facilityStudy/";

	@Autowired
	private FacilityStudyService service;

	@Autowired
	private CalendarManageService calendarManageService;

	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, FacilityStudy facilityStudy, HttpServletRequest request, @PathVariable ("url") String url) {
		Homepage homepage = getSessionHomepage(request);
		facilityStudy.setHomepage_id(homepage.getHomepage_id());

		if (StringUtils.isEmpty(facilityStudy.getPlan_date())) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			facilityStudy.setPlan_date(sf.format(new Date()));
		}

		model.addAttribute("facilityStudy", facilityStudy);
//		getClosedDate3
		CalendarManage cm = new CalendarManage();
		cm.setHomepage_id(homepage.getHomepage_id());
		cm.setPlan_day(facilityStudy.getPlan_date());
		cm = calendarManageService.getClosedDate3(cm);
		if (cm == null) {
			model.addAttribute("applicableList", service.getApplicableList(facilityStudy));
		} else {
			model.addAttribute("closedDay", true);
		}

		return String.format(basePath, homepage.getFolder()) + "index";
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, FacilityStudy fs, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		fs.setHomepage_id(homepage.getHomepage_id());

		if (fs.getEditMode().equals("VIEW")) {
			HttpSession session = request.getSession();
			if (session.getAttribute("studyRoomCert") == null) {
				return String.format(basePath, homepage.getFolder()) + "apply";
			}
			FacilityStudy cert = (FacilityStudy) session.getAttribute("studyRoomCert");

			if (StringUtils.isEmpty(cert.getApply_name()) || StringUtils.isEmpty(cert.getApply_password())) {
				return String.format(basePath, homepage.getFolder()) + "apply";
			}

			fs.setApply_name(cert.getApply_name());
			fs.setApply_password(cert.getApply_password());
			model.addAttribute("facilityStudy", service.copyObjectPaging(fs, service.getFacilityStudyOne(fs)));

		} else {
			model.addAttribute("facilityStudy", fs);

		}

		return String.format(basePath, homepage.getFolder()) + "edit";
	}

	@RequestMapping (value = {"/apply.*"}, method = RequestMethod.GET)
	public String apply(Model model, FacilityStudy fs, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		fs.setHomepage_id(homepage.getHomepage_id());

		return String.format(basePath, homepage.getFolder()) + "apply";
	}

	@RequestMapping (value = {"/applyList.*"})
	public String applyList(Model model, FacilityStudy fs, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		fs.setHomepage_id(homepage.getHomepage_id());

		HttpSession session = request.getSession();

		if (StringUtils.isNotEmpty(fs.getApply_name()) && StringUtils.isNotEmpty(fs.getApply_password())) {
			session.setAttribute("studyRoomCert", fs);
		} else {
			if (session.getAttribute("studyRoomCert") == null) {
				return String.format(basePath, homepage.getFolder()) + "apply";
			}
		}

		FacilityStudy cert = (FacilityStudy) session.getAttribute("studyRoomCert");

		cert = (FacilityStudy) service.copyObjectPaging(fs, cert);

		service.setPaging(model, service.getFacilityStudyCount(cert), cert);
		model.addAttribute("facilityStudy", cert);
		model.addAttribute("facilityStudyList", service.getFacilityStudyList(cert));


		return String.format(basePath, homepage.getFolder()) + "applyList";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FacilityStudy fs, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		fs.setHomepage_id(homepage.getHomepage_id());

		if (fs.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "apply_name", "'신청자명' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_name", 100, "신청자명");
			ValidationUtils.rejectIfEmpty(result, "apply_password", "'비밀번호' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_password", 64, "비밀번호");
			ValidationUtils.rejectIfEmpty(result, "apply_phone1", "'휴대폰번호1' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_phone1", 13, "휴대전화1");
			ValidationUtils.rejectIfEmpty(result, "apply_phone2", "'휴대폰번호2' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_phone2", 13, "휴대전화2");
			ValidationUtils.rejectIfEmpty(result, "study_name", "'모임명' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "study_name", 100, "모임명");
			ValidationUtils.rejectIfEmpty(result, "study_purpose", "'신청목적' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "study_purpose", 500, "신청목적");
			ValidationUtils.rejectIfEmpty(result, "apply_count", "'참여인원' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfEmpty(result, "apply_list", "'참가자명단' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_list", 500, "참가자명단");


			String[] plan_date = fs.getStudy_date().split("-");

			DateTime reference = new DateTime(Integer.parseInt(plan_date[0]), Integer.parseInt(plan_date[1]), 20, 0, 0);
			long ref = reference.plusMonths(-1).getMillis();
			DateTime today = new DateTime();

			if (ref > today.getMillis()) {
				result.reject("20일 이후 신청 가능합니다.");
			}


		}

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			if (fs.getEditMode().equals("ADD")) {
				service.addFacilityStudy(fs);
				res.setValid(true);
				res.setMessage("신청되었습니다.");
				res.setUrl("index.do?menu_idx="+fs.getMenu_idx()+"&plan_date="+fs.getStudy_date());
			} else if (fs.getEditMode().equals("CANCEL")) {

				HttpSession session = request.getSession();
				if (session.getAttribute("studyRoomCert") == null) {
					res.setValid(false);
					res.setMessage("비정상적인 접근입니다.");
					return res;
				}
				FacilityStudy cert = (FacilityStudy) session.getAttribute("studyRoomCert");

				if (StringUtils.isEmpty(cert.getApply_name()) || StringUtils.isEmpty(cert.getApply_password())) {
					res.setValid(false);
					res.setMessage("비정상적인 접근입니다.");
					return res;
				}

				fs.setApply_name(cert.getApply_name());
				fs.setApply_password(cert.getApply_password());

				service.cancelUserFacilityStudy(fs);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
				res.setUrl("applyList.do?menu_idx="+fs.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}



}
