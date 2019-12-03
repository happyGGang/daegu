package kr.go.gbelib.app.cms.module.elib.book;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategory;
import kr.go.gbelib.app.cms.module.elib.category.ElibCategoryService;
import kr.go.gbelib.app.cms.module.elib.code.ElibCode;
import kr.go.gbelib.app.cms.module.elib.code.ElibCodeService;
import kr.go.gbelib.app.cms.module.elib.lending.LendingAutoReturnService;
import kr.go.gbelib.app.cms.module.elib.member.ElibMember;
import kr.go.gbelib.app.cms.module.elib.member.ElibMemberService;
import kr.go.gbelib.app.common.api.MemberAPI;

@Controller
public class BookController extends BaseController {
	
	private final String basePath = "/cms/module/elib/book/";

	@Autowired
	private BookService service;
	
	@Autowired
	private ElibCategoryService elibCategoryService;
	
	@Autowired
	private ElibCodeService elibCodeService;
	
	@Autowired
	private LendingAutoReturnService lendingAutoReturnService;
	
	@Autowired
	private ElibMemberService elibMemberService;
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/index.*"})
	public String book_index(Model model, @PathVariable String type, Book book, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		book.setHomepage_id(getAsideHomepageId(request));
		
		book.setType(type);
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		int count = service.getBookListCntCms(book);
		service.setPaging(model, count, book);
		List<Book> bookList = service.getBookListCms(book);
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/edit.*"})
	public String book_edit(Model model, Book book, HttpServletRequest request) throws AuthException {
		book.setHomepage_id(getAsideHomepageId(request));	
		
		if(book.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			book = (Book) service.copyObjectPaging(book, service.getBookInfo(book));
		} else {
			checkAuth("C", model, request);
		}
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, Book book, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = book.getEditMode();
		if(!(editMode.equals("DELETE") || editMode.equals("ADDBESTBOOK") || editMode.equals("DELETEBESTBOOK")
				|| editMode.equals("ADDCATBESTBOOK") || editMode.equals("DELETECATBESTBOOK"))) {
			ValidationUtils.rejectIfEmpty(result, "book_code", "책코드를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_name", "제목을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "author_name", "저자를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "book_pubname", "출판사를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "isbn13", "ISBN을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "format", "포맷을 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "book_image", "서적 이미지를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "book_pubdt", "출판일자를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "", "공급사를 입력하세요.");
//			ValidationUtils.rejectIfEmpty(result, "", "도서관을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "max_lend", "최대대출권수를 입력하세요.");
		}
		if(!result.hasErrors()) {
//			if ( Integer.parseInt(getSessionMemberInfo(request).getAuth_id()) <= 200 ) {
				if(editMode.equals("ADD")) {
					book.setAdd_id(getSessionMemberId(request));
					service.addBook(book);
					res.setValid(true);
					res.setMessage("등록 되었습니다.");
				}
				else if(editMode.equals("MODIFY")) {
					book.setModify_id(getSessionMemberId(request));
					service.modifyBook(book);
					res.setValid(true);
					res.setMessage("수정 되었습니다.");
				}
				else if(editMode.equals("DELETE")) {
					service.deleteBook(book);
					res.setValid(true);
					res.setMessage("삭제 되었습니다.");
				}
//			}
//			else {
//				res.setValid(false);
//				res.setMessage("권한이 없습니다.");
//			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/excelDownload.*"}, method = RequestMethod.POST)
	public BookExcelView excel(Model model, Book book, HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE") || StringUtils.equals(sortField, "book_name")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		model.addAttribute("book", book); 
		model.addAttribute("bookList", service.getBookListAll(book));
		return new BookExcelView();
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/{type}/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, Book book, HttpServletRequest request, HttpServletResponse response) throws Exception{
		if(book.getSortType() == null) book.setSortType("ASC");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE") || StringUtils.equals(sortField, "book_name")) {
			book.setSortField("book_name");
			book.setSortType("ASC");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		List<Book> bookList = service.getBookListAll(book);
		
		new BookXlsToCsv(book, bookList, "콘텐츠 목록.csv", request, response);
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/upload_index.*"})
	public String upload_index(Model model, Book book, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		book.setHomepage_id(getAsideHomepageId(request));
		
		if(book.getSortType() == null) book.setSortType("ASC");
		
		book.setApproved_yn("N");
		
		String sortField = book.getSortField();
		if(StringUtils.equals(sortField, "TITLE")) {
			book.setSortField("book_name");
		} else if(StringUtils.equals(sortField, "lend_total")) {
			book.setSortType("DESC");
		}
		
		int count = service.getBookListCntUpload(book);
		service.setPaging(model, count, book);
		List<Book> bookList = service.getBookListUpload(book);
		
		model.addAttribute("book", book);
		model.addAttribute("obj", book);
		model.addAttribute("bookListCnt", count);
		model.addAttribute("bookList", bookList);
		model.addAttribute("cateList", elibCategoryService.getCategoryList(new ElibCategory(book.getType())));
		model.addAttribute("compList", elibCodeService.getCompList(new ElibCode(book.getType())));
		
		return basePath + "upload_index";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/result.*"})
	public String result(Model model, Book book, MultipartHttpServletRequest request, HttpServletResponse response) throws AuthException, IOException {
		checkAuth("C", model, request);
		
		List<String> logs = service.upload(model, request, response);
		
		model.addAttribute("logs", logs);
		
		return basePath + "result";
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/approve.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse approve(Model model, Book book, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		service.approveBook(book);
		res.setValid(true);
		res.setMessage("승인되었습니다.");
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/approve_all.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse approveAll(Model model, Book book, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		service.approveBookAll(book);
		res.setValid(true);
		res.setMessage("전체 승인되었습니다.");
		
		return res;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/auto_return.*"})
	public void autoReturn(Model model, HttpServletRequest request, HttpServletResponse response) {
		lendingAutoReturnService.autoReturn();
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/auto_update_lendable_dt.*"})
	public void autoUpdateLendableDt(Model model, HttpServletRequest request, HttpServletResponse response) {
		lendingAutoReturnService.autoUpdateLendableDt();
	}
	
	private Map<String, String> getMember(ElibMember elibMember) {
		Member member = new Member();
		member.setUser_id(elibMember.getP_id());
//		member.setCheck_certify_type("WEBID");
//		member.setCheck_certify_data(elibMember.getMember_id());
		Map<String, String> data = MemberAPI.getMember("WEB", member);
		return data;
	}
	
	@RequestMapping(value = {"/cms/module/elib/book/fill_in_members.*"})
	public void fillInMembers(Model model, HttpServletRequest request, HttpServletResponse response) {
		List<ElibMember> list = elibMemberService.getMemberList();
		
		if(list != null) {
			for(ElibMember member: list) {
				if(StringUtils.isEmpty(member.getSex())) {
					Map<String, String> data = getMember(member);
					if(data == null) continue;
					
//					System.out.println("@@@@@@@@@@ fillInMembers member.getMember_id(): " + member.getMember_id());
//					System.out.println("@@@@@@@@@@ fillInMembers data.get(\"SEX\"): " + data.get("SEX"));
//					System.out.println("@@@@@@@@@@ fillInMembers data.get(\"BIRTHD\"): " + data.get("BIRTHD"));
					member.setSex(data.get("SEX"));
					member.setBirth_day(data.get("BIRTHD"));
					
					elibMemberService.modifyMember(member);
				}
			}
		}
		
	}
	
}
