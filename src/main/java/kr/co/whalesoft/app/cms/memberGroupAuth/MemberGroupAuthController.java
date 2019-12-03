package kr.co.whalesoft.app.cms.memberGroupAuth;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenuService;
import kr.co.whalesoft.app.cms.authCode.AuthCodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroup;
import kr.co.whalesoft.app.cms.memberGroup.MemberGroupService;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngt;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

/**
 * 그룹 권한 관리
 * @author YONGJU
 *
 */
@Controller
@RequestMapping(value={"/cms/memberGroupAuth", "/wbuilder/memberGroupAuth"})
public class MemberGroupAuthController extends BaseController {

	private final String basePath = "/cms/memberGroupAuth/";
	private final String wbuilderPath = "/wbuilder/memberGroupAuth/";

	@Autowired
	private MemberGroupService memberGroupService;

	@Autowired
	private MemberGroupAuthService service;

	@Autowired
	private AdminMenuService adminMenuService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private AuthCodeService authCodeService;

	/**
	 * 첫페이지.
	 * @param model
	 * @param memberGroup
	 * @param request
	 * @return
	 * @throws AuthException
	 */
	@RequestMapping (value = { "/index.*" }, method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		return returnUrl("index", request);
	}

	/**
	 * 우측창 페이지 불러오기 (관리자메뉴 or 사용자메뉴)
	 * @param model
	 * @param memberGroupAuth
	 * @param request
	 * @return
	 * @throws AuthException
	 */
	@RequestMapping(value="/memberGroupAuth.*", method=RequestMethod.GET)
	public String memberGroupAuth(Model model, MemberGroupAuth memberGroupAuth, MemberGroup memberGroup, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		memberGroup = memberGroupService.getMemberGroupOne(memberGroup);
		if (memberGroup != null && (StringUtils.equals(memberGroup.getAdmin_group_yn(), "Y") || StringUtils.equals(memberGroup.getAdmin_yn(), "Y"))) {
			return basePath + "disabled_ajax";
		}

		ModuleMngt moduleMngt = new ModuleMngt();

		String pathFile = StringUtils.equals(memberGroupAuth.getModuleType(), "CMS") ? "Admin" : "User";
		if (memberGroup != null && (StringUtils.equals(memberGroup.getUser_group_yn(), "Y") || StringUtils.equals(memberGroup.getGuest_group_yn(), "Y"))) {
			pathFile = "User";
			memberGroupAuth.setModuleType("SITE");
		}

		if (StringUtils.equals(memberGroupAuth.getModuleType(), "CMS")) {
			model.addAttribute("menuList", adminMenuService.getAdminMenuTreeListWithAuth(memberGroupAuth));
			model.addAttribute("memberGroupAuth", service.getMemberGroupAuth(memberGroupAuth));
		} else {
			MemberGroup memberGroupOne = memberGroupService.getMemberGroupOne(new MemberGroup(memberGroupAuth.getMember_group_idx()));
			if (!StringUtils.equals(memberGroupOne.getSite_id(), "CMS")) {
				memberGroupAuth.setHomepage_id(memberGroupOne.getSite_id());
				List<Homepage> homepageList = service.getHomepageListByMemberGroup(memberGroupAuth);
				model.addAttribute("siteList", homepageList);
//				if (StringUtils.isEmpty(memberGroupAuth.getHomepage_id())) {
//					if (homepageList != null && homepageList.size() > 0) {
//						memberGroupAuth.setHomepage_id(homepageList.get(0).getHomepage_id());
//					}
//				}
			} else {
				@SuppressWarnings ("unchecked")
				List<Homepage> homepageList = (List<Homepage>) request.getSession().getAttribute("homepageList");
				model.addAttribute("siteList", homepageList);
				if (StringUtils.isEmpty(memberGroupAuth.getHomepage_id())) {
					if (homepageList != null && homepageList.size() > 0) {
						memberGroupAuth.setHomepage_id(homepageList.get(0).getHomepage_id());
					}
				}
			}

			model.addAttribute("memberGroupAuth", service.getMemberGroupAuth(memberGroupAuth));
			model.addAttribute("menuList", menuService.getMenuTreeListWithAuth(memberGroupAuth));
		}
		moduleMngt.setModule_type(memberGroupAuth.getModuleType());
//		model.addAttribute("moduleAuthIdList", authService.getAuth("MODULEAUTH"));
		model.addAttribute("memberGroup", memberGroupService.getMemberGroupOne(new MemberGroup(memberGroupAuth.getMember_group_idx())));

		return returnUrl("memberGroupAuth" + pathFile + "_ajax", request);

	}

	/**
	 * 모듈권한설정 팝업창
	 * @param model
	 * @param authority
	 * @return
	 * @throws AuthException
	 */
	@RequestMapping(value="/editAuthGroupModule{url}.*", method=RequestMethod.GET)
	public String editAuthGroupModule(Model model, MemberGroupAuth memberGroupAuth, @PathVariable("url") String url, HttpServletRequest request) throws AuthException {
		checkAuth("C", model, request);
		checkAuth("U", model, request);
//		moduleManageService.getModule
		memberGroupAuth.setAuthCodeList(service.getAuthCodeList(memberGroupAuth));
		model.addAttribute("moduleAuthList", authCodeService.getAuthCode(memberGroupAuth.getAuth_group_id()));
		model.addAttribute("memberGroupAuth", memberGroupAuth);

		return returnUrl("editAuthGroup" + url, request);
	}




	/**
	 * 그룹의 권한 부여
	 * @param model
	 * @param memberGroupAuth
	 * @param result
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, MemberGroupAuth memberGroupAuth, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			memberGroupAuth.setCud_id(getSessionMemberId(request));
			if (service.addMemberGroupAuth(memberGroupAuth, request) < 1) {
				res.setValid(false);
				res.setMessage("변경된 결과가 없습니다.");
			} else {
				res.setValid(true);
				res.setMessage("저장 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	private String returnUrl(String url, HttpServletRequest request) {
		if (request.getHeader("referer").toString().contains("wbuilder")) {
			return wbuilderPath + url;
		} else {
			return basePath + url;
		}
	}
}
