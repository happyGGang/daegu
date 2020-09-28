package kr.co.whalesoft.app.cms.homepage.subHomepage;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/subHomepage"})
public class SubHomepageController extends BaseController {

	private final String basePath = "/cms/homepage/sub/";

	@Autowired
	private HomepageService service;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Homepage homepage, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		homepage.setHomepage_group(getAsideHomepageId(request));
		int count = service.getSubHomepageListCount(homepage);
		service.setPaging(model, count, homepage);
		model.addAttribute("homepageList", service.getSubHomepageList(homepage));
		model.addAttribute("homepageListCount", count);
		model.addAttribute("homepage", homepage);
		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Homepage homepage, HttpServletRequest request) throws AuthException {
		homepage.setHomepage_group(getAsideHomepageId(request));
		if(homepage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("homepage", service.copyObjectPaging(homepage, service.getHomepageOne(homepage)));
		} else {
			checkAuth("C", model, request);
			int next_print_seq = service.getSubNextPrintSeq(homepage);
			homepage.setPrint_seq(next_print_seq);
			model.addAttribute("homepage", homepage);
		}
		return basePath + "edit_ajax";
	}

	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Homepage homepage, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(!homepage.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_name", "홈페이지명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "homepage_type", "홈페이지 유형을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "domain", "도메인명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "folder", "폴더명을 입력하세요.");
		}

		if(!result.hasErrors()) {
			if(homepage.getEditMode().equals("ADD")) {
				service.addHomepage(homepage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(homepage.getEditMode().equals("MODIFY")) {
				service.modifyHomepage(homepage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(homepage.getEditMode().equals("DELETE")) {
				service.deleteHomepage(homepage);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
