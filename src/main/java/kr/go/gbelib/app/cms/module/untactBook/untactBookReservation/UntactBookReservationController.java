package kr.go.gbelib.app.cms.module.untactBook.untactBookReservation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller
@RequestMapping(value="/cms/module/untactBook/untactBookReservation")
public class UntactBookReservationController extends BaseController {
	                                                          
	private final String basepath = "/cms/module/untactBook/untactBookReservation/";
	
	@Autowired
	private UntactBookReservationService reservationService;
	
	@Autowired
	private HomepageService homepageService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(untactBookReservation == null) {  
			untactBookReservation = new UntactBookReservation();
			untactBookReservation.setHomepage_id(getAsideHomepageId(request));  
		}
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		if (StringUtils.isEmpty(untactBookReservation.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			untactBookReservation.setStart_date(startDateFormat.format(now));
			untactBookReservation.setEnd_date(endDateFormat.format(now));
		}
		
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		int count = reservationService.getUntactBookReservationListCount(untactBookReservation);
		reservationService.setPaging(model, count, untactBookReservation);
		untactBookReservation.setTotalDataCount(count);
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationListCount", count);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationList(untactBookReservation));
		
		return basepath + "index";
	}
	
	@RequestMapping(value = { "/smsWrite.*" })
	public String smsWrite(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		if(untactBookReservation == null) {  
			untactBookReservation = new UntactBookReservation();
			untactBookReservation.setHomepage_id(getAsideHomepageId(request));  
		}
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		List<UntactBookReservation> smsList = reservationService.smsSendALL(untactBookReservation);
		
		model.addAttribute("sms", smsList);
		
		return basepath + "smsIndex_ajax";
	}
	
	@RequestMapping(value = { "/smsSend.*" })
	public @ResponseBody JsonResponse smsSend(Model model, LibrarySearch librarySearch, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request) {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		if (!result.hasErrors()) {
			Homepage homepage = new Homepage();
			homepage.setHomepage_id(getAsideHomepageId(request));
			
			homepage = homepageService.getHomepageOne(homepage);
			
			librarySearch.setManageCode(homepage.getManage_code());
			String userIp = request.getRemoteAddr();
			
			List<UntactBookReservation> smsList = reservationService.smsSendALL(untactBookReservation);
			for(int i =0; i < smsList.size(); i++) {
				UntactBookReservation one = smsList.get(i);
				librarySearch.setUserkey(one.getRec_key());
				String mes = "대출하신 [" + one.getBook_name() + "]\n\n"+ untactBookReservation.getAdminMessage() +"입니다.";
				LibSearchAPI.sendSms(librarySearch, mes, userIp);
			}
			res.setValid(true);
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookReservationSearchView excelDownload(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request){
		HttpSession session = request.getSession();
		
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationExcelList(untactBookReservation));
		
		return new UntactBookReservationSearchView();
	}
	
}
