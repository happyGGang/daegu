package kr.co.whalesoft.app.cms.commonMenu;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.whalesoft.app.cms.auth.Auth;
import kr.co.whalesoft.app.cms.auth.AuthService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/commonMenu"})
public class CommonMenuController extends BaseController {
	
	private final String basePath = "/cms/commonMenu/";
	
	@Autowired
	private CommonMenuService service; 
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private AuthService authService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, CommonMenu menu, HttpServletRequest request) {
		Member member = getSessionMemberInfo(request);
		
		model.addAttribute("menu", menu); 
		model.addAttribute("member", member);
		
		return basePath + "index";
	}
	
	/**
	 * 최상위 메뉴정보를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getMenuTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<CommonMenu> getMenuTreeList() {
		List<CommonMenu> aaa = service.getMenuTreeList(); 
		return aaa;
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, CommonMenu menu) {
		CommonMenu parentMenu = null;
		
		parentMenu = service.getParentMenuOne(menu);
		
		if(menu.getEditMode().equals("MODIFY")) {
			menu = (CommonMenu)service.copyObjectPaging(menu, service.getMenuOne(menu));
		} else {
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
		model.addAttribute("authList", authService.getMenuAuth(new Auth(menu.getHomepage_id())));
		model.addAttribute("menuAuthArray", service.getMenuAuth(menu));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(menu.getHomepage_id())));
		
		return basePath + "edit_ajax";
	}
	
	
	@RequestMapping(value = {"/editMenuType.*"}, method = RequestMethod.GET)
	public String editMenuType(Model model, CommonMenu menu) {
		
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
	public @ResponseBody JsonResponse save(CommonMenu menu, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
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
		
		if ( !result.hasErrors() ) {
			if ( menu.getEditMode().equals("MODIFY") ) {
				mFile = mpRequest.getFileMap().get("menu_img_file");
				mFileTopIcon = mpRequest.getFileMap().get("menu_top_icon_file");
				mFileLeftIcon = mpRequest.getFileMap().get("menu_left_icon_file");
				service.modifyMenu(mFile, mFileTopIcon, mFileLeftIcon, menu);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(menu.getEditMode().equals("ADD")) {
				mFile = mpRequest.getFileMap().get("menu_img_file");
				mFileTopIcon = mpRequest.getFileMap().get("menu_top_icon_file");
				mFileLeftIcon = mpRequest.getFileMap().get("menu_left_icon_file");
				service.addMenu(mFile, mFileTopIcon, mFileLeftIcon, menu);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(menu.getEditMode().equals("parentMenuModify")) {
				service.modifyParentMenu(menu);
				res.setValid(true);
				res.setMessage("메뉴이동 되었습니다.");
			}
		} 
		else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	/*@RequestMapping(value = {"/edit_html.*"}, method = RequestMethod.GET)
	public String edit_html(Model model, MenuHtml menuHtml) {
		model.addAttribute("menuHtmlList", menuHtmlService.getMenuHtml(menuHtml));
		MenuHtml menuHtmlTemp = menuHtmlService.getLastMenuHtmlOne(menuHtml);
		if(menuHtmlTemp != null) {
			menuHtml.setHtml(menuHtmlTemp.getHtml());
		}
		
		model.addAttribute("menuHtml", menuHtml);
		return basePath + "/menu_type/html_ajax";
	}
	
	@RequestMapping(value = {"/save_html.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save_html(MenuHtml menuHtml, BindingResult result, HttpServletRequest request) {
		 유효성 검증 >>>>> 
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
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
	
	@RequestMapping(value = {"/edit_board.*"}, method = RequestMethod.GET)
	public String edit_board(Model model, BoardManage boardManage) {
		model.addAttribute("boardManageList", boardManageService.getBoardManage(boardManage));
		return basePath + "/menu_type/board_ajax";
	}
	
	@RequestMapping(value = {"/getMenuHtmlStrOne.*"}, method = RequestMethod.GET)
	public @ResponseBody String getMenuHtmlStrOne(MenuHtml menuHtml) {
		return menuHtmlService.getMenuHtmlStrOne(menuHtml);
	}*/
}