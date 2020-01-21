package kr.co.whalesoft.app.cms.menu;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.boardManage.BoardManage;
import kr.co.whalesoft.app.cms.boardManage.BoardManageService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtml;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuHtmlService;
import kr.co.whalesoft.app.cms.menu.menuHtml.MenuTempFile;
import kr.co.whalesoft.app.cms.menu.menuLog.MenuLogService;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngt;
import kr.co.whalesoft.app.cms.moduleMngt.ModuleMngtService;
import kr.co.whalesoft.app.cms.organization.Organization;
import kr.co.whalesoft.app.cms.organization.OrganizationService;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSite;
import kr.co.whalesoft.app.cms.recommendSite.RecommendSiteService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/menu"})
public class MenuController extends BaseController {

	private final String basePath = "/cms/menu/";

	@Autowired
	private MenuService service;

	@Autowired
	private MenuLogService menuLogService;

	@Autowired
	private HomepageService homepageService;

	@Autowired
	private MenuHtmlService menuHtmlService;

	@Autowired
	private BoardManageService boardManageService;

	@Autowired
	private ModuleMngtService moduleMngtService;

	@Autowired
	private MenuService menuService;

	@Autowired
	private RecommendSiteService recommendSiteService;

//	@Autowired
//	private TaskManageService taskManageService;
	
	@Autowired
	private OrganizationService organizationService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Menu menu, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Member member = getSessionMemberInfo(request);
//		if ( !getSessionIsAdmin(request) ) {
			menu.setHomepage_id(getAsideHomepageId(request));
//		}

		model.addAttribute("menu", menu);
		model.addAttribute("member", member);

		return basePath + "index";
	}

	/**
	 * 최상위 메뉴정보를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getMenuTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<Menu> getMenuTreeList(Menu menu) {
		List<Menu> menuList = service.getMenuTreeList(menu);
		return menuList;
	}

	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, Menu menu, HttpServletRequest request) throws AuthException {
		Menu parentMenu = null;

		parentMenu = service.getParentMenuOne(menu);

		if(menu.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			menu = (Menu)service.copyObjectPaging(menu, service.getMenuOne(menu));
			if ( menu.getMenu_type().equals("PROGRAM") ) {
				model.addAttribute("moduleMngt", moduleMngtService.getModuleMngtOne(new ModuleMngt(menu.getManage_idx())));
			} else if (menu.getMenu_type().equals("BOARD")) {
				model.addAttribute("boardManage", boardManageService.getBoardManageOne(new BoardManage(menu.getHomepage_id(), menu.getManage_idx())));
			}
		} else {
			checkAuth("C", model, request);
			parentMenu = service.getMenuOne(menu);
			if(parentMenu != null) {
				menu.setGroup_idx(parentMenu.getGroup_idx());
				menu.setParent_menu_idx(parentMenu.getMenu_idx());
			}
			if (!menu.getEditMode().equals("FIRST")) {
				menu.setPrint_seq(service.getNextPrintSeq(menu));
			}
		}

		model.addAttribute("menu", menu);
		model.addAttribute("parentMenu", parentMenu);
//		model.addAttribute("authList", authService.getMenuAuth(new Auth(menu.getHomepage_id())));
//		model.addAttribute("menuAuthArray", service.getMenuAuth(menu));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(menu.getHomepage_id())));

		return basePath + "edit_ajax";
	}


	@RequestMapping(value = {"/editMenuType.*"}, method = RequestMethod.GET)
	public String editMenuType(Model model, Menu menu) {

		String viewFile = "";

		if(menu.getMenu_type().equals("HTML")) {
			viewFile = "html_ajax";
		} else if(menu.getMenu_type().equals("BOARD")) {
			viewFile = "board_ajax";
		} else if(menu.getMenu_type().equals("PROGRAM")) {

		} else if(menu.getMenu_type().equals("LINK")) {

		} else if(menu.getMenu_type().equals("LINK_OUTER")) {

		}

		return basePath + "menu_type/" + viewFile;
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Menu menu, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(menu.getEditMode().equals("ADD") || menu.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "menu_name", "메뉴명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "use_yn", "메뉴사용여부를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "view_yn", "메뉴표시여부를 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		MultipartFile mFile = null;
		MultipartFile mFileTopIcon = null;
		MultipartFile mFileLeftIcon = null;

		if(!result.hasErrors()) {
			menu.setAdd_id(getSessionMemberId(mpRequest));
			menu.setModify_id(getSessionMemberId(mpRequest));

			if ( StringUtils.isEmpty(menu.getInclude_menu_name_yn()) ) {
				menu.setInclude_menu_name_yn("N");
			}

			if(menu.getEditMode().equals("MODIFY")) {
				mFile = mpRequest.getFileMap().get("menu_img_file");
				mFileTopIcon = mpRequest.getFileMap().get("menu_top_icon_file");
				mFileLeftIcon = mpRequest.getFileMap().get("menu_left_icon_file");
				service.modifyMenu(mFile, mFileTopIcon, mFileLeftIcon, menu);
				menuLogService.addMenuLog(menu, request);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(menu.getEditMode().equals("ADD")) {
				mFile = mpRequest.getFileMap().get("menu_img_file");
				mFileTopIcon = mpRequest.getFileMap().get("menu_top_icon_file");
				mFileLeftIcon = mpRequest.getFileMap().get("menu_left_icon_file");
				service.addMenu(mFile, mFileTopIcon, mFileLeftIcon, menu);
				menuLogService.addMenuLog(menu, request);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(menu.getEditMode().equals("parentMenuModify")) {
				service.modifyParentMenu(menu);
				service.modifyChildMenu(menu);
				menuLogService.addMenuLog(menu, request);
				res.setValid(true);
				res.setMessage("메뉴이동 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Menu menu, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(!result.hasErrors()) {
			service.deleteMenu(menu);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/edit_html.*"}, method = RequestMethod.GET)
	public String edit_html(Model model, MenuHtml menuHtml) {
		model.addAttribute("menuHtmlList", menuHtmlService.getMenuHtml(menuHtml));
		MenuHtml menuHtmlTemp = menuHtmlService.getLastMenuHtmlOne(menuHtml);
		if(menuHtmlTemp != null) {
			menuHtml.setHtml(menuHtmlTemp.getHtml());
		}

		model.addAttribute("menuHtml", menuHtml);
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(menuHtml.getHomepage_id())));
		return basePath + "/menu_type/html_ajax";
	}

	@RequestMapping(value = {"/save_html.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save_html(MenuHtml menuHtml, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			menuHtml.setAdd_id(getSessionMemberId(request));
			menuHtmlService.addMenuHtml(menuHtml, request);
			menuLogService.addMenuLog(menuHtml, request);
			res.setValid(true);
			res.setMessage("등록 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/save_temp_html.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save_temp_html(MenuHtml menuHtml, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		if(!result.hasErrors()) {
			menuHtmlService.setMenuTempHtml(menuHtml);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setMessage("오류가 발생했습니다. 다시 시도해주세요.");
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/edit_board.*"}, method = RequestMethod.GET)
	public String edit_board(Model model, BoardManage boardManage) {
		model.addAttribute("boardManageList", boardManageService.getBoardManageAll(boardManage));
		return basePath + "/menu_type/board_ajax";
	}

	@RequestMapping(value = {"/edit_module.*"}, method = RequestMethod.GET)
	public String edit_module(Model model, ModuleMngt moduleMngt) {
		moduleMngt.setModule_type("SITE");
		model.addAttribute("moduleMngtList", moduleMngtService.getModuleMngtListAll(moduleMngt));
		return basePath + "/menu_type/module_ajax";
	}

	@RequestMapping(value = {"/getMenuHtmlStrOne.*"}, method = RequestMethod.GET, produces = { "text/plain; charset=UTF-8" })
	public @ResponseBody String getMenuHtmlStrOne(MenuHtml menuHtml) {
		return menuHtmlService.getMenuHtmlStrOne(menuHtml);
	}

	@RequestMapping(value = {"/add_temp_file.*"}, method = RequestMethod.POST)
	public @ResponseBody MenuTempFile addMenuTempFile(MenuTempFile menuTempFile, BindingResult result, MultipartHttpServletRequest mpRequest) {

		if(!result.hasErrors()) {
			menuTempFile.setAdd_id(getSessionMemberId(mpRequest));
			MultipartFile mfile = mpRequest.getFileMap().get("menu_temp_file");
			menuHtmlService.addMenuTempFile(menuTempFile, mfile);
//			menuTempFile.setValid(true);
//		} else {
//			menuTempFile.setValid(false);
		}

		return menuTempFile;
	}

	@RequestMapping(value = {"/delete_temp_file.*"}, method = RequestMethod.POST)
	public @ResponseBody MenuTempFile deleteMenuTempFile(MenuTempFile menuTempFile, BindingResult result, HttpServletRequest request) {

		if(!result.hasErrors()) {
			menuHtmlService.deleteMenuTempFile(menuTempFile);
//			menuTempFile.setValid(true);
//		} else {
//			menuTempFile.setValid(false);
		}

		return menuTempFile;
	}

	@RequestMapping(value = {"/get_temp_files.*"}, method = RequestMethod.GET)
	public String getMenuTempFiles(Model model, MenuTempFile menuTempFile) {
		model.addAttribute("tempFileList", menuHtmlService.getTempFileList(menuTempFile));
		model.addAttribute("tempFile", menuTempFile);
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(menuTempFile.getHomepage_id())));
		return basePath + "getMenuTempFiles_ajax";
	}

	@RequestMapping(value = {"/{contextPath}/htmlEdit.*"})
	public String htmlEdit(@PathVariable String contextPath, Model model, Menu menu, HttpServletRequest request, HttpSession session) {
		Homepage homepage = getHomepage(contextPath, request);

		String homepage_id = homepage.getHomepage_id();
		int menu_idx = menu.getMenu_idx();
		menu.setHomepage_id(homepage_id);
		menu = menuService.getMenuOne(menu);

		session.setAttribute("homepage_id", homepage_id);
		session.setAttribute("menu_idx", menu_idx);

		MenuHtml menuHtml = menuHtmlService.getLastMenuHtmlOne(new MenuHtml(homepage_id, menu_idx));

		model.addAttribute("siteList", recommendSiteService.getRecommendSiteListAll(new RecommendSite(homepage_id)));
		model.addAttribute("menuHtml", menuHtml);
		model.addAttribute("menuOne", service.getMenuOne(menu));
		model.addAttribute("menuLeftList", menuService.getMenuLeftTreeListCache(homepage_id, menu.getGroup_idx()));
		model.addAttribute("menuTreeList", menuService.getMenuTreeListCache(homepage_id));

		return "/homepage/" + homepage.getFolder() + "/htmlEdit";
	}

	private Homepage getHomepage(String contextPath, HttpServletRequest request) {
		Homepage homepage = homepageService.getHomepageOneInPath(contextPath);
		request.setAttribute("homepage", homepage);
		return homepage;
	}

	@RequestMapping(value = {"/{contextPath}/se2configuration_general.*"})
	public String se2configuration_general(@PathVariable String contextPath, Model model, Menu menu, HttpServletRequest request) {

		model.addAttribute("contextPath", contextPath);

		return basePath + "se2configuration_general_ajax";
	}

	@RequestMapping(value = {"/{contextPath}/se2inputarea.*"})
	public String se2inputarea(@PathVariable String contextPath, Model model, Menu menu, HttpServletRequest request) {

		model.addAttribute("contextPath", contextPath);

		return basePath + "se2inputarea_ajax";
	}

	@RequestMapping(value = {"/{contextPath}/se2skin.*"})
	public String se2skin(@PathVariable String contextPath, Model model, Menu menu, HttpServletRequest request) {

		model.addAttribute("contextPath", contextPath);

		return basePath + "se2skin_ajax";
	}

	@RequestMapping(value = {"/se2photo_uploader.*"})
	public String se2photo_uploader(Model model, Menu menu, HttpServletRequest request, HttpSession session) {

		model.addAttribute("homepage_id", session.getAttribute("homepage_id"));
		model.addAttribute("menu_idx", session.getAttribute("menu_idx"));

		return basePath + "se2photo_uploader_ajax";
	}

	@RequestMapping(value = {"/imgUpload.*"}, method = RequestMethod.POST)
	public String imgUpload(@RequestParam String callback, @RequestParam String callback_func, MenuTempFile menuTempFile, BindingResult result, MultipartHttpServletRequest mpRequest) {

		MultipartFile mfile = mpRequest.getFileMap().get("menu_temp_file");
		menuHtmlService.addMenuTempFile(menuTempFile, mfile);
		String path = menuTempFile.getPath();
		String[] pathnames = path.split("/");
		String filename = pathnames[pathnames.length-1];
		HashMap<String, String> fileHash = new HashMap<String, String>();
		fileHash.put("name", filename);
		fileHash.put("size", String.valueOf(path.getBytes().length));

		StringBuilder sb = new StringBuilder();

		sb.append(callback);
		sb.append("?callback_func=" + callback_func);
		sb.append("&bNewLine=true");
		sb.append("&sFileName=" + encodeURIComponent(mfile.getOriginalFilename()));
		sb.append("&sFileURL=" + menuHtmlService.getMenuTempFileStoragePath() + path);

		return "redirect:" + sb.toString();
	}

	private static String encodeURIComponent(String s) {
	    String result;

	    try {
	        result = URLEncoder.encode(s, "UTF-8")
	                .replaceAll("\\+", "%20")
	                .replaceAll("\\%21", "!")
	                .replaceAll("\\%27", "'")
	                .replaceAll("\\%28", "(")
	                .replaceAll("\\%29", ")")
	                .replaceAll("\\%7E", "~");
	    } catch (UnsupportedEncodingException e) {
	        result = s;
	        e.printStackTrace();
	    }

	    return result;
	}

	@RequestMapping(value = {"/getHistory.*"}, method = RequestMethod.GET)
	public String getHistory(Model model, MenuHtml menuHtml, HttpSession session) {

		String homepage_id = session.getAttribute("homepage_id").toString();
		int menu_idx = (Integer) session.getAttribute("menu_idx");

		menuHtml.setHomepage_id(homepage_id);
		menuHtml.setMenu_idx(menu_idx);

		model.addAttribute("homepage_id", homepage_id);
		model.addAttribute("menu_idx", menu_idx);

		model.addAttribute("menuHtmlList", menuHtmlService.getMenuHtml(menuHtml));
		MenuHtml menuHtmlTemp = menuHtmlService.getLastMenuHtmlOne(menuHtml);
		if(menuHtmlTemp != null) {
			menuHtml.setHtml(menuHtmlTemp.getHtml());
		}

		model.addAttribute("menuHtml", menuHtml);
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(menuHtml.getHomepage_id())));
		return basePath + "getHistory_ajax";
	}

	@RequestMapping(value = {"/managerView.*"}, method = RequestMethod.GET)
	public String managerView(Model model, Menu menu) {
		model.addAttribute("manageList", organizationService.getOrganizationWorkList(new Organization(menu.getHomepage_id())));
		
		return basePath + "managerView_ajax";
	}
}