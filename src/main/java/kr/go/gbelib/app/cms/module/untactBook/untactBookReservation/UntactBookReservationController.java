package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;

@Controller
@RequestMapping(value="/cms/module/untactBook/untactBookReservation")
public class UntactBookReservationController extends BaseController {
	                                                          
	private final String basepath = "/cms/module/untactBook/untactBookReservation/";
	
	@Autowired
	private UntactBookReservationService reservationService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(untactBookReservation == null) {  
			untactBookReservation = new UntactBookReservation();
			untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		}
		
		if ( StringUtils.isEmpty(untactBookReservation.getEnd_date()) ) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			untactBookReservation.setStart_date(startDateFormat.format(now));
			untactBookReservation.setEnd_date(endDateFormat.format(now));
		}
		
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		int count = reservationService.getUntactBookReservationListCount(untactBookReservation);
		reservationService.setPaging(model, count, untactBookReservation);
		untactBookReservation.setTotalPageCount(count);
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationListCount", count);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationList(untactBookReservation));
		
		return basepath + "index";
	}
	
	@RequestMapping(value = {"/excelDownload.*"})
	public UntactBookReservationSearchView excelDownload(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request){
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationList(untactBookReservation));
		
		return new UntactBookReservationSearchView();
	}
	
}
