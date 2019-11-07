package kr.co.whalesoft.app.cms.statusMng;

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
@RequestMapping(value = {"/cms/statusMng"})
public class StatusMngController extends BaseController {
	
	private final String basePath = "/cms/statusMng/";
	
	@Autowired
	private StatusMngService service;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, StatusMng statusMng, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		statusMng.setHomepage_id(getAsideHomepageId(request));
		
		int count = service.getStatusMngCount(statusMng);
		service.setPaging(model, count, statusMng);
		statusMng.setTotalDataCount(count);
		
		model.addAttribute("statusMng", statusMng);
//		model.addAttribute("statusMngList", service.getstatusMngList(statusMng));
		
//		model.addAttribute("divList", service.getDivList(statusMng));
//		model.addAttribute("statusList", service.getStatusList(statusMng));
		
		model.addAttribute("divList", service.getChartDivList(statusMng.getHomepage_id()));
		model.addAttribute("statusList", service.getStatusList(statusMng.getHomepage_id()));
		model.addAttribute("totalCnt", service.getTotalCant(statusMng.getHomepage_id()));
		model.addAttribute("homepage", homepageService.getHomepageOne(new Homepage(statusMng.getHomepage_id())));

		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, StatusMng statusMng, HttpServletRequest request) throws AuthException {
		if(statusMng.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
//			statusMng = (DeptMng)service.copyObjectPaging(statusMng, service.getStatusMngOne(statusMng));
		} else {
			checkAuth("C", model, request);
		}
		
		model.addAttribute("statusMng", statusMng);
		model.addAttribute("statusDivList", service.getDivList(statusMng.getHomepage_id()));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(StatusMng statusMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "div_name", "'직렬' 필수 입력 항목입니다.");
		ValidationUtils.rejectIfStringLength(result, "div_name", 100, "직렬");

		if(!result.hasErrors()) {
			if(statusMng.getEditMode().equals("ADD")) {
				statusMng.setAdd_id(getSessionMemberId(request));
				statusMng.setDiv_print_seq(service.getDivNextPrintSeq(statusMng));
				service.addStatusDiv(statusMng);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(statusMng.getEditMode().equals("MODIFY")) {
				statusMng.setMod_id(getSessionMemberId(request));
				service.modifyStatusDiv(statusMng);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(StatusMng statusMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.statusMngDel(statusMng);
			service.deleteDivAll(statusMng);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/status.*"})
	public String status(Model model, StatusMng statusMng, HttpServletRequest request) throws AuthException {
		if(statusMng.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			statusMng = (StatusMng)service.copyObjectPaging(statusMng, service.getStatusMngOne(statusMng));
		} else {
			checkAuth("C", model, request);
			statusMng.setPrint_seq(service.getNextPrintSeq(statusMng));
		}
		
		model.addAttribute("statusMng", statusMng);
		model.addAttribute("divList", service.getDivList(statusMng.getHomepage_id()));
		
		return basePath + "status_ajax";
	}
	
	@RequestMapping(value = {"/statusSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusSave(StatusMng statusMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "rating", "급수를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "max_cnt", "정원을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "cur_cnt", "현원을 입력하세요.");
//		ValidationUtils.rejectIfZero(result, "max_cnt", "정원은 0이상의 숫자만 입력가능합니다.");
//		ValidationUtils.rejectIfZero(result, "cur_cnt", "현원은 0이상의 숫자만 입력가능합니다.");
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			if(statusMng.getEditMode().equals("ADD")) {
				statusMng.setAdd_id(getSessionMemberId(request));
				service.addStatusCnt(statusMng);
				service.modifyRatingCnt(statusMng);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if(statusMng.getEditMode().equals("MODIFY")) {
				statusMng.setMod_id(getSessionMemberId(request));
				service.modifyStatusCnt(statusMng);
				service.modifyRatingCnt(statusMng);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/statusDelete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusDelete(StatusMng statusMng, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if(!result.hasErrors()) {
			service.statusMngCnt(statusMng);
			service.modifyRatingCnt(statusMng);
			res.setValid(true);
			res.setReload(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

}
