package kr.go.gbelib.app.cms.module.facility;

import java.text.SimpleDateFormat;
import java.util.*;

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

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
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
	private FacilityEquipmentService equipmentService;

	@Autowired
	private FacilityReqService facilityReqService;

	@Autowired
	private CodeService codeService;

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
		FacilityEquipment equipment = new FacilityEquipment();
		if(facility.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			equipment.setFacility_idx(facility.getFacility_idx());
			equipment.setHomepage_id(facility.getHomepage_id());
			List<FacilityEquipment> facilityEquipmentList = equipmentService.getFacilityEquipmentList(equipment);
			Facility facility1 = service.getFacilityOne(facility);
			if (facilityEquipmentList.size() > 0) {
				List<String> nameList = new ArrayList<>();
				List<String> standardList = new ArrayList<>();
				List<String> cntList = new ArrayList<>();
			    for (FacilityEquipment fe : facilityEquipmentList) {
					nameList.add(fe.getEquipment_name());
					standardList.add(fe.getEquipment_standard());
					cntList.add(fe.getEquipment_cnt());
				}
				facility1.setEquipment_name_list(nameList);
				facility1.setEquipment_standard_list(standardList);
				facility1.setEquipment_cnt_list(cntList);
			}
			model.addAttribute("facility", service.copyObjectPaging(facility, facility1));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("facility", facility);
		}
		model.addAttribute("dateTypeList", codeService.getCode(facility.getHomepage_id(), "H0002"));

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
			FacilityEquipment equipment = new FacilityEquipment();
			equipment.setHomepage_id(facility.getHomepage_id());
			if(editMode.equals("ADD")) {
				facility.setAdd_id(getSessionMemberId(request));
				equipment.setAdd_id(facility.getAdd_id());
				int addResult = service.addFacility(facility);
				if (addResult == 0) {
					res.setValid(false);
					res.setMessage("이용가능일자와 요일이 맞지 않습니다.");

				} else {
					List<Integer> idList = service.getFacilityLastIDX(facility);
					for (Integer id : idList) {
						equipment.setFacility_idx(id);
						for (int i = 0; i < facility.getEquipment_name_list().size();i++) {
							equipment.setEquipment_name(facility.getEquipment_name_list().get(i));
							equipment.setEquipment_standard(facility.getEquipment_standard_list().get(i));
							equipment.setEquipment_cnt(facility.getEquipment_cnt_list().get(i));
							equipmentService.addFacilityEquipment(equipment);
						}
					}
					res.setValid(true);
					res.setMessage("등록 되었습니다.");

				}
			} else if(editMode.equals("MODIFY")) {
				facility.setModify_id(getSessionMemberId(request));
				service.modifyFacility(facility);
				equipment.setFacility_idx(facility.getFacility_idx());
				equipment.setAdd_id(facility.getModify_id());
				equipmentService.deleteFacilityEquipment(equipment);
				for (int i = 0; i < facility.getEquipment_name_list().size();i++) {
					equipment.setEquipment_name(facility.getEquipment_name_list().get(i));
					equipment.setEquipment_standard(facility.getEquipment_standard_list().get(i));
					equipment.setEquipment_cnt(facility.getEquipment_cnt_list().get(i));
					equipmentService.addFacilityEquipment(equipment);
				}
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				equipment.setFacility_idx(facility.getFacility_idx());
				equipmentService.deleteFacilityEquipment(equipment);
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
		FacilityEquipment equipment = new FacilityEquipment();
		equipment.setHomepage_id(facilityReq.getHomepage_id());
		equipment.setFacility_idx(facilityReq.getFacility_idx());

		model.addAttribute("facilityEquipmentList",equipmentService.getFacilityEquipmentList(equipment));
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

		List<Map<String, Object>> memberInfo = null;
		if ( facilityReq.getSearch_api_type().equals("WEBID") ) {
			facilityReqMember.setMember_id(facilityReq.getApply_id());

			memberInfo = MemberAPI.checkDupUser("0", facilityReqMember);

			if ( memberInfo.isEmpty() ) {
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
				facilityReq.setModify_id(getSessionMemberId(request));
				facilityReqService.modifyFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if ( editMode.equals("DELETE") ) {
				facilityReq.setModify_id(getSessionMemberId(request));
				facilityReqService.deleteFacilityReq(facilityReq);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
			else if ( editMode.equals("OK") ) {
				facilityReq.setApply_status("2");
				facilityReq.setModify_id(getSessionMemberId(request));
				facilityReqService.changeStatus(facilityReq);
				res.setValid(true);
				res.setMessage("승인 되었습니다.");
			}
			else if ( editMode.equals("CANCEL") ) {
				facilityReq.setApply_status("3");
				facilityReq.setModify_id(getSessionMemberId(request));
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
		List<FacilityReq> list = facilityReqService.getFacilityReqList(facilityReq);
		List<FacilityEquipment> eqList = new ArrayList<>();
		model.addAttribute("applyList", list);
		FacilityEquipment equipment = new FacilityEquipment();
		equipment.setFacility_idx(facilityReq.getFacility_idx());
		equipment.setHomepage_id(facilityReq.getHomepage_id());
		for (FacilityReq req : list) {
			if (StringUtils.isNotEmpty(req.getEquipment())) {
				String[] equipmentInfo =  req.getEquipment().split(",");
				for (int i = 0; i < equipmentInfo.length; i++) {
					FacilityEquipment equipment2 = new FacilityEquipment();
					String[] info = equipmentInfo[i].split(":");
					equipment.setEquipment_idx(Integer.parseInt(info[0]));
					equipment2 = equipmentService.getFacilityEquipmentOne(equipment);
					equipment2.setEquipment_need_cnt(info[1]);
					eqList.add(equipment2);
				}
			}
		}
		model.addAttribute("facilityEquipmentList", eqList);

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