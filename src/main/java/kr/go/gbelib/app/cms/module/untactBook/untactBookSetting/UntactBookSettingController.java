package kr.go.gbelib.app.cms.module.untactBook.untactBookSetting;

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
@RequestMapping(value = {"/cms/module/untactBook/untactBookSetting"})
public class UntactBookSettingController extends BaseController {

	private final String basePath = "/cms/module/untactBook/untactBookSetting/";
	
	@Autowired
	private UntactBookSettingService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookSetting untactBookSetting, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = service.getUntactBookSettingOne(getAsideHomepageId(request));
		
		if(untactBookSetting == null) {
			untactBookSetting = new UntactBookSetting();
			untactBookSetting.setHomepage_id(getAsideHomepageId(request));
		}
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/save.*" }, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(UntactBookSetting untactBookSetting, BindingResult result, HttpServletRequest request) {

		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);

		/* <<<<< 유효성 검증 */
		if (!result.hasErrors()) {
			untactBookSetting.setHomepage_id(getAsideHomepageId(request));
			
			service.mergeUntactBookSetting(untactBookSetting);
			res.setValid(true);
			res.setMessage("저장 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}