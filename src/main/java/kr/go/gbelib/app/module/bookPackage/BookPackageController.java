package kr.go.gbelib.app.module.bookPackage;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import kr.go.gbelib.app.cms.module.bookPackage.BookPackage;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackageService;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackageView;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Controller(value = "userBookPackage")
@RequestMapping(value = {"/{homepagePath}/module/bookPackage"})
public class BookPackageController extends BaseController {
	
	private String basePath = "/homepage/%s/module/bookPackage/";
	
	@Autowired
	private BookPackageService service;
	
	public SupportMember sessionSupportMember(HttpServletRequest request) {
		SupportMember supportMember = (SupportMember)request.getSession().getAttribute("supportMember");
		return supportMember;
	}
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookPackage bookPackage, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(bookPackage.getCategory() == null) {
			bookPackage.setCategory("all");
		}
		
		service.setPaging(model, service.getBookPackageCount(bookPackage), bookPackage);

		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("bookPackageList", service.getBookPackageList(bookPackage));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, BookPackage bookPackage, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		int menu_idx = bookPackage.getMenu_idx();
		
		bookPackage = (BookPackage)service.copyObjectPaging(bookPackage, service.getBookPackageOne(bookPackage));
		bookPackage.setMenu_idx(menu_idx);
		
		model.addAttribute("bookPackage", bookPackage);

		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookPackage bookPackage, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(bookPackage.getEditMode().equals("ADD") || bookPackage.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "book_package_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_package_subject", "책꾸러미명을 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (bookPackage.getEditMode().equals("MODIFY")) {
				bookPackage.setModify_id(getSessionMemberId(request));
				service.modifyBookPackage(bookPackage);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (bookPackage.getEditMode().equals("DELETE")) {
				service.deleteBookPackage(bookPackage);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx() + "&viewPage="+bookPackage.getViewPage());
				res.setMessage("삭제되었습니다.");
			} else if(bookPackage.getEditMode().equals("DELETE_CHECK")) {
				service.deleteCheckBookPackage(bookPackage);
				res.setValid(true);
				res.setMessage("선택 삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/loanList.*"}, method = RequestMethod.GET)
	public String bookPackageLoanList(Model model, BookPackage bookPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember supportMember = sessionSupportMember(request);
		if ( supportMember == null ) {
    		bookPackage.setBefore_url(String.format("/%s/module/bookPackage/loanList.do?menu_idx=%s", homepage.getContext_path(), bookPackage.getMenu_idx()));
    		service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackage.getMenu_idx(), bookPackage.getBefore_url()), request, response);
    		return null;
        }
		
		bookPackage.setAdd_id(supportMember.getMember_id());
		service.setPaging(model, service.getBookPackageLoanCount(bookPackage), bookPackage);
		
		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("loanList", service.getBookPackageLoanList(bookPackage));

		return String.format(basePath, homepage.getFolder()) + "loanList";
	}
	
	@RequestMapping(value = {"/loanEdit.*"})
	public String bookPackageReq(Model model, BookPackage bookPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember supportMember = sessionSupportMember(request);
		if ( supportMember == null ) {
    		bookPackage.setBefore_url(String.format("/%s/module/bookPackage/index.do?menu_idx=%s", homepage.getContext_path(), bookPackage.getMenu_idx()));
    		service.alertMessageAndUrl("로그인 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackage.getMenu_idx(), bookPackage.getBefore_url()), request, response);
    		return null;
        }
		
		int menu_idx = bookPackage.getMenu_idx();
		
		if(bookPackage.getEditMode().equals("MODIFY")) {
			
			bookPackage = (BookPackage)service.copyObjectPaging(bookPackage, service.getBookPackageLoanOne(bookPackage));
			String[] phone = bookPackage.getPhone().split("-");
			bookPackage.setPhone_1(phone[0]);
			bookPackage.setPhone_2(phone[1]);
			bookPackage.setPhone_3(phone[2]);
			
			String[] school_tel = bookPackage.getSchool_tel().split("-");
			bookPackage.setSchool_tel_1(school_tel[0]);
			bookPackage.setSchool_tel_2(school_tel[1]);
			bookPackage.setSchool_tel_3(school_tel[2]);
			
		} else {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, 3);
			
			bookPackage = (BookPackage)service.copyObjectPaging(bookPackage, service.getBookPackageOne(bookPackage));
			bookPackage.setLoan_start_date(sdf.format(cal.getTime()));
			
			
			if(bookPackage.getLender_count() > 1) {
				service.alertMessage("해당 도서에 이미 예약자가 있습니다.", request, response);
			} else if(bookPackage.getLender_count() > 0) {
				bookPackage.setRequest_status("1");
			}
			
			bookPackage.setSchool_name(supportMember.getSchool_name());
			
		}
		
		bookPackage.setMenu_idx(menu_idx);
		model.addAttribute("bookPackage", bookPackage);
		
		return String.format(basePath, homepage.getFolder()) + "loanEdit";
	}
	
	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookPackageReqSave(BookPackage bookPackage, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(bookPackage.getEditMode().equals("ADD") || bookPackage.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출시작기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "school_name", "학교명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "request_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "request_content", "신청사유를 입력하세요.");
    		
    		String phone = bookPackage.getPhone_1() + "-" + bookPackage.getPhone_2() + "-" + bookPackage.getPhone_3();
			String school_tel = bookPackage.getSchool_tel_1() + "-" + bookPackage.getSchool_tel_2() + "-" + bookPackage.getSchool_tel_3();
			bookPackage.setPhone(phone);
			bookPackage.setSchool_tel(school_tel);
			
			Pattern pattern1 = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher1 = pattern1.matcher(bookPackage.getPhone());
    		if (!matcher1.matches()) {
    			result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
    		}
    		
			Pattern pattern2 = Pattern.compile("^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher2 = pattern2.matcher(bookPackage.getSchool_tel());
    		if (!matcher2.matches()) {
    			result.rejectValue("school_tel_2", "학교 연락처 형식이 올바르지 않습니다.");
    		}
    		
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (bookPackage.getEditMode().equals("ADD")) {
				bookPackage.setAdd_id(sessionSupportMember(request).getMember_id());
				service.addBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx());
				res.setMessage("등록되었습니다.");
			} else if (bookPackage.getEditMode().equals("MODIFY")) {
				bookPackage.setModify_id(sessionSupportMember(request).getMember_id());
				service.modifyBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx() + "&viewPage="+bookPackage.getViewPage());
				res.setMessage("수정되었습니다.");
			} else if (bookPackage.getEditMode().equals("DELETE")) {
				service.deleteBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx() + "&viewPage="+bookPackage.getViewPage());
				res.setMessage("삭제되었습니다.");
			} else if(bookPackage.getEditMode().equals("returnReq")) {
				service.modifyReturnReq(bookPackage);
				res.setValid(true);
				res.setMessage("반납요청이 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookPackageView excel(Model model, BookPackage bookPackage, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<BookPackage> bookPackageList = null;
		if(bookPackage.getEditMode().equals("bookPackage")) {
			bookPackageList = service.getBookPackageList(bookPackage);
		} else {
			bookPackageList = service.getBookPackageLoanList(bookPackage);
		}
		
		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("bookPackageList", bookPackageList);

		return new BookPackageView();
	}

}
