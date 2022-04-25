package kr.co.whalesoft.app.cms.module.showPerformance.apply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformance;
import kr.co.whalesoft.app.cms.module.showPerformance.ShowPerformanceService;
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
@RequestMapping(value = {"/cms/module/showPerformance/apply"})
public class ShowApplyController extends BaseController {

	private final String basePath = "/cms/module/showPerformance/apply/";

	@Autowired
	private ShowApplyService service;

	@Autowired
	private ShowPerformanceService showPerformanceService;

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ShowApply showApply) {
		if(showApply.getEditMode().equals("MODIFY")) {
			model.addAttribute("showApply", service.copyObjectPaging(showApply, service.getApplyOne(showApply)));
		} else {
			showApply.setMember_check("y");
			model.addAttribute("showApply", showApply);
		}
		return basePath + "edit_ajax";
	}
	@RequestMapping(value = {"/noMemberApply.*"})
	public String noMemberApply(Model model, ShowApply showApply) {
		showApply.setMember_check("n");
		if(showApply.getEditMode().equals("MODIFY")) {
			model.addAttribute("showApply", service.copyObjectPaging(showApply, service.getApplyOne(showApply)));
		} else {
			model.addAttribute("showApply", showApply);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, ShowApply showApply) {
		
		if(showApply.getEditMode().equals("VIEW")) {
			service.deleteApply(showApply);
		}
		
		showApply.setPlan_date(showApply.getStart_date());
		model.addAttribute("applyList", service.getApply(showApply));
		return basePath + "applyEdit_ajax";
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ShowApplySearchView excel(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("showApply", showApply);
		model.addAttribute("applyResult", service.getApply(showApply));
		return new ShowApplySearchView();
	}

	@RequestMapping(value = {"/excelDownloadMonth.*"}, method = RequestMethod.POST)
	public ShowApplySearchView excelDownloadMonth(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("showApply", showApply);

		showApply.setStart_date(showApply.getPlan_date() + "-01");
		showApply.setEnd_date(showApply.getPlan_date() + "-31");

		model.addAttribute("applyResult", service.getApplyMonth(showApply));
		return new ShowApplySearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<ShowApply> applyResult = service.getApply(showApply);

		new ShowApplyXlsToCsv(showApply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, ShowApply showApply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		showApply.setStart_date(showApply.getPlan_date() + "-01");
		showApply.setEnd_date(showApply.getPlan_date() + "-31");

		List<ShowApply> applyResult = service.getApplyMonth(showApply);

		new ShowApplyXlsToCsv(showApply, applyResult, "견학신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, ShowApply showApply) {
		model.addAttribute("showApply", service.copyObjectPaging(showApply, service.getApplyOne(showApply)));
		return basePath + "stateEdit_ajax";
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, ShowApply showApply, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		Member applyMember = new Member();
		applyMember.setUser_id(showApply.getApplicant_member_id());

		List<Map<String, Object>> memberInfo = null;
		if ( showApply.getSearch_api_type().equals("WEBID") ) {
			applyMember.setCertType(showApply.getSearch_api_type());
			applyMember.setMember_id(showApply.getApplicant_member_id());
			
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
	public @ResponseBody JsonResponse save(ShowApply showApply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if(showApply.getEditMode().equals("ADD") || showApply.getEditMode().equals("MODIFY")) {
			if ( !"Y".equals(showApply.getSelf_info_yn()) ) {
				res.setValid(false);
				res.setMessage("개인정보 동의 후 신청이 가능합니다.");
				return res;
			}
			if (showApply.getMember_check().equals("y")) {
				ValidationUtils.rejectIfEmpty(result, "applicant_member_id", "신청자 ID를 입력하세요.");
			}
			
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_2", "신청자 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_tel_3", "신청자 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "applicant_name", " 신청자 이름을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_1", "신청기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_2", "신청기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_tel_3", "신청기관 전화번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "total_peple", "방문인원을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "agency_address", "주소를 입력하세요.");
		}
		


		if(!result.hasErrors()) {
			if(showApply.getEditMode().equals("ADD")) {
				
				if (service.checkApply(showApply) > 0 ) {
					res.setValid(false);
					res.setMessage("이미 신청 되었습니다.");
					return res;
				}
				
				if (service.checkApplyDay(showApply) > 0 ) {
					res.setValid(false);
					res.setMessage("1일 1회만 신청 가능합니다." );
					return res;
				}
				
				ShowPerformance showPerformance = showPerformanceService.getShowPerformanceOne(new ShowPerformance(showApply.getHomepage_id(), showApply.getShowPerformance_idx()));
				
				if ( showPerformance.getMax_apply() > 0 ) {
					if (showPerformance.getMax_apply() <= showPerformance.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청 정원이 마감되었습니다.");
						return res;
					}
				}

				showApply.setAdd_id(getSessionMemberId(request));
				showApply.setStart_date(showPerformance.getStart_date());
				showApply.setStart_time(showPerformance.getStart_time());
				showApply.setEnd_date(showPerformance.getEnd_date());
				showApply.setEnd_time(showPerformance.getEnd_time());
				String addResult = (String) service.addApply(showApply, request);
				if (addResult != null) {
					res.setValid(true);
					res.setUrl(addResult);
					res.setTargetOpener(true);
					return res;
				}

				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(showApply.getEditMode().equals("MODIFY")) {
				showApply.setModify_id(getSessionMemberId(request));
				service.modifyApply(showApply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(showApply.getEditMode().equals("STATEMODIFY")) {
				showApply.setModify_id(getSessionMemberId(request));
				service.modifyApplyState(showApply);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
			else if(showApply.getEditMode().equals("DELETE")) {
				service.deleteApply(showApply);
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
