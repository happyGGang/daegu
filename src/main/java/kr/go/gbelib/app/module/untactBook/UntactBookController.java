package kr.go.gbelib.app.module.untactBook;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackList;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackListService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookPenaltySetting.UntactBookPenaltySettingService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookRound;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;
import kr.go.gbelib.app.intro.search.LibrarySearchService;

@Controller(value="untactBook")
@RequestMapping(value = {"/{homepagePath}/module/untactBook"})
public class UntactBookController extends BaseController {

	private String basePath = "/homepage/%s/module/untactBook/";
	
	@Autowired
	private LibrarySearchService service;

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private UntactBookReservationService untactBookReservationService;
	
	@Autowired
	private UntactLockerSettingService untactLockerSettingService;
	
	@Autowired
	private UntactBookBlackListService untactBookBlackListService;
	
	@Autowired
	private UntactBookPenaltySettingService untactBookPenaltySettingService;
	
	@RequestMapping(value = {"/index.*"})
	public String myUntactBookResve(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, UntactBookReservation untactBookReservation, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		Member member = getSessionMemberInfo(request);

		untactBookReservation.setHomepage_id(homepage.getHomepage_id());
		untactBookReservation.setMember_id(member.getMember_id());
		
		int count = untactBookReservationService.getUntactBookReservationInfoCount(untactBookReservation);
		untactBookReservationService.setPaging(model, count, untactBookReservation);
		untactBookReservation.setTotalDataCount(count);
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationListCount", count);
		model.addAttribute("untactBookReservationList", untactBookReservationService.getUntactBookReservationInfo(untactBookReservation));
		
		if(StringUtils.isNotEmpty(untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()))) {
			if(untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()).equals("1")) {
				return String.format(basePath, homepage.getFolder()) + "qrIndex";
			} else if (untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()).equals("0")) {
				return String.format(basePath, homepage.getFolder()) + "passwordIndex";
			}
		}
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping(value = { "/untactBookQrCode.*" })
	public String qrCode(@PathVariable("homepagePath") String homepagePath, Model model, LibrarySearch librarySearch, UntactBookReservation untactBookReservation, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = getSessionHomepage(request);
		return String.format(basePath, homepage.getFolder()) + "untactBookQrCode_ajax";
	}
	
	@RequestMapping (value = {"/cancelReserve.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse cancelReserve(LibrarySearch librarySearch, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		
		JsonResponse res = new JsonResponse(request);
		
		Member member = getSessionMemberInfo(request);
		
		if (!result.hasErrors()) {
			untactBookReservation.setHomepage_id(homepage.getHomepage_id());
			untactBookReservation.setCancel_ip(request.getRemoteAddr());
			List<UntactBookReservation> reservationList = untactBookReservationService.getReservationList(untactBookReservation);
			
			String request_number = String.valueOf(reservationList.get(0).getRequest_number());
			
			Map<String, Object> resultList = LibSearchAPI.getReserveList(member.getRec_key());
			List<Map<String, Object>> list = null;
			if(resultList != null && !resultList.isEmpty() && resultList.get("LIST_DATA") != null){
				list = LibSearchAPI.getListData(resultList);
				String reckey = String.valueOf(list.get(0).get("PK"));
				librarySearch.setUserkey(member.getRec_key());
				librarySearch.setBookkey(reckey);
				ApiResponse apiResult = LibSearchAPI.cancelReservation2(librarySearch);
				
				if (apiResult.getStatus()) {
					untactBookReservation.setRequest_number(Integer.parseInt(request_number));
					untactBookReservationService.cancelReserve(untactBookReservation);
					res.setValid(true);
					res.setMessage("취소 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("예약취소에 실패하였습니다.\nKLAS API 예약취소 오류 입니다. : " + apiResult.getMessage());
				}
			}
			
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = { "/form.*" }, method = RequestMethod.POST)
	public String untactBookForm(Model model, LibrarySearch librarySearch, UntactBookReservation untactBookReservation, UntactBookBlackList untactBookBlackList, UntactBookRound untactBookRound, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);
		untactBookBlackList.setMember_id(member.getMember_id());
		untactBookBlackList.setHomepage_id(homepage.getHomepage_id());
		
		untactBookReservation.setHomepage_id(homepage.getHomepage_id());
		untactBookReservation.setMember_id(member.getMember_id());

		untactBookRound.setHomepage_id(homepage.getHomepage_id());
		
		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			int loginMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(homepage.getHomepage_id(), 5));
			service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/intro/login/index.do?menu_idx=%d", homepage.getContext_path(), loginMenuIdx), request, response);
			return null;
		}

		if (librarySearch.getBooktype() == null) {
			librarySearch.setBooktype("BO");
		}
		
		if(StringUtils.isEmpty(untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()))) {
			service.alertMessage("비대면 도서대출예약이 불가능한 도서관입니다.", request, response);
			return null;
		}
		
		//북구 구수산도서관에만 휴관일 당일 신청 불가
		if(homepage.getManage_code().equals("h46")){
			//휴관일 예약 불가(회차 반복일이 하루일경우)
			Calendar cal = Calendar.getInstance();
	        cal.setTime(new Date());
	        SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDD");
	        
			if(!(sdf.format(cal.getTime()).isEmpty())) {
				librarySearch.setManageCode(homepage.getManage_code());
				librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
				
				Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(librarySearch);
				
				if(holiDays.get("RESULT_CODE").equals("1")) {
					service.alertMessage("휴관일은 비대면 예약신청이 불가능 합니다.", request, response);
					return null;
				}
			}
		} else {
			//휴관일 예약 불가(회차 반복일이 하루일경우)
			Calendar cal = Calendar.getInstance();
	        cal.setTime(new Date());
	        SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMDD");
	        //TODO 회차 반복일이 하루가 아니라면 수정필요
	        cal.add(Calendar.DATE, 1);
	        
			if(!(sdf.format(cal.getTime()).isEmpty())) {
				librarySearch.setManageCode(homepage.getManage_code());
				librarySearch.setSearch_start_date(sdf.format(cal.getTime()));
				
				Map<String, Object> holiDays = LibSearchAPI.getCheckHoliday(librarySearch);
				
				if(holiDays.get("RESULT_CODE").equals("1")) {
					service.alertMessage("휴관일 이전은 비대면 예약신청이 불가능 합니다.", request, response);
					return null;
				}
			}
		}
		
		//사물함 사용 여부 확인
		if(!(untactLockerSettingService.getLockerUseType(homepage.getHomepage_id()).equals("사물함없음"))) {
			if(untactLockerSettingService.getLockerUseYN(homepage.getHomepage_id()).equals("N")) {
				service.alertMessage("금일 비대면 도서대출예약은 마감되었습니다.", request, response);
				return null;
			}
		}
		
		//비대면 도서대출 예약 가능한 사물함 count
		if (untactLockerSettingService.getUntactLockerSettingCount(homepage.getHomepage_id()) == 0) {
			service.alertMessage("금일 비대면 도서대출예약은 마감되었습니다.", request, response);
			return null;
		}
		
		//회차
		if((untactLockerSettingService.getUntactBookRoundOne(untactBookRound)) == null || "".equals(untactLockerSettingService.getUntactBookRoundOne(untactBookRound))) {
			service.alertMessage("금일 비대면 도서대출예약은 마감되었습니다.", request, response);
			return null;
		}
		
		//비대면 도서대출 설정유무 확인
		if (untactLockerSettingService.getLockerMaxCount(homepage.getHomepage_id()) == 0) {
			service.alertMessage("비대면 도서대출예약이 불가능한 도서관입니다.", request, response);
			return null;
		}
		
		//비대면 도서대출 예약 가능한 사물함 count
		if (untactLockerSettingService.getUntactLockerSettingCount(homepage.getHomepage_id()) == 0) {
			service.alertMessage("금일 비대면 도서대출예약은 마감되었습니다.", request, response);
			return null;
		}
		
		String penaltyEndDate = untactBookPenaltySettingService.getEndDate(homepage.getHomepage_id());
		
		//페널티 초과 회원 예약 불가
		if(untactBookBlackListService.getPenaltyCount(untactBookBlackList) > 0 && untactBookPenaltySettingService.getPenaltyCount(homepage.getHomepage_id()) > 0) {
			if (untactBookBlackListService.getPenaltyCount(untactBookBlackList) >= untactBookPenaltySettingService.getPenaltyCount(homepage.getHomepage_id())) {
				service.alertMessage("현재 이용자님 께서는 관리자에 의해\\n\\n" + penaltyEndDate + "일 까지 비대면 도서대출 이용이 제한되어 있습니다.", request, response);
				return null; 
			}
		}
		
		//비대면 도서대출 예약가능 사물함갯수와 예약횟수 비교
		untactBookReservation.setRound_idx(untactLockerSettingService.getUntactBookRoundOne(untactBookRound));
		if (untactLockerSettingService.getUntactLockerSettingCount(homepage.getHomepage_id()) <= untactBookReservationService.getUntactBookReservationCount(untactBookReservation)) {
			service.alertMessage("금일 비대면 도서대출예약은 마감되었습니다.", request, response);
			return null; 
		}
		
		Map<String, Object> result = LibSearchAPI.getBookInfo(librarySearch);
		List<Map<String, Object>> list = null;

		int count = LibSearchAPI.getSearchCount(result);
		librarySearch.setTotalDataCount(count);
		service.setPaging(model, count, librarySearch);

		if (count > 0) {
			list = LibSearchAPI.getListData(result);
			model.addAttribute("detail", list.get(0));
		}

		UntactBookSetting untactBookSetting = untactLockerSettingService.getUntactBookSettingOne(homepage.getHomepage_id());

		model.addAttribute("librarySearch", librarySearch);
		model.addAttribute("termsList", untactLockerSettingService.getUntactBookSettingTerms(homepage.getHomepage_id()));
		model.addAttribute("untactBookSetting", untactBookSetting);

		return String.format(basePath, homepage.getFolder()) + "form";
	}
	
	@RequestMapping(value = {"/save.*"}, method=RequestMethod.POST)
	public @ResponseBody JsonResponse saveUntactBook(Model model, LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request) {
		Homepage homepage = getSessionHomepage(request);
		Member member = getSessionMemberInfo(request);
		untactBookBlackList.setMember_id(member.getMember_id());
		
		untactBookReservation.setHomepage_id(homepage.getHomepage_id());
		untactBookReservation.setMember_id(member.getMember_id());
		untactBookRound.setHomepage_id(homepage.getHomepage_id());
		
		JsonResponse res = new JsonResponse(request);

		if (!isLogin(request) || !"HOMEPAGE".equals(getSessionMemberLoginType(request))) {
			res.setValid(false);
			res.setMessage("로그인 후 이용가능합니다.");
			return res;
		}
		
		if (untactLockerSettingService.getLockerMaxCount(homepage.getHomepage_id()) == 0) {
			result.reject("비대면 도서대출예약이 불가능한 도서관입니다.");
		}
		
		untactBookReservation.setRound_idx(untactLockerSettingService.getUntactBookRoundOne(untactBookRound));
		if (untactLockerSettingService.getUntactLockerSettingCount(homepage.getHomepage_id()) <= untactBookReservationService.getUntactBookReservationCount(untactBookReservation)) {
			result.reject("금일 비대면 사물함 대출은 마감되었습니다.");
		}
		
		String penaltyEndDate = untactBookPenaltySettingService.getEndDate(homepage.getHomepage_id());
		
		if(untactBookBlackListService.getPenaltyCount(untactBookBlackList) > 0 && untactBookPenaltySettingService.getPenaltyCount(homepage.getHomepage_id()) > 0) {
			if (untactBookBlackListService.getPenaltyCount(untactBookBlackList) >= untactBookPenaltySettingService.getPenaltyCount(homepage.getHomepage_id())) {
				result.reject("현재 이용자님 께서는 관리자에 의해\\n\\n" + penaltyEndDate + "일 까지 비대면 도서대출 이용이 제한되어 있습니다.");
			}
		}
		
		//회차
		if(StringUtils.isNotEmpty(untactLockerSettingService.getUntactBookRoundOne(untactBookRound))) {
			untactBookReservation.setRound_idx(untactLockerSettingService.getUntactBookRoundOne(untactBookRound));
		} else {
			result.reject("금일 비대면 사물함 대출은 마감되었습니다.");
		}
		
		if (!result.hasErrors()) {
			// 정회원만 가능
			if (!StringUtils.equals(member.getMember_class(), "0")) {
				res.setValid(false);
				res.setMessage("예약 신청 가능한 회원이 아닙니다.");
				return res;
			}
			
			untactBookReservation.setHomepage_id(homepage.getHomepage_id());
			untactBookReservation.setMember_id(member.getMember_id());
			untactBookReservation.setMember_name(member.getMember_name());
			
			untactBookReservation.setRec_key(member.getUser_no());
			untactBookReservation.setManage_code(homepage.getManage_code());
			untactBookReservation.setUser_key(member.getRec_key());
			untactBookReservation.setReg_no(librarySearch.getReg_no());
			
			int locker_number = untactBookReservationService.getUntactBookReservationLockerNumber(untactBookReservation);
			untactBookReservation.setLocker_number(locker_number);
			
			librarySearch.setUserkey(untactBookReservation.getUser_key());
			librarySearch.setManageCode(untactBookReservation.getManage_code());
			//임시로 예약 만기일수 10일로 설정
			String expire_date = "10";
			librarySearch.setExprire_date_cnt(expire_date);
			
			//비대면도서대출(무인예약API)
			ApiResponse apiResult = LibSearchAPI.untactloanreserve(librarySearch);
			if (apiResult.getStatus()) {
				untactBookReservationService.addUntactBookReservation(untactBookReservation);
				res.setValid(true);
				res.setMessage("예약 되었습니다.");
				
			} else {
				res.setValid(false);
				res.setMessage("[KLAS API 오류]\n" + apiResult.getMessage());
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
