package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibRaffle;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLibService;

@Controller
@RequestMapping(value = {"/cms/module/nearbyLib/nearbyLibRaffle"})
public class NearbyLibRaffleController extends BaseController {

	private final String basePath = "/cms/module/nearbyLib/nearbyLibRaffle/";
	
	@Autowired
	private NearbyLibRaffleService nearbyLibRaffleService;

	@Autowired
	private NearbyLibService nearbyLibService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, NearbyLibRaffle nearbyLibRaffle, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if (StringUtils.isEmpty(nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			
			nearbyLibRaffle.setStart_date(startDateFormat.format(now));
			nearbyLibRaffle.setEnd_date(endDateFormat.format(now));
		}
		
		int count = nearbyLibRaffleService.getNearbyLibRaffleCount(nearbyLibRaffle);
		nearbyLibRaffleService.setPaging(model, count, nearbyLibRaffle);
		
		model.addAttribute("nearbyLibRaffle", nearbyLibRaffle);
		model.addAttribute("nearbyLibRaffleCount", count);
		model.addAttribute("nearbyLibRaffleList", nearbyLibRaffleService.getNearbyLibRaffleList(nearbyLibRaffle));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, NearbyLibRaffle nearbyLibRaffle, NearbyLib nearbyLib) throws ParseException {
		
		//내집앞도서관 추첨된 인원 제외한 예약 내역 전체
		int count = nearbyLibRaffleService.getToShuffleNearbyLibRaffleCount(nearbyLibRaffle, nearbyLib);
		nearbyLibRaffleService.setPaging(model, count, nearbyLibRaffle);
		
		List<NearbyLibRaffle> nearbyLibRaffleList = nearbyLibRaffleService.getDedupeReservation(nearbyLibRaffle, nearbyLib);
		
		model.addAttribute("nearbyLibRaffle", nearbyLibRaffle);
		model.addAttribute("nearbyLibRaffleCount", count);
		model.addAttribute("nearbyLibRaffleList", nearbyLibRaffleList);
		
		return basePath + "edit";
	}
	
	@RequestMapping(value = {"/viewRaffle.*"})
	public String viewRaffle(Model model, NearbyLibRaffle nearbyLibRaffle, HttpServletRequest request) {
		List<NearbyLibRaffle> winnerList = nearbyLibRaffleService.getWinnerNearbyLibRaffle(nearbyLibRaffle);
		
		model.addAttribute("winnerList", winnerList);
		
		return basePath + "raffleList_ajax";
	}
	
	@RequestMapping(value = {"/raffleList.*"})
	public String raffleList(Model model, NearbyLibRaffle nearbyLibRaffle, HttpServletRequest request) {
		List<NearbyLibRaffle> winnerList = nearbyLibRaffleService.getWinFromNearbyLib(nearbyLibRaffle);
		
		nearbyLibRaffleService.saveWinnerList(winnerList, request, nearbyLibRaffle);
		
		model.addAttribute("winnerList", winnerList);
		
		return basePath + "raffleList_ajax";
	}
	
	@RequestMapping(value = {"/viewMember.*"})
	public String viewMember(Model model, NearbyLibRaffle nearbyLibRaffle, NearbyLib nearbyLib, HttpServletRequest request) {
		nearbyLib.setMember_id(nearbyLibRaffle.getMember_id());
		List<NearbyLib> nearbyLibMemberList = nearbyLibService.getNearbyLibMemberList(nearbyLib);
		
		model.addAttribute("memberList", nearbyLibMemberList);
		
		return basePath + "memberList_ajax";
	}
	
	@RequestMapping(value = {"/deleteRaffle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteRaffle(Model model, NearbyLibRaffle nearbyLibRaffle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if ( !result.hasErrors() ) {
			nearbyLibRaffleService.deleteRaffle(nearbyLibRaffle);
			
			res.setValid(true);
			res.setMessage("삭제되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public NearbyLibRaffleSearchView excelDownload(Model model, NearbyLibRaffle nearbyLibRaffle, HttpServletRequest request){
		if (StringUtils.isEmpty(nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			
			nearbyLibRaffle.setStart_date(startDateFormat.format(now));
			nearbyLibRaffle.setEnd_date(endDateFormat.format(now));
		}
		
		model.addAttribute("nearbyLibRaffle", nearbyLibRaffle);
		model.addAttribute("nearbyLibRaffleExcelList", nearbyLibRaffleService.getNearbyLibRaffleExcelList(nearbyLibRaffle));
		
		return new NearbyLibRaffleSearchView();
	}
}
