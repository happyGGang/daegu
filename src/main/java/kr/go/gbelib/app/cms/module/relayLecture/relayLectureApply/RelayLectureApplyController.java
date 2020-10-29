package kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import kr.go.gbelib.app.cms.module.relayLecture.RelayLecture;
import kr.go.gbelib.app.cms.module.relayLecture.RelayLectureService;

@Controller
@RequestMapping(value = {"/cms/module/relayLecture/relayLectureApply"})
public class RelayLectureApplyController extends BaseController {

	private final String basePath = "/cms/module/relayLecture/relayLectureApply/";
	
	@Autowired
	private RelayLectureApplyService service;
	
	@Autowired
	private RelayLectureService relayLectureService ;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, RelayLectureApply relayLectureApply, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		relayLectureApply.setHomepage_id(getAsideHomepageId(request));

		@SuppressWarnings("unchecked")
		Map<String, String> parameterMap = request.getParameterMap();
		if (parameterMap != null && !parameterMap.containsKey("reception_status")) {
			relayLectureApply.setReception_status("");
		}
		
		service.setPaging(model, service.relayLectureApplyCount(relayLectureApply), relayLectureApply);

		model.addAttribute("relayLectureApply", relayLectureApply);
		model.addAttribute("relayLectureApplyList", service.relayLectureApplyList(relayLectureApply));

		return basePath + "index_ajax";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, RelayLectureApply relayLectureApply, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		relayLectureApply.setHomepage_id(getAsideHomepageId(request));
		
		model.addAttribute("relayLectureApply", relayLectureApply);
		model.addAttribute("getRelayLectureApply", service.getRelayLectureApply(relayLectureApply));
		
		return basePath + "view";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, RelayLectureApply relayLectureApply, HttpServletRequest request) throws Exception {
		
		if(relayLectureApply.getEditMode().equals("MODIFY") ) {
			checkAuth("U", model, request);
			model.addAttribute("relayLectureApply", service.copyObjectPaging(relayLectureApply, service.getRelayLectureApply(relayLectureApply)));
		} else {
			checkAuth("C", model, request);
			relayLectureApply.setHomepage_id(getAsideHomepageId(request));

			model.addAttribute("relayLectureApply", relayLectureApply);
		}
		return basePath + "edit_ajax";
		
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(RelayLectureApply relayLectureApply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		if(relayLectureApply.getEditMode().equals("ADD") || relayLectureApply.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "applicant_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_sex", "성별을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_age", "연령대를 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_phone", "휴대폰 번호를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "applicant_phone", "휴대폰 번호가 올바르지 않습니다.");
    		
    		ValidationUtils.rejectIfStringLength(result, "applicant_name", 20, "이름");
		}
		
		
		if (!result.hasErrors()) {
			relayLectureApply.setAdd_id(getSessionMemberId(request));
			
			RelayLecture relayLecture = relayLectureService.getRelayLecture(new RelayLecture(getAsideHomepageId(request), relayLectureApply.getLecture_idx()));
			int total = service.totalRelayLectureApply(relayLectureApply); 
			
			if (relayLectureApply.getEditMode().equals("ADD")) {
				 if (relayLecture.getRecruitment_number() > 0) {
	               if (relayLecture.getRecruitment_number() < total + 1) {
	                  res.setValid(false);
                      res.setMessage("신청인원이 가득찼습니다.");
                      return res;
	               }
	            }
				
				service.addRelayLectureApply(relayLectureApply);
				res.setValid(true);
				res.setMessage("저장되었습니다.");
				
			} else if (relayLectureApply.getEditMode().equals("MODIFY")) {
				if (relayLecture.getRecruitment_number() > 0) {
	               if (relayLecture.getRecruitment_number() < total + 1) {
	                  res.setValid(false);
                      res.setMessage("신청인원이 가득찼습니다.");
                      return res;
	               }
	            }
				
				service.modifyRelayLectureApply(relayLectureApply);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping (value = {"/statusChange.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse statusChange(RelayLectureApply relayLectureApply, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		
		relayLectureApply.setHomepage_id(getAsideHomepageId(request));
		
		if (!result.hasErrors()) {
			RelayLecture relayLecture = relayLectureService.getRelayLecture(new RelayLecture(getAsideHomepageId(request), relayLectureApply.getLecture_idx()));
			int total = service.totalRelayLectureApply(relayLectureApply); 
			
			if (relayLectureApply.getReception_status().equals("Y") &&relayLecture.getRecruitment_number() <= total) {
				 res.setValid(false);
				 res.setMessage("신청인원이 가득찼습니다.");
				 return res;
			} else {
				service.statusChangeRelayLectureApply(relayLectureApply);
				res.setValid(true);
				res.setMessage("변경되었습니다.");
			}
			 
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}	
	
	@RequestMapping(value = { "/excelDownload.*" }, method = RequestMethod.POST)
	public RelayLectureApplyView excel(Model model, RelayLectureApply relayLectureApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		model.addAttribute("relayLecture", relayLectureService.getRelayLecture(new RelayLecture(getAsideHomepageId(request), relayLectureApply.getLecture_idx())));
		model.addAttribute("relayLectureApply", relayLectureApply);
		model.addAttribute("relayLectureResult", service.relayLectureApplyListAll(relayLectureApply));

		return new RelayLectureApplyView();
	} 
	
	@RequestMapping(value = { "/csvDownload.*" }, method = RequestMethod.POST)
	public void csv(Model model, RelayLectureApply relayLectureApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<RelayLectureApply> relayList = service.relayLectureApplyListAll(relayLectureApply);
		
		RelayLecture relayLecture = relayLectureService.getRelayLecture(new RelayLecture(getAsideHomepageId(request), relayLectureApply.getLecture_idx()));
		
		new RelayLectureApplyXlsToCsv(relayList, relayLecture.getEvent_name() + ".csv", relayLecture, request, response);
	} 
	
}
