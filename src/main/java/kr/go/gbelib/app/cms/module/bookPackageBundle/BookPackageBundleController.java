package kr.go.gbelib.app.cms.module.bookPackageBundle;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller
@RequestMapping(value = {"/cms/module/bookPackageBundle"})
public class BookPackageBundleController extends BaseController {
	
	private final String basePath = "/cms/module/bookPackageBundle/";

	@Autowired
	private BookPackageBundleService bookPackageBundleService;
	
	@RequestMapping (value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		}
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		int count = bookPackageBundleService.getBookPackageDetailCount(bookPackageBundle);
		bookPackageBundleService.setPaging(model, count, bookPackageBundle);
		bookPackageBundle.setTotalDataCount(count);
		
		List<BookPackageBundle> bookPackageDetailList = bookPackageBundleService.getBookPackageDetailList(bookPackageBundle);
		List<BookPackageBundle> bookPackageCategoryList = bookPackageBundleService.getBookPackageCategoryList(bookPackageBundle);
		
		bookPackageDetail(bookPackageDetailList);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageDetailList);
		model.addAttribute("bookPackageCategoryList", bookPackageCategoryList);

		return basePath + "index";
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

	@RequestMapping (value = {"/bundleList.*"}, method = RequestMethod.GET)
	public String bundleList(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		}
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		int count = bookPackageBundleService.getBookPackageBundleDetailCount(bookPackageBundle);
		bookPackageBundleService.setPaging(model, count, bookPackageBundle);
		bookPackageBundle.setTotalDataCount(count);
		
		List<BookPackageBundle> bundleList = bookPackageBundleService.getBookPackageBundleDetailList(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bundleList", bundleList);
		
		return basePath + "bundleList";
	}


	@RequestMapping(value = { "/bookPackageBundleDetail.*" })
	public String bookPackageBundleDetail(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		
		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		}
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		List<BookPackageBundle> bookPackageDetailList = bookPackageBundleService.getBookPackage(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageDetailList", bookPackageDetailList);
		
		return basePath + "bookPackageBundleDetail_ajax";
	}

	@RequestMapping(value = { "/getBookDetail.*" })
	public String getBookDetail(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		
		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		}
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		bookPackageBundle = bookPackageBundleService.getBookDetail(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		
		return basePath + "bookDetail_ajax";
	}

	@RequestMapping(value = { "/bookPackageBundleEdit.*" })
	public String bookSettingEdit(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {

		if (bookPackageBundle == null) {
			bookPackageBundle = new BookPackageBundle();
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		}

		model.addAttribute("bookPackageBundle", bookPackageBundle);

		return basePath + "bookPackageBundleEdit_ajax";
	}

	@RequestMapping (value = {"/bookPackageBundleSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse bookPackageBundleSave(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);

		ValidationUtils.rejectIfEmpty(result, "book_package_bundle_title", "학생추천도서 꾸러미 제목를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "grade", "수준별 보기를 선택해주세요.");
		
		if (!result.hasErrors()) {
			if(bookPackageBundleService.createBookPackageBundle(bookPackageBundle) > 0) {
				res.setValid(true);
				res.setMessage("저장 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("저장에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = { "/bookPackageBundleModify.*" })
	public String bookPackageBundleModify(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		BookPackageBundle bookPackageBundleDetail = bookPackageBundleService.getBookPackageBundleOne(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundleDetail);
		
		return basePath + "bookPackageBundleModify_ajax";
	}
	
	@RequestMapping (value = {"/modifyBookPackageBundle.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyBookPackageBundle(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "book_package_bundle_title", "학생추천도서 꾸러미 제목를 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "grade", "수준별 보기를 선택해주세요.");
		ValidationUtils.rejectIfEmpty(result, "loan_count", "대출가능권수를 선택해주세요.");
		ValidationUtils.rejectIfEmpty(result, "quantity", "소장권수를 선택해주세요.");
		
		if (!result.hasErrors()) {
			if(bookPackageBundleService.modifyBookPackageBundle(bookPackageBundle) > 0) {
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("수정에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(!result.hasErrors()) {
			bookPackageBundleService.deleteBookPackageBundle(bookPackageBundle);
			bookPackageBundleService.deleteBookPackageBundleDetail(bookPackageBundle);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	@RequestMapping(value = {"/deleteBook.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteBook(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(!result.hasErrors()) {
			bookPackageBundleService.deleteBookDetail(bookPackageBundle);
			bookPackageBundleService.deleteBook(bookPackageBundle);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}

	@RequestMapping(value = { "/getBookPackage.*" })
	public String getBookPackage(Model model, LibrarySearch librarySearch, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		List<BookPackageBundle> bookPackageBundleList = bookPackageBundleService.getBookPackageBundleList(bookPackageBundle);

		bookPackageBundle = bookPackageBundleService.getBookDetail(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);

		return basePath + "bundleEdit_ajax";
	}

	@RequestMapping (value = {"/addBookPackageDetail.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse addBookPackageDetail(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		
		if (!result.hasErrors()) {
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
			if(bookPackageBundleService.addBookPackageDetail(bookPackageBundle) > 0) {
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping(value = { "/getBookPackageAll.*" })
	public String getBookPackageAll(Model model, LibrarySearch librarySearch, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		List<BookPackageBundle> bookPackageBundleList = bookPackageBundleService.getBookPackageBundleList(bookPackageBundle);
		
		List<BookPackageBundle> bookPackageDetailList = bookPackageBundleService.getBookDetailAll(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageDetailList", bookPackageDetailList);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);
		
		return basePath + "bundleEditAll_ajax";
	}
	
	@RequestMapping (value = {"/addBookPackageDetailAll.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse addBookPackageDetailAll(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		JsonResponse res = new JsonResponse(request);
		
		List<BookPackageBundle> detailList = bookPackageBundleService.getDetailList(bookPackageBundle);
		
		if (!result.hasErrors()) {
			for(int i = 0; i < detailList.size(); i++) {
				bookPackageBundle.setBook_package_bundle_detail_idx(detailList.get(i).getBook_package_bundle_detail_idx());
				int addResult = bookPackageBundleService.addBookPackageDetail(bookPackageBundle);
				if(addResult > 0) {
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				} else {
					res.setValid(false);
					res.setMessage("등록에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}
	
	@RequestMapping (value = {"/modifyBook.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyBook(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));

		JsonResponse res = new JsonResponse(request);

		if (!result.hasErrors()) {
			bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
			if(bookPackageBundleService.modifyBook(bookPackageBundle) > 0) {
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else {
				res.setValid(false);
				res.setMessage("수정에 실패하였습니다.\n관리자에게 문의해주세요.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		return res;
	}

	@RequestMapping(value = { "/addBook.*" })
	public String addBook(Model model, LibrarySearch librarySearch, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		
		return basePath + "addBook_ajax";
	}

	@RequestMapping(value = { "/getBookPackageOne.*" })
	public String getBookPackageOne(Model model, LibrarySearch librarySearch, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		List<BookPackageBundle> bookPackageBundleList = bookPackageBundleService.getBookPackageBundleList(bookPackageBundle);
		
		bookPackageBundle = bookPackageBundleService.getBookPackageDetailOne(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);
		
		return basePath + "bookPackage_ajax";
	}
	
	@RequestMapping (value = {"/search.*"}, method = RequestMethod.GET)
	public String search(Model model, LibrarySearch librarySearch, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> map = null;
		if (StringUtils.isNotEmpty(librarySearch.getSearch_text())) {
			map = LibSearchAPI.getNaverList(librarySearch);
			int totalCount = (Integer) map.get("totalCount");
			@SuppressWarnings ("unchecked")
			List<Map<String, Object>> itemList = (List<Map<String, Object>>) map.get("list");
			if (itemList != null && itemList.size() > 0) {
				for (Map<String, Object> map2 : itemList) {
					String[] isbnArr = String.valueOf(map2.get("isbn")).split(" ");
					for (int i = 0; i < isbnArr.length; i++) {
						String isbn = String.valueOf(map2.get("isbn")).split(" ")[i];
						map2.put("isbn"+isbn.length(), isbn);

						LibrarySearch bookSerach = new LibrarySearch();
						bookSerach.setIsbn(isbn);
						Map<String, Object> sameBook = (Map<String, Object>) LibSearchAPI.getBookDetail(bookSerach);

						int sameBookCount = LibSearchAPI.getSearchCount(sameBook);

						if (sameBookCount > 0) {
							map2.put("already"+isbn.length(), true);
						}

					}

				}
				bookPackageBundleService.setPaging(model, totalCount, librarySearch);
				model.addAttribute("naverResult", map);
			}
		}
		
		model.addAttribute("librarySearch", librarySearch);
		
		return basePath + "search_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "book_package_name", "이름을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "category", "주류별을 선택해주세요.");

		if (!result.hasErrors()) {
			bookPackageBundleService.addBookPackageBundle(bookPackageBundle);
			res.setValid(true);
			res.setMessage("등록되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}

	@RequestMapping (value = {"/saveBook.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveBook(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "book_package_name", "도서명을 입력하세요.");
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			bookPackageBundleService.addBook(bookPackageBundle);
			res.setValid(true);
			res.setMessage("등록되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/modifyBookPackage.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse modifyBookPackage(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		ValidationUtils.rejectIfEmpty(result, "book_package_name", "이름을 입력하세요.");
		ValidationUtils.rejectIfEmpty(result, "category", "주류별을 선택해주세요.");

		if (!result.hasErrors()) {
			bookPackageBundleService.modifyBookPackage(bookPackageBundle);
			res.setValid(true);
			res.setMessage("수정되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/loanList.*"}, method = RequestMethod.GET)
	public String bookPackageLoanList(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		
		bookPackageBundleService.setPaging(model, bookPackageBundleService.getBookPackageLoanCount(bookPackageBundle), bookPackageBundle);
		
		List<BookPackageBundle> bookPackageCategoryList = bookPackageBundleService.getBookPackageCategoryList(bookPackageBundle);
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("loanList", bookPackageBundleService.getBookPackageLoanList(bookPackageBundle));
		model.addAttribute("bookPackageCategoryList", bookPackageCategoryList);

		return basePath + "loanList";
	}
	
	@RequestMapping(value = {"/loanEdit.*"})
	public String bookPackageReq(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request) throws AuthException {
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
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, 5);
			
			bookPackageBundle = (BookPackageBundle)bookPackageBundleService.copyObjectPaging(bookPackageBundle, bookPackageBundleService.getBookPackageOne(bookPackageBundle));
			bookPackageBundle.setLoan_start_date(sdf.format(cal.getTime()));
			
			if(bookPackageBundle.getLender_count() > 0) {
				bookPackageBundle.setRequest_status("1");
			}
			
			model.addAttribute("bookPackageBundle", bookPackageBundle);
		}
		
		return basePath + "loanEdit_ajax";
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
				res.setMessage("등록되었습니다.");
			} else if (bookPackageBundle.getEditMode().equals("MODIFY")) {
				bookPackageBundle.setModify_id(getSessionMemberId(request));
				bookPackageBundleService.modifyBookPackageLoan(bookPackageBundle);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (bookPackageBundle.getEditMode().equals("DELETE")) {
				bookPackageBundleService.deleteBookPackageLoan(bookPackageBundle);
				res.setValid(true);
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
	public BookPackageBundleView excelDownload(Model model, BookPackageBundle bookPackageBundle, HttpServletRequest request){
		bookPackageBundle.setHomepage_id(getAsideHomepageId(request));
		List<BookPackageBundle> bookPackageBundleList = null;
		
		if(bookPackageBundle.getEditMode().equals("bookPackage")) {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleExcelList(bookPackageBundle);
		} else if(bookPackageBundle.getEditMode().equals("bundleList")) {
			bookPackageBundleList = bookPackageBundleService.bundleExcelList(bookPackageBundle);
		} else if (bookPackageBundle.getEditMode().equals("bookPackageLoan")) {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleLoanExcelList2(bookPackageBundle);
		} else {
			bookPackageBundleList = bookPackageBundleService.getBookPackageBundleLoanExcelList(bookPackageBundle);
		}
		
		model.addAttribute("bookPackageBundle", bookPackageBundle);
		model.addAttribute("bookPackageBundleList", bookPackageBundleList);
		
		return new BookPackageBundleView();
	}
	
	@RequestMapping(value = {"/deleteBookPackageDetail.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse deleteBookPackageDetail(BookPackageBundle bookPackageBundle, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		if(!result.hasErrors()) {
			bookPackageBundleService.deleteBookPackageBundleDetailOne(bookPackageBundle);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}