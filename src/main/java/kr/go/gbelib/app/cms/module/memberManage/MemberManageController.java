package kr.go.gbelib.app.cms.module.memberManage;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/memberManage"})
public class MemberManageController extends BaseController {
	
	private final String basePath = "/cms/module/memberManage/";
	
	@Autowired
	private MemberManageService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MemberManage memberManage, HttpServletRequest request) {
		
		service.setPaging(model, service.getMemberManageCount(memberManage), memberManage);

		model.addAttribute("memberManage", memberManage);
		model.addAttribute("memberManageList", service.getMemberManageList(memberManage));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, MemberManage memberManage, HttpServletRequest request) throws AuthException {
		if(memberManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("memberManage", service.copyObjectPaging(memberManage, service.getMemberManageOne(memberManage)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("memberManage", memberManage);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MemberManage memberManage, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if (memberManage.getEditMode().equals("ADD") && memberManage.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "member_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "member_id", "아이디를 입력하세요");
    		if(memberManage.getEditMode().equals("ADD")) {
    			ValidationUtils.rejectIfEmpty(result, "member_password", "비밀번호를 입력하세요");
    			ValidationUtils.rejectIfEmpty(result, "password_check", "비밀번호 확인을 입력하세요");
    		}
    		ValidationUtils.rejectOnlyKor(result, "member_name", "이름은 한글만 입력할 수 있습니다.");
    		ValidationUtils.rejectOnlyEngNum(result, "member_id", "아이디는 영문/숫자만 사용하실 수 있습니다.");
    		
    		if(memberManage.getMember_id().length() > 10) {
    			result.rejectValue("member_id", "아이디는 10자 이내만 사용하실 수 있습니다.");
    		}
    		
    		if(memberManage.getEditMode().equals("ADD")) {
        		if(memberManage.getMember_password().length() < 5) {
        			result.rejectValue("member_password", "비밀번호는 5자리 이상 입력해주세요.");
        		}
        		if(!StringUtils.equals(memberManage.getMember_password(), memberManage.getPassword_check())) {
        			result.rejectValue("password_check", "비밀번호가 다릅니다.");
        		}
    		}
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (memberManage.getEditMode().equals("ADD")) {
				if(service.memberIdDuplCheck(memberManage) > 0) {
					res.setValid(false);
					res.setMessage("아이디가 중복됩니다.");
					return res;
				}
				
				memberManage.setAdd_id(getSessionMemberId(request));
				service.addMemberManage(memberManage);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (memberManage.getEditMode().equals("MODIFY")) {
				memberManage.setModify_id(getSessionMemberId(request));
				service.modifyMemberManage(memberManage);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (memberManage.getEditMode().equals("DELETE")) {
				service.deleteMemberManage(memberManage);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(memberManage.getEditMode().equals("DELETE_CHECK")) {
				service.deleteCheckMemberManage(memberManage);
				res.setValid(true);
				res.setMessage("선택 항목 모두 삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
