package kr.co.whalesoft.app.cms.quickMenu;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/quickMenu"})
public class QuickMenuController extends BaseController {

	private final String basePath = "/cms/quickMenu/";

	@Autowired
	private QuickMenuService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, QuickMenu quickMenu, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
//		if ( !getSessionIsAdmin(request) ) {
			quickMenu.setHomepage_id(getAsideHomepageId(request));	
//		}
		
		int count = service.getQuickMenuListCount(quickMenu);
		service.setPaging(model, count, quickMenu);
		quickMenu.setTotalDataCount(count);
		model.addAttribute("quickMenu", quickMenu);
		model.addAttribute("quickMenuListCount", count);
		model.addAttribute("quickMenuList", service.getQuickMenuList(quickMenu));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, QuickMenu quickMenu, HttpServletRequest request) throws AuthException {
		if(quickMenu.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("quickMenu", service.copyObjectPaging(quickMenu, service.getQuickMenuOne(quickMenu)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("quickMenu", quickMenu);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, QuickMenu quickMenu, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = quickMenu.getEditMode();
		
		if(!editMode.equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "menu_name", "메뉴명을 입력하세요");
			if(quickMenu.getIcon_file() == null && editMode.equals("ADD")) {
				result.rejectValue("icon_file", "파일을 선택하세요.");
			}
		}
		
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				quickMenu.setAdd_id(getSessionMemberId(request));
				service.addQuickMenu(quickMenu);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				quickMenu.setModify_id(getSessionMemberId(request));
				service.modifyQuickMenu(quickMenu);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteQuickMenu(quickMenu);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}