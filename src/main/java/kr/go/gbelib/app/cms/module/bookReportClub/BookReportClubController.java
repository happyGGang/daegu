package kr.go.gbelib.app.cms.module.bookReportClub;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.AttachmentUtils;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/bookReportClub"})
public class BookReportClubController extends BaseController {
	
	private final String basePath = "/cms/module/bookReportClub/";

	@Autowired
	private BookReportClubService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookReportClub.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bookReportClubCount(bookReportClub), bookReportClub);
		
		model.addAttribute("bookReportClub", bookReportClub);
		model.addAttribute("bookReportClubList", service.bookReportClubList(bookReportClub));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookReportClub.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookReportClub", bookReportClub);
		model.addAttribute("getBookReportClub", service.getBookReportClub(bookReportClub));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookReportClub bookReportClub, HttpServletRequest request) throws Exception {
		bookReportClub.setHomepage_id(getAsideHomepageId(request));
		
		checkAuth("C", model, request);
		model.addAttribute("bookReportClub", bookReportClub);
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookReportClub bookReportClub, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookReportClub.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "participation_field", "참가분야를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "club_name", "동아리명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "rep_name", "대표자명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(제1 연락처) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(제1 연락처) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookReportClub.getUser_phone2())) {
    			ValidationUtils.rejectPhone(result, "user_phone2", "휴대폰(제2 연락처) 번호가 올바르지 않습니다.");
    		}
    		if (StringUtils.isNotEmpty(bookReportClub.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "rep_name", 20, "대표자명");
    		ValidationUtils.rejectIfStringLength(result, "club_name", 50, "동아리명");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 500, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 500, "상세주소");
		}
		
		if (!result.hasErrors()) {
			if (bookReportClub.getEditMode().equals("ADD")) {
				bookReportClub.setAdd_id(getSessionMemberId(request));
				service.addBookReportClub(bookReportClub, mpRequest);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BookReportClub bookReportClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookReportClub.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookReportClub.getEditMode().equals("DELETE")) {
				service.deleteBookReportClub(bookReportClub);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
				res.setUrl("index.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}	
	
	
	@RequestMapping (value = {"/statusChange.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusChange(BookReportClub bookReportClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookReportClub.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeBookReportClub(bookReportClub);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookReportClubSearchView excel(Model model, BookReportClub bookReportClub, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("bookReportClub", bookReportClub);
		model.addAttribute("bookReportClubResult", service.getExcelList(bookReportClub));
		
		return new BookReportClubSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BookReportClub bookReportClub, HttpServletRequest request, HttpServletResponse response) {
		List<BookReportClub> bookReportClubList = service.getExcelList(bookReportClub);
		
		new BookReportClubXlsToCsv(bookReportClubList, "독서동아리경연대회 리스트.csv", request, response);
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{book_club_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("book_club_idx") int book_club_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BookReportClub bookReportClub = service.getBookReportClub(new BookReportClub(homepage_id, book_club_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bookReportClub.getServer_file_name();
		File file = new File(filePath);
		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String fileName = String.format("%s.%s", bookReportClub.getOrg_file_name(),bookReportClub.getFile_extension() );

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");
	    
	    return bytes;
    }
	
	@RequestMapping(value = "/download/{homepage_id}/{book_club_idx}2.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile2(@PathVariable("homepage_id") String homepage_id, @PathVariable("book_club_idx") int book_club_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BookReportClub bookReportClub = service.getBookReportClub(new BookReportClub(homepage_id, book_club_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bookReportClub.getServer_file_name2();
		File file = new File(filePath);
		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String fileName = String.format("%s.%s", bookReportClub.getOrg_file_name2(), bookReportClub.getFile_extension2() );
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");
		
		return bytes;
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{book_club_idx}3.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile3(@PathVariable("homepage_id") String homepage_id, @PathVariable("book_club_idx") int book_club_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BookReportClub bookReportClub = service.getBookReportClub(new BookReportClub(homepage_id, book_club_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bookReportClub.getServer_file_name3();
		File file = new File(filePath);
		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String fileName = String.format("%s.%s", bookReportClub.getOrg_file_name3(), bookReportClub.getFile_extension3() );
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");
		
		return bytes;
	}
}
