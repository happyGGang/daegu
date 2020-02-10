package kr.go.gbelib.app.cms.module.pictureBook;

import java.util.Calendar;
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
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping(value = {"/cms/module/pictureBook"})
public class PictureBookController extends BaseController {
	
	private final String basePath = "/cms/module/pictureBook/";
	
	@Autowired
	private PictureBookService service;
	
	@RequestMapping (value = {"/index{url}.*"}, method = RequestMethod.GET)
	public String index(Model model, PictureBook pictureBook, HttpServletRequest request, @PathVariable("url") String url) {
		
		service.setPaging(model, service.getPictureBookCount(pictureBook), pictureBook);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookList", service.getPictureBookList(pictureBook));

		return basePath + "index" + url;
	}
	
	@RequestMapping (value = {"/view{url}.*"}, method = RequestMethod.GET)
	public String view(Model model, PictureBook pictureBook, HttpServletRequest request,  @PathVariable("url") String url) throws AuthException {
		checkAuth("R", model, request);
		String loan_year = pictureBook.getLoan_year();
		
		pictureBook = (PictureBook)service.copyObjectPaging(pictureBook, service.getPictureBookOne(pictureBook));
		pictureBook.setLoan_year(loan_year);
		pictureBook.setBefore_url(url);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("loanableMonth", service.getLoanableMonth(pictureBook));

		return basePath + "view";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, PictureBook pictureBook, HttpServletRequest request) throws AuthException {
		if(pictureBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("pictureBook", service.copyObjectPaging(pictureBook, service.getPictureBookOne(pictureBook)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("pictureBook", pictureBook);
		}
		
		return basePath + "edit_ajax";
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
				service.setPaging(model, totalCount, librarySearch);
				model.addAttribute("naverResult", map);
			}
		}
		
		model.addAttribute("librarySearch", librarySearch);
		
		return basePath + "search_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(PictureBook pictureBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(!pictureBook.getEditMode().equals("DELETE")) {
    		ValidationUtils.rejectIfEmpty(result, "picture_book_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "picture_book_subject", "책꾸러미명을 입력하세요.");
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if (pictureBook.getEditMode().equals("ADD")) {
				pictureBook.setAdd_id(getSessionMemberId(request));
				service.addPictureBook(pictureBook);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (pictureBook.getEditMode().equals("MODIFY")) {
				pictureBook.setModify_id(getSessionMemberId(request));
				service.modifyPictureBook(pictureBook);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (pictureBook.getEditMode().equals("DELETE")) {
				service.deletePictureBook(pictureBook);
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
	public String loanList(Model model, PictureBook pictureBook, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		
		if(StringUtils.isEmpty(pictureBook.getPay_yn())) {
			pictureBook.setPay_yn("N");
		}
		
		service.setPaging(model, service.getPictureBookLoanCount(pictureBook), pictureBook);

		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookLoanList", service.getPictureBookLoanList(pictureBook));

		return basePath + "loanList";
	}
	
	@RequestMapping(value = {"/loanEdit.*"})
	public String loanEdit(Model model, PictureBook pictureBook, HttpServletRequest request) throws AuthException {
		if(pictureBook.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("pictureBook", service.copyObjectPaging(pictureBook, service.getPictureBookLoanOne(pictureBook)));
		} else {
			checkAuth("C", model, request);
			model.addAttribute("pictureBook", pictureBook);
		}
		
		return basePath + "loanEdit_ajax";
	}
	
	@RequestMapping (value = {"/loanSave.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse loanSave(PictureBook pictureBook, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		if(pictureBook.getEditMode().equals("ADD") || pictureBook.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "request_name", "신청자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_2", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "phone_3", "휴대폰을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_2", "학교 연락처를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "school_tel_3", "학교 연락처를 입력하세요.");
    		
    		String phone = pictureBook.getPhone_1() + "-" + pictureBook.getPhone_2() + "-" + pictureBook.getPhone_3();
			String school_tel = pictureBook.getSchool_tel_1() + "-" + pictureBook.getSchool_tel_2() + "-" + pictureBook.getSchool_tel_3();
			pictureBook.setPhone(phone);
			pictureBook.setSchool_tel(school_tel);
			
			Pattern pattern1 = Pattern.compile("^01[0|1|6|7|8|9]-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher1 = pattern1.matcher(pictureBook.getPhone());
    		if (!matcher1.matches()) {
    			result.rejectValue("phone_2", "휴대폰 형식이 올바르지 않습니다.");
    		}
    		
			Pattern pattern2 = Pattern.compile("^[\\d]{2,3}-?[\\d]{3,4}-?[\\d]{4}$");
    		Matcher matcher2 = pattern2.matcher(pictureBook.getSchool_tel());
    		if (!matcher2.matches()) {
    			result.rejectValue("school_tel_2", "학교 연락처 형식이 올바르지 않습니다.");
    		}
    		
		}
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			if(pictureBook.getEditMode().equals("ADD") || pictureBook.getEditMode().equals("MODIFY")) {
				int loan_year = Integer.parseInt(pictureBook.getLoan_year());
				int loan_month = Integer.parseInt(pictureBook.getLoan_month());
				
				Calendar cal = Calendar.getInstance();
				cal.set(loan_year, loan_month-1, 1);
				pictureBook.setLoan_start_date(loan_year + "-" + loan_month + "-" + "01");
				pictureBook.setLoan_end_date(loan_year + "-" + loan_month + "-" + cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			}
			
			if (pictureBook.getEditMode().equals("ADD")) {
				pictureBook.setAdd_id(getSessionMemberId(request));
				service.addPictureBookLoan(pictureBook);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			} else if (pictureBook.getEditMode().equals("MODIFY")) {
				pictureBook.setModify_id(getSessionMemberId(request));
				service.modifyPictureBookLoan(pictureBook);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			} else if (pictureBook.getEditMode().equals("DELETE")) {
				service.deletePictureBookLoan(pictureBook);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			} else if(pictureBook.getEditMode().equals("status")) {
				service.statusChangeAll(pictureBook);
				res.setValid(true);
				res.setMessage("상태가 모두 변경되었습니다.");
				res.setReload(true);
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public PictureBookView excel(Model model, PictureBook pictureBook, HttpServletRequest request, HttpServletResponse response) throws Exception{
		List<PictureBook> pictureBookLoanList = service.getPictureBookLoanExcelList(pictureBook);
		
		model.addAttribute("pictureBook", pictureBook);
		model.addAttribute("pictureBookLoanList", pictureBookLoanList);

		return new PictureBookView();
	}

}
