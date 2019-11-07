package kr.go.gbelib.app.cms.module.teach.teachCategoryCode;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

/**
 * 강좌 분류 코드
 * @author YONGJU
 *
 */
@Controller
@RequestMapping(value = { "/cms/module/teach/teachCategoryCode" })
public class TeachCategoryCodeController extends BaseController {
	
	@Autowired
	private TeachCategoryCodeService service;

	private final String basePath = "/cms/module/teach/teachCategoryCode/";
	
	
	@RequestMapping(value="/index.*", method=RequestMethod.GET)
	public String login(Model model, TeachCategoryCode code, HttpServletRequest request) {
		model.addAttribute("code", code);
		model.addAttribute("rootGroupList", service.getRootGroup());
		model.addAttribute("middleGroupList", service.getMiddleGroup());
		return basePath + "index";
	}
	
	@RequestMapping(value="/edit.*", method=RequestMethod.GET)
	public String edit(Model model, TeachCategoryCode code, HttpServletRequest request) {
		model.addAttribute("code", code);
		model.addAttribute("middleGroup", service.getMiddleGroupOne(code)); 
		model.addAttribute("codeList", service.getCode(code));
		model.addAttribute("rootGroupList", service.getRootGroup());
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/rootGroupEdit.*"}, method = RequestMethod.GET)
	public String rootGroupEdit(Model model, TeachCategoryCode code, HttpServletRequest requeset, @RequestParam String editMode) {
		if (code.getEditMode().equals("rootGroupModify")) {
			code = service.getRootGroupOne(code);
			code.setEditMode(editMode);
		}
		model.addAttribute("code", code);
		return basePath + "rootGroupEdit_ajax";
	}
	
	@RequestMapping(value = {"/groupSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse groupSave(TeachCategoryCode code, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "teach_group_id", "코드ID를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "teach_code_name", "코드명을 입력하세요.");
		
		if(code.getEditMode().equals("add")) {
			if(service.getMiddleGroupOne(code) != null) {
				result.reject("이미 존재하는 중분류코드ID 입니다.");
			}
		}
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			code.setAdd_id(getSessionMemberId(request));
			code.setModify_id(getSessionMemberId(request));
			if(code.getEditMode().equals("modify")) {
				service.modifyCodeGroup(code);
				res.setValid(true);
//				res.setUrl("/code/index.ws");
				res.setMessage("수정 되었습니다.");
			} else {
				service.addCodeGroup(code);
				res.setValid(true);
//				res.setUrl("/code/index.ws");
				res.setMessage("등록 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/codeSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse codeSave(TeachCategoryCode code, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "teach_code_id", "코드ID를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "teach_code_name", "코드명을 입력하세요.");
		ValidationUtils.rejectExceptNumber(result, "print_seq", "순서는 숫자만 가능합니다.");
		
		if(code.getEditMode().equals("rootGroupAdd")) {
			if(service.getRootGroupOne(code) != null) {
				result.reject("이미 존재하는 대분류코드ID 입니다.");
			}
		}
		
		/* <<<<< 유효성 검증 */
		
		if(!result.hasErrors()) {
			code.setAdd_id(getSessionMemberId(request));
			code.setModify_id(getSessionMemberId(request));
			if(code.getEditMode().equals("modify")) {
				service.modifyCode(code);
				res.setValid(true);
//				res.setUrl("/code/");
				res.setMessage("수정 되었습니다.");
			} else if (code.getEditMode().equals("add")) {
				service.addCode(code);
				res.setValid(true);
//				res.setUrl("/code/");
				res.setMessage("등록 되었습니다.");
			} else if (code.getEditMode().equals("rootGroupAdd")) {
				service.addRootGroupCode(code);
				res.setValid(true);
//				res.setUrl("/code/");
				res.setMessage("대분류가 등록 되었습니다.");
			} else if (code.getEditMode().equals("rootGroupModify")) {
				service.modifyRootGroupCode(code);
				res.setValid(true);
//				res.setUrl("/code/");
				res.setMessage("대분류가 수정 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
			for (ObjectError err : result.getAllErrors()) {
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + err.getCode());
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + err.getDefaultMessage());
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + err.getObjectName());
			}

		}
		
		return res;
	}
	
}
