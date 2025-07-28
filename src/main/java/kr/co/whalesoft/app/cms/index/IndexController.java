package kr.co.whalesoft.app.cms.index;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.app.cms.adminMenu.AdminMenu;
import kr.co.whalesoft.app.cms.adminMenu.AdminMenuService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.memberGroupAuth.MemberGroupAuthService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller(value = "cmsIndexController")
@RequestMapping(value = {"/cms"})
public class IndexController extends BaseController {

	private final String basePath = "/cms/";

	@Autowired
	private AdminMenuService adminMenuService;

	@Autowired
	private MemberGroupAuthService memberGroupAuthService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, HttpServletRequest request) throws AuthException {
		return basePath + "index";
	}

	@RequestMapping(value = {"/ready.*"})
	public String ready(Model model, HttpServletRequest request) {
		return basePath + "ready";
	}

	@RequestMapping(value = {"/aside.*"})
	public String aside(Model model, AdminMenu adminMenu, HttpServletRequest request) {
		List<Homepage> homepageList = getSessionMemberInfo(request).getAuthorityHomepageList();

		if (StringUtils.isEmpty(adminMenu.getHomepage_id())) {
			if (homepageList != null && homepageList.size() > 0) {
				adminMenu.setHomepage_id(homepageList.get(0).getHomepage_id());
			}
		}
		adminMenu.setMember_id(getSessionMemberId(request));
		request.getSession().setAttribute("asideHomepageId", adminMenu.getHomepage_id());

		if (getSessionMemberInfo(request).isAdmin()) {
			adminMenu.setAdmin_access_yn("Y");
			model.addAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
		} else {
			//사이트관리자 여부 확인
			if (getSessionMemberInfo(request).getAuthMap().containsKey(adminMenu.getHomepage_id()+"_A")) {
				adminMenu.setAdmin_access_yn("Y");
				model.addAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
			} else {
				adminMenu.setAuthgroupIdxList(memberGroupAuthService.getAuthGroupIdxList(adminMenu));
				if (adminMenu.getAuthgroupIdxList() != null && adminMenu.getAuthgroupIdxList().size() > 0) {
					model.addAttribute("adminMenuList", adminMenuService.getAdminMenuListNew(adminMenu));
				}
			}
		}

		model.addAttribute("adminMenu", adminMenu);

		return basePath + "aside";
	}

	@RequestMapping(value = {"/bside.*"})
	public String bside(Model model, AdminMenu adminMenu, HttpServletRequest request) {
		return basePath + "bside";
	}

	@RequestMapping("/asideHomepage.*")
	public String asideHomepage(AdminMenu adminMenu, HttpServletRequest request) {
		request.getSession().setAttribute("adminMenu", adminMenu);
		request.setAttribute("adminMenu", adminMenu);
		request.getSession().setAttribute("asideHomepageId", adminMenu.getHomepage_id());
		
		//TODO 해당 홈페이지에서 사용하지 않는 메뉴를 클릭하였을때 main페이지인 /cms/index.jsp로 보내야함.

		return basePath + "index";
	}

}