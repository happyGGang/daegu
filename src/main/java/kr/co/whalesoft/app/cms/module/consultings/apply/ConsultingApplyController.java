package kr.co.whalesoft.app.cms.module.consultings.apply;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.consultings.Consultings;
import kr.co.whalesoft.app.cms.module.consultings.ConsultingsService;
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
@RequestMapping(value = {"/cms/module/consultings/apply"})
public class ConsultingApplyController extends BaseController {

	private final String basePath = "/cms/module/consultings/apply/";

	@Autowired
	private ConsultingApplyService service;

	@Autowired
	private ConsultingsService consultingsService;

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ConsultingApply apply) {
		if(apply.getEditMode().equals("MODIFY")) {
			model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		} else {
		model.addAttribute("apply", apply);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/applyEdit.*"})
	public String applyEdit(Model model, ConsultingApply apply) {
		apply.setPlan_date(apply.getStart_date());
		model.addAttribute("applyList", service.getApply(apply));
		return basePath + "applyEdit_ajax";
	}

	@RequestMapping(value = {"/excelDownloadDate.*"})
	public String excelDownloadDate(Model model, ConsultingApply apply) {
		Consultings consultings = new Consultings();
		consultings.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		model.addAttribute("consultings", consultings);		
		model.addAttribute("apply", apply);
		return basePath + "excelDownloadDate_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public ConsultingApplySearchView excel(Model model, ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("apply", apply);
		model.addAttribute("applyResult", service.getApply(apply));
		return new ConsultingApplySearchView();
	}		

	@RequestMapping(value = {"/excelDownloadMonth.*"})
	public ConsultingApplySearchView excelDownloadMonth(Model model, ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		if("default".equals(apply.getEditMode())){
			apply.setStart_date(apply.getPlan_year1() + "-" +apply.getPlan_month1() + "-01");
			apply.setEnd_date(apply.getPlan_year1() + "-" +apply.getPlan_month1() + "-31");
		}else if ("select".equals(apply.getEditMode())) {
			apply.setStart_date(apply.getPlan_year2() + "-" +apply.getPlan_month2() + "-01");
			apply.setEnd_date(apply.getPlan_year3() + "-" +apply.getPlan_month3() + "-31");
		}
		
		model.addAttribute("apply", apply);
		model.addAttribute("applyResult", service.getApplyMonth(apply));
		return new ConsultingApplySearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<ConsultingApply> applyResult = service.getApply(apply);

		new ConsultingApplyXlsToCsv(apply, applyResult, "상담신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/csvDownloadMonth.*"}, method = RequestMethod.POST)
	public void csvDownloadMonth(Model model, ConsultingApply apply, HttpServletRequest request, HttpServletResponse response) throws Exception{
		apply.setStart_date(apply.getPlan_date() + "-01");
		apply.setEnd_date(apply.getPlan_date() + "-31");

		List<ConsultingApply> applyResult = service.getApplyMonth(apply);

		new ConsultingApplyXlsToCsv(apply, applyResult, "상담신청현황 리스트.csv", request, response);
	}

	@RequestMapping(value = {"/stateEdit.*"})
	public String stateEdit(Model model, ConsultingApply apply) {
		model.addAttribute("apply", service.copyObjectPaging(apply, service.getApplyOne(apply)));
		return basePath + "stateEdit_ajax";
	}

	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, ConsultingApply apply, HttpServletRequest request) {
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
	public @ResponseBody JsonResponse save(ConsultingApply apply, BindingResult result, HttpServletRequest request) {
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
				Consultings consultings = consultingsService.getConsultingsOne(new Consultings(apply.getHomepage_id(), apply.getConsultings_idx()));

				if ( consultings.getMax_apply() > 0 ) {
					if (consultings.getMax_apply() <= consultings.getApply_count() ) {
						res.setValid(false);
						res.setMessage("신청가능팀수가 가득찼습니다.");
						return res;
					}
				}

				apply.setAdd_id(getSessionMemberId(request));
				apply.setStart_date(consultings.getStart_date());
				apply.setStart_time(consultings.getStart_time());
				apply.setEnd_date(consultings.getEnd_date());
				apply.setEnd_time(consultings.getEnd_time());
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
