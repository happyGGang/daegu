package kr.co.whalesoft.app.cms.code;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/code/{mode}", "/wbuilder/code/{mode}"})
public class CodeController extends BaseController {
	
	@ModelAttribute
	private void getMode(Model model, @PathVariable String mode) {
		this.mode = mode.toUpperCase();
		model.addAttribute("mode", mode.toUpperCase());
	}
	 
	private String mode;
	
	private final String basePath = "/cms/code/"; 
	
	private final String wbuilderPath = "/wbuilder/code/"; 

	@Autowired
	private CodeService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Code code, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		code.setMode(mode);
		if (mode.equals("CMS")) {
			code.setHomepage_id(mode);	
		} else {
			code.setHomepage_id(getAsideHomepageId(request));	
		}
		model.addAttribute("code", code);

		
		if (mode.equals("CMS")) {
			return wbuilderPath + "index";
		} else {
			return basePath + "index";
		}
	}
	
	/**
	 * 최상위 코드그룹정보를 가져온다.
	 * @return
	 */
	@RequestMapping(value="/getCodeGroupTreeList.*", method=RequestMethod.GET)
	public @ResponseBody List<Code> getCodeGroupTreeList(Code code) {
		code.setMode(mode);
		return service.getCodeGroupTreeList(code);
	}
	
	@RequestMapping(value="/getCodeGroupOne.*", method=RequestMethod.GET)
	public @ResponseBody Code getCodeGroupOne(Model model, Code code) {
		code.setMode(mode);
		if(code.getGroup_id().equals("ROOT")) {
			code = new Code();
			code.setGroup_id("ROOT");
			code.setGroup_name("코드그룹 모음");
			code.setRemark("코드그룹 모음은 수정할 수 없습니다.");
			return code;
		} else {
			return service.getCodeGroupOne(code);
		}
	}
	
	@RequestMapping(value="/editCodeGroup.*", method=RequestMethod.GET)
	public String editCodeGroup(Model model, Code code, HttpServletRequest request) throws AuthException {
		if(code.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			Code codeOne = (Code) service.copyObjectPaging(code, service.getCodeGroupOne(code));
			codeOne.setMode(mode);
			codeOne.setHomepage_id(getAsideHomepageId(request));
			model.addAttribute("code", codeOne);
		} else {
			checkAuth("C", model, request);
			code.setGroup_id("");
			model.addAttribute("code", code);
		}
		
		if (mode.equals("CMS")) {
			return wbuilderPath + "codeGroup/editCodeGroup_ajax";
		} else {
			return basePath + "codeGroup/editCodeGroup_ajax";
		}
		
	}
	
	@RequestMapping(value = {"/saveCodeGroup.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveCodeGroup(Model model, Code code, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		if(!code.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "group_id", "코드그룹 ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "group_name", "코드그룹명을 입력하세요.");
		} else {
			ValidationUtils.rejectIfEmpty(result, "group_id", "코드그룹명을 입력하세요.");
		}
		
		if(!result.hasErrors()) {
			code.setCud_id(getSessionMemberId(request));
			if(code.getEditMode().equals("ADD")) {
				service.addCodeGroup(code);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(code.getEditMode().equals("MODIFY")) {
				service.modifyCodeGroup(code);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(code.getEditMode().equals("DELETE")) {
				if(service.getCodeCount(code) > 0) {
					res.setValid(false);
					res.setMessage("하위 데이터가 존재하여 삭제할 수 없습니다.");
				} else {
					service.deleteCodeGroup(code);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value="/code.*", method=RequestMethod.GET)
	public String code(Model model, Code code, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		code.setMode(mode);
		model.addAttribute("codeList", service.getCodeList(code));
		model.addAttribute("code", code);
		
		if (mode.equals("CMS")) {
			return wbuilderPath + "code/code_ajax"; 
		} else {
			return basePath + "code/code_ajax"; 
		}
		
	}
	
	@RequestMapping(value="/editCode.*", method=RequestMethod.GET)
	public String editCode(Model model, Code code, HttpServletRequest request) throws AuthException {
		if(code.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			code.setMode(mode);
			model.addAttribute("code", service.copyObjectPaging(code, service.getCodeOne(code)));
		} else {
			checkAuth("C", model, request);
			code.setMode(mode);
			code.setPrint_seq(service.getNextPrintSeq(code));
			model.addAttribute("code", code);
		}
		
		if (mode.equals("CMS")) {
			return wbuilderPath + "code/editCode_ajax";
		} else {
			return basePath + "code/editCode_ajax";
		}
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Code code, BindingResult result, HttpServletRequest request) {
		
		JsonResponse res = new JsonResponse(request);
		
		if(!code.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "code_id", "코드 ID를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "code_name", "코드명을 입력하세요.");
		} else {
			ValidationUtils.rejectIfEmpty(result, "code_id", "코드 ID를 입력하세요.");
		}
		
		if(!result.hasErrors()) {
			code.setCud_id(getSessionMemberId(request));
			if(code.getEditMode().equals("ADD")) {
				if(service.getCodeOne(code) == null) {
					service.addCode(code);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("코드ID가 중복 되었습니다.");
				}
			} else if(code.getEditMode().equals("MODIFY")) {
				service.modifyCode(code);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(code.getEditMode().equals("DELETE")) {
				service.deleteCode(code);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	} 
	
}