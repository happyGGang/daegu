package kr.co.whalesoft.app.cms.homepage;

import java.util.ArrayList;
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
@RequestMapping(value = {"/cms/homepage"})
public class HomepageController extends BaseController {

	private final String basePath = "/cms/homepage/";

	@Autowired
	private HomepageService service;

	@Autowired
	private CodeService codeService;

	@RequestMapping(value = {"/index.*"})
	public String index(Model model, Homepage homepage, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		homepage.setRowCount(30);
		int count = service.getHomepageListCount();
		service.setPaging(model, count, homepage);
		model.addAttribute("homepageList", service.getHomepageList(homepage));
		model.addAttribute("homepageListCount", count);
		model.addAttribute("homepage", homepage);
		model.addAttribute("homepageTypeList", codeService.getCode(homepage.getHomepage_id(), "C0001"));
		return basePath + "index";
	}

	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, Homepage homepage, HttpServletRequest request) throws AuthException {
		if(homepage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("homepage", service.copyObjectPaging(homepage, service.getHomepageOne(homepage)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("homepage", homepage);
		}
		model.addAttribute("homepageTypeList", codeService.getCode(homepage.getHomepage_id(), "C0001"));
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

	@RequestMapping(value = {"/tempPage.*"})
	public String tempPage(Model model, Homepage homepage) {
		model.addAttribute("homepage", service.getHomepageOne(homepage));

		List<String> hourList = new ArrayList<String>();
		for(int i=1; i<=23; i++) {
			if(i < 10) {
				hourList.add("0" + i);
			} else {
				hourList.add(Integer.toString(i));
			}
		}

		model.addAttribute("hourList", hourList);
		return basePath + "tempPage_ajax";
	}

	@RequestMapping(value = {"/modifyTempPage.*"})
	public @ResponseBody JsonResponse  modifyTempPage(Model model, Homepage homepage, BindingResult result, HttpServletRequest request) {

		JsonResponse res = new JsonResponse(request);

		if(homepage.getTemp_use_yn().equals("Y")) {
			ValidationUtils.rejectIfEmpty(result, "temp_start_date_1", "시작시간은 필수값 입니다.");
			ValidationUtils.rejectIfEmpty(result, "temp_start_date_2", "시작시간은 필수값 입니다.");
			ValidationUtils.rejectIfEmpty(result, "temp_start_date_3", "시작시간은 필수값 입니다.");

			ValidationUtils.rejectIfEmpty(result, "temp_end_date_1", "종료시간은 필수값 입니다.");
			ValidationUtils.rejectIfEmpty(result, "temp_end_date_2", "종료시간은 필수값 입니다.");
			ValidationUtils.rejectIfEmpty(result, "temp_end_date_3", "종료시간은 필수값 입니다.");
		}

		if(!result.hasErrors()) {
			if(service.modifyHomepageTemp(homepage) > 0) {
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}