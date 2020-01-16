package kr.co.whalesoft.app.cms.terms;

import javax.servlet.http.HttpServletRequest;

import kr.co.whalesoft.app.cms.code.CodeService;
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

@Controller
@RequestMapping(value = {"/cms/terms"})
public class TermsController extends BaseController {

	private final String basePath = "/cms/terms/";

	@Autowired
	private TermsService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Terms terms, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		terms.setHomepage_id(getAsideHomepageId(request));

		int count = service.getTermsListCount(terms);

		service.setPaging(model, count, terms);
		model.addAttribute("terms", terms);
		model.addAttribute("termsListCount", count);
		model.addAttribute("termsList", service.getTermsList(terms));

		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Terms terms, HttpServletRequest request) throws AuthException {
		terms.setHomepage_id(getAsideHomepageId(request));
		if(terms.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			terms = (Terms)service.copyObjectPaging(terms, service.getTermsOne(terms));
		} else {
			checkAuth("C", model, request);
		}

		model.addAttribute("terms", terms);
		model.addAttribute("termsTypeList", codeService.getCode("CMS", "C0015"));

		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/view.*"})
	public String view(Model model, Terms terms, HttpServletRequest request) {
		terms.setHomepage_id(getAsideHomepageId(request));
		terms = (Terms)service.copyObjectPaging(terms, service.getTermsOne(terms));

		model.addAttribute("terms", terms);

		return basePath + "view_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Terms terms, BindingResult result, HttpServletRequest request) {
		terms.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "contents", "상세내용을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "use_yn", "사용여부를 선택해주세요.");

		terms.setAdd_id(getSessionMemberId(request));

 		if(!result.hasErrors()) {
			if(terms.getEditMode().equals("ADD")) {
				service.addTerms(terms);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(terms.getEditMode().equals("MODIFY")) {
				service.modifyTerms(terms);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Model model, Terms terms, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

 		if(!result.hasErrors()) {
// 			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) == 100 ) {
				service.deleteTerms(terms);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
// 			} else {
// 				res.setValid(false);
// 				res.setMessage("권한이 없습니다.");
// 			}
 		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
