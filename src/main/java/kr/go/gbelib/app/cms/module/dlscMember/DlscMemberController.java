package kr.go.gbelib.app.cms.module.dlscMember;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value={"/cms/dlscMember"})
public class DlscMemberController extends BaseController {
	
	private final String basePath = "/cms/module/dlscMember/";
	
	@Autowired
	private DlscMemberService service;
	
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, DlscMember dlscMember, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		service.setPaging(model, service.getDlscMemberCount(dlscMember), dlscMember);
		model.addAttribute("dlscMember", dlscMember);
		model.addAttribute("dlscMemberList", service.getDlscMember(dlscMember));
		return basePath + "index";
	}

	/**
	 * 회원가입시 DLS인증
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping (value = { "/checkDlsTest.*" })
	public String checkDlsTest(Model model, HttpServletRequest request) {
		String ck_flag = request.getParameter("ck_flag");
		String member_nm = request.getParameter("member_nm");
		
		model.addAttribute("ck_flag", ck_flag);
		model.addAttribute("member_nm", member_nm);
		return basePath + "checkDlsTest_ajax";
	}
}
