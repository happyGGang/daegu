package kr.go.gbelib.app.module.bookPackage;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackage;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackageService;
import kr.go.gbelib.app.cms.module.bookPackage.BookPackageView;
import kr.go.gbelib.app.cms.module.supportMember.SupportMember;
import kr.go.gbelib.app.common.api.LibSearchAPI;
import kr.go.gbelib.app.intro.search.LibrarySearch;

@Controller(value = "userBookPackage")
@RequestMapping(value = {"/{homepagePath}/module/bookPackage"})
public class BookPackageController extends BaseController {
	
	private String basePath = "/homepage/%s/module/bookPackage/";
	
	@Autowired
	private BookPackageService service;
	
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
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, BookPackage bookPackage, HttpServletRequest request) {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		if(bookPackage.getEditMode().equals("MODIFY")) {
			int menu_idx = bookPackage.getMenu_idx();
			bookPackage = (BookPackage)service.copyObjectPaging(bookPackage, service.getBookPackageOne(bookPackage));
			bookPackage.setMenu_idx(menu_idx);
		}
		model.addAttribute("bookPackage", bookPackage);
		
		return String.format(basePath, homepage.getFolder()) + "edit";
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
			if (bookPackage.getEditMode().equals("ADD")) {
				bookPackage.setAdd_id(sessionLoginSupport(request).getMember_id());
				service.addBookPackage(bookPackage);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx());
				res.setMessage("등록되었습니다.");
			} else if (bookPackage.getEditMode().equals("MODIFY")) {
				bookPackage.setModify_id(sessionLoginSupport(request).getMember_id());
				service.modifyBookPackage(bookPackage);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx()+"&viewPage="+bookPackage.getViewPage());
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
		SupportMember loginSupport = sessionLoginSupport(request);
		
		if (loginSupport == null && !getSessionIsAdmin(request)) {
    		bookPackage.setBefore_url(String.format("/%s/module/bookPackage/loanList.do?menu_idx=%s", homepage.getContext_path(), bookPackage.getMenu_idx()));
    		service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackage.getMenu_idx(), bookPackage.getBefore_url()), request, response);
    		return null;
        }
		
		if(!getSessionIsAdmin(request) && !loginSupport.getAuth_group().equals("1")) {
			bookPackage.setAdd_id(loginSupport.getMember_id());
		}
		service.setPaging(model, service.getBookPackageLoanCount(bookPackage), bookPackage);
		
		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("loanList", service.getBookPackageLoanList(bookPackage));

		return String.format(basePath, homepage.getFolder()) + "loanList";
	}
	
	@RequestMapping(value = {"/loanEdit.*"})
	public String bookPackageReq(Model model, BookPackage bookPackage, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		SupportMember loginSupport = sessionLoginSupport(request);
		if (loginSupport == null && !getSessionIsAdmin(request)) {
    		bookPackage.setBefore_url(String.format("/%s/module/bookPackage/index.do?menu_idx=%s", homepage.getContext_path(), bookPackage.getMenu_idx()));
    		service.alertMessageAndUrl("학교도서관 회원인증 후 이용가능합니다.", String.format("/%s/module/supportMember/index.do?menu_idx=%s&before_url=%s", homepage.getContext_path(), bookPackage.getMenu_idx(), bookPackage.getBefore_url()), request, response);
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
			
			bookPackage.setSchool_name(loginSupport != null ? loginSupport.getSchool_name() : "관리자");
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
			String session_id = getSessionIsAdmin(request) ? getSessionMemberId(request) : sessionLoginSupport(request).getMember_id();
			if (bookPackage.getEditMode().equals("ADD")) {
				bookPackage.setAdd_id(session_id);
				service.addBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("index.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx());
				res.setMessage("등록되었습니다.");
			} else if (bookPackage.getEditMode().equals("MODIFY")) {
				bookPackage.setModify_id(session_id);
				service.modifyBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx() + "&viewPage="+bookPackage.getViewPage() + "&rowCount="+bookPackage.getRowCount());
				res.setMessage("수정되었습니다.");
			} else if (bookPackage.getEditMode().equals("DELETE")) {
				service.deleteBookPackageLoan(bookPackage);
				res.setValid(true);
				res.setUrl("loanList.do");
				res.setData("menu_idx="+bookPackage.getMenu_idx() + "&viewPage="+bookPackage.getViewPage() + "&rowCount="+bookPackage.getRowCount());
				res.setMessage("취소되었습니다.");
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
		SupportMember sm = sessionLoginSupport(request);
		
		if(sm != null && !sm.getAuth_group().equals("1")) {
			bookPackage.setAdd_id(sm.getMember_id());
		}
		
		List<BookPackage> bookPackageList = null;
		if(bookPackage.getEditMode().equals("bookPackage")) {
			bookPackageList = service.getBookPackageExcelList(bookPackage);
		} else {
			bookPackageList = service.getBookPackageLoanExcelList(bookPackage);
		}
		
		model.addAttribute("bookPackage", bookPackage);
		model.addAttribute("bookPackageList", bookPackageList);

		return new BookPackageView();
	}
	
	@RequestMapping(value= {"/mysqlToTibero.*"}, method = RequestMethod.GET)
	public void mysqlToTibero(Model model, BookPackage bookPackage, HttpServletRequest request) {
		List<Map<String, Object>> listMap = service.getMysqlToTibero();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		for (Map<String, Object> map : listMap) {
			BookPackage bp = new BookPackage();
			
			bp.setBook_package_idx(Integer.parseInt(String.valueOf(map.get("b_num"))));
			bp.setBook_package_name(String.valueOf(map.get("b_name")));
			bp.setBook_package_subject(String.valueOf(map.get("b_subject")));
			bp.setAuthor(String.valueOf(map.get("b_temp1")));
			bp.setPublisher(String.valueOf(map.get("b_temp2")));
			
			String b3 = String.valueOf(map.get("b_temp3"));
			try {
				bp.setPublish_year(Integer.parseInt(b3));
			} catch(NumberFormatException e) {
				bp.setPublish_year(1900);
			}
			
			bp.setIsbn(String.valueOf(map.get("b_temp4")));
			
			String b5 = String.valueOf(map.get("b_temp5")).replace(",", "");
			try {
				bp.setBook_price(Integer.parseInt(b5));
			} catch(NumberFormatException e) {
				bp.setBook_price(0);
			}
			String b7 = String.valueOf(map.get("b_temp7")).replace(",", "").trim();
			if(StringUtils.isNotEmpty(b7)) {
				bp.setBook_pages(Integer.parseInt(b7));
			} else {
				bp.setBook_pages(0);
			}
			
			bp.setPurpose(String.valueOf(map.get("b_temp8")));
			String b12 = String.valueOf(map.get("b_temp12"));
			if(StringUtils.isNotEmpty(b12)) {
				bp.setLoan_count(Integer.parseInt(b12));
			}
			String b15 = String.valueOf(map.get("b_temp15"));
			if(StringUtils.isNotEmpty(b15)) {
				bp.setQuantity(Integer.parseInt(b15));
			}
			bp.setGrade(String.valueOf(map.get("b_temp9")));
			
			String keyword = String.valueOf(map.get("b_temp10"));
			String [] keyarr = keyword.split(",");
			keyword = "";
			for (String key : keyarr) {
				
				if(key.equals("6")) {
					keyword += ",000";
				} else if(key.equals("7")) {
					keyword += ",100";
				} else if(key.equals("8")) {
					keyword += ",200";
				} else if(key.equals("9")) {
					keyword += ",300";
				} else if(key.equals("10")) {
					keyword += ",400";
				} else if(key.equals("11")) {
					keyword += ",500";
				} else if(key.equals("12")) {
					keyword += ",600";
				} else if(key.equals("13")) {
					keyword += ",700";
				} else if(key.equals("14")) {
					keyword += ",800";
				} else if(key.equals("15")) {
					keyword += ",900";
				}
			}
			
			bp.setCategory(keyword.equals("") ? null : keyword.substring(1));
			bp.setKeyword(String.valueOf(map.get("b_temp11")));
			bp.setDesc_link(String.valueOf(map.get("b_temp13")));
			bp.setImage_link(String.valueOf(map.get("b_temp14")));
			bp.setContent(String.valueOf(map.get("b_content")));
			bp.setOrg_file_name(String.valueOf(map.get("b_file1")));
			
			String file_name = String.valueOf(map.get("b_file1"));
			if(StringUtils.isNotEmpty(file_name)) {
				try {
					
					File f = new File("C:\\Users\\whalesoft\\Desktop\\대구시통합도서관\\image\\board_12\\" + file_name);
					FileInputStream is = new FileInputStream(f);
					MultipartFile mp = new MockMultipartFile("file", f.getName(), "text/plain", IOUtils.toByteArray(is));
					bp.setMfile(mp);
				} catch (FileNotFoundException e1) {
					e1.printStackTrace();
				} catch(IOException e2) {
					e2.printStackTrace();
				}
			}
			
			try {
				bp.setAdd_date(sdf.parse(String.valueOf(map.get("b_regdate"))));
				bp.setAdd_id(String.valueOf(map.get("b_id")));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			System.out.println("@@@@@@@@@@@@@@ data : " + bp.toString());
			service.addMysqlToTibero(bp);
			
		}
		
		
		List<Map<String, Object>> listMap2 = service.getMysqlToTibero2();;
		
		for (Map<String, Object> map2 : listMap2) {
			BookPackage bp = new BookPackage();
			
			bp.setBook_package_idx(Integer.parseInt(String.valueOf(map2.get("b_num"))));
			bp.setBook_package_loan_idx(Integer.parseInt(String.valueOf(map2.get("bb_num"))));
			bp.setRequest_name(String.valueOf(map2.get("bb_manager")));
			bp.setSchool_name(String.valueOf(map2.get("bb_school")));
			bp.setLoan_start_date(String.valueOf(map2.get("bb_sdate")));
			bp.setLoan_end_date(String.valueOf(map2.get("bb_edate")) == "" ? String.valueOf(map2.get("bb_sdate")) : String.valueOf(map2.get("bb_edate")));
			bp.setPhone(String.valueOf(map2.get("bb_phone")));
			String school_tel = String.valueOf(map2.get("bb_school_tel"));
			bp.setSchool_tel(StringUtils.isEmpty(school_tel) ? "053-0000-0000" : school_tel);
			bp.setRequest_content(String.valueOf(map2.get("bb_content")));
			bp.setRequest_status(String.valueOf(map2.get("bb_status")));
			bp.setReturn_yn(String.valueOf(map2.get("bb_return")) == "" ? "N" : String.valueOf(map2.get("bb_return")));
			
			try {
				bp.setAdd_date(sdf.parse(String.valueOf(map2.get("bb_regdate"))));
				bp.setAdd_id(String.valueOf(map2.get("m_id")));
			} catch(ParseException e) {
				e.printStackTrace();
			}
			
//			System.out.println("@@@@@@@@@@@@@@ data2 : " + bp.toString2());
//			service.addMysqlToTibero2(bp);
		}
	}

}
