package kr.go.gbelib.app.cms.module.elib.config;

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
@RequestMapping(value = {"/cms/module/elib/config"})
public class ConfigController extends BaseController {

	private final String basePath = "/cms/module/elib/config/";

	@Autowired
	private ConfigService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Config config, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		config.setHomepage_id(getAsideHomepageId(request));	
		
		model.addAttribute("config", service.getConfig());
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Config config, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = config.getEditMode();
		
		ValidationUtils.rejectIfEmpty(result, "user_max_lend", "개인별 최대 대출 권수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "book_max_lend", "도서별 최대 대출 권수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "max_reserve", "개인별 최대 예약 권수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "book_max_reserve", "도서별 최대 동시 예약자수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "lend_max_term", "대출 기간을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "max_extention", "연장 횟수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "ext_lend_term", "연장 가능일을 입력하세요.");
		
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				config.setModify_id(getSessionMemberId(request));
				service.setConfig(config);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
//			} else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		
		return res;
	}

}
