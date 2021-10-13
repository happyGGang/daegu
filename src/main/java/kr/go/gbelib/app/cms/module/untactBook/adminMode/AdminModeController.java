package kr.go.gbelib.app.cms.module.untactBook.adminMode;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackList;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackListService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationSearchView;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping(value = {"/cms/module/untactBook/adminMode"})
public class AdminModeController extends BaseController {

	private final String basePath = "/cms/module/untactBook/adminMode/";
	
	@Autowired
	private UntactLockerSettingService settingService;
	
	@Autowired
	private UntactBookReservationService reservationService;
	
	@Autowired
	private UntactBookBlackListService blackListService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookSetting untactBookSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		int count = reservationService.getUntactBookReservationListCount(untactBookReservation);
		reservationService.setPaging(model, count, untactBookReservation);
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactBookReservationListCount", count);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationListNow(untactBookReservation));
		model.addAttribute("passwordCount", reservationService.checkPasswordCount(untactBookReservation));
		model.addAttribute("nonPasswordCount", reservationService.checkNonPasswordCount(untactBookReservation));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/cancelSettingEdit.*" })
	public String cancelSettingEdit(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request,  HttpServletResponse response) throws Exception {
		 untactBookReservation.setHomepage_id(getAsideHomepageId(request)); 
		untactBookReservation = reservationService.getUntactBookReservationOne(untactBookReservation);
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		return basePath + "cancelSettingEdit_ajax";
	}

	@RequestMapping (value = {"/cancelSettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse cancelSettingSave(UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		JsonResponse res = new JsonResponse(request);
		
		untactBookReservation.setCancel_id(getSessionMemberId(request));
		untactBookReservation.setCancel_ip(request.getRemoteAddr());
		
		if (!result.hasErrors()) {
			reservationService.cancelReservationStep(untactBookReservation);
			res.setValid(true);
			res.setMessage("취소 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping(value = { "/blackListSettingEdit.*" })
	public String blackListSettingEdit(Model model, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, HttpServletRequest request,  HttpServletResponse response) throws Exception {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation = reservationService.getUntactBookReservationOne(untactBookReservation);
		
		untactBookBlackList.setHomepage_id(untactBookReservation.getHomepage_id());
		untactBookBlackList.setMember_id(untactBookReservation.getMember_id());
		untactBookBlackList.setMember_name(untactBookReservation.getMember_name());
		
		if (blackListService.penaltyCount(untactBookBlackList) > 0) {
			blackListService.alertMessageOnly("penaltyFalse", request, response);
			return null;
		} else {
			model.addAttribute("untactBookBlackList", untactBookBlackList);
			return basePath + "blackListSettingEdit_ajax";
		}
	}

	@RequestMapping (value = {"/blackListSettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse blackListSettingSave(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		untactBookBlackList.setHomepage_id(untactBookReservation.getHomepage_id());
		
		SimpleDateFormat penaltyDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		
		untactBookBlackList.setPenalty_day(penaltyDateFormat.format(now));
		untactBookBlackList.setPenalty_register_id(getSessionMemberId(request));
		untactBookBlackList.setPenalty_register_ip(request.getRemoteAddr());
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			blackListService.grantPenalty(untactBookBlackList);
			res.setValid(true);
			res.setMessage("패널티가 부여 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/modifyReservationStep.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyReservationStep(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (reservationService.checkPassword(untactBookReservation) > 0) {
			reservationService.alertMessageOnly("passwordCheck", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			reservationService.modifyReservationStep(untactBookReservation);
			res.setValid(true);
			res.setMessage("수정되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/deleteAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteAllReservation(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			reservationService.deleteAllReservation(untactBookReservation);
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/randomPassword.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse randomPassword(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (reservationService.checkNonPasswordCount(untactBookReservation) == 0) {
			reservationService.alertMessageOnly("passwordCheck", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			reservationService.passwordSetting(untactBookReservation);
				res.setValid(true);
				res.setMessage("생성되었습니다.");
			} else {
				res.setValid(false);
				res.setResult(result.getAllErrors());
			}
		
		return res;
	}
	
	@RequestMapping (value = {"/reservationStepSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse reservationStep(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation = reservationService.getUntactBookReservationOne(untactBookReservation);
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			reservationService.changeReservationStep(untactBookReservation);
			res.setValid(true);
			res.setMessage("비치되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookReservationSearchView excelDownload(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request){
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationExcelList(untactBookReservation));
		
		return new UntactBookReservationSearchView();
	}
	
}
