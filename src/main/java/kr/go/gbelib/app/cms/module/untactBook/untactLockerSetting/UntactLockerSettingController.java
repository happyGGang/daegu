package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

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

@Controller
@RequestMapping(value="/cms/module/untactBook/untactLockerSetting")
public class UntactLockerSettingController extends BaseController {
	                                                          
	private final String basepath = "/cms/module/untactBook/untactLockerSetting/";
	
	@Autowired
	private UntactLockerSettingService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactLockerSetting untactLockerSetting, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(untactLockerSetting == null) {  
			untactLockerSetting = new UntactLockerSetting();
			untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		}
		
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		model.addAttribute("untactLockerSettingList", service.getUntactLockerSettingList(getAsideHomepageId(request)));
		
		return basepath + "index";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(UntactLockerSetting untactLockerSetting, BindingResult result, HttpServletRequest request) {
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			service.modifyUntactLockerSetting(untactLockerSetting);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
		
	}
	
	@RequestMapping (value = {"/modAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modeAll(UntactLockerSetting untactLockerSetting, BindingResult result, HttpServletRequest request) {
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			service.modifyUntactLockerSettingALL(untactLockerSetting);
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
		
	}
	
	
}
