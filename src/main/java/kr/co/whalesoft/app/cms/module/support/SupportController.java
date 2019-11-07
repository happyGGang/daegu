package kr.co.whalesoft.app.cms.module.support;

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
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.module.supportManage.SupportManage;
import kr.co.whalesoft.app.cms.module.supportManage.SupportManageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.dept.Dept;
import kr.go.gbelib.app.cms.module.dept.DeptService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
@RequestMapping(value = {"/cms/module/support"})
public class SupportController extends BaseController {
	
	private final String basePath = "/cms/module/support/";
	
	@Autowired
	private SupportService service;
	
	@Autowired
	private SupportManageService supportManageService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private DeptService deptService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Support support, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			support.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		if(support.getPlan_date() == null || support.getPlan_date().equals("")) {
			support.setPlan_date(new SimpleDateFormat("yyyy-MM").format(new Date()));
		}
	
		model.addAttribute("supportManageRepo", supportManageService.getSupportManageRepo(supportManageService.getSupportManage(new SupportManage(support.getHomepage_id(), support.getPlan_date()))));
		model.addAttribute("calendarList", service.getCalendar(support));
		model.addAttribute("support", support);
		model.addAttribute("supportList", service.getSupport(support));
		model.addAttribute("monthList", codeService.getCode(support.getHomepage_id(), "C0004"));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Support support, HttpServletRequest request) throws AuthException {
		
		if(support.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("support", service.copyObjectPaging(support, service.getSupportOne(support)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("support", support);
		}
		model.addAttribute("cellPhoneCode", codeService.getCode(support.getHomepage_id(), "C0002"));
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/editManage.*"})
	public String editManage(Model model, SupportManage supportManage) {
		model.addAttribute("supportManageList", supportManageService.getSupportManage(supportManage));
		
		if(supportManage.getEditMode().equals("MODIFY")) {
			model.addAttribute("supportManage", supportManageService.copyObjectPaging(supportManage, supportManageService.getSupportManageOne(supportManage)));
		} else {
			model.addAttribute("supportManage", supportManage);
		}
		
		return basePath + "editManage_ajax";
	}
	
	@RequestMapping(value = {"/result.*"})
	public String result(Model model, Support support) {
		model.addAttribute("support", service.copyObjectPaging(support, service.getSupportOne(support)));
		return basePath + "result_ajax";
	}
	
	@RequestMapping(value = {"/indexApply.*"})
	public String indexApply(Model model, Support support) {
		model.addAttribute("support", support);
		model.addAttribute("supportList", service.getSupport(support));
		return basePath + "indexApply_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public SupportSearchView excel(Model model, Support support, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		model.addAttribute("support", support); 		
		model.addAttribute("supportResult", service.getSupport(support));
		return new SupportSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Support support, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<Support> supportList = service.getSupport(support);
		
		new SupportXlsToCsv(supportList, "현장지원 신청현황 리스트.csv", request, response);
	}
	
	@RequestMapping(value = { "/searchDept.*" })
	public String searchDept(Model model, Dept dept, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if ( StringUtils.isNotEmpty(dept.getCode_name()) ) {
			dept.setSearch_type("CODE_NAME");
			dept.setSearch_text(dept.getCode_name());
		}
		
		int count = deptService.getDeptCount(dept);
		deptService.setPaging(model, count, dept);
		model.addAttribute("dept", dept);
		model.addAttribute("deptListCount", count);
		model.addAttribute("deptList", deptService.getDept(dept));
		return "/cms/module/dept/search_ajax";
	}
	
	@RequestMapping(value = {"/checkId.*"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkId(Model model, Support support, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member supportMember = new Member();
		supportMember.setUser_id(support.getReq_id());
		supportMember.setCheck_certify_type("WEBID");
		supportMember.setCheck_certify_data(support.getReq_id());

		Map<String, String> memberInfo = MemberAPI.getMemberCertify("WEB", supportMember);
		
		if ( memberInfo != null ) {
			String web_id 	= memberInfo.get("WEB_ID");
			String seq_no 	= memberInfo.get("SEQ_NO");
			
			support.setReq_id(web_id);
			support.setMember_key(seq_no);		
		}
		else {
			result.put("resultMsg", "해당 ID는 유효한 회원이 아닙니다.");
			return result;
		}
		result.put("memberInfo", memberInfo);
		return result; 
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Support support, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(!support.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "req_organ_code", "신청기관명을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_name", "신청자성명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel1", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel2", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "requer_tel3", "신청자 휴대폰번호를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "hope_req_dt", "지원희망일자를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "req_title", "제목을 입력하세요.");
		}
			
		SupportManage supportManage = supportManageService.getCheckReqCount(new SupportManage(support.getHomepage_id(), support.getHope_req_dt()));
		if ( supportManage == null ) {
			res.setValid(false);
			res.setMessage("신청 가능일이 아닙니다.");
			return res;
		}
		
		if (supportManage.getLimit_req_count() > supportManage.getReq_count() ) {
			Member member = (Member) getSessionMemberInfo(request);		

			if(!result.hasErrors()) {
				support.setReq_id(member.getMember_id());
				if(support.getEditMode().equals("ADD")) {
					service.addSupport(support);
					res.setValid(true);
					res.setMessage("등록되었습니다.");
					
				} else if(support.getEditMode().equals("MODIFY")) {
					service.modifySupport(support);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				} else if(support.getEditMode().equals("DELETE")) {
					service.deleteSupport(support);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			} else {
				res.setValid(false);
				res.setResult(result.getAllErrors());
			}			
		}
		else {
			res.setValid(false);
			res.setMessage("신청 가능한 횟수가 다 찼습니다.");
			return res;
		}
		return res;
	}
	
	@RequestMapping(value = {"/saveManage.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveManage(SupportManage supportManage, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(!supportManage.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "시작일을 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "종료일을 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "limit_req_count", "신청 제한 수를 입력하세요.");
		}
			
		Member member = (Member) getSessionMemberInfo(request);		

		if(!result.hasErrors()) {
			supportManage.setAdd_id(member.getMember_id());
			supportManage.setMod_id(member.getMember_id());
			if(supportManage.getEditMode().equals("ADD")) {
				supportManageService.addSupportManage(supportManage);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(supportManage.getEditMode().equals("MODIFY")) {
				supportManageService.modifySupportManage(supportManage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(supportManage.getEditMode().equals("DELETE")) {
				supportManageService.deleteSupportManage(supportManage);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/result.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse result(Support support, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		if(!support.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "support_div", "지원구분을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "supporter", "지원자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "support_content", "지원내용을 입력하세요.");
		}
			
		Member member = (Member) getSessionMemberInfo(request);		

		if(!result.hasErrors()) {
			support.setReq_id(member.getMember_id());
			if(!support.getEditMode().equals("DELETE")) {
				service.modifySupportResult(support);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				
			} else if(support.getEditMode().equals("DELETE")) {
				service.deleteSupport(support);
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
