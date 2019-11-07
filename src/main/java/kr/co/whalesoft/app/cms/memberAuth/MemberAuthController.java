package kr.co.whalesoft.app.cms.memberAuth;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/memberAuth"})
public class MemberAuthController extends BaseController {

	private final String basePath = "/cms/memberAuth/";
	
	@Autowired
	private MemberAuthService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, MemberAuth memberAuth) {
		model.addAttribute("memberAuth", memberAuth);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/memberAuth.*"})
	public String memberAuth(Model model, MemberAuth memberAuth) {
		model.addAttribute("memberAuth", memberAuth);
		if(memberAuth.getHomepage_id() != null) {
			model.addAttribute("memberList", service.getMemberAuthIn(memberAuth));
		}
		
		return basePath + "memberAuth_ajax";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String editAuth(Model model, MemberAuth memberAuth) {
		model.addAttribute("memberAuth", memberAuth);
		model.addAttribute("memberList", service.getMemberAuthNotIn(memberAuth));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MemberAuth memberAuth, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			if(memberAuth.getEditMode().equals("ADD")) {
				service.addMemberAuth(memberAuth);
				res.setValid(true);
				res.setResult("저장 되었습니다.");
			} else if(memberAuth.getEditMode().equals("DELETE")) {
				service.deleteMemberAuth(memberAuth);
				res.setValid(true);
				res.setResult("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}