package kr.go.gbelib.app.cms.module.smsReception;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/smsReception"})
public class SmsReceptionController extends BaseController {
	
	private final String basePath = "/cms/module/smsReception/";
	
	@Autowired
	private SmsReceptionService service;
	
	@Autowired
	private CodeService CodeService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, SmsReception smsReception, HttpServletRequest request) {
		smsReception.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getSmsReceptionCount(smsReception);
		service.setPaging(model, count, smsReception);
		
		model.addAttribute("smsReception", smsReception);
//		model.addAttribute("smsReceptionList", service.getSmsReceptionList(smsReception));
		
		List<SmsReception>smsReceptionList = service.getSmsReceptionList(smsReception);
		for(SmsReception one : smsReceptionList) {
			one.setReception_list(service.getReceptionWorkList(one));
		}
		
		model.addAttribute("smsReceptionList", smsReceptionList);
		model.addAttribute("workCodeList", CodeService.getCode("CMS", "C0025"));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, SmsReception smsReception, HttpServletRequest request) throws AuthException {
		if(smsReception.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			
			model.addAttribute("smsReception", service.copyObjectPaging(smsReception, service.getSmsReceptionOne(smsReception)));
		} else {
			checkAuth("C", model, request);
			
			model.addAttribute("smsReception", smsReception);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(SmsReception smsReception, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "reception_name", "담당자명 필수 입력입니다.");
		ValidationUtils.rejectIfEmpty(result, "reception_phone", "연락처 필수 입력입니다.");
		ValidationUtils.rejectPhone(result, "reception_phone", "연락처 형식은 (01x-xxxx-xxxx) or (01x-xxx-xxxx)입니다.");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(smsReception.getEditMode().equals("ADD")) {
				smsReception.setAdd_id(getSessionMemberId(request));
				service.addSmsReception(smsReception);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
			} else if(smsReception.getEditMode().equals("MODIFY")) {
				smsReception.setMod_id(getSessionMemberId(request));
				service.modSmsReception(smsReception);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/work.*"})
	public String work(Model model, SmsReception smsReception, HttpServletRequest request) throws AuthException {
		checkAuth("C", model, request);
		checkAuth("U", model, request);
		
		model.addAttribute("smsReception", smsReception);
		smsReception.setReception_list(service.getReceptionWorkList(smsReception));
		
		model.addAttribute("workCodeList", CodeService.getCode("CMS", "C0025"));
		
		return basePath + "work_ajax";
	}
	
	@RequestMapping(value = {"/workSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse workSave(SmsReception smsReception, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
//		ValidationUtils.rejectIfEmpty(result, "field", "errorCode");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			for(SmsReception one : smsReception.getReception_list()) {
				one.setHomepage_id(smsReception.getHomepage_id());
				one.setReception_idx(smsReception.getReception_idx());
				if(one.getWork_idx() == 0) {
					one.setWork_idx(service.getWorkIdx(one));
				}
				if(one.getReception_yn() == null) {
					one.setReception_yn("N");
				}
				service.mergeReception(one);
			}
			
			res.setValid(true);
			res.setMessage("저장되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(SmsReception smsReception, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			int res_num = service.receptionDel(smsReception);
			if(res_num > 0) {
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
				res.setReload(true);
			} else {
				res.setValid(false);
				res.setMessage("관리자에게 문의하세요.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
