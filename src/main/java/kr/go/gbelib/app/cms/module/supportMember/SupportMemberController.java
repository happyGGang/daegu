package kr.go.gbelib.app.cms.module.supportMember;

import java.io.IOException;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jxl.read.biff.BiffException;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.member.MemberService;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.app.cms.memberGroupSubord.MemberGroupSubordService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/supportMember"})
public class SupportMemberController extends BaseController {
	
	private final String basePath = "/cms/module/supportMember/";
	
	@Autowired
	private SupportMemberService service;
	
	@Autowired
	private MemberGroupService memberGroupService;
	
	@Autowired
	private MemberGroupSubordService memberGroupSubordService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, SupportMember supportMember, HttpServletRequest request) {
		
		service.setPaging(model, service.getSupportMemberCount(supportMember), supportMember);

		model.addAttribute("supportMember", supportMember);
		model.addAttribute("supportMemberList", service.getSupportMemberList(supportMember));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, SupportMember supportMember, HttpServletRequest request) throws AuthException {
		if(supportMember.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("supportMember", service.copyObjectPaging(supportMember, service.getSupportMemberOne(supportMember)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("supportMember", supportMember);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(SupportMember supportMember, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if (supportMember.getEditMode().equals("ADD") || supportMember.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "school_name", "학교명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력하세요");
    		if(supportMember.getEditMode().equals("ADD") || StringUtils.isNotEmpty(supportMember.getMember_password())) {
    			ValidationUtils.rejectIfEmpty(result, "member_password", "비밀번호를 입력하세요");
    			ValidationUtils.rejectIfEmpty(result, "password_check", "비밀번호 확인을 입력하세요");
    		}
    		//ValidationUtils.rejectOnlyKor(result, "school_name", "학교명은 한글만 입력할 수 있습니다.");
    		ValidationUtils.rejectOnlyEngNum(result, "member_id", "아이디는 영문/숫자만 사용하실 수 있습니다.");
    		
    		if(supportMember.getMember_id().length() > 10) {
    			result.rejectValue("member_id", "아이디는 10자 이내만 사용하실 수 있습니다.");
    		}
    		
    		if(supportMember.getEditMode().equals("ADD") || StringUtils.isNotEmpty(supportMember.getMember_password())) {
        		if(supportMember.getMember_password().length() < 5) {
        			result.rejectValue("member_password", "비밀번호는 5자리 이상 입력해주세요.");
        		}
        		if(!StringUtils.equals(supportMember.getMember_password(), supportMember.getPassword_check())) {
        			result.rejectValue("password_check", "비밀번호가 다릅니다.");
        		}
    		}
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (supportMember.getEditMode().equals("ADD")) {
				if(service.memberIdDuplCheck(supportMember) > 0) {
					res.setValid(false);
					res.setMessage("아이디가 중복됩니다.");
					return res;
				}
				
				supportMember.setAdd_id(getSessionMemberId(request));
				service.addSupportMember(supportMember);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (supportMember.getEditMode().equals("MODIFY")) {
				supportMember.setModify_id(getSessionMemberId(request));
				service.modifySupportMember(supportMember);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (supportMember.getEditMode().equals("DELETE")) {
				service.deleteSupportMember(supportMember);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(supportMember.getEditMode().equals("DELETE_CHECK")) {
				service.deleteCheckSupportMember(supportMember);
				res.setValid(true);
				res.setMessage("선택 항목 모두 삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/grouping.*"}, method = RequestMethod.GET)
	public String grouping(Model model, SupportMember supportMember, HttpServletRequest request) throws AuthException {
		checkAuth("C", model, request);
		checkAuth("U", model, request);
		MemberGroup memberGroup = new MemberGroup();
		memberGroup.setSite_id(getAsideHomepageId(request));
		//내권한 사이트목록 가져와서 집어넣기.
		memberGroup.setEditMode("SUPPORT");
		model.addAttribute("getMemberGroupList", memberGroupService.getMemberGroupList(memberGroup));
		
		Member member = new Member(supportMember.getMember_id());
		supportMember.setAuthGroupIdxList(memberGroupSubordService.getAuthGroupIdxList(member));
		model.addAttribute("supportMember", supportMember);
		return basePath + "grouping_ajax";
	}
	
	/**
	 * 관리자 그룹설정
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/saveGroup.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveGroup(SupportMember supportMember, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			Member member = new Member();
			member.setMember_id(supportMember.getMember_id());
			member.setAuthGroupIdxList(supportMember.getAuthGroupIdxList());
			member.setHomepage_id(getAsideHomepageId(request));
			memberService.addMemberGroup(member);
			service.modifySupportMemberGroup(supportMember);
			res.setValid(true);
			res.setMessage("저장되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/excelDownload.*"}, method = RequestMethod.GET)
	public SupportMemberExcelView excelUploadIndex(Model model, HttpServletRequest request) {
		
		return new SupportMemberExcelView();
	}
	
	@RequestMapping (value = {"/excelUpload.*"})
	public String excelUpload(Model model, SupportMember supportMember, HttpServletRequest request) throws AuthException {
		
		return basePath + "excelUpload_ajax";
	}
	
	@RequestMapping (value = { "/excelUploadSave.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse excelUploadSave(SupportMember supportMember, MultipartHttpServletRequest request, HttpServletResponse response) throws BiffException, IOException {
		JsonResponse res = new JsonResponse(request);
		MultipartFile mfile = request.getFile("mfile");
		
		if(mfile != null) {
			String fileType = mfile.getOriginalFilename().substring(mfile.getOriginalFilename().lastIndexOf(".")+1).toUpperCase();
			
			if(fileType.equals("XLS")) {
				int successCount = service.excelUploadSave(request.getFile("mfile"));
				
				if(successCount > 0 && successCount != 2) {
					res.setValid(true);
					res.setMessage("저장되었습니다.");
				} else if(successCount == 2) {
					res.setValid(false);
					res.setMessage("중복되는 아이디가 있습니다.\n중복되는 엑셀에서 중복되는 아이디를 삭제해주세요.");
				} else {
					res.setValid(false);
					res.setMessage("엑셀파일 저장 실패하였습니다.\n관리자에게 문의해 주세요.");
				}
			} else {
				res.setValid(false);
				res.setMessage(".xls 확장자를 가진 파일만 등록할 수 있습니다. \n(Excel 97 - 2003 통합 문서)");
			}
		} else {
			res.setValid(false);
			res.setMessage("파일을 선택해주세요.");
		}
		
		return res;
	}

}
