package kr.co.whalesoft.app.cms.module.volunteer.apply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.volunteer.Volunteer;
import kr.co.whalesoft.app.cms.module.volunteer.VolunteerService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.MemberAPI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = {"/cms/module/volunteer/apply"})
public class VolunteerApplyController extends BaseController {

	private final String basePath = "/cms/module/volunteer/apply/";

	@Autowired
	private VolunteerApplyService service;

	@Autowired
	private VolunteerService volunteerService;

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, VolunteerApply apply) {
		if(apply.getEditMode().equals("MODIFY")) {
			model.addAttribute("volunteerApply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		} else {
		model.addAttribute("volunteerApply", apply);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, VolunteerApply apply) {
		
		if(apply.getEditMode().equals("VIEW")) {
			service.deleteApply(apply);
		}
		
		apply.setPlan_date(apply.getStart_date());
		model.addAttribute("applyList", service.getApply(apply));
		return basePath + "applyEdit_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public kr.co.whalesoft.app.cms.module.volunteer.apply.ApplySearchView excel(Model model, VolunteerApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("apply", apply);
		model.addAttribute("applyResult", service.getApply(apply));
		return new kr.co.whalesoft.app.cms.module.volunteer.apply.ApplySearchView();
	}

	@RequestMapping(value = {"/excelDownloadMonth.*"}, method = RequestMethod.POST)
	public kr.co.whalesoft.app.cms.module.volunteer.apply.ApplySearchView excelDownloadMonth(Model model, VolunteerApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("apply", apply);

		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");

		model.addAttribute("applyResult", service.getApplyMonth(apply));
		return new ApplySearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(VolunteerApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<VolunteerApply> applyResult = service.getApply(apply);

		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, VolunteerApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");

		List<VolunteerApply> applyResult = service.getApplyMonth(apply);
		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, VolunteerApply apply) {
		model.addAttribute("volunteerApply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		return basePath + "stateEdit_ajax";
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, VolunteerApply apply, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member applyMember = new Member();
		applyMember.setUser_id(apply.getApplicant_member_id());

		List<Map<String, Object>> memberInfo = null;
		if ( apply.getSearch_api_type().equals("WEBID") ) {
			applyMember.setCertType(apply.getSearch_api_type());
			applyMember.setMember_id(apply.getApplicant_member_id());
			
			memberInfo = MemberAPI.checkDupUser("0", applyMember);
			
			if ( memberInfo.isEmpty() ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}

		result.put("memberInfo", memberInfo);

		return result;
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(VolunteerApply apply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(apply.getEditMode().equals("ADD") || apply.getEditMode().equals("MODIFY")) {
			if ( !"Y".equals(apply.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			ValidationUtils.rejectIfEmpty(result, "applicant_member_id", "신청자 ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력하세요.");
			if(apply.getHomepage_id().equals("h50")) {
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
			}else {
				ValidationUtils.rejectIfEmpty(result, "age", "연령대를 선택해주세요.");
				
			}
			if("h45".equals(apply.getHomepage_id()) || "h73".equals(apply.getHomepage_id()) || "h59".equals(apply.getHomepage_id()) || "h60".equals(apply.getHomepage_id())) {
				ValidationUtils.rejectIfEmpty(result, "protector_name", "보호자동의서에 보호자이름을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "protector_relation", "신청인과의 관계를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "protector_address", "보호자 주소를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "protector_tel_1", "보호자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "protector_tel_2", "보호자 전화번호를 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "protector_tel_3", "보호자 전화번호를 입력하세요.");
			}
			ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력하세요.");
		}
		


		if(!result.hasErrors()) {
			if(apply.getEditMode().equals("ADD")) {
				
				if (service.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}
				
//				if (service.checkApplyDay(apply) > 0 ) {
//					res.setValid(false);
//					res.setMessage("1일 1회만 신청 가능합니다." );
//					return res;
//				}
				
				String chekMonth = apply.getStart_date(); 
				apply.setCheckMonth(chekMonth.substring(0,7));
				
				if (service.checkApplyMonth(apply) > 3 ) {
					res.setValid(false);
					res.setMessage("월 4 회 까지만 신청 가능합니다.");
					return res;
				}
				
				
				Volunteer volunteer; 
				if (apply.getHomepage_id().equals("h50")) {
					 volunteer = volunteerService.getVolunteerOne(new Volunteer(apply.getHomepage_id(), apply.getVolunteer_idx()));
				}
				else {
					 volunteer = volunteerService.getTimeVolunteerOne(new Volunteer(apply.getHomepage_id(), apply.getVolunteer_idx()));
				}

				if ( volunteer.getMax_apply() > 0 ) {
					if (volunteer.getMax_apply() <= volunteer.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}

				apply.setAdd_id(getSessionMemberId(request));
				apply.setStart_date(volunteer.getStart_date());
				apply.setUse_time(volunteer.getUse_time());
				apply.setEnd_date(volunteer.getEnd_date());				
				String addResult = (String) service.addApply(apply, request);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(apply.getEditMode().equals("MODIFY")) {
				apply.setModify_id(getSessionMemberId(request));
				service.modifyApply(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(apply.getEditMode().equals("STATEMODIFY")) {
				apply.setModify_id(getSessionMemberId(request));
				service.modifyApplyState(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(apply.getEditMode().equals("DELETE")) {
				service.deleteApply(apply);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
