package kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping (value = {"/modifyAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyAll(UntactLockerSetting untactLockerSetting, BindingResult result, HttpServletRequest request) {
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


	@RequestMapping(value = { "/bookSettingEdit.*" })
	public String bookSettingEdit(Model model, UntactBookSetting untactBookSetting, HttpServletRequest request) throws AuthException {
		untactBookSetting = service.getUntactBookSettingOne(getAsideHomepageId(request));

		if(untactBookSetting == null) {
			untactBookSetting = new UntactBookSetting();
			untactBookSetting.setHomepage_id(getAsideHomepageId(request));
		}

		model.addAttribute("termsList", service.getUntactBookSettingTerms(untactBookSetting.getHomepage_id()));
		model.addAttribute("untactBookSetting", untactBookSetting);

		return basepath + "bookSettingEdit_ajax";
	}

	@RequestMapping (value = {"/bookSettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookSettingSave(UntactBookSetting untactBookSetting, BindingResult result, HttpServletRequest request) {
		untactBookSetting.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "locker_use_yn", "사물함 사용여부를 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "row_count", "사물함 한줄당 갯수를 입력하세요.");
		ValidationUtils.rejectIfZero(result, "total_count", "총 사물함 갯수를 입력하세요.");
		ValidationUtils.rejectIfZero(result, "reservation_max_count", "하루최대 대출가능 권수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "locker_use_type", "사물함 타입을 설정해주세요.");

		if (!result.hasErrors()) {
			service.mergeUntactBookSetting(untactBookSetting);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
}
