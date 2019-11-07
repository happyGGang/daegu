package kr.co.whalesoft.app.cms.menu.menuAccess;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value = { "/cms/menuAccess" })
public class MenuAccessController extends BaseController {
	private final String basePath = "/cms/menuAccess/";

	@Autowired
	private MenuAccessService service;

	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		MenuAccess menuAccess = new MenuAccess();
		
		String today = sf.format(new Date());

		menuAccess.setStart_date(today);
		menuAccess.setEnd_date(today);
		model.addAttribute("menuAccess", menuAccess);
		model.addAttribute("member", getSessionMemberInfo(request));
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/menuAccessTable.*" })
	public String getMenuAccessData(Model model, MenuAccess menuAccess) {
		model.addAttribute("menuAccess", menuAccess);
		model.addAttribute("menuAccessResult", service.getMenuAccessCount(menuAccess));
		return basePath + "menuAccessTable_ajax";
	}
	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public MenuAccessSearchView excelDownload(Model model, MenuAccess menuAccess, HttpServletRequest request){
		model.addAttribute("menuAccess", menuAccess);
		model.addAttribute("menuAccessResult", service.getMenuAccessCount(menuAccess));
		
		return new MenuAccessSearchView();
	}
	
	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csvDownload(Model model, MenuAccess menuAccess, HttpServletRequest request, HttpServletResponse response){
		List<MenuAccess> menuAccessResult = service.getMenuAccessCount(menuAccess);
		
		new MenuAccessXlsToCsv(menuAccess, menuAccessResult, request, response);
	}
}
