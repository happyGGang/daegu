package kr.go.gbelib.app.module.libraryCheck;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.libraryCheck.LibraryCheck;
import kr.go.gbelib.app.cms.module.libraryCheck.LibraryCheckService;
import kr.go.gbelib.app.cms.module.libraryCheck.LibraryCheckView;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Controller(value = "userLibraryCheck")
@RequestMapping(value = {"/{homepagePath}/module/libraryCheck"})
public class LibraryCheckController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/libraryCheck/";
	
	@Autowired
	private LibraryCheckService service;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, LibraryCheck libraryCheck, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		service.setPaging(model, service.getLibraryCheckCount(libraryCheck), libraryCheck);
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckList", service.getLibraryCheckList(libraryCheck));
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, LibraryCheck libraryCheck, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if(libraryCheck.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			int menu_idx = libraryCheck.getMenu_idx();
			libraryCheck = (LibraryCheck)service.copyObjectPaging(libraryCheck, service.getLibraryCheckOne(libraryCheck));
			libraryCheck.setMenu_idx(menu_idx);
		}
		model.addAttribute("libraryCheck", libraryCheck);

		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/view.*"}, method = RequestMethod.POST)
	public String view(Model model, LibraryCheck libraryCheck, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		libraryCheck = (LibraryCheck)service.copyObjectPaging(libraryCheck, service.getLibraryCheckOne(libraryCheck));

		model.addAttribute("libraryCheck", libraryCheck);

		return String.format(basePath, homepage.getFolder()) + "view_ajax";
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
			String session_id = getSessionIsAdmin(request) ? getSessionMemberId(request) : sessionLoginSupport(request).getMember_id();
			if (libraryCheck.getEditMode().equals("ADD")) {
				libraryCheck.setAdd_id(session_id);
				service.addLibraryCheck(libraryCheck);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+libraryCheck.getMenu_idx());
				res.setMessage("등록되었습니다.");
			} else if (libraryCheck.getEditMode().equals("MODIFY")) {
				libraryCheck.setModify_id(session_id);
				service.modifyLibraryCheck(libraryCheck);
				res.setUrl("index.do");
				res.setData("menu_idx="+libraryCheck.getMenu_idx() + "&viewPage="+libraryCheck.getViewPage());
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
	public String loanList(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember supportMember = sessionLoginSupport(request);
		if ( supportMember == null && !getSessionIsAdmin(request) ) {
			libraryCheck.setBefore_url(String.format("/%s/module/libraryCheck/loanList.do?menu_idx=%s", homepage.getContext_path(), libraryCheck.getMenu_idx()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), libraryCheck.getMenu_idx(), libraryCheck.getBefore_url()), request, response);
			return null;
		}
		
		if(!getSessionIsAdmin(request) && !"1".equals(supportMember.getAuth_group())) {
			libraryCheck.setAdd_id(supportMember.getMember_id());
		}
		
		service.setPaging(model, service.getLibraryCheckLoanCount(libraryCheck), libraryCheck);

		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckLoanList", service.getLibraryCheckLoanList(libraryCheck));
		model.addAttribute("libraryCheckList", service.getLibraryCheckList(libraryCheck));

		return String.format(basePath, homepage.getFolder()) + "loanList";
	}
	
	@RequestMapping (value = {"/loanView.*"}, method = RequestMethod.GET)
	public String loanView(Model model, LibraryCheck libraryCheck, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		libraryCheck = (LibraryCheck)service.copyObjectPaging(libraryCheck, service.getLibraryCheckLoanOne(libraryCheck));
		model.addAttribute("libraryCheck", libraryCheck);

		return String.format(basePath, homepage.getFolder()) + "loanView";
	}
	
	@RequestMapping (value = {"/loanEdit.*"}, method = RequestMethod.GET)
	public String loanEdit(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember loginSupport = sessionLoginSupport(request);
		if (loginSupport == null && !getSessionIsAdmin(request)) {
			libraryCheck.setBefore_url(String.format("/%s/module/libraryCheck/index.do?menu_idx=%s", homepage.getContext_path(), libraryCheck.getMenu_idx()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), libraryCheck.getMenu_idx(), libraryCheck.getBefore_url()), request, response);
			return null;
		}

		if(libraryCheck.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			int menu_idx = libraryCheck.getMenu_idx();
			libraryCheck = (LibraryCheck)service.copyObjectPaging(libraryCheck, service.getLibraryCheckLoanOne(libraryCheck));
			libraryCheck.setMenu_idx(menu_idx);
		}
		
		List<String> list = checkDisabledList(libraryCheck);

		//TODO 해당 주로부터 2주뒤의예약이 가득 차있으면 메세지...
		if(libraryCheck.getEditMode().equals("ADD")) {
			if(list.size() > 6) {
				service.alertMessage("현재 예약이 최대로 되어 예약이 불가합니다.\n(문의 전화 053-231-2857)", request, response);
				return null;
			}
		}

		if(libraryCheck.getEditMode().equals("ADD") && loginSupport != null && !getSessionIsAdmin(request)) {
			libraryCheck.setSchool_name(loginSupport.getSchool_name());
			if(service.checkLoanCount(libraryCheck) >= 2) {
				service.alertMessage("최대 신청대수는 2대 입니다.예약 현황을 확인해주세요.\n(문의 전화 053-231-2857)", request, response);
				return null;
			}
		}
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("loginSupport", loginSupport);
		model.addAttribute("disabledList", list);

		return String.format(basePath, homepage.getFolder()) + "loanEdit";
	}

	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse loanSave(LibraryCheck libraryCheck, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(libraryCheck.getEditMode().equals("ADD") || libraryCheck.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출종료기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "hope_date", "방문예정일자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "hope_start_time", "방문예정시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "hope_start_minute", "방문예정시간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "school_name", "학교명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "request_name", "신청자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");
    		
    		SupportMember loginSupport = sessionLoginSupport(request);
    		if (loginSupport != null && !getSessionIsAdmin(request) && !"1".equals(loginSupport.getAuth_group())) {
        		try {
        			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    				Date startDate = sdf.parse(libraryCheck.getLoan_start_date());
    				Date endDate = sdf.parse(libraryCheck.getLoan_end_date());
    				
    				if((int)(endDate.getTime() - startDate.getTime()) / (24*60*60*1000) > 13) {
    					result.reject("대출기간은 최대 2주까지 대여 가능합니다.");
    				}
    			} catch (ParseException e) {
    				e.printStackTrace();
    			}
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
		
		if(libraryCheck.getEditMode().equals("ADD") || libraryCheck.getEditMode().equals("MODIFY")) {
			if(service.getLibraryCheckLoanDupl(libraryCheck) > 0) {
				result.reject("해당 날짜의 장서점검기는 이미 예약중 입니다.");
			}
		}

		if (!result.hasErrors()) {
			String session_id = getSessionIsAdmin(request) ? getSessionMemberId(request) : sessionLoginSupport(request).getMember_id();
			String param = "menu_idx="+libraryCheck.getMenu_idx() + "&viewPage="+libraryCheck.getViewPage()
				+ "&search_type="+libraryCheck.getSearch_type() + "&search_text="+libraryCheck.getSearch_text();
			if (libraryCheck.getEditMode().equals("ADD")) {
				libraryCheck.setAdd_id(session_id);
				service.addLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData(param);
				res.setMessage("등록되었습니다.");
			} else if (libraryCheck.getEditMode().equals("MODIFY")) {
				libraryCheck.setModify_id(session_id);
				service.modifyLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData(param);
				res.setMessage("수정되었습니다.");
			} else if(libraryCheck.getEditMode().equals("DELETE")) {
				service.deleteLibraryCheckLoan(libraryCheck);
				res.setValid(true);
				res.setMessage("취소되었습니다.");
			} else if(libraryCheck.getEditMode().equals("STATUS")) {
				service.modifyLibraryCheckStatus(libraryCheck);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData(param);
				res.setMessage("선택 상태 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/libraryCheckloanList.*"}, method = RequestMethod.POST)
	public String libraryCheckloanList(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember supportMember = sessionLoginSupport(request);
		if ( supportMember == null && !getSessionIsAdmin(request) ) {
			libraryCheck.setBefore_url(String.format("/%s/module/libraryCheck/loanList.do?menu_idx=%s", homepage.getContext_path(), libraryCheck.getMenu_idx()));
			service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), libraryCheck.getMenu_idx(), libraryCheck.getBefore_url()), request, response);
			return null;
		}
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckList", service.getLibraryCheckReservedList(libraryCheck));

		return String.format(basePath, homepage.getFolder()) + "libraryCheckloanList_ajax";
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public LibraryCheckView excel(Model model, LibraryCheck libraryCheck, HttpServletRequest request, HttpServletResponse response) throws Exception{
		SupportMember sm = sessionLoginSupport(request);
		
		if(sm != null && !("1").equals(sm.getAuth_group())) {
			libraryCheck.setAdd_id(sm.getMember_id());
		}
		
		List<LibraryCheck> libraryCheckLoanList = service.getLibraryCheckLoanExcelList(libraryCheck);
		
		model.addAttribute("libraryCheck", libraryCheck);
		model.addAttribute("libraryCheckLoanList", libraryCheckLoanList);

		return new LibraryCheckView();
	}
	
	private List<String> checkDisabledList(LibraryCheck libraryCheck) throws ParseException {
		List<LibraryCheck> disableList = service.getLibraryCheckReservedList(libraryCheck);
		
		List<String> list = new ArrayList<String>();
		
		for(int i = 0; i < disableList.size(); i++) {
			String loan_start_date = disableList.get(i).getLoan_start_date();
			String loan_end_date = disableList.get(i).getLoan_end_date();
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
			
			Date start = format.parse(loan_start_date);
			Date end = format.parse(loan_end_date);
			
			long Sec = end.getTime() - start.getTime();
			long Days = Sec / (24*60*60*1000);
			
			Days = Math.abs(Days);
			
			if(Days > 6) {
				Calendar cal = Calendar.getInstance();
				cal.setTime(start);
				cal.add(Calendar.DATE, 7);
				
				list.add("\""+format.format(start)+"\"");
				list.add("\""+format.format(cal.getTime()).toString()+"\"");
			} else {
				list.add("\""+format.format(start)+"\"");
			}
		}
		return list;
	}
}