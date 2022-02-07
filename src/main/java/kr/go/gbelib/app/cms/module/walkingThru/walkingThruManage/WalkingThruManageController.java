package kr.go.gbelib.app.cms.module.walkingThru.walkingThruManage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.code.CodeService;
import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.homepage.HomepageService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList.WalkingThruBlackList;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruBlackList.WalkingThruBlackListService;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord.WalkingThruRecord;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord.WalkingThruRecordSearchView;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruRecord.WalkingThruRecordService;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSetting;
import kr.go.gbelib.app.cms.module.walkingThru.walkingThruSetting.WalkingThruSettingService;
import kr.go.gbelib.app.common.api.ApiResponse;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller
@RequestMapping(value = {"/cms/module/walkingThru/walkingThruManage"})
public class WalkingThruManageController extends BaseController {

	private final String basePath = "/cms/module/walkingThru/walkingThruManage/";
	
	@Autowired
	private WalkingThruSettingService settingService;
	
	@Autowired
	private WalkingThruRecordService recordService;
	
	@Autowired
	private WalkingThruBlackListService blackListService;
	
	@Autowired
	private HomepageService homepageService;
	
	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = { "/index.*" })
	public String index(Model model, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruRecordList", recordService.getWalkingThruRecordList(walkingThruRecord));
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("walkingThruCodeList", codeService.getCode("CMS", "UT000"));
		model.addAttribute("passwordCount", recordService.checkPasswordCount(walkingThruRecord));
		model.addAttribute("nonPasswordCount", recordService.checkNonPasswordCount(walkingThruRecord));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = { "/processedIndex.*" })
	public String processedIndex(Model model, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruRecordList", recordService.getWalkingThruRecordListBefore(walkingThruRecord));
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("walkingThruCodeList", codeService.getCode("CMS", "UT000"));
		model.addAttribute("passwordCount", recordService.checkPasswordCountBefore(walkingThruRecord));
		model.addAttribute("nonPasswordCount", recordService.checkNonPasswordCountBefore(walkingThruRecord));
		
		return basePath + "processedIndex";
	}

	@RequestMapping(value = { "/unprocessedIndex.*" })
	public String unprocessedIndex(Model model, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);

		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruRecordList", recordService.getWalkingThruRecordUnprocessedList(walkingThruRecord));
		model.addAttribute("walkingThruSetting", walkingThruSetting);
		model.addAttribute("walkingThruCodeList", codeService.getCode("CMS", "UT000"));
		
		return basePath + "unprocessedIndex";
	}
	
	@RequestMapping(value = { "/blackListSettingEdit.*" })
	public String blackListSettingEdit(Model model, WalkingThruBlackList walkingThruBlackList, WalkingThruRecord walkingThruRecord, HttpServletRequest request,  HttpServletResponse response) throws Exception {
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		walkingThruRecord = recordService.getWalkingThruRecordOne(walkingThruRecord);
		
		walkingThruBlackList.setHomepage_id(walkingThruRecord.getHomepage_id());
		walkingThruBlackList.setMember_id(walkingThruRecord.getMember_id());
		walkingThruBlackList.setMember_name(walkingThruRecord.getMember_name());
		
		if (blackListService.penaltyCount(walkingThruBlackList) > 0) {
			blackListService.alertMessageOnly("penaltyFalse", request, response);
			return null;
		} else {
			model.addAttribute("walkingThruBlackList", walkingThruBlackList);
			return basePath + "blackListSettingEdit_ajax";
		}
	}

	@RequestMapping (value = {"/blackListSettingSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse blackListSettingSave(WalkingThruBlackList walkingThruBlackList, WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		walkingThruBlackList.setHomepage_id(walkingThruRecord.getHomepage_id());
		
		SimpleDateFormat penaltyDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = new Date();
		
		walkingThruBlackList.setPenalty_day(penaltyDateFormat.format(now));
		walkingThruBlackList.setPenalty_register_id(getSessionMemberId(request));
		walkingThruBlackList.setPenalty_register_ip(request.getRemoteAddr());
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			blackListService.grantPenalty(walkingThruBlackList);
			res.setValid(true);
			res.setMessage("패널티가 부여 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	//대기로 변경
	@RequestMapping (value = {"/waitingReservationStep.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse waitingReservationStep(LibrarySearch librarySearch, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		if(walkingThruSetting.getPassword_yn().equals("Y")) {
			if(recordService.checkPassword(walkingThruRecord) > 0) {
				res.setValid(false);
				res.setMessage("비밀번호를 설정해주세요.");
				return res;
			}
		}
		
		List<WalkingThruRecord> waitingReservationList = recordService.getWaitingReservationList(walkingThruRecord);
		for (int i = 0; i < waitingReservationList.size(); i++) {
			String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
			String manageCode = String.valueOf(waitingReservationList.get(i).getManage_code());
			String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
			String regNo = String.valueOf(waitingReservationList.get(i).getReg_no());
			String member_name = String.valueOf(waitingReservationList.get(i).getMember_name());
			String book_name = String.valueOf(waitingReservationList.get(i).getBook_name());
			String pass = String.valueOf(waitingReservationList.get(i).getPassword());
			
			librarySearch.setManageCode(manageCode);
			librarySearch.setUserkey(userKey);
			librarySearch.setRegNo(regNo);
			
			//무인대출예약 목록 조회
			Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUntactBookLoanReserveList(librarySearch, null);
			List<Map<String, Object>> list = null;
			
			list = LibSearchAPI.getListData(unmannedLoanReserveList);
			
			if (list != null && list.size() > 0) {
				String loanKey = String.valueOf(list.get(0).get("LOAN_KEY"));
				
				walkingThruRecord.setLoankey(loanKey);
				
				librarySearch.setLoan_key(loanKey);
				
				//loanKey 가져와서 예약대출기 상태 수정
				ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
				
				Homepage homepage = new Homepage();
				homepage.setHomepage_id(getAsideHomepageId(request));
				
				homepage = homepageService.getHomepageOne(homepage);
				
				String userIp = request.getRemoteAddr();
				
				librarySearch.setManageCode(manageCode);
				librarySearch.setUserkey(userKey);
				
				if(walkingThruSetting.getLoan_time_choice().equals("T") && walkingThruSetting.getPassword_yn().equals("Y")) {
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n비밀번호 : "+pass+"\n대출가능 시간은 금일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."; 
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else if(walkingThruSetting.getLoan_time_choice().equals("T") && walkingThruSetting.getPassword_yn().equals("N")){
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n대출가능 시간은 금일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."+"\n도서대출시 신분증 혹은 회원증을 챙겨주세요.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else if(walkingThruSetting.getLoan_time_choice().equals("N") && walkingThruSetting.getPassword_yn().equals("Y")){
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n비밀번호 : "+pass+"\n대출가능 시간은 익일 " + walkingThruSetting.getLoan_time() + " 까지 입니다.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else {
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n대출가능 시간은 익일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."+"\n도서대출시 신분증 혹은 회원증을 챙겨주세요.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				}
				
				if(apiResult.getStatus()){
					if (!result.hasErrors()) {
						walkingThruRecord.setReservation_step("3");
						walkingThruRecord.setRequest_number(Integer.parseInt(request_number));
						int modify_result = recordService.waitingReservationStep(walkingThruRecord);
						
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
	
	//대출로 변경
	@RequestMapping (value = {"/bookReservation.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookReservation(LibrarySearch librarySearch, WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);

		List<WalkingThruRecord> waitingReservationList = recordService.getWaitingReservationList(walkingThruRecord);
		
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
				walkingThruRecord.setReservation_step("4");
				walkingThruRecord.setRequest_number(Integer.parseInt(request_number));
				int count = recordService.bookReservation(walkingThruRecord);
				
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
	public @ResponseBody JsonResponse cancelSettingSave(WalkingThruRecord walkingThruRecord, LibrarySearch librarySearch, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		JsonResponse res = new JsonResponse(request);
		
		walkingThruRecord.setCancel_id(getSessionMemberId(request));
		walkingThruRecord.setCancel_ip(request.getRemoteAddr());
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			List<WalkingThruRecord> waitingReservationList = recordService.getWaitingReservationList(walkingThruRecord);
			
			for (int i = 0; i < waitingReservationList.size(); i++) {
				String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
				String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
				
				Map<String, Object> resultList = LibSearchAPI.getReserveList(userKey);
				List<Map<String, Object>> list = null;
				
				try {
					if(resultList != null && !resultList.isEmpty() && resultList.get("LIST_DATA") != null) {
						list = LibSearchAPI.getListData(resultList);
						String reckey = String.valueOf(list.get(0).get("PK"));
						librarySearch.setUserkey(userKey);
						librarySearch.setBookkey(reckey);
						ApiResponse apiResult = LibSearchAPI.cancelReservation(librarySearch);
						
						if (apiResult.getStatus()) {
							walkingThruRecord.setRequest_number(Integer.parseInt(request_number));
							recordService.cancelReservationStep(walkingThruRecord);
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
				} catch (Exception e) {
					res.setValid(false);
					res.setMessage("이미 대출처리 되었습니다.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;

	}
	
	@RequestMapping (value = {"/randomPassword.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse randomPassword(WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if(recordService.checkPasswordCount(walkingThruRecord) == 0) {
			recordService.alertMessageOnly("nonPasswordCheck", request, response);
			return null;
		}
		
		if (recordService.checkNonPasswordCount(walkingThruRecord) == 0) {
			recordService.alertMessageOnly("passwordCheck", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			recordService.passwordSetting(walkingThruRecord);
				res.setValid(true);
				res.setMessage("생성되었습니다.");
			} else {
				res.setValid(false);
				res.setResult(result.getAllErrors());
			}
		
		return res;
	}
	
	//대기,대출항목탭 대기로 변경
	@RequestMapping (value = {"/waitingReservationStepBefore.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse waitingReservationStepBefore(LibrarySearch librarySearch, WalkingThruSetting walkingThruSetting, WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {

		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		walkingThruSetting.setHomepage_id(getAsideHomepageId(request));
		walkingThruSetting = settingService.getWalkingThruSettingOne(getAsideHomepageId(request));
		
		if(walkingThruSetting.getPassword_yn().equals("Y")) {
			if(recordService.checkPassword(walkingThruRecord) > 0) {
				res.setValid(false);
				res.setMessage("비밀번호를 설정해주세요.");
				return res;
			}
		}
		
		List<WalkingThruRecord> waitingReservationList = recordService.getWaitingReservationList(walkingThruRecord);
		for (int i = 0; i < waitingReservationList.size(); i++) {
			String request_number = String.valueOf(waitingReservationList.get(i).getRequest_number());
			String manageCode = String.valueOf(waitingReservationList.get(i).getManage_code());
			String userKey = String.valueOf(waitingReservationList.get(i).getUser_key());
			String regNo = String.valueOf(waitingReservationList.get(i).getReg_no());
			String member_name = String.valueOf(waitingReservationList.get(i).getMember_name());
			String book_name = String.valueOf(waitingReservationList.get(i).getBook_name());
			String pass = String.valueOf(waitingReservationList.get(i).getPassword());
			String start_date = String.valueOf(waitingReservationList.get(i).getStart_date());
			
			librarySearch.setManageCode(manageCode);
			librarySearch.setUserkey(userKey);
			librarySearch.setRegNo(regNo);
			
			librarySearch.setSearch_start_date(start_date);
			
			//무인대출예약 목록 조회
			Map<String, Object> unmannedLoanReserveList = LibSearchAPI.getUntactBookLoanReserveList(librarySearch, null);
			List<Map<String, Object>> list = null;
			
			list = LibSearchAPI.getListData(unmannedLoanReserveList);
			
			if (list != null && list.size() > 0) {
				String loanKey = String.valueOf(list.get(0).get("LOAN_KEY"));
				
				walkingThruRecord.setLoankey(loanKey);
				
				librarySearch.setLoan_key(loanKey);
				
				//loanKey 가져와서 예약대출기 상태 수정
				ApiResponse apiResult = LibSearchAPI.bookreserveUpdateStatus(librarySearch);
				
				Homepage homepage = new Homepage();
				homepage.setHomepage_id(getAsideHomepageId(request));
				
				homepage = homepageService.getHomepageOne(homepage);
				
				String userIp = request.getRemoteAddr();
				
				librarySearch.setManageCode(manageCode);
				librarySearch.setUserkey(userKey);
				
				if(walkingThruSetting.getLoan_time_choice().equals("T") && walkingThruSetting.getPassword_yn().equals("Y")) {
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n비밀번호 : "+pass+"\n대출가능 시간은 금일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."; 
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else if(walkingThruSetting.getLoan_time_choice().equals("T") && walkingThruSetting.getPassword_yn().equals("N")){
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n대출가능 시간은 금일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."+"\n도서대출시 신분증 혹은 회원증을 챙겨주세요.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else if(walkingThruSetting.getLoan_time_choice().equals("N") && walkingThruSetting.getPassword_yn().equals("Y")){
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n비밀번호 : "+pass+"\n대출가능 시간은 익일 " + walkingThruSetting.getLoan_time() + " 까지 입니다.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				} else {
					String mes =  "[" +homepage.getHomepage_name() + "]\n" + member_name + "님 도서 비치가 완료되었습니다.\n도서 정보 : "+book_name+"\n대출가능 시간은 익일 " + walkingThruSetting.getLoan_time() + " 까지 입니다."+"\n도서대출시 신분증 혹은 회원증을 챙겨주세요.";
					LibSearchAPI.sendSms(librarySearch, mes, userIp);
				}
				
				if(apiResult.getStatus()){
					if (!result.hasErrors()) {
						walkingThruRecord.setReservation_step("3");
						walkingThruRecord.setRequest_number(Integer.parseInt(request_number));
						int modify_result = recordService.waitingReservationStep(walkingThruRecord);
						
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
	
	@RequestMapping (value = {"/randomPasswordBefore.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse randomPasswordBefore(WalkingThruRecord walkingThruRecord, BindingResult result, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if(recordService.checkPasswordCountBefore(walkingThruRecord) == 0) {
			recordService.alertMessageOnly("nonPasswordCheck", request, response);
			return null;
		}
		
		if (recordService.checkNonPasswordCountBefore(walkingThruRecord) == 0) {
			recordService.alertMessageOnly("passwordCheck", request, response);
			return null;
		}
		
		if (!result.hasErrors()) {
			recordService.passwordSettingBefore(walkingThruRecord);
				res.setValid(true);
				res.setMessage("생성되었습니다.");
			} else {
				res.setValid(false);
				res.setResult(result.getAllErrors());
			}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public WalkingThruRecordSearchView excelDownload(Model model, WalkingThruRecord walkingThruRecord, HttpServletRequest request){
		walkingThruRecord.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("walkingThruRecord", walkingThruRecord);
		model.addAttribute("walkingThruRecordList", recordService.getWalkingThruRecordExcelListNow(walkingThruRecord));
		
		return new WalkingThruRecordSearchView();
	}
}
