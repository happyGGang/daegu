package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibStatus;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibManage.NearbyLibManageService;

@Controller
@RequestMapping(value = { "/cms/module/nearbyLib/nearbyLibStatus" })
public class NearbyLibStatusController extends BaseController {

	private final String basePath = "/cms/module/nearbyLib/nearbyLibStatus/";
	
	@Autowired
	private NearbyLibManageService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, HttpServletRequest request, NearbyLibStatus nearbyLibStatus) throws AuthException {
		checkAuth("R", model, request);
		nearbyLibStatus.setHomepage_id(getAsideHomepageId(request));

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

		String today = sf.format(new Date());

		if(nearbyLibStatus.getStart_date() == null || nearbyLibStatus.getEnd_date() == null) {
			nearbyLibStatus.setStart_date(today);
			nearbyLibStatus.setEnd_date(today);
		}

		//dateType
		if(nearbyLibStatus.getDate_type() != null) {
			if(nearbyLibStatus.getDate_type().equals("DAY")) {
				model.addAttribute("calendarList", service.getNearbyLibStatus(nearbyLibStatus));

			} else if(nearbyLibStatus.getDate_type().equals("MONTH")) {
				model.addAttribute("calendarList", service.getCalendarMonthStatus(nearbyLibStatus));

			} else if(nearbyLibStatus.getDate_type().equals("YEAR")) {
				model.addAttribute("calendarList", service.getCalendarYearStatus(nearbyLibStatus));

			} else {
				model.addAttribute("calendarList", service.getNearbyLibStatus(nearbyLibStatus));
			}
		}

		model.addAttribute("nearbyLibStatus", nearbyLibStatus);
		model.addAttribute("member", getSessionMemberInfo(request));
		return basePath + "index";
	}
}
