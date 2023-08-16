package kr.go.gbelib.app.cms.module.libraryCheck;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/libraryCheck"})
public class LibraryCheckController extends BaseController {
	
	private final String basePath = "/cms/module/libraryCheck/";
	
	@Autowired
	private LibraryCheckService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, LibraryCheck libraryCheck, HttpServletRequest request) {
		
		service.setPaging(model, service.getLibraryCheckCount(libraryCheck), libraryCheck);
		libraryCheck.setTotalDataCount(service.getLibraryCheckCount(libraryCheck));
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckList", service.getLibraryCheckList(libraryCheck));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, LibraryCheck libraryCheck, HttpServletRequest request) throws AuthException {

		if(libraryCheck.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("libraryCheck", service.copyObjectPaging(libraryCheck, service.getLibraryCheckOne(libraryCheck)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("libraryCheck", libraryCheck);
		}

		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, LibraryCheck libraryCheck, HttpServletRequest request) {

		libraryCheck = (LibraryCheck) service.copyObjectPaging(libraryCheck, service.getLibraryCheckOne(libraryCheck));

		model.addAttribute("libraryCheck", libraryCheck);

		return basePath + "view";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(LibraryCheck libraryCheck, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(libraryCheck.getEditMode().equals("ADD") || libraryCheck.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "library_check_name", "이름이 없습니다.");
    		ValidationUtils.rejectIfEmpty(result, "library_check_number", "선택한 장서점검기가 없습니다.");
		}
		
		if(libraryCheck.getEditMode().equals("ADD") && service.getLibraryCheckDupl(libraryCheck) > 0) {
			result.reject("해당 장서점검기는 등록되어있습니다.");
		}

		if (!result.hasErrors()) {
			if (libraryCheck.getEditMode().equals("ADD")) {
				libraryCheck.setAdd_id(getSessionMemberId(request));
				service.addLibraryCheck(libraryCheck);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (libraryCheck.getEditMode().equals("MODIFY")) {
				libraryCheck.setModify_id(getSessionMemberId(request));
				service.modifyLibraryCheck(libraryCheck);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(libraryCheck.getEditMode().equals("DELETE")) {
				service.deleteLibraryCheck(libraryCheck);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(libraryCheck.getEditMode().equals("DELETE_ALL")) {
				service.deleteLibraryCheckAll(libraryCheck);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/loanList.*"}, method = RequestMethod.GET)
	public String loanList(Model model, LibraryCheck libraryCheck, HttpServletRequest request) {
		
		service.setPaging(model, service.getLibraryCheckLoanCount(libraryCheck), libraryCheck);

		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckLoanList", service.getLibraryCheckLoanList(libraryCheck));
		model.addAttribute("libraryCheckList", service.getLibraryCheckList(libraryCheck));

		return basePath + "loanList";
	}
	
	@RequestMapping (value = {"/loanEdit.*"}, method = RequestMethod.GET)
	public String loanEdit(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws AuthException, Exception {
		
//		List<String> list = checkDisabledList(libraryCheck);
//
//		//TODO 해당 주로부터 2주뒤의예약이 가득 차있으면 메세지...
//		if(libraryCheck.getEditMode().equals("ADD")) {
//			if(list.size() > 6) {
//				service.alertMessage("현재 예약이 최대로 되어 예약이 불가합니다.\n(문의 전화 053-231-2857)", request, response);
//				return null;
//			}
//		}

		if(libraryCheck.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("libraryCheck", service.copyObjectPaging(libraryCheck, service.getLibraryCheckLoanOne(libraryCheck)));
//			model.addAttribute("disabledList", list);
		} else {
			checkAuth("C", model, request);
			if (getSessionIsAdmin(request)) {
				model.addAttribute("isAdmin", true);
			} else {
				model.addAttribute("isAdmin", false);
			}
			model.addAttribute("libraryCheck", libraryCheck);
//			model.addAttribute("disabledList", list);
		}

		return basePath + "loanEdit_ajax";
	}
	
	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse loanSave(LibraryCheck libraryCheck, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(libraryCheck.getEditMode().equals("ADD") || libraryCheck.getEditMode().equals("MODIFY")) {
			if (!"6".equals(libraryCheck.getRequest_status())) {
				ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
				ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출종료기간을 입력하세요.");
			}
//			ValidationUtils.rejectIfEmpty(result, "hope_date", "방문예정일자를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "hope_start_time", "방문예정시간을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "hope_start_minute", "방문예정시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "request_name", "신청자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");

			if ("6".equals(libraryCheck.getRequest_status())) {
				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String now = dateFormat.format(date);
				libraryCheck.setLoan_start_date(now);
				libraryCheck.setLoan_end_date("9999-12-31");
			}
    		
    		String phone = libraryCheck.getPhone_1() + "-" + libraryCheck.getPhone_2() + "-" + libraryCheck.getPhone_3();
			String school_tel = libraryCheck.getSchool_tel_1() + "-" + libraryCheck.getSchool_tel_2() + "-" + libraryCheck.getSchool_tel_3();
			libraryCheck.setPhone(phone);
			libraryCheck.setSchool_tel(school_tel);
			
			Pattern pattern1 = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher1 = pattern1.matcher(libraryCheck.getPhone());
    		if (!matcher1.matches()) {
    			result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
    		}
    		
			Pattern pattern2 = Pattern.compile("^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher2 = pattern2.matcher(libraryCheck.getSchool_tel());
    		if (!matcher2.matches()) {
    			result.rejectValue("school_tel_2", "학교 연락처 형식이 올바르지 않습니다.");
    		}
		}

		if (!result.hasErrors()) {
			if (libraryCheck.getEditMode().equals("ADD")) {
				libraryCheck.setAdd_id(getSessionMemberId(request));
				service.addLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (libraryCheck.getEditMode().equals("MODIFY")) {
				libraryCheck.setModify_id(getSessionMemberId(request));
				service.modifyLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if(libraryCheck.getEditMode().equals("DELETE")) {
				service.deleteLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if(libraryCheck.getEditMode().equals("STATUS")) {
				service.modifyLibraryCheckStatus(libraryCheck);
				res.setValid(true);
				res.setMessage("선택 상태 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LibraryCheckView excel(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<LibraryCheck> libraryCheckLoanList = service.getLibraryCheckLoanExcelList(libraryCheck);
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckLoanList", libraryCheckLoanList);

		return new LibraryCheckView();
	}
	
//	private List<String> checkDisabledList(LibraryCheck libraryCheck) throws ParseException {
//		List<LibraryCheck> disableList = service.getLibraryCheckReservedList(libraryCheck);
//		
//		List<String> list = new ArrayList<String>();
//		
//		for(int i = 0; i < disableList.size(); i++) {
//			String loan_start_date = disableList.get(i).getLoan_start_date();
//			String loan_end_date = disableList.get(i).getLoan_end_date();
//			
//			SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
//			
//			Date start = format.parse(loan_start_date);
//			Date end = format.parse(loan_end_date);
//			
//			long Sec = end.getTime() - start.getTime();
//			long Days = Sec / (24*60*60*1000);
//			
//			Days = Math.abs(Days);
//			
//			if(Days > 6) {
//				Calendar cal = Calendar.getInstance();
//				cal.setTime(start);
//				cal.add(Calendar.DATE, 7);
//				
//				list.add("\""+format.format(start)+"\"");
//				list.add("\""+format.format(cal.getTime()).toString()+"\"");
//			} else {
//				list.add("\""+format.format(start)+"\"");
//			}
//		}
//		return list;
//	}
	
	@RequestMapping (value = {"/checkLoanDate.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse checkLoanDate(LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		JsonResponse res = new JsonResponse(request);
		
		String loan_start_date = libraryCheck.getLoan_start_date();
		String loan_end_date = libraryCheck.getLoan_end_date();
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date start_date = sdf.parse(loan_start_date);
			Date end_date = sdf.parse(loan_end_date);
			
		    long calDate = start_date.getTime() - end_date.getTime(); 
		    long calDateDays = calDate / ( 24*60*60*1000); 
		    
		    calDateDays = Math.abs(calDateDays);
			
		    //신청기간 2주에서 한달 제한
		    if(calDateDays < 6 || calDateDays > 13) {
				res.setValid(false);
				res.setMessage("신청 가능 기간은 최소 1주에서 최대 2주까지입니다.");
				return res;
			}
		} catch (Exception e) {
			res.setValid(false);
			res.setMessage("신청 날짜 비교에 오류가 생겼습니다. 다시 신청해주세요.");
			return res;
		}
		
		int checkDupLoanDateCount = service.checkDupLoanDateCount(libraryCheck);
		
		if(checkDupLoanDateCount > 0) {
			libraryCheck = service.dupLoanDate(libraryCheck);
			
			res.setValid(false);
			res.setMessage("이미 신청이된 날짜입니다. " + libraryCheck.getLoan_end_date() + " 이후로 신청이 가능합니다.");
			
			return res;
		}
		
		res.setValid(true);
		
		return res;
	}

}
