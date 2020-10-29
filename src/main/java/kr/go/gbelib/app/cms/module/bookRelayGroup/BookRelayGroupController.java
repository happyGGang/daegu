package kr.go.gbelib.app.cms.module.bookRelayGroup;

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

@Controller
@RequestMapping(value = {"/cms/module/bookRelayGroup"})
public class BookRelayGroupController extends BaseController {
	
	private final String basePath = "/cms/module/bookRelayGroup/";

	@Autowired
	private BookRelayGroupService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayGroup.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.bookRelayGroupCount(bookRelayGroup), bookRelayGroup);
		
		model.addAttribute("bookRelayGroup", bookRelayGroup);
		model.addAttribute("bookRelayGroupList", service.bookRelayGroupList(bookRelayGroup));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		bookRelayGroup.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("bookRelayGroup", bookRelayGroup);
		model.addAttribute("getBookRelayGroup", service.getBookRelayGroup(bookRelayGroup));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, BookRelayGroup bookRelayGroup, HttpServletRequest request) throws Exception {
		
		if(bookRelayGroup.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("bookRelayGroup", service.copyObjectPaging(bookRelayGroup, service.getBookRelayGroup(bookRelayGroup)));
			return basePath + "edit";
		} else {
			bookRelayGroup.setHomepage_id(getAsideHomepageId(request));
			
			checkAuth("C", model, request);
			model.addAttribute("bookRelayGroup", bookRelayGroup);
			return basePath + "edit_ajax";
		}
	}
	
	
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(BookRelayGroup bookRelayGroup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(bookRelayGroup.getEditMode().equals("ADD") || bookRelayGroup.getEditMode().equals("MODIFY") ) {
			ValidationUtils.rejectIfEmpty(result, "group_name", "기관명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "manager_name", "담당자명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "user_phone", "휴대폰 번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "postcode", "우편번호를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_base", "주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "address_detailed", "상세주소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_area", "도서영역을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "book_quantity", "독서노트 신청수량을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_plan", "릴레이 계획을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "relay_personnel", "릴레이 예상인원을 입력하세요.");
    		
    		ValidationUtils.rejectPhone(result, "user_phone", "휴대폰 번호가 올바르지 않습니다.");
    		
    		ValidationUtils.rejectIfStringLength(result, "group_name", 100, "기관명");
    		ValidationUtils.rejectIfStringLength(result, "manager_name", 20, "담당자명");
    		ValidationUtils.rejectIfStringLength(result, "postcode", 5, "우편번호");
    		ValidationUtils.rejectIfStringLength(result, "address_base", 800, "주소");
    		ValidationUtils.rejectIfStringLength(result, "address_detailed", 800, "상세주소");
    		ValidationUtils.rejectIfStringLength(result, "relay_plan", 500, "릴레이 계획");
		}
		
		if (!result.hasErrors()) {
			if (bookRelayGroup.getEditMode().equals("ADD")) {
				bookRelayGroup.setAdd_id(getSessionMemberId(request));
				service.addBookRelayGroup(bookRelayGroup);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
			} else if (bookRelayGroup.getEditMode().equals("MODIFY")) {
				bookRelayGroup.setModify_id(getSessionMemberId(request));
				service.modifyBookRelayGroup(bookRelayGroup);
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
	public @ResponseBody JsonResponse delete(BookRelayGroup bookRelayGroup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayGroup.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (bookRelayGroup.getEditMode().equals("DELETE")) {
				service.deleteBookRelayGroup(bookRelayGroup);
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
	public @ResponseBody JsonResponse statusChange(BookRelayGroup bookRelayGroup, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		bookRelayGroup.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeBookRelayGroup(bookRelayGroup);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	
}
