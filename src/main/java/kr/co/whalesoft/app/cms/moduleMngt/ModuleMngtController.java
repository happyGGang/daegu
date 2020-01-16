package kr.co.whalesoft.app.cms.moduleMngt;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.authCode.AuthCodeService;
import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.terms.Terms;
import kr.co.whalesoft.app.cms.terms.TermsService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/wbuilder/moduleMngt"})
public class ModuleMngtController extends BaseController {

	private final String basePath = "/wbuilder/moduleMngt/";

	@Autowired
	private ModuleMngtService service;

	@Autowired
	private TermsService termsService;

	@Autowired
	private AuthCodeService authCodeService;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ModuleMngt moduleMngt, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		moduleMngt.setHomepage_id(getAsideHomepageId(request));
		int count = service.getModuleMngtListCount(moduleMngt);
		service.setPaging(model, count, moduleMngt);
		model.addAttribute("moduleMngt", moduleMngt);
		model.addAttribute("moduleMngtListCount", count);
		model.addAttribute("moduleMngtList", service.getModuleMngtList(moduleMngt));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ModuleMngt moduleMngt, HttpServletRequest request) throws AuthException {
		if ( moduleMngt.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("moduleMngt", service.copyObjectPaging(moduleMngt, service.getModuleMngtOne(moduleMngt)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("moduleMngt", moduleMngt);
		}

		model.addAttribute("authCodeList", authCodeService.getAuthGroupList());
		model.addAttribute("termsCodeList", codeService.getCode("CMS", "C0015"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ModuleMngt moduleMngt, BindingResult result, HttpServletRequest request) throws AuthException {
		JsonResponse res = new JsonResponse(request);
		String editMode = moduleMngt.getEditMode();

		if ( !moduleMngt.getEditMode().equals("DELETE") ) {
			ValidationUtils.rejectIfEmpty(result, "module_name", "모듈명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "link_url", "링크URL을 입력하세요.");
		}

		if ( !result.hasErrors() ) {
			if ( editMode.equals("ADD") ) {
				checkAuth("C", model, request);
				moduleMngt.setAdd_id(getSessionMemberId(request));
				service.addModuleMngt(moduleMngt);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				moduleMngt.setModify_id(getSessionMemberId(request));
				service.modifyModuleMngt(moduleMngt);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteModuleMngt(moduleMngt);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/moduleTerms.*"})
	public String moduleTerms(Model model, ModuleMngt moduleMngt) {
		model.addAttribute("moduleMngt", moduleMngt);
		model.addAttribute("inTermsList", termsService.getTermsListInModule(new Terms(moduleMngt.getModule_idx())));
		model.addAttribute("notInTermsList", termsService.getTermsListNotInModule(new Terms(moduleMngt.getModule_idx())));
		return basePath + "termsList_ajax";
	}

	@RequestMapping(value = {"/saveTerms.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveTerms(Model model, ModuleMngt moduleMngt, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);

		if ( !result.hasErrors() ) {
			if ( moduleMngt.getEditMode().equals("ADD") ) {
				service.addModuleTerms(moduleMngt);
				res.setValid(true);
				res.setMessage("저장 되었습니다.");
			}
			else if ( moduleMngt.getEditMode().equals("DELETE") ) {
				service.deleteModuleTerms(moduleMngt);
				res.setValid(true);
				res.setMessage("저장 되었습니다.");
			}
		}

		return res;
	}

}