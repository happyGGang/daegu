package kr.go.gbelib.app.cms.module.untactBook.untactBookPenaltySetting;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
@RequestMapping(value = {"/cms/module/untactBook/untactBookPenaltySetting"})
public class UntactBookPenaltySettingController extends BaseController {

	private final String basePath = "/cms/module/untactBook/untactBookPenaltySetting/";
	
	@Autowired
	private UntactBookPenaltySettingService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, UntactBookPenaltySetting penalty, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		penalty.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getUntactBookPenaltySettingCount(penalty);
		service.setPaging(model, count, penalty);
		penalty.setTotalDataCount(count);
		model.addAttribute("untactBookPenaltySettingCount", count);
		model.addAttribute("untactBookPenaltySetting", penalty);
		model.addAttribute("untactBookPenaltySettingList", service.getUntactBookPenaltySettingList(penalty));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, UntactBookPenaltySetting penalty, HttpServletRequest request) throws AuthException {

		if (penalty.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			penalty = (UntactBookPenaltySetting)service.copyObjectPaging(penalty, service.getUntactBookPenaltySettingOne(penalty));
		} else {
			checkAuth("C", model, request);
			if(StringUtils.isEmpty(penalty.getUse_yn())) {
				penalty.setUse_yn("Y");
			}
		}
		
		
		
		model.addAttribute("untactBookPenaltySetting", penalty);

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(UntactBookPenaltySetting penalty, BindingResult result, HttpServletRequest request) {
		
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		if(penalty.getEditMode().equals("ADD") || penalty.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "start_date", "시작일을 지정하세요.");
			ValidationUtils.rejectIfEmpty(result, "end_date", "종료일을 지정하세요.");
			
			if(penalty.getPenalty_count() == null) {
				result.rejectValue("penalty_count", "패널티 횟수를 입력해주세요.");
			} else {
				ValidationUtils.rejectExceptNumber(result, "penalty_count", "숫자만 입력가능합니다.");
			}
			
			if(penalty.getPenalty_day() == null) {
				result.rejectValue("penalty_day", "패널티 일수를 입력해주세요.");
			} else {
				ValidationUtils.rejectExceptNumber(result, "penalty_day", "숫자만 입력가능합니다.");
			}
			
			if (service.duplicateCheck(penalty) > 0) {
				result.rejectValue("start_date", "패널티 기간이 중복되었습니다.");
			}
		}
		
		/* <<<<< 유효성 검증 */
		if (!result.hasErrors()) {

			res.setValid(true);
			if(penalty.getEditMode().equals("ADD")) {
				service.addUntactBookPenaltySetting(penalty);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (penalty.getEditMode().equals("MODIFY")) {
				service.modifyUntactBookPenaltySetting(penalty);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(penalty.getEditMode().equals("DELETE")) {
				service.deleteUntactBookPenaltySetting(penalty);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(UntactBookPenaltySetting penalty, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			service.deleteUntactBookPenaltySetting(penalty);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
