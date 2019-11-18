package kr.co.whalesoft.app.cms.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.Days;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.whalesoft.app.cms.accountLock.AccountLock;
import kr.co.whalesoft.app.cms.accountLock.AccountLockService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.framework.base.BaseController;

@Controller
@RequestMapping(value = {"/cms/login","/pms/login","/dms/login"})
public class LoginController extends BaseController {

	private final String basePath = "/cms/login/";

	@Autowired
	private LoginService service;

	@Autowired
	private AccountLockService accountLockService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Menu menu,HttpServletRequest request) {
		model.addAttribute("login", new Login());
		//관리자 로그인후 이동할 이전 주소 기록
		if(request.getHeader("referer") != null && !request.getHeader("referer").isEmpty() && request.getHeader("referer").indexOf("login/index.") == -1 && request.getHeader("referer").indexOf("/cms/aside.") == -1){
			request.getSession().setAttribute("returnUrl", request.getHeader("referer"));
			log.debug("retrunUrl : "+request.getSession().getAttribute("returnUrl"));
		}
		return basePath + "index";
	}

	@RequestMapping(value = {"/redirect.*"})
	public String redirect(Model model, Menu menu) {
		return basePath + "redirect";
	}

	/**
	 * 로그인 처리
	 * @param member
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login.*", method=RequestMethod.POST)
	public String loginProc(@Valid Login login,BindingResult result, HttpServletRequest request, RedirectAttributes redirectAttributes, HttpServletResponse response) throws Exception {
		String redirectURL = "http://" + request.getServerName();
		int redirectPort = request.getServerPort();
		if (redirectPort != 443) {
			redirectURL += ":"+redirectPort;
		}

//		if(result.hasErrors()){
//			System.out.println(result);
//			for(ObjectError error: result.getAllErrors()){
//				System.out.println(msg.getMessage(this,error.getDefaultMessage()));
//			}
//			return basePath + "index";
//		}

		Member member = new Member();
		member.setMember_id(login.getMember_id());
		member.setMember_pw(login.getMember_pw());

		String loginResult = service.login(member, request);
		if(loginResult.equals("LOGIN")) {
			/**
			 * 비밀번호 만료일자가 지난 경우 패스워드 변경유도 페이지로 이동.
			 */
			try {
				if (member.getPw_change_date() != null && !StringUtils.isEmpty(member.getPassword_expiry_day())) {

//					DateTimeFormatter fmt = DateTimeFormat.forPattern("yyyyMMdd");

					DateTime updateDate = new DateTime(member.getPw_change_date());
					DateTime currentDate = DateTime.now();

					Days daysBetween = Days.daysBetween(updateDate, currentDate);

					int expiryDay = Integer.parseInt(member.getPassword_expiry_day());

					if (daysBetween.getDays() > expiryDay) {
						Homepage homepage = new Homepage();
						homepage.setHomepage_code(member.getLoca());
						Homepage getHomepage = homepageService.getHomepageOneByCode(homepage);

						int menuIdx = homepageService.getMenuIdxByLinkUrl(getHomepage.getHomepage_id(), "/intro/join/changePwForm.do");

						String passwordExpiry = String.format("https://gbelib.kr/%s/intro/join/passwordExpiry.do?menu_idx=%s", getHomepage.getContext_path(), menuIdx);

						request.getSession().setAttribute("passwordExpiry", passwordExpiry);

					}
				}
			} catch (Exception e) {

			}

			if(request.getSession().getAttribute("returnUrl") != null){
				String returnUrl = String.valueOf(request.getSession().getAttribute("returnUrl"));
				if (returnUrl.contains("/cms/")) {
					redirectURL = "redirect:" + redirectURL + "/cms/index.do";
				} else {
//					redirectURL = "redirect:" + request.getSession().getAttribute("returnUrl");
					redirectURL = "redirect:" + redirectURL + getPath(request.getRequestURI()) + "/index.do";
				}
			}else{
				redirectURL = "redirect:" + redirectURL + getPath(request.getRequestURI()) + "/index.do";
			}
		} else if(loginResult.equals("LOCKED")) {
			service.alertMessage("로그인 5회 중 5회 이상 실패\\n입력하신 아이디에 대해서 10분간 접속을 차단합니다.", request, response);
			return null;
		} else if(loginResult.equals("FAILED")) {
			AccountLock accountLock = accountLockService.getAccountLock(new AccountLock(member, request.getRemoteAddr()));
			service.alertMessage(String.format("로그인 5회 중 %d회 실패\\n아이디 또는 비밀번호를 다시 확인하세요", accountLock.getCount()), request, response);
			return null;
		}

		return redirectURL;
	}

	/**
	 * 로그아웃 처리
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/logout.*", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, RedirectAttributes redirectAttributes) {
//		String redirectURL = request.getServerName() + ":" + request.getServerPort();
		String redirectURL = request.getServerName();
		service.logout(request);
		return "redirect:http://" + redirectURL + getPath(request.getRequestURI()) + "/login/index.do";

	}


	//접속URI를 기준으로 PMS로 갈건지 CMS로 갈건지 결정
	public String getPath(String uri){
		String path = "/cms";
		if(uri.startsWith("/pms/")){
			path = "/pms";
		}else if(uri.startsWith("/dms/")){
			path = "/dms";
		} else {

		}
		return path;
	}


}