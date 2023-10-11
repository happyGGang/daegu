package kr.go.gbelib.app.module.bookPackageBundle;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.go.gbelib.app.cms.module.bookPackageBundle.BookPackageBundle;
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
import kr.go.gbelib.app.cms.module.bookPackageBundle.BookPackageBundleService;
import kr.go.gbelib.app.cms.module.bookPackageBundle.BookPackageBundleView;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;

@Controller(value = "userBookPackageBundle")
@RequestMapping(value = {"/{homepagePath}/module/bookPackageBundle"})
public class BookPackageBundleController extends BaseController {

	public static final int DAYS_TO_ADD = 5;
	public static final int LOAN_START_DATE_ADD = DAYS_TO_ADD;
	public static final int LOAN_END_DATE_ADD = 15;
	private String basePath = "/homepage/%s/module/bookPackageBundle/";

	@Autowired
	private BookPackageBundleService bookPackageBundleService;

	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(homepage.getHomepage_id());
		}
		
		bookPackageBundle.setHomepage_id(homepage.getHomepage_id());

		int count = bookPackageBundleService.getBookPackageDetailCount(bookPackageBundle);
		bookPackageBundleService.setPaging(model, count, bookPackageBundle);
		bookPackageBundle.setTotalDataCount(count);
		
		List<BookPackageBundle> bookPackageDetailList = bookPackageBundleService.getBookPackageDetailList(bookPackageBundle);
		List<BookPackageBundle> bookPackageCategoryList = bookPackageBundleService.getBookPackageCategoryList(bookPackageBundle);
		List<BookPackageBundle> bookPackageAllTitleCount = bookPackageBundleService.getBookPackageAllTitleCount(bookPackageBundle);

		bookPackageDetail(bookPackageDetailList);
		
		model.addAttribute("bookPackageAllTitleCount",bookPackageAllTitleCount);
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageDetailList);
		model.addAttribute("bookPackageCategoryList", bookPackageCategoryList);
		
		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	private List<BookPackageBundle> bookPackageDetail(List<BookPackageBundle> bookPackageDetailList) {
		int temp = 0;
		
		for(Iterator<BookPackageBundle> it=bookPackageDetailList.iterator(); it.hasNext();) {
			BookPackageBundle item = it.next();
			
			if(item.getBook_package_bundle_idx() == temp) it.remove();
			
			temp = item.getBook_package_bundle_idx();
		}
		
		return bookPackageDetailList;
	}

	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
	
		Homepage homepage = (Homepage) request.getAttribute("homepage");
	
		if(bookPackageBundle.getEditMode().equals("MODIFY")) { 
			checkAuth("U", model, request);
		
			int menu_idx = bookPackageBundle.getMenu_idx(); bookPackageBundle = (BookPackageBundle)bookPackageBundleService.copyObjectPaging(bookPackageBundle, bookPackageBundleService.getBookPackageOne(bookPackageBundle)); bookPackageBundle.setMenu_idx(menu_idx);
		}
		model.addAttribute("bookPackageBundle", bookPackageBundle);
	
		return String.format(basePath, homepage.getFolder()) + "edit"; 
	}
	
	@RequestMapping (value = {"/view.*"}, method = RequestMethod.GET)
	public String view(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		int menu_idx = bookPackageBundle.getMenu_idx();
		
		bookPackageBundle.setMenu_idx(menu_idx);
		
		bookPackageBundle.setHomepage_id(homepage.getHomepage_id());
		List<BookPackageBundle> bookPackageBundleList = bookPackageBundleService.getBookPackage(bookPackageBundle);
		
		bookPackageBundle = bookPackageBundleService.getBookPackageOne(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);
	
		return String.format(basePath, homepage.getFolder()) + "view";
	}

	@RequestMapping (value = {"/loanList.*"}, method = RequestMethod.GET)
	public String bookPackageLoanList(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		SupportMember loginSupport = sessionLoginSupport(request);
		int menu_idx = bookPackageBundle.getMenu_idx();
		bookPackageBundle.setMenu_idx(menu_idx);
		
		if (loginSupport == null && !getSessionIsAdmin(request)) {
			bookPackageBundle.setBefore_url(String.format("/%s/module/bookPackage/loanList.do?menu_idx=%s", homepage.getContext_path(), bookPackageBundle.getMenu_idx()));
			bookPackageBundleService.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackageBundle.getMenu_idx(), bookPackageBundle.getBefore_url()), request, response);
    		return null;
        }

		if(!getSessionIsAdmin(request) && !"1".equals(loginSupport.getAuth_group())) {
			bookPackageBundle.setAdd_id(loginSupport.getMember_id());
		}
		bookPackageBundle.setHomepage_id(homepage.getHomepage_id());
		
		bookPackageBundleService.setPaging(model, bookPackageBundleService.getBookPackageLoanCount(bookPackageBundle), bookPackageBundle);
		
		List<BookPackageBundle> bookPackageCategoryList = bookPackageBundleService.getBookPackageCategoryList(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("loanList", bookPackageBundleService.getBookPackageLoanList(bookPackageBundle));
		model.addAttribute("bookPackageCategoryList", bookPackageCategoryList);

		return String.format(basePath, homepage.getFolder()) + "loanList";
	}

	
	@RequestMapping (value = {"/loanView.*"}, method = RequestMethod.GET)
	public String loanView(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
	checkAuth("R", model, request); 
	Homepage homepage = (Homepage) request.getAttribute("homepage");
	
	bookPackageBundle = (BookPackageBundle)bookPackageBundleService.copyObjectPaging(bookPackageBundle, bookPackageBundleService.getBookPackageLoanOne(bookPackageBundle));
	model.addAttribute("bookPackageBundle", bookPackageBundle);
	
	return String.format(basePath, homepage.getFolder()) + "loanView"; 
	}

	@RequestMapping(value = {"/loanEdit.*"})
	public String bookPackageReq(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");

		SupportMember loginSupport = sessionLoginSupport(request);
		if (loginSupport == null && !getSessionIsAdmin(request)) {
			bookPackageBundle.setBefore_url(String.format("/%s/module/bookPackageBundle/index.do?menu_idx=%s", homepage.getContext_path(), bookPackageBundle.getMenu_idx()));
			bookPackageBundleService.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackageBundle.getMenu_idx(), bookPackageBundle.getBefore_url()), request, response);
			return null;
		}
		
		if(bookPackageBundle.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			
			bookPackageBundle = (BookPackageBundle)bookPackageBundleService.copyObjectPaging(bookPackageBundle, bookPackageBundleService.getBookPackageLoanOne(bookPackageBundle));
			String[] phone = bookPackageBundle.getPhone().split("-");
			bookPackageBundle.setPhone_1(phone[0]);
			bookPackageBundle.setPhone_2(phone[1]);
			bookPackageBundle.setPhone_3(phone[2]);
			
			String[] school_tel = bookPackageBundle.getSchool_tel().split("-");
			bookPackageBundle.setSchool_tel_1(school_tel[0]);
			bookPackageBundle.setSchool_tel_2(school_tel[1]);
			bookPackageBundle.setSchool_tel_3(school_tel[2]);
			
			model.addAttribute("bookPackageBundle", bookPackageBundle);
		} else {
			checkAuth("C", model, request);
			bookPackageBundle = (BookPackageBundle) bookPackageBundleService.copyObjectPaging(bookPackageBundle, bookPackageBundleService.getBookPackageOne(bookPackageBundle));

			bookPackageBundleService.setBookPackageDefaultDate(bookPackageBundle);
			StringBuilder getDisableBetweenDate = setDisableBetweenDate(bookPackageBundle);
			model.addAttribute("disableBetweenDates", getDisableBetweenDate);
			model.addAttribute("bookPackageBundle", bookPackageBundle);
		}
			return String.format(basePath, homepage.getFolder()) + "loanEdit";
	}

	private StringBuilder setDisableBetweenDate(BookPackageBundle bookPackageBundle) {
		StringBuilder betweenDates = new StringBuilder();
		List<BookPackageBundle> reservation_date = bookPackageBundleService.getReservationDate(bookPackageBundle);

		if (bookPackageBundle.getRequest_status() != null && bookPackageBundle.getRequest_status().equals("1")) {

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

			Optional<LocalDate> minDateOptional = reservation_date.stream()
																  .map(date -> LocalDate.parse(date.getLoan_start_date(), formatter))
																  .min(LocalDate::compareTo);

			Optional<LocalDate> maxDateOptional = reservation_date.stream()
																  .map(date -> LocalDate.parse(date.getLoan_end_date(), formatter))
																  .max(LocalDate::compareTo);

			if (minDateOptional.isPresent() && maxDateOptional.isPresent()) {
				LocalDate minDate = minDateOptional.get();
				LocalDate maxDate = maxDateOptional.get();

				maxDate = maxDate.plusDays(LOAN_START_DATE_ADD);
				LocalDate finalMaxDate = maxDate.plusDays(LOAN_END_DATE_ADD);
				bookPackageBundle.setLoan_start_date(maxDate.plusDays(1).format(formatter));
				bookPackageBundle.setLoan_end_date(finalMaxDate.format(formatter));

				betweenDates = new StringBuilder();
				LocalDate currentDate = minDate;
				while (!currentDate.isAfter(maxDate)) {
					betweenDates.append("\"").append(currentDate).append("\"").append(",");
					currentDate = currentDate.plusDays(1);
				}

				if (betweenDates.length() > 0) {
					betweenDates.deleteCharAt(betweenDates.length() - 1);
				}
				betweenDates.insert(0, "[");
				betweenDates.append("]");
			}
		}
		return betweenDates;
	}

	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookPackageReqSave(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(bookPackageBundle.getEditMode().equals("ADD") || bookPackageBundle.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "loan_start_date", "대출시작기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "loan_end_date", "대출시작기간을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "school_name", "학교명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "request_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "request_content", "신청사유를 입력하세요.");
    		
    		String phone = bookPackageBundle.getPhone_1() + "-" + bookPackageBundle.getPhone_2() + "-" + bookPackageBundle.getPhone_3();
			String school_tel = bookPackageBundle.getSchool_tel_1() + "-" + bookPackageBundle.getSchool_tel_2() + "-" + bookPackageBundle.getSchool_tel_3();
			bookPackageBundle.setPhone(phone);
			bookPackageBundle.setSchool_tel(school_tel);
			
			Pattern pattern1 = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher1 = pattern1.matcher(bookPackageBundle.getPhone());
    		if (!matcher1.matches()) {
    			result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
    		}
    		
			Pattern pattern2 = Pattern.compile("^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher2 = pattern2.matcher(bookPackageBundle.getSchool_tel());
    		if (!matcher2.matches()) {
    			result.rejectValue("school_tel_2", "학교 연락처 형식이 올바르지 않습니다.");
    		}
    		
		}
		
		if (!result.hasErrors()) {
			
			if (bookPackageBundle.getEditMode().equals("ADD")) {
				bookPackageBundle.setAdd_id(getSessionMemberId(request));
				bookPackageBundleService.addBookPackageLoan(bookPackageBundle);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackageBundle.getMenu_idx());
				res.setMessage("대출기간을 변경을 원하실 경우,\r\n"
						+ "관리자에게 반납 가능한 날짜를 정확히 요청하셔야하며,\r\n"
						+ "반드시 대출 현황에서 변경된 내용을 직접 확인해주세요.\r\n"
						+ "(예약 학교가 있는 경우, 기간 변경이 어려울 수 있습니다.)\r\n"
						+ "\r\n"
						+ "반납일=우리도서관 도착날짜 입니다. 배송기간을 고려하여\r\n"
						+ "반납요청은 반납일 3일전에 꼭 해주세요!");
			} else if (bookPackageBundle.getEditMode().equals("MODIFY")) {
				bookPackageBundle.setModify_id(getSessionMemberId(request));
				bookPackageBundleService.modifyBookPackageLoan(bookPackageBundle);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackageBundle.getMenu_idx() + "&viewPage="+bookPackageBundle.getViewPage() + "&rowCount="+bookPackageBundle.getRowCount());
				res.setMessage("수정되었습니다.");
			} else if (bookPackageBundle.getEditMode().equals("DELETE")) {
				bookPackageBundleService.deleteBookPackageLoan(bookPackageBundle);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackageBundle.getMenu_idx() + "&viewPage="+bookPackageBundle.getViewPage() + "&rowCount="+bookPackageBundle.getRowCount());
				res.setMessage("취소되었습니다.");
			} else if(bookPackageBundle.getEditMode().equals("returnReq")) {
				bookPackageBundleService.modifyReturnReq(bookPackageBundle);
				res.setValid(true);
				res.setMessage("반납요청이 변경되었습니다.");
			} else if(bookPackageBundle.getEditMode().equals("STATUS")) {
				bookPackageBundleService.statusChangeAll(bookPackageBundle);
				res.setValid(true);
				res.setMessage("상태가 모두 변경되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookPackageBundleView excel(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request, HttpServletResponse response) throws Exception{
		SupportMember sm = sessionLoginSupport(request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(sm != null && !"1".equals(sm.getAuth_group())) {
			bookPackageBundle.setAdd_id(sm.getMember_id());
		}
		
		bookPackageBundle.setHomepage_id(homepage.getHomepage_id());
		List<BookPackageBundle> bookPackageBundleList = null;
		
		if(bookPackageBundle.getEditMode().equals("bookPackage")) {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleExcelList(bookPackageBundle);
		} else if (bookPackageBundle.getEditMode().equals("bookPackageLoan")) {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleLoanExcelList2(bookPackageBundle);
		} else {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleLoanExcelList(bookPackageBundle);
		}
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);

		return new BookPackageBundleView();
	}
	
}
