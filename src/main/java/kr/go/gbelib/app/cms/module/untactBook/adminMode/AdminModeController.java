package kr.go.gbelib.app.cms.module.untactBook.adminMode;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.untactBook.untactBookPenalty.UntactBookPenalty;
import kr.go.gbelib.app.cms.module.untactBook.untactBookPenalty.UntactBookPenaltyService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
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
	private UntactBookPenaltyService penaltyService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookSetting untactBookSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationList(untactBookReservation));
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/penaltySettingEdit.*" })
	public String penaltySettingEdit(Model model, UntactBookPenalty untactBookPenalty, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation = reservationService.getUntactBookReservationOne(untactBookReservation);
		
		untactBookPenalty.setHomepage_id(untactBookReservation.getHomepage_id());
		untactBookPenalty.setMember_id(untactBookReservation.getMember_id());
		untactBookPenalty.setMember_name(untactBookReservation.getMember_name());
		
		model.addAttribute("untactBookPenalty", untactBookPenalty);
		
		return basePath + "penaltySettingEdit_ajax";
	}

	@RequestMapping (value = {"/penaltySettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookSettingSave(UntactBookPenalty untactBookPenalty, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request,  HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		
		untactBookPenalty.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (penaltyService.penaltyCount(homepage.getHomepage_id()) > 0) {
			penaltyService.alertMessage("이미 패널티 부여가 되었습니다.", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			penaltyService.mergePenaltySetting(untactBookPenalty);
			res.setValid(true);
			res.setMessage("패널티가 부여 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
}
