package kr.go.gbelib.app.cms.module.bookReportContest;

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
@RequestMapping(value = {"/cms/module/bookReportContest"})
public class BookReportContestController extends BaseController {
	
	private final String basePath = "/cms/module/bookReportContest/";

	@Autowired
	private BookReportContestService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookReportContest bookReportContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookReportContest.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bookReportContestCount(bookReportContest), bookReportContest);
		
		model.addAttribute("bookReportContest", bookReportContest);
		model.addAttribute("bookReportContestList", service.bookReportContestList(bookReportContest));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookReportContest bookReportContest, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookReportContest.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookReportContest", bookReportContest);
		model.addAttribute("getBookReportContest", service.getBookReportContest(bookReportContest));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookReportContest bookReportContest, HttpServletRequest request) throws Exception {
		bookReportContest.setHomepage_id(getAsideHomepageId(request));
		
		checkAuth("C", model, request);
		model.addAttribute("bookReportContest", bookReportContest);
		return basePath + "edit_ajax";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookReportContest bookReportContest, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookReportContest.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "participation_field", "참가분야를 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "user_name", "성명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰(본인) 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰(본인) 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookReportContest.getProtector_phone())) {
    			ValidationUtils.rejectPhone(result, "protector_phone", "휴대폰(보호자) 번호가 올바르지 않습니다.");
    		}
    		if (StringUtils.isNotEmpty(bookReportContest.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "성명");
    		ValidationUtils.rejectIfStringLength(result, "school_name", 50, "학교");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 500, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 500, "상세주소");
		}
		
		if (!result.hasErrors()) {
			if (bookReportContest.getEditMode().equals("ADD")) {
				bookReportContest.setAdd_id(getSessionMemberId(request));
				service.addBookReportContest(bookReportContest, mpRequest);
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
	public @ResponseBody JsonResponse delete(BookReportContest bookReportContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookReportContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookReportContest.getEditMode().equals("DELETE")) {
				service.deleteBookReportContest(bookReportContest);
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
	public @ResponseBody JsonResponse statusChange(BookReportContest bookReportContest, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookReportContest.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeBookReportContest(bookReportContest);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookReportContestSearchView excel(Model model, BookReportContest bookReportContest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("bookReportContest", bookReportContest);
		model.addAttribute("bookReportContestResult", service.getExcelList(bookReportContest));
		
		return new BookReportContestSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BookReportContest bookReportContest, HttpServletRequest request, HttpServletResponse response) {
		List<BookReportContest> bookReportContestList = service.getExcelList(bookReportContest);
		
		new BookReportContestXlsToCsv(bookReportContestList, "독후감 공모 리스트.csv", request, response);
	}
	
	@RequestMapping(value = "/download/{homepage_id}/{book_report_idx}.*", method = RequestMethod.GET)
	@ResponseBody
    public byte[] getFile(@PathVariable("homepage_id") String homepage_id, @PathVariable("book_report_idx") int book_report_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BookReportContest bookReportContest = service.getBookReportContest(new BookReportContest(homepage_id, book_report_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bookReportContest.getServer_file_name();
		File file = new File(filePath);
		System.out.println(filePath);
		byte[] bytes = null;

		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}

		String fileName = String.format("%s.%s", bookReportContest.getOrg_file_name(),bookReportContest.getFile_extension() );

		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.setHeader("Content-Type", "application/octet-stream");
	    
	    return bytes;
    }
	
	@RequestMapping(value = "/download/{homepage_id}/{book_report_idx}2.*", method = RequestMethod.GET)
	@ResponseBody
	public byte[] getFile2(@PathVariable("homepage_id") String homepage_id, @PathVariable("book_report_idx") int book_report_idx, HttpServletRequest request, HttpServletResponse response) throws Exception {
		BookReportContest bookReportContest = service.getBookReportContest(new BookReportContest(homepage_id, book_report_idx));
		
		String filePath = service.getRootPath()+ "/" + homepage_id + "/" + bookReportContest.getServer_file_name2();
		File file = new File(filePath);
		System.out.println(filePath);
		byte[] bytes = null;
		
		if(file.length() > 0) {
			bytes = FileCopyUtils.copyToByteArray(file);
		} else {
			response.setHeader("Content-type", "text/html");
			service.alertMessage("파일이 존재하지 않습니다.", request, response);
			return null;
		}
		
		String fileName = String.format("%s.%s", bookReportContest.getOrg_file_name2(),bookReportContest.getFile_extension2() );
		
		response.setHeader("Content-Disposition", AttachmentUtils.getContentDisposition(fileName, request.getHeader("user-agent")));
		response.setHeader("Content-Length", Long.toString(file.length()));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", "application/octet-stream");
		
		return bytes;
	}
}
