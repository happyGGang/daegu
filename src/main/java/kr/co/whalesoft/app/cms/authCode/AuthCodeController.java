package kr.co.whalesoft.app.cms.authCode;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/authCode"})
public class AuthCodeController extends BaseController {

	private final String basePath = "/cms/authCode/";
	
	@Autowired
	private AuthCodeService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, AuthCode auth, HttpServletRequest request) {
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("auth", auth);
		
		return basePath + "index";
	}
	
	/**
	 * 트리 리스트를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getAuthGroupTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<AuthCode> getCodeGroupTreeList() {
		return service.getAuthGroupTreeList();
	}
	
	@RequestMapping(value="/getAuthGroupOne.*", method=RequestMethod.GET)
	public @ResponseBody AuthCode getCodeGroupOne(Model model, AuthCode auth) {
		if(auth.getAuth_group_id().equals("ROOT")) {
			auth = new AuthCode();
			auth.setAuth_group_id("ROOT");
			auth.setAuth_group_name("권한그룹 모음");
			auth.setRemark("권한그룹 모음은 수정할 수 없습니다.");
			return auth;
		} else {
			return service.getAuthGroupOne(auth);
		}
	}
	
	@RequestMapping(value="/editAuthGroup.*", method=RequestMethod.GET)
	public String editCodeGroup(Model model, AuthCode auth) {
		if(auth.getEditMode().equals("MODIFY")) {
			model.addAttribute("auth", service.copyObjectPaging(auth, service.getAuthGroupOne(auth)));
		} else {
			model.addAttribute("auth", auth);
		}
		
		return basePath + "authGroup/editAuthGroup_ajax";
	}
	
	@RequestMapping(value = {"/saveAuthGroup.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveAuthGroup(Model model, AuthCode auth, BindingResult result, HttpServletRequest request) {
		Member member = getSessionMemberInfo(request);
		model.addAttribute("member", member);
		
		JsonResponse res = new JsonResponse(request);
		
		if(!auth.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "auth_group_id", "권한그룹 ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "auth_group_name", "권한그룹명을 입력하세요.");
		} else {
			ValidationUtils.rejectIfEmpty(result, "auth_group_id", "권한그룹명을 입력하세요.");
		}

		if(!result.hasErrors()) {
			if ( member.isAdmin() ) {
				if(auth.getEditMode().equals("ADD")) {
					auth.setAdd_id(getSessionMemberId(request));
					service.addAuthGroup(auth, request);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else if(auth.getEditMode().equals("MODIFY")) {
					auth.setMod_id(getSessionMemberId(request));
					service.modifyAuthGroup(auth, request);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				} else if(auth.getEditMode().equals("DELETE")) {
					if(service.getAuthCount(auth) > 0) {
						res.setValid(false);
						res.setMessage("하위 데이터가 존재하여 삭제할 수 없습니다.");
					} else {
						service.deleteAuthGroup(auth);
						res.setValid(true);
						res.setMessage("삭제 되었습니다.");
					}
				}
			}
			else {
				res.setValid(false);
				res.setMessage("권한이 없습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value="/auth.*", method=RequestMethod.GET)
	public String code(Model model, AuthCode auth, HttpServletRequest request) {
		model.addAttribute("member", getSessionMemberInfo(request));
		model.addAttribute("authList", service.getAuthCode(auth.getAuth_group_id()));
		model.addAttribute("auth", auth);
		
		return basePath + "auth/auth_ajax"; 
	}
	
	@RequestMapping(value="/editAuth.*", method=RequestMethod.GET)
	public String editCode(Model model, AuthCode auth) {
		if(auth.getEditMode().equals("MODIFY")) {
			model.addAttribute("auth", service.copyObjectPaging(auth, service.getAuthOne(auth)));
		} else {
			auth.setPrint_seq(service.getNextPrintSeq(auth));
			model.addAttribute("auth", auth);
		}
		
		return basePath + "auth/editAuth_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, AuthCode auth, BindingResult result, HttpServletRequest request) {
		Member member = getSessionMemberInfo(request);
		model.addAttribute("member", member);
		
		JsonResponse res = new JsonResponse(request);
		
		if(!auth.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "auth_id", "권한 ID를 입력하세요.");
			ValidationUtils.rejectExceptNumber(result, "auth_id", "권한 ID는 숫자만 입력 가능 합니다.");
			ValidationUtils.rejectIfEmpty(result, "auth_name", "권한명을 입력하세요.");
		} else {
			ValidationUtils.rejectIfEmpty(result, "auth_id", "권한 ID를 입력하세요.");
		}
		
		if(!result.hasErrors()) {
			if ( member.isAdmin() ) {
				if(auth.getEditMode().equals("ADD")) {
					if(service.getAuthOne(auth) == null) {
						auth.setAdd_id(getSessionMemberId(request));
						service.addAuth(auth, request);
						res.setValid(true);
						res.setMessage("등록 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage("권한ID가 중복 되었습니다.");
					}
				} else if(auth.getEditMode().equals("MODIFY")) {
					auth.setMod_id(getSessionMemberId(request));
					service.modifyAuth(auth, request);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				} else if(auth.getEditMode().equals("DELETE")) {
					service.deleteAuth(auth);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			}
			else {
				res.setValid(false);
				res.setMessage("권한이 없습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	} 
}