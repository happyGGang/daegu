package kr.go.gbelib.app.cms.module.relayLecture;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/module/relayLecture"})
public class RelayLectureController extends BaseController {

	private final String basePath = "/cms/module/relayLecture/";
	
	@Autowired
	private RelayLectureService service;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, RelayLecture relayLecture, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		relayLecture.setHomepage_id(getAsideHomepageId(request));
		
		service.setPaging(model, service.relayLectureCount(relayLecture), relayLecture);
		
		model.addAttribute("relayLecture", relayLecture);
		model.addAttribute("relayLectureList", service.relayLectureList(relayLecture));

		return basePath + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, RelayLecture relayLecture, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		relayLecture.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("relayLecture", relayLecture);
		model.addAttribute("getRelayLecture", service.getRelayLecture(relayLecture));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, RelayLecture relayLecture, HttpServletRequest request) throws Exception {
		
		if(relayLecture.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			
			model.addAttribute("relayLecture", service.copyObjectPaging(relayLecture, service.getRelayLecture(relayLecture)));
			return basePath + "edit";
		} else {
			checkAuth("C", model, request);
			relayLecture.setHomepage_id(getAsideHomepageId(request));

			model.addAttribute("relayLecture", relayLecture);
			return basePath + "edit_ajax";
		}
		
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(RelayLecture relayLecture, BindingResult result, HttpServletRequest request, MultipartHttpServletRequest mpRequest) {
		JsonResponse res = new JsonResponse(request);
		
		if(relayLecture.getEditMode().equals("ADD") || relayLecture.getEditMode().equals("MODIFY")) {
    		ValidationUtils.rejectIfEmpty(result, "event_name", "행사명을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "event_start_date", "행사시작일자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "event_end_date", "행사종료일자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "event_place", "행사장소를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "event_start_time", "행사시작시간을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "event_end_time", "행사종료시간 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "apply_start_date", "신청시작일자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "apply_start_time", "신청시작시간을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "apply_end_date", "신청종료일자를 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "apply_end_time", "신청종료시간을 입력하세요.");
    		
    		ValidationUtils.rejectIfStringLength(result, "event_name", 500, "행사명");
			ValidationUtils.rejectIfStringLength(result, "event_place", 100, "행사장소");
    		
    		if (relayLecture.getRecruitment_number() == 0) {
    			ValidationUtils.rejectIfEmpty(result, "recruitment_number", "모집인원을 입력하세요.");
			}
		}
		
		if (!result.hasErrors()) {
			relayLecture.setAdd_id(getSessionMemberId(request));
			if (relayLecture.getEditMode().equals("ADD")) {
				service.addRelayLecture(relayLecture, mpRequest);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				res.setUrl("index.do");
				
			} else if (relayLecture.getEditMode().equals("MODIFY")) {
				service.modifyRelayLecture(relayLecture, mpRequest);
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
	public @ResponseBody JsonResponse delete(RelayLecture relayLecture, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		relayLecture.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			if (relayLecture.getEditMode().equals("DELETE")) {
				service.deleteRelayLecture(relayLecture);
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
	public @ResponseBody JsonResponse statusChange(RelayLecture relayLecture, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		relayLecture.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			service.statusChangeRelayLecture(relayLecture);
			res.setValid(true);
			res.setMessage("변경되었습니다.");
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
}
