package kr.co.whalesoft.app.cms.adminMenu;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngt;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngtService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/wbuilder/adminMenu"})
public class AdminMenuController extends BaseController {

	private final String basePath = "/wbuilder/adminMenu/";

	@Autowired
	private AdminMenuService service;

	@Autowired
	private ModuleMngtService moduleMngtService;

	@Autowired
	private HomepageService homepageService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, AdminMenu adminMenu, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		model.addAttribute("adminMenu", adminMenu);
		return basePath + "index";
	}

	/**
	 * 최상위 메뉴정보를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getAdminMenuTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<AdminMenu> getAdminMenuTreeList() {
		return service.getAdminMenuTreeList();
	}

	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, AdminMenu adminMenu, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		AdminMenu parentAdminMenu = null;

		parentAdminMenu = service.getParentAdminMenuOne(adminMenu);

		if(adminMenu.getEditMode().equals("MODIFY")) {
			adminMenu = (AdminMenu)service.copyObjectPaging(adminMenu, service.getAdminMenuOneByIdx(adminMenu));
		} else {
			parentAdminMenu = service.getAdminMenuOneByIdx(adminMenu);
			if(parentAdminMenu != null) {
				adminMenu.setGroup_idx(parentAdminMenu.getGroup_idx());
				adminMenu.setParent_menu_idx(parentAdminMenu.getMenu_idx());
			}
			if (adminMenu.getEditMode().equals("ADD")) {
				adminMenu.setPrint_seq(service.getPrint_seq(adminMenu));
			}
		}
//		model.addAttribute("menuAuthArray", service.getAdminMenuAuth(adminMenu));
//		model.addAttribute("authList", authService.getMenuAuth(new Auth(adminMenu.getHomepage_id(), "AUTH001")));
		ModuleMngt moduleMngt = new ModuleMngt();
		moduleMngt.setModule_type("CMS");
		model.addAttribute("moduleList", moduleMngtService.getModuleMngtListAll(moduleMngt));
		model.addAttribute("adminMenu", adminMenu);
		model.addAttribute("parentAdminMenu", parentAdminMenu);
		model.addAttribute("homepageList", homepageService.getNormalHomepage());

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(AdminMenu adminMenu, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(adminMenu.getEditMode().equals("ADD") || adminMenu.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "menu_name", "메뉴명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "메뉴사용여부를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "view_yn", "메뉴표시여부를 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(adminMenu.getEditMode().equals("MODIFY")) {
				adminMenu.setModify_id(getSessionMemberId(request));
				service.modifyAdminMenu(adminMenu);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(adminMenu.getEditMode().equals("ADD")) {
				adminMenu.setAdd_id(getSessionMemberId(request));
				service.addAdminMenu(adminMenu);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(adminMenu.getEditMode().equals("DELETE")) {
				service.deleteAdminMenu(adminMenu);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			} else if(adminMenu.getEditMode().equals("parentAdminMenuModify")) {
				service.modifyParentAdminMenu(adminMenu);
				res.setValid(true);
				res.setMessage("메뉴이동 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/editAuth.*"}, method = RequestMethod.GET)
	public String editAuth(Model model, AdminMenu adminMenu) {
//		Group group = new Group();
//		group.setMenu_idx(adminMenu.getMenu_idx());

		model.addAttribute("adminMenuAuthGroup", adminMenu);
//		model.addAttribute("groupListAll", groupService.selectGroups());
//		model.addAttribute("adminMenuAuthGroupList", groupService.getGroupByAdminMenu(group));

		return basePath + "editAuth_ajax";
	}

	@RequestMapping(value = { "/saveAuth.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveAuth(AdminMenu adminMenu, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "menu_idx", "선택된 메뉴가 없습니다.");
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			service.saveAdminMenuAuth(adminMenu);

			res.setValid(true);
			res.setMessage("저장되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}