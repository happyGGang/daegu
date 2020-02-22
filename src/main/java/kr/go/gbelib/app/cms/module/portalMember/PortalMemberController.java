package kr.go.gbelib.app.cms.module.portalMember;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/portalMember"})
public class PortalMemberController extends BaseController {
	
	private final String basePath = "/cms/module/portalMember/";
	
	@Autowired
	private PortalMemberService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, PortalMember portalMember, HttpServletRequest request) {
		
		service.setPaging(model, service.getPortalMemberCount(portalMember), portalMember);
	
		model.addAttribute("portalMember", portalMember);
		model.addAttribute("portalMemberList", service.getPortalMemberList(portalMember));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, PortalMember portalMember, HttpServletRequest request) throws AuthException {
		if(portalMember.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("portalMember", service.copyObjectPaging(portalMember, service.getPortalMemberOne(portalMember)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("portalMember", portalMember);
		}
		
		model.addAttribute("homepageList", homepageService.getNormalHomepage());
		
		return basePath + "edit_ajax";
	}
	
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(PortalMember portalMember, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		String editMode = portalMember.getEditMode();
		if(editMode.equals("ADD") || editMode.equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "agency_name", "기관명을 입력해주세요.");
			ValidationUtils.rejectOnlyKor(result, "agency_name", "학교명은 한글만 입력할 수 있습니다.");
			ValidationUtils.rejectIfEmpty(result, "agency_id", "아이디를 입력해주세요.");
			ValidationUtils.rejectOnlyEngNum(result, "agency_id", "아이디는 영문/숫자만 사용하실 수 있습니다.");
			
			if(portalMember.getAgency_id().length() > 10) {
    			result.rejectValue("agency_id", "아이디는 10자 이내만 사용하실 수 있습니다.");
    		}
			
			if(editMode.equals("ADD") || StringUtils.isNotEmpty(portalMember.getAgency_password())) {
				ValidationUtils.rejectIfEmpty(result, "agency_password", "비밀번호를 입력해주세요.");
				ValidationUtils.rejectIfEmpty(result, "password_check", "비밀번호를 입력해주세요.");
				
				if(portalMember.getAgency_password().length() < 5) {
        			result.rejectValue("agency_password", "비밀번호는 5자리 이상 입력해주세요.");
        		}
        		if(!StringUtils.equals(portalMember.getAgency_password(), portalMember.getPassword_check())) {
        			result.rejectValue("password_check", "비밀번호가 다릅니다.");
        		}
			}
			
			if(editMode.equals("ADD") && service.getPortalMemberOne(portalMember) != null) {
				res.setValid(false);
				res.setMessage("아이디가 중복됩니다.");
				return res;
			}
    		
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (editMode.equals("ADD")) {
				portalMember.setAdd_id(getSessionMemberId(request));
				service.addPortalMember(portalMember);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (editMode.equals("MODIFY")) {
				portalMember.setModify_id(getSessionMemberId(request));
				service.modifyPortalMember(portalMember);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deletePortalMember(portalMember);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(editMode.equals("DELETE_CHECK")) {
				service.deletePortalMemberArr(portalMember);
				res.setValid(true);
				res.setMessage("선택 삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
