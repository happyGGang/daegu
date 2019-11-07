package kr.co.whalesoft.app.cms.module.excursions.apply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.excursions.Excursions;
import kr.co.whalesoft.app.cms.module.excursions.ExcursionsService;
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
@RequestMapping(value = {"/cms/module/excursions/apply"})
public class ApplyController extends BaseController {

	private final String basePath = "/cms/module/excursions/apply/";
	
	@Autowired
	private ApplyService service;
	
	@Autowired
	private ExcursionsService excursionsService;
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Apply apply) {
		if(apply.getEditMode().equals("MODIFY")) {
			model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		} else {
		model.addAttribute("apply", apply);
		}
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, Apply apply) {
		apply.setPlan_date(apply.getStart_date());
		model.addAttribute("applyList", service.getApply(apply));
		return basePath + "applyEdit_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ApplySearchView excel(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		model.addAttribute("apply", apply); 		
		model.addAttribute("applyResult", service.getApply(apply));
		return new ApplySearchView();
	}
	
	@RequestMapping(value = {"/excelDownloadMonth.*"}, method = RequestMethod.POST)
	public ApplySearchView excelDownloadMonth(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		model.addAttribute("apply", apply); 		
		
		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");
		
		model.addAttribute("applyResult", service.getApplyMonth(apply));
		return new ApplySearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Apply> applyResult = service.getApply(apply);
		
		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, Apply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");
		
		List<Apply> applyResult = service.getApplyMonth(apply);
		
		new ApplyXlsToCsv(apply, applyResult, "견학신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, Apply apply) {
		model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		return basePath + "stateEdit_ajax";
	}
	
	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, Apply apply, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member applyMember = new Member();
		applyMember.setUser_id(apply.getApplicant_member_id());
		applyMember.setCheck_certify_type("WEBID");
		applyMember.setCheck_certify_data(apply.getApplicant_member_id());

		Map<String, String> memberInfo = null;
		if ( apply.getSearch_api_type().equals("WEBID") ) {
			applyMember.setCheck_certify_type("WEBID");
			applyMember.setCheck_certify_data(apply.getApplicant_member_id());

			memberInfo = MemberAPI.getMemberCertify("WEB", applyMember);
			
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			} else {
				Member member = new Member();
				member.setUser_id(memberInfo.get("USER_ID"));
				memberInfo = MemberAPI.getMember("WEB", member);
			}
		}
		else {
//			memberInfo = MemberAPI.getDupUser("WEB", applyMember, "0002", apply.getApplicant_member_id());
			Member member = new Member();
			member.setUser_id(apply.getApplicant_member_id());
			memberInfo = MemberAPI.getMember("WEB", member);
			if ( memberInfo == null ) {
				result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
				return result;
			}
		}
				
		result.put("memberInfo", memberInfo);
		
		return result; 
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Apply apply, BindingResult result, HttpServletRequest request) {
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
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "age", "연령대를 입력해주세요.");
			ValidationUtils.rejectIfEmpty(result, "personnel", "방문인원을 입력하세요.");
		}
		if(!result.hasErrors()) {
			if(apply.getEditMode().equals("ADD")) {
				if ( service.checkApply(apply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}
				Excursions excursions = excursionsService.getExcursionsOne(new Excursions(apply.getHomepage_id(), apply.getExcursions_idx()));
				
				if ( excursions.getMax_apply() > 0 ) {
					if (excursions.getMax_apply() <= excursions.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}
				
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
				service.modifyApply(apply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} 
			else if(apply.getEditMode().equals("STATEMODIFY")) {
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
