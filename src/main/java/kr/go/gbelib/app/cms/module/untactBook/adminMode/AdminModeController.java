package kr.go.gbelib.app.cms.module.untactBook.adminMode;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = {"/cms/module/untactBook/adminMode"})
public class AdminModeController extends BaseController {

	private final String basePath = "/cms/module/untactBook/adminMode/";
	
	@Autowired
	private UntactLockerSettingService settingService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookSetting untactBookSetting, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		
		return basePath + "index_ajax";
	}
	
}
