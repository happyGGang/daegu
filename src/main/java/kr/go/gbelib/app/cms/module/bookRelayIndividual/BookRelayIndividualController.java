package kr.go.gbelib.app.cms.module.bookRelayIndividual;

import java.util.List;

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
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/bookRelayIndividual"})
public class BookRelayIndividualController extends BaseController {
	
	private final String basePath = "/cms/module/bookRelayIndividual/";

	@Autowired
	private BookRelayIndividualService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayIndividual.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bookRelayIndividualCount(bookRelayIndividual), bookRelayIndividual);
		
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);
		model.addAttribute("bookRelayIndividualList", service.bookRelayIndividualList(bookRelayIndividual));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayIndividual.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);
		model.addAttribute("getBookRelayIndividual", service.getBookRelayIndividual(bookRelayIndividual));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request) throws Exception {
		
		if(bookRelayIndividual.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("bookRelayIndividual", service.copyObjectPaging(bookRelayIndividual, service.getBookRelayIndividual(bookRelayIndividual)));
			return basePath + "edit";
		} else {
			bookRelayIndividual.setHomepage_id(getAsideHomepageId(request));
			
			checkAuth("C", model, request);
			model.addAttribute("bookRelayIndividual", bookRelayIndividual);
			return basePath + "edit_ajax";
			
		}
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayIndividual bookRelayIndividual, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayIndividual.getEditMode().equals("ADD") || bookRelayIndividual.getEditMode().equals("MODIFY") ) {
    		ValidationUtils.rejectIfEmpty(result, "user_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "reader_contest", "다독자 공모를 선택하세요.");
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (StringUtils.isNotEmpty(bookRelayIndividual.getUser_email())) {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "user_name", 20, "이름");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "user_affiliation", 50, "소속명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레리 계획");
		}
		
		if (!result.hasErrors()) {
			if (bookRelayIndividual.getEditMode().equals("ADD")) {
				bookRelayIndividual.setAdd_id(getSessionMemberId(request));
				service.addBookRelayIndividual(bookRelayIndividual);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
			} else if (bookRelayIndividual.getEditMode().equals("MODIFY")) {
				bookRelayIndividual.setModify_id(getSessionMemberId(request));
				service.modifyBookRelayIndividual(bookRelayIndividual);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
				res.setUrl("index.do");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
	@RequestMapping (value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(BookRelayIndividual bookRelayIndividual, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayIndividual.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookRelayIndividual.getEditMode().equals("DELETE")) {
				service.deleteBookRelayIndividual(bookRelayIndividual);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}	
		
	
	@RequestMapping (value = {"/statusChange.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusChange(BookRelayIndividual bookRelayIndividual, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayIndividual.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeBookRelayIndividual(bookRelayIndividual);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	@RequestMapping(value = {"/excelDownload.*"}, method = RequestMethod.POST)
	public BookRelayIndividualSearchView excel(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("bookRelayIndividual", bookRelayIndividual);
		model.addAttribute("bookRelayIndividualResult", service.getExcelList(bookRelayIndividual));
		
		return new BookRelayIndividualSearchView();
	}

	@RequestMapping(value = {"/csvDownload.*"}, method = RequestMethod.POST)
	public void csv(Model model, BookRelayIndividual bookRelayIndividual, HttpServletRequest request, HttpServletResponse response) {
		List<BookRelayIndividual> bookRelayIndividualList = service.getExcelList(bookRelayIndividual);
		
		new BookRelayIndividualXlsToCsv(bookRelayIndividualList, "독서릴레이-개인 리스트.csv", request, response);
	}
	
}
