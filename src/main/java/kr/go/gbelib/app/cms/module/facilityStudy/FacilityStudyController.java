/**
 *
 */
package kr.go.gbelib.app.cms.module.facilityStudy;

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

import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManage;
import kr.co.whalesoft.app.cms.module.calendarManage.CalendarManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

/**
 * @author whaleesoft YONGJU 2020. 2. 17.
 *
 */
@Controller
@RequestMapping(value = {"/cms/module/facilityStudy"})
public class FacilityStudyController extends BaseController {

	private final String basePath = "/cms/module/facilityStudy/";

	@Autowired
	private FacilityStudyService service;
	
	@Autowired
	private CalendarManageService calendarManageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, FacilityStudy facilityStudy, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		if ( StringUtils.isEmpty(facilityStudy.getPlan_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			facilityStudy.setPlan_date(sf.format(new Date()));
		}

		service.setPaging(model, service.getFacilityStudyCount(facilityStudy), facilityStudy);
		model.addAttribute("facilityStudy", facilityStudy);
		model.addAttribute("facilityStudyList", service.getFacilityStudyList(facilityStudy));
		return basePath + "index";
	}

	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, FacilityStudy facilityStudy, HttpServletRequest request) {
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		if (facilityStudy.getEditMode().equals("ADD")) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			facilityStudy.setStudy_date(sf.format(new Date()));
			model.addAttribute("facilityStudy", facilityStudy);
		} else {
			model.addAttribute("facilityStudy", service.copyObjectPaging(facilityStudy, service.getFacilityStudyOne(facilityStudy)));
		}

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/cancel.*"}, method = RequestMethod.GET)
	public String cancel(Model model, FacilityStudy facilityStudy, HttpServletRequest request) {
		facilityStudy.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("facilityStudy", service.copyObjectPaging(facilityStudy, service.getFacilityStudyOne(facilityStudy)));

		return basePath + "cancel_ajax";
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(FacilityStudy facilityStudy, BindingResult result, HttpServletRequest request) {
		facilityStudy.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);
		
		if (facilityStudy.getEditMode().equals("ADD")) {
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
			if(facilityStudy.getMan_count() == 0 && facilityStudy.getWoman_count() == 0) {
    			result.rejectValue("man_count", "참여인원을 입력하세요.");
    		}

			ValidationUtils.rejectIfEmpty(result, "apply_list", "'참가자명단' 필수 입력 항목입니다.");
			ValidationUtils.rejectIfStringLength(result, "apply_list", 500, "참가자명단");

			CalendarManage cm = new CalendarManage();
			cm.setHomepage_id(getAsideHomepageId(request));
			cm.setPlan_day(facilityStudy.getStudy_date());
			cm = calendarManageService.getClosedDate3(cm);
			if(cm != null) {
				result.reject("휴관일에는 신청할 수 없습니다.");
			}
		} else if (facilityStudy.getEditMode().equals("CANCEL_TXT")) {
			ValidationUtils.rejectIfEmpty(result, "cancel_txt", "취소 사유를 입력해 주세요.");
		}

		if (!result.hasErrors()) {
			if (facilityStudy.getEditMode().equals("DELETE")) {
				service.deleteFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if (facilityStudy.getEditMode().equals("DELETE_ALL")) {
				service.deleteFacilityStudyALL(facilityStudy);
				res.setValid(true);
				res.setMessage("일괄 삭제되었습니다.");
			} else if (facilityStudy.getEditMode().equals("APPROVE")) {
				service.approveFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("승인되었습니다.");
			} else if (facilityStudy.getEditMode().equals("CANCEL")) {
				service.cancelFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if (facilityStudy.getEditMode().equals("CANCEL_TXT")) {
				facilityStudy.setCancel_txt("관리자 취소 : " + facilityStudy.getCancel_txt());
				service.cancelTxtFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if (facilityStudy.getEditMode().equals("READY")) {
				service.readyFacilityStudy(facilityStudy);
				res.setValid(true);
				res.setMessage("변경되었습니다.");
			} else if (facilityStudy.getEditMode().equals("ADD")) {
				if (service.isAlready(facilityStudy)) {
					res.setValid(false);
					res.setMessage("해당 시간으로 등록 불가합니다.");
				} else {
					service.addFacilityStudy(facilityStudy);
					res.setValid(true);
					res.setMessage("등록되었습니다.");

				}
			} else if (facilityStudy.getEditMode().equals("MODIFY")) {
				if (service.isAlready(facilityStudy)) {
					res.setValid(false);
					res.setMessage("해당 시간으로 변경 불가합니다.");
				} else {
					service.modifyFacilityStudy(facilityStudy);
					res.setValid(true);
					res.setMessage("변경되었습니다.");
				}

			} else {

			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public FacilityStudyView excel(Model model, FacilityStudy facilityStudy, HttpServletRequest request, HttpServletResponse response) throws Exception{
		facilityStudy.setHomepage_id(getAsideHomepageId(request));
		List<FacilityStudy> facilityStudyList = service.getFacilityStudyAll(facilityStudy);
		model.addAttribute("facilityStudy", facilityStudy);
		model.addAttribute("facilityStudyList", facilityStudyList);

		return new FacilityStudyView();
	}
}
