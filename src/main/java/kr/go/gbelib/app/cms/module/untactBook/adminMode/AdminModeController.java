package kr.go.gbelib.app.cms.module.untactBook.adminMode;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackList;
import kr.go.gbelib.app.cms.module.untactBook.untactBookBlackList.UntactBookBlackListService;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservation;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationSearchView;
import kr.go.gbelib.app.cms.module.untactBook.untactBookReservation.UntactBookReservationService;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookRound;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactBookSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSetting;
import kr.go.gbelib.app.cms.module.untactBook.untactLockerSetting.UntactLockerSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, UntactBookSetting untactBookSetting, UntactBookRound untactBookRound, UntactLockerSetting untactLockerSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		//그전회차 idx가져오기
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		untactBookReservation.setRound_idx(round_idx);
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		model.addAttribute("untactLockerSettingList", settingService.showLockerStateBefore(untactBookReservation));

		int rowCount = untactBookSetting.getRow_count();
		int totalCount = untactBookSetting.getTotal_count();
		int remainder = totalCount%rowCount;
		int quotient = totalCount/rowCount;
		
		 if(remainder > 0) { 
			 model.addAttribute("quotient", quotient+1);
		} else {
			model.addAttribute("quotient", quotient);
		}
		
		//금일기준 그전 회차를 가지고 와야함
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationListNow(untactBookReservation));
		model.addAttribute("passwordCount", reservationService.checkPasswordCount(untactBookReservation));
		model.addAttribute("nonPasswordCount", reservationService.checkNonPasswordCount(untactBookReservation));
		model.addAttribute("untactStatusCodeList", codeService.getCode("CMS", "UT000"));
		
		if (StringUtils.isNotEmpty(settingService.getLockerUseType(getAsideHomepageId(request)))) {
			if(!(settingService.getLockerUseType(getAsideHomepageId(request)).equals("사물함없음"))) {
				return basePath + "index";
			}
		}
		return basePath + "nonLockerIndex";
	}
	
	@RequestMapping(value = { "/index2.*" })
	public String index2(Model model, UntactBookSetting untactBookSetting, UntactBookRound untactBookRound, UntactLockerSetting untactLockerSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		//전전회차 가져오기 위한 round_idx설정
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		untactBookReservation.setRound_idx(round_idx);
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		model.addAttribute("untactLockerSettingList", settingService.showLockerStateBefore(untactBookReservation));
		
		int rowCount = untactBookSetting.getRow_count();
		int totalCount = untactBookSetting.getTotal_count();
		int remainder = totalCount%rowCount;
		int quotient = totalCount/rowCount;
		
		 if(remainder > 0) { 
			 model.addAttribute("quotient", quotient+1);
		} else {
			model.addAttribute("quotient", quotient);
		}
		
		//전회차 idx로 전전회차 List구함
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationListBefore(untactBookReservation));
		model.addAttribute("passwordCount", reservationService.checkPasswordCountBefore(untactBookReservation));
		model.addAttribute("nonPasswordCount", reservationService.checkNonPasswordCountBefore(untactBookReservation));
		model.addAttribute("untactStatusCodeList", codeService.getCode("CMS", "UT000"));
		
		if (StringUtils.isNotEmpty(settingService.getLockerUseType(getAsideHomepageId(request)))) {
			if(!(settingService.getLockerUseType(getAsideHomepageId(request)).equals("사물함없음"))) {
				return basePath + "index2";
			}
		}
		return basePath + "nonLockerIndex";
	}
	
	@RequestMapping(value = { "/index3.*" })
	public String index3(Model model, UntactBookSetting untactBookSetting, UntactBookRound untactBookRound, UntactLockerSetting untactLockerSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		
		int rowCount = untactBookSetting.getRow_count();
		int totalCount = untactBookSetting.getTotal_count();
		int remainder = totalCount%rowCount;
		int quotient = totalCount/rowCount;
		
		 if(remainder > 0) { 
			 model.addAttribute("quotient", quotient+1);
		} else {
			model.addAttribute("quotient", quotient);
		}
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		untactBookReservation.setRound_idx(round_idx);
		model.addAttribute("untactLockerSettingList", settingService.showLockerStateBefore(untactBookReservation));
		//TODO 이전의 모든 미처리 항목 가져오게 변경필요 (대출, 만기 빼고 전부다)
		model.addAttribute("untactBookReservationList", reservationService.getUnprocessedList(untactBookReservation));
		model.addAttribute("untactStatusCodeList", codeService.getCode("CMS", "UT000"));
		
		if (StringUtils.isNotEmpty(settingService.getLockerUseType(getAsideHomepageId(request)))) {
			if(!(settingService.getLockerUseType(getAsideHomepageId(request)).equals("사물함없음"))) {
				return basePath + "index3";
			}
		}
		return basePath + "nonLockerIndex";
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
	
	//1번. 신청에서 접수로 변경 
	@RequestMapping (value = {"/receiptReservationStep.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse receiptReservationStep(LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		
		//당일 회차 사물함 비밀번호 등록여부 체크
		if(StringUtils.isNotEmpty(round_idx)) {
			untactBookReservation.setRound_idx(round_idx);
			if (reservationService.checkPassword(untactBookReservation) > 0) {
				res.setValid(false);
				res.setMessage("사물함 비밀번호를 설정해주세요.");
				return res;
			}
		}
		
		if (!result.hasErrors()) {
			untactBookReservation.setReservation_step("2");
			int modify_result = reservationService.receiptReservationStep(untactBookReservation);
			
			if (modify_result < 1) {
				res.setValid(false);
				res.setMessage("접수에 실패하였습니다. 관리자에게 문의하세요");
			}
			
			res.setValid(true);
			res.setMessage("접수되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	//2번. 접수에서 대기로 변경
	@RequestMapping (value = {"/waitingReservationStep.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse waitingReservationStep(LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		List<UntactBookReservation> waitingReservationList = reservationService.getWaitingReservationList(untactBookReservation);
		for (int i = 0; i < waitingReservationList.size(); i++) {
			String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
			String manageCode = String.valueOf(waitingReservationList.get(i).getManage_code());
			String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
			String regNo = String.valueOf(waitingReservationList.get(i).getReg_no());
			String member_name = String.valueOf(waitingReservationList.get(i).getMember_name());
			String book_name = String.valueOf(waitingReservationList.get(i).getBook_name());
			String locker_no = String.valueOf(waitingReservationList.get(i).getLocker_number());
			String locker_pass = String.valueOf(waitingReservationList.get(i).getLocker_password());
			String round_idx = String.valueOf(waitingReservationList.get(i).getRound_idx());
			
			librarySearch.setManageCode(manageCode);
			librarySearch.setUserkey(userKey);
			librarySearch.setRegNo(regNo);
			
			untactBookRound.setRound_idx(round_idx);
			untactBookRound.setHomepage_id(getAsideHomepageId(request));
			untactBookRound = settingService.getUntactBookRoundAll(untactBookRound);
			
			librarySearch.setSearch_start_date(untactBookRound.getRound_start_date());
			librarySearch.setSearch_end_date(untactBookRound.getRound_end_date());
			//무인대출예약 목록 조회
			Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUntactBookLoanReserveList(librarySearch, null);
			List<Map<String, Object>> list = null;
			
			list = LibSearchAPI.getListData(unmannedLoanReserveList);
			
			if (list != null && list.size() > 0) {
				String loanKey = String.valueOf(list.get(0).get("LOAN_KEY"));
				
				untactBookReservation.setLoankey(loanKey);
				
				librarySearch.setLoan_key(loanKey);
				
				//loanKey 가져와서 예약대출기 상태 수정
				ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
				
				Homepage homepage = new Homepage();
				homepage.setHomepage_id(getAsideHomepageId(request));
				
				homepage = homepageService.getHomepageOne(homepage);
				
				String userIp = request.getRemoteAddr();
				
				librarySearch.setManageCode(manageCode);
				librarySearch.setUserkey(userKey);
				
				untactBookRound.setRound_idx(round_idx);
				untactBookRound.setHomepage_id(getAsideHomepageId(request));
				String loanTime = settingService.getReturnDate(untactBookRound);
				
				String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n사물함 번호 : " + locker_no +"\n사물함 비밀번호 : " + locker_pass+"\n대출만기일은 " + loanTime + "까지 입니다."; 
				
				LibSearchAPI.sendSms(librarySearch, mes, userIp);
				
				if(apiResult.getStatus()){
					if (!result.hasErrors()) {
						untactBookReservation.setReservation_step("3");
						untactBookReservation.setRequest_number(Integer.parseInt(request_number));
						int modify_result = reservationService.waitingReservationStep(untactBookReservation);
						
						if (modify_result < 1) {
							res.setValid(false);
							res.setMessage("대기 처리에 실패하였습니다. 관리자에게 문의하세요");
						}
						res.setValid(true);
						res.setMessage("대기 처리 되었습니다.");
					} else {
						res.setValid(false);
						res.setResult(result.getAllErrors());
					}
				} else {
					res.setValid(false);
					res.setMessage("대기 상태 변경에 실패하였습니다.\nKLAS API 예약수정 오류 입니다. : " + apiResult.getMessage());
				}
			} else {
				res.setValid(false);
				res.setMessage("예약키 조회에 실패하였습니다.\n홈페이지에서 예약 상태를 확인해주세요.");
			}
		}
		return res;
	}
	
	//3번. 대기에서 대출로 변경
	@RequestMapping (value = {"/bookReservation.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookReservation(LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);

		List<UntactBookReservation> waitingReservationList = reservationService.getWaitingReservationList(untactBookReservation);
		
		for (int i = 0; i < waitingReservationList.size(); i++) {
			String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
			String manageCode = String.valueOf(waitingReservationList.get(i).getManage_code());
			String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
			String regNo = String.valueOf(waitingReservationList.get(i).getReg_no());
			
			librarySearch.setManageCode(manageCode);
			librarySearch.setUserkey(userKey);
			librarySearch.setReg_no(regNo);
			String ip = request.getRemoteAddr();
			ApiResponse apiResult = LibSearchAPI.unmannedloan(librarySearch, ip);
			if (apiResult.getStatus()) {
				untactBookReservation.setReservation_step("4");
				untactBookReservation.setRequest_number(Integer.parseInt(request_number));
				int count = reservationService.bookReservation(untactBookReservation);
				
				if(count < 1) {
					res.setValid(false);
					res.setMessage("대출에 실패 하였습니다. 관리자에게 문의하세요");
				}
				res.setValid(true);
				res.setMessage("대출되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("대출에 실패하였습니다.\nKLAS API 무인대출 오류 입니다. : " + apiResult.getMessage());
			}
		}
		return res;
	}
	
	//예약취소
	@RequestMapping (value = {"/cancelReservation.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse cancelSettingSave(UntactBookReservation untactBookReservation, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		JsonResponse res = new JsonResponse(request);
		
		untactBookReservation.setCancel_id(getSessionMemberId(request));
		untactBookReservation.setCancel_ip(request.getRemoteAddr());
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			List<UntactBookReservation> waitingReservationList = reservationService.getWaitingReservationList(untactBookReservation);
			
			for (int i = 0; i < waitingReservationList.size(); i++) {
				String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
				String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
				
				Map<String, Object> resultList = LibSearchAPI.getReserveList(userKey);
				List<Map<String, Object>> list = null;
				
				if(resultList != null && !resultList.isEmpty() && resultList.get("LIST_DATA") != null) {
					list = LibSearchAPI.getListData(resultList);
					String reckey = String.valueOf(list.get(0).get("PK"));
					librarySearch.setUserkey(userKey);
					librarySearch.setBookkey(reckey);
					ApiResponse apiResult = LibSearchAPI.cancelReservation(librarySearch);
					
					if (apiResult.getStatus()) {
						untactBookReservation.setRequest_number(Integer.parseInt(request_number));
						reservationService.cancelReservationStep(untactBookReservation);
						res.setValid(true);
						res.setMessage("취소 되었습니다.");
					} else {
						res.setValid(false);
						res.setMessage("예약취소에 실패하였습니다.\nKLAS API 예약취소 오류 입니다. : " + apiResult.getMessage());
					}
				} else {
					res.setValid(false);
					res.setMessage("예약 목록 조회에 실패하였습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/randomPassword.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse randomPassword(UntactBookRound untactBookRound, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		
		if(StringUtils.isNotEmpty(round_idx)) {
			untactBookReservation.setRound_idx(round_idx);
			if(reservationService.checkPasswordCount(untactBookReservation) == 0) {
				reservationService.alertMessageOnly("nonPasswordCheck", request, response);
				return null;
			}
			
			if (reservationService.checkNonPasswordCount(untactBookReservation) == 0) {
				reservationService.alertMessageOnly("passwordCheck", request, response);
				return null;
			}
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
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookReservationSearchView excelDownload(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request){
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationExcelListNow(untactBookReservation));
		
		return new UntactBookReservationSearchView();
	}
	//**********************************************************이전전회차 구하기*******************************************************************************
	//1번. 대출,만기처리항목 신청에서 접수로 변경 
	@RequestMapping (value = {"/receiptReservationStepBefore.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse receiptReservationStepBefore(LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		untactBookRound.setRound_idx(round_idx);
		String before_round_idx = settingService.getUntactBookRoundBefore(untactBookRound);
		
		//당일 회차 사물함 비밀번호 등록여부 체크
		if(StringUtils.isNotEmpty(before_round_idx)) {
			untactBookReservation.setRound_idx(before_round_idx);
			if (reservationService.checkPassword(untactBookReservation) > 0) {
				res.setValid(false);
				res.setMessage("사물함 비밀번호를 설정해주세요.");
				return res;
			}
		}
		
		if (!result.hasErrors()) {
			untactBookReservation.setReservation_step("2");
			int modify_result = reservationService.receiptReservationStep(untactBookReservation);
			
			if (modify_result < 1) {
				res.setValid(false);
				res.setMessage("접수에 실패하였습니다. 관리자에게 문의하세요");
			}
			
			res.setValid(true);
			res.setMessage("접수되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
		
	@RequestMapping (value = {"/randomPasswordBefore.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse randomPasswordBefore(UntactBookRound untactBookRound, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		untactBookRound.setHomepage_id(getAsideHomepageId(request));
		String round_idx = settingService.getUntactBookRound(untactBookRound);
		untactBookReservation.setRound_idx(round_idx);
		
		if(StringUtils.isNotEmpty(round_idx)) {
			if(reservationService.checkPasswordCountBefore(untactBookReservation) == 0) {
				reservationService.alertMessageOnly("nonPasswordCheck", request, response);
				return null;
			}
			
			if (reservationService.checkNonPasswordCountBefore(untactBookReservation) == 0) {
				reservationService.alertMessageOnly("passwordCheck", request, response);
				return null;
			}
		}
		
		if (!result.hasErrors()) {
			reservationService.passwordSettingBefore(untactBookReservation);
				res.setValid(true);
				res.setMessage("생성되었습니다.");
			} else {
				res.setValid(false);
				res.setResult(result.getAllErrors());
			}
		
		return res;
	}
	
}
