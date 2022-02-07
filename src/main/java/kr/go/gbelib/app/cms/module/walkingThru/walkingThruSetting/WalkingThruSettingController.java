package kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting;

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
@RequestMapping(value="/cms/module/walkingThru/walkingThruSetting")
public class WalkingThruSettingController extends BaseController {

	private final String basePath = "/cms/module/walkingThru/walkingThruSetting/";

	@Autowired
	private WalkingThruSettingService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, WalkingThruSetting walkingThruSetting, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("walkingThruSettingList", service.getWalkingThruSettingList(walkingThruSetting));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/walkingThruSettingEdit.*" })
	public String walkingThruSettingEdit(Model model, WalkingThruSetting walkingThruSetting, HttpServletRequest request) throws AuthException {
		walkingThruSetting = service.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		if(walkingThruSetting == null) {
			walkingThruSetting = new WalkingThruSetting();
			walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		}
		
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("termsList", service.getWalkingThruSettingTerms(walkingThruSetting.getHomepage_id()));

		return basePath + "walkingThruSettingEdit_ajax";
	}
	
	@RequestMapping(value = {"/walkingThruSettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse walkingThruSettingSave(WalkingThruSetting walkingThruSetting, BindingResult result, HttpServletRequest request) {
		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "password_yn", "비밀번호 사용여부를 선택하세요.");
		ValidationUtils.rejectIfZero(result, "reserve_start_hour", "예약가능 시간을 선택하세요.");
		ValidationUtils.rejectIfZero(result, "loan_start_hour", "대출가능 시간을 선택하세요.");
		ValidationUtils.rejectIfEmpty(result, "loan_time_choice", "익일,금일중 하나를 선택하세요.");
		
		if(!result.hasErrors()) {
			service.modifyWalkingThruSetting(walkingThruSetting);
			res.setValid(true);
			res.setMessage("수정 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		} 
		return res;
	}
}
