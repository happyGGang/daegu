package kr.go.gbelib.app.module.menuRating;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.menuRating.MenuRating;
import kr.go.gbelib.app.cms.module.menuRating.MenuRatingService;

@Controller(value = "userMenuRating")
@RequestMapping(value = {"/{homepagePath}/module/menuRating"})
public class MenuRatingController extends BaseController {
	
	private String basePath = "/homepage/%s/module/menuRating/";
	
	@Autowired
	private MenuRatingService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MenuRating menuRating, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		menuRating.setHomepage_id(homepage.getHomepage_id());

		model.addAttribute("menuRating", menuRating);

		return String.format(basePath, homepage.getFolder()) + "index_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MenuRating menuRating, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */
		
		if (!result.hasErrors()) {
			@SuppressWarnings ("unchecked")
			Set<String> session_menu_idx = (Set<String>)request.getSession().getAttribute("session_menu_idx");
			if(session_menu_idx == null) {
				session_menu_idx = new HashSet<String>();
			}
			
			if (menuRating.getEditMode().equals("ADD")) {
				String homepage_menu = menuRating.getHomepage_id() + "-" + menuRating.getMenu_idx();
				if(session_menu_idx.contains(homepage_menu)) {
					res.setValid(false);
					res.setMessage("위 메뉴에는 이미 별점을 선정하셨습니다.");
				} else {
					String session_member_id = getSessionMemberId(request);
					menuRating.setAdd_id(session_member_id == null ? "anonymous" : session_member_id);
					service.addMenuRatingScore(menuRating);
					res.setValid(true);
					res.setMessage("메뉴 별점을 등록하였습니다.");
					
					session_menu_idx.add(homepage_menu);
					request.getSession().setAttribute("session_menu_idx", session_menu_idx);
				}
				res.setUrl("module/menuRating/index.do");
				res.setData("menu_idx="+menuRating.getMenu_idx());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
