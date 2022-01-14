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
	public String index(Model model, UntactBookSetting untactBookSetting, UntactLockerSetting untactLockerSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		int count = reservationService.getUntactBookReservationListCount(untactBookReservation);
		reservationService.setPaging(model, count, untactBookReservation);
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		model.addAttribute("untactLockerSettingList", settingService.showLockerState(getAsideHomepageId(request)));
		model.addAttribute("untactBookReservationListCount", count);
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
	public String index2(Model model, UntactBookSetting untactBookSetting, UntactLockerSetting untactLockerSetting, UntactBookReservation untactBookReservation, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		untactBookSetting = settingService.getUntactBookSettingOne(getAsideHomepageId(request));
		
		untactLockerSetting.setHomepage_id(getAsideHomepageId(request));
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);;
		
		untactBookReservation.setAdmin_member_id(member.getMember_id());
		
		int count = reservationService.getUntactBookReservationListCount(untactBookReservation);
		reservationService.setPaging(model, count, untactBookReservation);
		
		model.addAttribute("untactBookSetting", untactBookSetting);
		model.addAttribute("untactLockerSetting", untactLockerSetting);
		model.addAttribute("untactLockerSettingList", settingService.showLockerState(getAsideHomepageId(request)));
		model.addAttribute("untactBookReservationListCount", count);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationListBefore(untactBookReservation));
		model.addAttribute("passwordCount", reservationService.checkPasswordCount(untactBookReservation));
		model.addAttribute("nonPasswordCount", reservationService.checkNonPasswordCount(untactBookReservation));
		model.addAttribute("untactStatusCodeList", codeService.getCode("CMS", "UT000"));
		
		if (StringUtils.isNotEmpty(settingService.getLockerUseType(getAsideHomepageId(request)))) {
			if(!(settingService.getLockerUseType(getAsideHomepageId(request)).equals("사물함없음"))) {
				return basePath + "index2";
			}
		}
		
		
		return basePath + "nonLockerIndex";
	}
	
	@RequestMapping (value = {"/cancelReservation.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse cancelSettingSave(UntactBookReservation untactBookReservation, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		JsonResponse res = new JsonResponse(request);
		
		untactBookReservation.setCancel_id(getSessionMemberId(request));
		untactBookReservation.setCancel_ip(request.getRemoteAddr());
		
		if (!result.hasErrors()) {
			
			librarySearch.setUserkey(untactBookReservation.getUser_key());
			librarySearch.setBookkey(untactBookReservation.getLoankey());
			ApiResponse apiResult = LibSearchAPI.cancelReservation(librarySearch);
			
			if (apiResult.getStatus()) {
				reservationService.cancelReservationStep(untactBookReservation);
				res.setValid(true);
				res.setMessage("취소 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage(apiResult.getMessage());
			}
			
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
	public @ResponseBody JsonResponse modifyReservationStep(LibrarySearch librarySearch, UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, UntactBookRound untactBookRound, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		if (reservationService.checkPassword(untactBookReservation) > 0) {
			reservationService.alertMessageOnly("passwordCheck", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			String step = untactBookReservation.getReservation_step();
			
			if(StringUtils.isNotEmpty(step)) {
				if(step.equals("1")) {
					untactBookReservation.setReservation_step("2");
					int modify_result = reservationService.receiptReservationStep(untactBookReservation);
					
					if (modify_result < 1) {
						res.setValid(false);
						res.setMessage("관리자에게 문의하세요");
					}
					
					res.setValid(true);
					res.setMessage("접수되었습니다.");
				} else if (step.equals("2")) {
					untactBookRound.setRound_idx(untactBookReservation.getRound_idx());
					untactBookRound.setHomepage_id(untactBookReservation.getHomepage_id());
					UntactBookRound roundTime = settingService.getUntactBookRoundAll(untactBookRound);
					
					LibrarySearch loanList = new LibrarySearch();
					
					loanList.setManageCode(untactBookReservation.getManage_code());
					loanList.setSearch_start_date(roundTime.getRound_start_date());
					loanList.setSearch_end_date(roundTime.getRound_end_date());
					loanList.setUserkey(untactBookReservation.getUser_key());
					loanList.setRegNo(untactBookReservation.getReg_no());
					
					Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUntactBookLoanReserveList(loanList, null);
					List<Map<String, Object>> list = null;
					
					list = LibSearchAPI.getListData(unmannedLoanReserveList);
					//여러권일때 여기를 수정하세용
					if (list != null) {
						String loanKey = String.valueOf(list.get(0).get("LOAN_KEY"));
						untactBookReservation.setLoankey(loanKey);
						
						librarySearch.setLoan_key(loanKey);
						ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
						
						if (apiResult.getStatus()) {
							untactBookReservation.setReservation_step("3");
							untactBookReservation.setLoankey(loanKey);
							int modify_result = reservationService.waitingReservationStep(untactBookReservation);
							
							Homepage homepage = new Homepage();
							homepage.setHomepage_id(getAsideHomepageId(request));
							
							homepage = homepageService.getHomepageOne(homepage);
							
							String userIp = request.getRemoteAddr();
							
							UntactBookReservation untactBookReservation2 = new UntactBookReservation();
							
							librarySearch.setManageCode(loanList.getManageCode());
							librarySearch.setUserkey(loanList.getUserkey());
							
							untactBookReservation2 = reservationService.getUntactBookReservationOne(untactBookReservation);
							
							String loanTime = settingService.getReturnDate(untactBookRound);;
							
							String mes =  "[" +homepage.getHomepage_name() + "]\n" + untactBookReservation2.getMember_name() + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+untactBookReservation2.getBook_name()+"\n사물함 번호 : " + untactBookReservation2.getLocker_number() +"\n사물함 비밀번호 : " + untactBookReservation2.getLocker_password()+"\n반납예정일은 " + loanTime + "까지 입니다."; 
							
							LibSearchAPI.sendSms(librarySearch, mes, userIp);
							
							if (modify_result < 1) {
								res.setValid(false);
								res.setMessage("관리자에게 문의하세요");
							}
							res.setValid(true);
							res.setMessage("대기 처리 되었습니다.");
						}else {
							result.reject("관리자에게 문의하세요");
						}
					}
				} else if (step.equals("3")) {
					
						untactBookReservation.setReservation_step("4");
						
						librarySearch.setManageCode(untactBookReservation.getManage_code());
						librarySearch.setUserkey(untactBookReservation.getUser_key());
						librarySearch.setReg_no(untactBookReservation.getReg_no());
						String ip = request.getRemoteAddr();
						ApiResponse apiResult = LibSearchAPI.unmannedloan(librarySearch, ip);
						
						if (apiResult.getStatus()) {
							int count = reservationService.bookReservation(untactBookReservation);
							
							if(count < 1) {
								res.setValid(false);
								res.setMessage("대출에 실패 하였습니다. 관리자에게 문의하세요");
							}
							res.setValid(true);
							res.setMessage("대출되었습니다.");
						}
					}
				} else {
					res.setValid(false);
					res.setResult(result.getAllErrors());
				}
				
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/deleteAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteAllReservation(UntactBookBlackList untactBookBlackList, UntactBookReservation untactBookReservation, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		untactBookReservation.setCancel_id(getSessionMemberId(request));
		untactBookReservation.setCancel_ip(request.getRemoteAddr());
		
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
		
		if(reservationService.checkPasswordCount(untactBookReservation) == 0) {
			reservationService.alertMessageOnly("nonPasswordCheck", request, response);
			return null;
		}
		
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
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public UntactBookReservationSearchView excelDownload(Model model, UntactBookReservation untactBookReservation, HttpServletRequest request){
		untactBookReservation.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("untactBookReservation", untactBookReservation);
		model.addAttribute("untactBookReservationList", reservationService.getUntactBookReservationExcelListNow(untactBookReservation));
		
		return new UntactBookReservationSearchView();
	}
	
}
