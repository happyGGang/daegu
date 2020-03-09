package kr.go.gbelib.app.module.supportMember;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;
import kr.go.gbelib.app.cms.module.supportMember.SupportMemberService;

@Controller(value = "userSupportMember")
@RequestMapping(value = {"/{homepagePath}/module/supportMember"})
public class SupportMemberController {
	
	private String basePath = "/homepage/%s/module/supportMember/";
	
	@Autowired
	private SupportMemberService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String loginForm(Model model, SupportMember supportMember, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember sessionMember = (SupportMember)request.getSession().getAttribute("loginSupport");
		if(sessionMember != null) {
			return "redirect:" + String.format("passwordForm.do?menu_idx=%s", menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 120)));
		}
		
		model.addAttribute("supportMember", supportMember);

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/loginProc.*"}, method = RequestMethod.POST)
	public String loginProc(Model model, SupportMember supportMember, HttpServletRequest request, HttpServletResponse response, @PathVariable ("homepagePath") String homepagePath) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		String returnUrl = supportMember.getBefore_url();
		
		SupportMember loginSupport = service.getSupportMemberLogin(supportMember);
    	if(loginSupport == null) {
    		service.alertMessage("아이디 또는 비밀번호를 다시 확인하세요", request, response);
    	} else {
    		loginSupport.setLogin(true);
			service.addLastLogin(loginSupport);
			
			if(loginSupport.getAuth_group().equals("1")) {
				loginSupport.setAdmin(true);
			}
			
			request.getSession().removeAttribute("member");
			request.getSession().setAttribute("loginSupport", loginSupport);
		}
    	
		if (StringUtils.isEmpty(returnUrl) || returnUrl.indexOf("/login/") > -1) {
			returnUrl = String.format("%s/%s/index.do", homepage.getDomain(), homepagePath);
			if (request.getRequestURL().toString().contains("localhost")) {
				returnUrl = String.format("%s/%s/index.do", "http://localhost", homepagePath);
			}
		}
		
		model.addAttribute("supportMember", supportMember);

		return "redirect:" + returnUrl.replaceAll("^http://(www\\.)?library\\.daegu\\.go\\.kr", "https://library.daegu.go.kr");
	}
	
	@RequestMapping (value = "/logout.*", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		request.getSession().invalidate();
		String redirectURL = (request.isSecure() ? "https://" : "http://") + request.getServerName() + "/" + homepage.getContext_path();
		return "redirect:" + redirectURL + "/index.do";
	}
	
	@RequestMapping (value = "/passwordForm.*", method = RequestMethod.GET)
	public String passwordChange(Model model, SupportMember supportMember, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		SupportMember sessionMember = (SupportMember)request.getSession().getAttribute("loginSupport");
		
		if(sessionMember == null) {
			supportMember.setBefore_url(String.format("/%s/module/supportMember/passwordForm.do?menu_idx=%s", homepage.getContext_path(), supportMember.getMenu_idx()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), supportMember.getMenu_idx(), supportMember.getBefore_url()), request, response);
			return null;
		}
		
		return String.format(basePath, homepage.getFolder()) + "passwordForm";
	}
	
	@RequestMapping (value = {"/passwordChange.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(SupportMember supportMember, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(supportMember.getMember_password().length() < 5) {
			result.rejectValue("member_password", "비밀번호는 5자리 이상 입력해주세요.");
		}
		if(!StringUtils.equals(supportMember.getMember_password(), supportMember.getPassword_check())) {
			result.rejectValue("password_check", "비밀번호가 다릅니다.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.passwordChange(supportMember);
			request.getSession().invalidate();
			res.setValid(true);
			res.setMessage("비밀번호 변경되었습니다.");
			res.setUrl("index.do");
			res.setData("menu_idx="+menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 119)));
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/mysql_to_tibero"}, method = RequestMethod.GET)
	public void mysqlToTibero() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		List<Map<String, Object>> list = service.getMySqlList();
		
		for (Map<String, Object> map : list) {
			SupportMember sm = new SupportMember();
			
			sm.setSupport_member_idx(Integer.parseInt(String.valueOf(map.get("m_num"))));
			sm.setSchool_name(String.valueOf(map.get("m_name")));
			sm.setMember_id(String.valueOf(map.get("m_id")));
			sm.setMember_password(String.valueOf(map.get("m_id")));
			sm.setAuth_group(String.valueOf(map.get("m_level")));
			
    		try {
    			String lastdate = String.valueOf(map.get("m_lastdate"));
    			if(StringUtils.isNotEmpty(lastdate)) {
    				sm.setLast_connect(sdf.parse(lastdate));
    			}
    			sm.setAdd_id(String.valueOf(map.get("m_id")));
    			sm.setAdd_date(sdf.parse(String.valueOf(map.get("m_date"))));
    			
    			
    			String moddate = String.valueOf(map.get("m_modymate"));
    			if(StringUtils.isNotEmpty(moddate)) {
    				sm.setModify_date(sdf.parse(moddate));
    				sm.setModify_id(String.valueOf(map.get("m_id")));
    			}
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}
    		
    		System.out.println("@@@@@@@@@@ : " + sm.toString());
    		service.addParseTibero(sm);
		}
		
	}

}
