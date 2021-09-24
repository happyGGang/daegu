package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import javax.servlet.http.HttpServletRequest;

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
	private UntactBookReservationService service;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(untactBookReservation == null) {  
			untactBookReservation = new UntactBookReservation();
			untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		}
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", service.getUntactBookReservationList(getAsideHomepageId(request)));
		
		return basepath + "index";
	}
	
}
