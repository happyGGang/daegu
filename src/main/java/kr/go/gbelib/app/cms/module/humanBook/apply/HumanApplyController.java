package kr.go.gbelib.app.cms.module.humanBook.apply;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;

@Controller
@RequestMapping(value = {"/cms/module/humanApply"})
public class HumanApplyController extends BaseController {
	
	private final String basePath = "/cms/module/humanBook/humanApply/";
	
	@Autowired
	private HumanApplyService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, HumanApply humanApply, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		humanApply.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.getHumanBookApplyCount(humanApply), humanApply);

		model.addAttribute("humanApply", humanApply);
		model.addAttribute("humanScheduleList", service.getHumanBookScheduleList(humanApply));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/status.*"}, method = RequestMethod.GET)
	public String status(Model model, HumanApply humanApply, HttpServletRequest request) {
		Homepage homepage = (Homepage)request.getAttribute("homepage");
		humanApply = (HumanApply) service.copyObjectPaging(humanApply, service.getHumanApplyOne(humanApply));

		model.addAttribute("humanApply", humanApply);

		return basePath + "status_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(HumanApply humanApply, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if(humanApply.getEditMode().equals("STATUS")) {
				humanApply.setModify_id(getSessionMemberId(request));
				service.modifyApplyStatus(humanApply);
				res.setValid(true);
				res.setMessage("신청상태 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public HumanApplyView excel(Model model, HumanApply humanApply, HttpServletRequest request, HttpServletResponse response) throws Exception{

		model.addAttribute("humanApply", humanApply);
		model.addAttribute("humanScheduleList", service.getHumanBookScheduleList(humanApply));

		return new HumanApplyView();
	}

}
