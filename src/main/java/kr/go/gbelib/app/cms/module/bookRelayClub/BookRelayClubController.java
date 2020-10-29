package kr.go.gbelib.app.cms.module.bookRelayClub;

import javax.servlet.http.HttpServletRequest;

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
import kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList.BookRelayClubList;
import kr.go.gbelib.app.cms.module.bookRelayClub.bookRelayClubList.BookRelayClubListService;

@Controller
@RequestMapping(value = {"/cms/module/bookRelayClub"})
public class BookRelayClubController extends BaseController {
	
	private final String basePath = "/cms/module/bookRelayClub/";

	@Autowired
	private BookRelayClubService service;
	
	@Autowired
	private BookRelayClubListService listservice;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayClub.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bookRelayClubCount(bookRelayClub), bookRelayClub);
		
		model.addAttribute("bookRelayClub", bookRelayClub);
		model.addAttribute("bookRelayClubList", service.bookRelayClubList(bookRelayClub));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayClub.setHomepage_id(getAsideHomepageId(request));
		
		BookRelayClubList bookRelayClubList = new BookRelayClubList();
		bookRelayClubList.setClub_idx(bookRelayClub.getClub_idx());
		model.addAttribute("relayList", listservice.bookRelayList(bookRelayClubList));
		
		model.addAttribute("bookRelayClub", bookRelayClub);
		model.addAttribute("getBookRelayClub", service.getBookRelayClub(bookRelayClub));
		
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayClub bookRelayClub, HttpServletRequest request) throws Exception {
		
		if(bookRelayClub.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			BookRelayClubList bookRelayClubList = new BookRelayClubList();
			bookRelayClubList.setClub_idx(bookRelayClub.getClub_idx());
			model.addAttribute("relayList", listservice.bookRelayList(bookRelayClubList));
			
			model.addAttribute("bookRelayClub", service.copyObjectPaging(bookRelayClub, service.getBookRelayClub(bookRelayClub)));
			return basePath + "edit";
		} else {
			bookRelayClub.setHomepage_id(getAsideHomepageId(request));

			checkAuth("C", model, request);
			model.addAttribute("bookRelayClub", bookRelayClub);
			return basePath + "edit_ajax";
		}
		
	}

	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayClub bookRelayClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayClub.getEditMode().equals("ADD") || bookRelayClub.getEditMode().equals("MODIFY") ) {
    		ValidationUtils.rejectIfEmpty(result, "club_name", "동아리명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "leader_name", "대표자명 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_plan", "릴레이 계획을 입력하세요.");

    		for (int i = 0; i < bookRelayClub.getRelayList().size(); i++) {
    			ValidationUtils.rejectIfEmpty(result, "relayList[" + i + "].relay_name", "릴레이 명단의 " + (i + 1) + "번째 이름을 입력하세요.");
    			ValidationUtils.rejectIfEmpty(result, "relayList[" + i + "].relay_phone", "릴레이 명단의 " + (i + 1) + "번째 연락처를 입력하세요.");
			}
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		if (bookRelayClub.getUser_email() != null && bookRelayClub.getUser_email() != "") {
    			ValidationUtils.rejectNotFullEmailType(result, "user_email", "이메일이 올바르지 않습니다.");
			}
    		
    		ValidationUtils.rejectIfStringLength(result, "club_name", 100, "동아리명");
    		ValidationUtils.rejectIfStringLength(result, "user_email", 100, "이메일");
    		ValidationUtils.rejectIfStringLength(result, "leader_name", 20, "대표자명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레이 계획");
    		ValidationUtils.rejectIfStringLength(result, "relay_name", 20, "명단 이름");
    		ValidationUtils.rejectIfStringLength(result, "relay_etc", 500, "명단 비고");
		}
		
		if (!result.hasErrors()) {
			if (bookRelayClub.getEditMode().equals("ADD")) {
				bookRelayClub.setAdd_id(getSessionMemberId(request));
				service.addBookRelayClub(bookRelayClub);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
				
			} else if (bookRelayClub.getEditMode().equals("MODIFY")) {
				bookRelayClub.setModify_id(getSessionMemberId(request));
				service.modifyBookRelayClub(bookRelayClub);
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
	public @ResponseBody JsonResponse delete(BookRelayClub bookRelayClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayClub.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookRelayClub.getEditMode().equals("DELETE")) {
				bookRelayClub.setModify_id(getSessionMemberId(request));
				service.deleteBookRelayClub(bookRelayClub);
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
	public @ResponseBody JsonResponse statusChange(BookRelayClub bookRelayClub, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayClub.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeBookRelayClub(bookRelayClub);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	
}
