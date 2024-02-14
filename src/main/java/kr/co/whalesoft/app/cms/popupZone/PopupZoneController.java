package kr.co.whalesoft.app.cms.popupZone;

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
@RequestMapping(value = {"/cms/popupZone"})
public class PopupZoneController extends BaseController {
	private final String basePath = "/cms/popupZone/";

	@Autowired
	private PopupZoneService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, PopupZone popupZone, HttpServletRequest request) throws AuthException {
//		if ( !getSessionIsAdmin(request) ) {
			popupZone.setHomepage_id(getAsideHomepageId(request));	
//		}
		checkAuth("R", model, request);
		int count = service.getPopupZoneCount(popupZone);
		service.setPaging(model, count, popupZone);
		popupZone.setTotalDataCount(count);
		model.addAttribute("popupZone", popupZone);
		model.addAttribute("popupZoneList", service.getPopupZone(popupZone));
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/popupZone.*"})
	public String popup(Model model, PopupZone popupZone) {
		

		return basePath + "popupZone_ajax";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, PopupZone popupZone, HttpServletRequest request) throws AuthException {
		if(popupZone.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			popupZone = (PopupZone)service.copyObjectPaging(popupZone, service.getPopupZoneOne(popupZone));
		} else {
			checkAuth("C", model, request);
			popupZone.setPrint_seq(service.getNextPrintSeq(popupZone.getHomepage_id()));
			
			if(StringUtils.isEmpty(popupZone.getUse_yn())) {
				popupZone.setUse_yn("Y");
			}
			
			if(StringUtils.isEmpty(popupZone.getSchool_use_yn())) {
				popupZone.setSchool_use_yn("N");
			}
			
			if(StringUtils.isEmpty(popupZone.getLink_target())) {
				popupZone.setLink_target("CURRENT");
			}
		}
		
		model.addAttribute("popupZone", popupZone);
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, PopupZone popupZone, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		ValidationUtils.rejectIfEmpty(result, "popup_zone_name", "팝업존명을 입력해주세요.");
		ValidationUtils.rejectIfEmpty(result, "start_date", "게시 시작일을 지정해주세요.");
		ValidationUtils.rejectIfEmpty(result, "end_date", "게시 종료일을 지정해주세요");
		ValidationUtils.rejectIfEmpty(result, "link_url", "링크URL을 지정해주세요");
		
		if(!result.hasErrors()) {
			if(popupZone.getEditMode().equals("ADD")) {
				popupZone.setAdd_id(getSessionMemberId(request));
				service.addPopupZone(popupZone, mpRequest);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(popupZone.getEditMode().equals("MODIFY")) {
				popupZone.setModify_id(getSessionMemberId(request));
				service.modifyPopupZone(popupZone, mpRequest);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(popupZone.getEditMode().equals("DELETE")) {
				service.deletePopupZone(popupZone);
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
	public @ResponseBody JsonResponse delete(Model model, PopupZone popupZone, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(!result.hasErrors()) {
			service.deletePopupZone(popupZone);
			res.setValid(true);
			res.setMessage("삭제 되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/printSeq.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse printSeq(PopupZone popupZone, BindingResult result, HttpServletRequest request) {
		/* 유효성 검증 >>>>> */
		JsonResponse res = new JsonResponse(request);
		/* <<<<< 유효성 검증 */

		if (!result.hasErrors()) {
			popupZone.setModify_id(getSessionMemberId(request));
			service.modifyPopupZonePrintSeq(popupZone);
			res.setValid(true);
			res.setReload(true);
			res.setMessage("수정되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
}
