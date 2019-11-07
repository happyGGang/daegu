package kr.go.gbelib.app.cms.module.facility;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.excursions.apply.Apply;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReq;
import kr.go.gbelib.app.cms.module.facilityReq.FacilityReqService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/facility"})
public class FacilityController extends BaseController {

	private final String basePath = "/cms/module/facility/";

	@Autowired
	private FacilityService service;
	
	@Autowired
	private FacilityReqService facilityReqService;	
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Facility facility, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			facility.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		if ( StringUtils.isEmpty(facility.getPlan_date()) ) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM");
			facility.setPlan_date(sf.format(new Date()));	
		}
		
		model.addAttribute("calendarList", service.getCalendar(facility));
		model.addAttribute("facility", facility);
		model.addAttribute("facilityRepo", service.convertToRepo(service.getFacilityList(facility)));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Facility facility, HttpServletRequest request) throws AuthException {
		if(facility.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("facility", service.copyObjectPaging(facility, service.getFacilityOne(facility)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("facility", facility);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Facility facility, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = facility.getEditMode();
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "facility_name", "시설물명을 입력하세요.");
			if ( editMode.equals("ADD") ) {
				ValidationUtils.rejectIfEmpty(result, "start_date", "이용 가능 기간을 선택하세요.");
				ValidationUtils.rejectIfEmpty(result, "end_date", "이용 가능 기간을 선택하세요.");
				
			}
			
			ValidationUtils.rejectIfEmpty(result, "start_time", "이용 가능시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_time", "이용 가능시간을 입력하세요.");
			
			ValidationUtils.rejectIfEmpty(result, "apply_start_date", "신청시작일를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_date", "신청종료일를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_start_time", "신청시작시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_end_time", "신청종료시간을 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "limit_count", "신청 제한 수는 숫자만 입력 가능합니다.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "사용여부를 선택하세요.");
			
			SimpleDateFormat sfTime = new SimpleDateFormat("HH:mm");
			sfTime.setLenient(false);
			try {
				sfTime.parse(facility.getStart_time());
				sfTime.parse(facility.getEnd_time());
				sfTime.parse(facility.getApply_start_time());
				sfTime.parse(facility.getApply_end_time());
			} catch (Exception e) {
				result.reject("시간입력은 00:00 ~ 23:59 범위 입니다.");
			}
		}
		
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				facility.setAdd_id(getSessionMemberId(request));
				service.addFacility(facility);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				facility.setMod_id(getSessionMemberId(request));
				service.modifyFacility(facility);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteFacility(facility);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/editApply.*"}, method = RequestMethod.GET)
	public String editApply(Model model, FacilityReq facilityReq) {
		model.addAttribute("facility", service.getFacilityOne(new Facility(facilityReq.getHomepage_id(), facilityReq.getFacility_idx())));
		
		if ( facilityReq.getEditMode().equals("MODIFY") ) {
			model.addAttribute("facilityReq", facilityReqService.copyObjectPaging(facilityReq, facilityReqService.getFacilityReqOne(facilityReq)));
		} 
		else {
			model.addAttribute("facilityReq", facilityReq);
		}
		return basePath + "editApply_ajax";
	}
	
	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, FacilityReq facilityReq, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member facilityReqMember = new Member();
		facilityReqMember.setUser_id(facilityReq.getApply_id());
		facilityReqMember.setCheck_certify_type("WEBID");
		facilityReqMember.setCheck_certify_data(facilityReq.getApply_id());

		Map<String, String> memberInfo = null;
		if ( facilityReq.getSearch_api_type().equals("WEBID") ) {  
			facilityReqMember.setCheck_certify_type("WEBID");
			facilityReqMember.setCheck_certify_data(facilityReq.getApply_id());

			memberInfo = MemberAPI.getMemberCertify("WEB", facilityReqMember);
			
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}
		else {
			memberInfo = MemberAPI.getDupUser("WEB", facilityReqMember, "0002", facilityReq.getApply_id());
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}
		result.put("memberInfo", memberInfo);
		return result; 
	}
	
	@RequestMapping(value = {"/saveApply.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveApply(Model model, FacilityReq facilityReq, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = facilityReq.getEditMode();
		if ( editMode.equals("ADD") || editMode.equals("MODIFY") ) {
			if ( editMode.equals("ADD") ) {
				ValidationUtils.rejectIfEmpty(result, "apply_id", "신청자 ID를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "member_key", "유효한 회원이 아닙니다.");
				if ( !"Y".equals(facilityReq.getSelf_info_yn()) ) {
					res.setValid(false);
					res.setMessage("개인정보 동의 후 신청이 가능합니다.");
					return res;
				}
			}
			
			ValidationUtils.rejectIfEmpty(result, "apply_phone", "신청자 휴대전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "apply_desc", "사용목적을 입력하세요.");
		}
		
		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				if ( facilityReqService.checkFacilityReq(facilityReq) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 등록된 신청자 입니다.");
					return res;
				}
				
				facilityReq.setAdd_id(getSessionMemberId(request));
				facilityReqService.addFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} 
			else if ( editMode.equals("MODIFY") ) {
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.modifyFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} 
			else if ( editMode.equals("DELETE") ) {
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.deleteFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			else if ( editMode.equals("OK") ) {
				facilityReq.setApply_status("2");
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.changeStatus(facilityReq);
				res.setValid(true);
				res.setMessage("승인 되었습니다.");
			}
			else if ( editMode.equals("CANCEL") ) {
				facilityReq.setApply_status("3");
				facilityReq.setMod_id(getSessionMemberId(request));
				facilityReqService.changeStatus(facilityReq);
				res.setValid(true);
				res.setMessage("취소 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/applyList.*"}, method = RequestMethod.GET)
	public String applyList(Model model, FacilityReq facilityReq) {
		model.addAttribute("facilityReq", facilityReq);
		model.addAttribute("applyList", facilityReqService.getFacilityReqList(facilityReq));
		
		return basePath + "applyList_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public FacilitySearchView excelDownload(Model model, Facility facility, HttpServletRequest request, HttpServletResponse response) throws Exception{
		model.addAttribute("facility", facility); 		
		model.addAttribute("facilityResult", service.getFacilityListByExcel(facility));
		model.addAttribute("facilityReqResult", facilityReqService.getFacilityReqListByExcel(new FacilityReq(facility.getHomepage_id(), facility.getPlan_date(), facility.getExcel_type())));
		return new FacilitySearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, Facility facility, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		model.addAttribute("facility", facility);
//		model.addAttribute("facilityResult", service.getFacilityListByExcel(facility));
//		model.addAttribute("facilityReqResult", facilityReqService.getFacilityReqListByExcel(new FacilityReq(facility.getHomepage_id(), facility.getPlan_date(), facility.getExcel_type())));
		List<Facility> facilityResult = service.getFacilityListByExcel(facility);
		List<FacilityReq> facilityReqResult = facilityReqService.getFacilityReqListByExcel(new FacilityReq(facility.getHomepage_id(), facility.getPlan_date(), facility.getExcel_type()));
		
		new FacilityXlsToCsv(facility, facilityResult, facilityReqResult, "시설물 리스트.csv", request, response);
	}
	
}