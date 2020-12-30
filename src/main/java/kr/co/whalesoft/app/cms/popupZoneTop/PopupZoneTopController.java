package kr.co.whalesoft.app.cms.popupZoneTop;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/popupZoneTop"})
public class PopupZoneTopController extends BaseController {
	private final String basePath = "/cms/popupZoneTop/";

	@Autowired
	private PopupZoneTopService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, PopupZoneTop popupZoneTop, HttpServletRequest request) throws AuthException {
//		if ( !getSessionIsAdmin(request) ) {
			popupZoneTop.setHomepage_id(getAsideHomepageId(request));	
//		}
		checkAuth("R", model, request);
		int count = service.getPopupZoneTopCount(popupZoneTop);
		service.setPaging(model, count, popupZoneTop);
		popupZoneTop.setTotalDataCount(count);
		model.addAttribute("popupZoneTop", popupZoneTop);
		model.addAttribute("popupZoneTopList", service.getPopupZoneTop(popupZoneTop));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/popupZoneTop.*"})
	public String popup(Model model, PopupZoneTop popupZoneTop) {
		

		return basePath + "popupZoneTop_ajax";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, PopupZoneTop popupZoneTop, HttpServletRequest request) throws AuthException {
		if(popupZoneTop.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			popupZoneTop = (PopupZoneTop)service.copyObjectPaging(popupZoneTop, service.getPopupZoneTopOne(popupZoneTop));
		} else {
			checkAuth("C", model, request);
			popupZoneTop.setPrint_seq(service.getNextPrintSeq(popupZoneTop.getHomepage_id()));
			
			if(StringUtils.isEmpty(popupZoneTop.getUse_yn())) {
				popupZoneTop.setUse_yn("Y");
			}
			
			if(StringUtils.isEmpty(popupZoneTop.getLink_target())) {
				popupZoneTop.setLink_target("CURRENT");
			}
		}
		
		model.addAttribute("popupZoneTop", popupZoneTop);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, PopupZoneTop popupZoneTop, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "popup_zone_name", "팝업존명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "start_date", "게시 시작일을 지정해주세요.");
		ValidationUtils.rejectIfEmpty(result, "end_date", "게시 종료일을 지정해주세요");
		ValidationUtils.rejectIfEmpty(result, "link_url", "링크URL을 지정해주세요");
		
		if(!result.hasErrors()) {
			if(popupZoneTop.getEditMode().equals("ADD")) {
				popupZoneTop.setAdd_id(getSessionMemberId(request));
				service.addPopupZoneTop(popupZoneTop, mpRequest);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(popupZoneTop.getEditMode().equals("MODIFY")) {
				popupZoneTop.setModify_id(getSessionMemberId(request));
				service.modifyPopupZoneTop(popupZoneTop, mpRequest);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(popupZoneTop.getEditMode().equals("DELETE")) {
				service.deletePopupZoneTop(popupZoneTop);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/delete.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse delete(Model model, PopupZoneTop popupZoneTop, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			service.deletePopupZoneTop(popupZoneTop);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
