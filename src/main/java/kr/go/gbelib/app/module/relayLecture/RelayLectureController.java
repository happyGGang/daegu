package kr.go.gbelib.app.module.relayLecture;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.homepage.Homepage;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.relayLecture.RelayLecture;
import kr.go.gbelib.app.cms.module.relayLecture.RelayLectureService;
import kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply.RelayLectureApply;
import kr.go.gbelib.app.cms.module.relayLecture.relayLectureApply.RelayLectureApplyService;

@Controller(value = "userRelayLecture")
@RequestMapping(value = {"/{homepagePath}/module/relayLecture"})
public class RelayLectureController extends BaseController {
	
	private final String basePath = "/homepage/%s/module/relayLecture/";

	@Autowired
	private RelayLectureService service;
	
	@Autowired
	private RelayLectureApplyService applyService;
	
	@RequestMapping (value = {"/index.*"})
	public String index(Model model, RelayLecture relayLecture, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		relayLecture.setHomepage_id(homepage.getHomepage_id());
		
		service.setPaging(model, service.relayLectureUserCount(relayLecture), relayLecture);
		
		model.addAttribute("relayLecture", relayLecture);
		model.addAttribute("relayLectureList", service.relayLectureUserList(relayLecture));

		return String.format(basePath, homepage.getFolder()) + "index";
	}
	
	@RequestMapping (value = {"/view.*"})
	public String view(Model model, RelayLecture relayLecture, HttpServletRequest request) throws Exception {
		checkAuth("R", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		relayLecture.setHomepage_id(homepage.getHomepage_id());
		
		service.addViewCount(relayLecture);
		
		service.setPaging(model, service.relayLectureCount(relayLecture), relayLecture);
		
		model.addAttribute("relayLecture", relayLecture);
		model.addAttribute("getRelayLecture", service.getRelayLecture(relayLecture));
		
		return String.format(basePath, homepage.getFolder()) + "view";
	}
	
	@RequestMapping (value = {"/step2.*"})
	public String step2(Model model, RelayLecture relayLecture, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		
		model.addAttribute("relayLecture", relayLecture);
		
		RelayLecture getRelayLecture = service.getRelayLecture(relayLecture);
		if(getRelayLecture.getApply_status() == 0) {
			service.alertMessage("신청 기간이 아닙니다.", request, response);
			return null;
		} else if(getRelayLecture.getApply_status() == 2) {
			service.alertMessage("신청 인원이 초과되었습니다.", request, response);
			return null;
		} else if(getRelayLecture.getApply_status() == 3) {
			service.alertMessage("신청 기간이 지났습니다.", request, response);
			return null;
		}
		return String.format(basePath, homepage.getFolder()) + "step2";
	}
	
	@RequestMapping (value = {"/edit.*"})
	public String edit(Model model, RelayLecture relayLecture, RelayLectureApply relayLectureApply, HttpServletRequest request, HttpServletResponse response) throws Exception {
		checkAuth("C", model, request);
		Homepage homepage = (Homepage) request.getAttribute("homepage");
		relayLecture.setHomepage_id(homepage.getHomepage_id());
		
		relayLecture.setAdd_id(getSessionMemberId(request));
		
		model.addAttribute("relayLectureApply", relayLectureApply);
		RelayLecture getRelayLecture = service.getRelayLecture(relayLecture);
		if(getRelayLecture.getApply_status() == 0) {
			service.alertMessage("신청 기간이 아닙니다.", request, response);
			return null;
		} else if(getRelayLecture.getApply_status() == 2) {
			service.alertMessage("신청 인원이 초과되었습니다.", request, response);
			return null;
		} else if(getRelayLecture.getApply_status() == 3) {
			service.alertMessage("신청 기간이 지났습니다.", request, response);
			return null;
		}
		model.addAttribute("getRelayLecture", getRelayLecture);

		return String.format(basePath, homepage.getFolder()) + "edit";
	}
	
	@RequestMapping (value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(RelayLectureApply relayLectureApply, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
		JsonResponse res = new JsonResponse(request);
		Homepage homepage = getSessionHomepage(request);
		if(relayLectureApply.getEditMode().equals("ADD")) {
			ValidationUtils.rejectIfEmpty(result, "applicant_name", "이름을 입력하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_sex", "성별을 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_age", "연령대를 선택하세요.");
    		ValidationUtils.rejectIfEmpty(result, "applicant_phone", "휴대폰 번호를 입력하세요.");

    		ValidationUtils.rejectPhone(result, "applicant_phone", "휴대폰 번호가 올바르지 않습니다.");
    		
    		ValidationUtils.rejectIfStringLength(result, "applicant_name", 20, "이름");
    		    		
    		RelayLecture relayLecture = service.getRelayLecture(new RelayLecture(homepage.getHomepage_id(), relayLectureApply.getLecture_idx()));
			try {
				if(relayLecture.getApply_status() == 0) {
				service.alertMessage("신청 기간이 아닙니다.", request, response);
				return null;
				} else if(relayLecture.getApply_status() == 2) {
					service.alertMessage("신청 인원이 초과되었습니다.", request, response);
					return null;
				} else if(relayLecture.getApply_status() == 3) {
					service.alertMessage("신청 기간이 지났습니다.", request, response);
					return null;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (!result.hasErrors()) {
			if (relayLectureApply.getEditMode().equals("ADD")) {
				Member member = getSessionMemberInfo(request);
				if (!member.isLogin() && member.isAnonymous()) {
					relayLectureApply.setAdd_id("ANONYMOUS");
				} else {
					relayLectureApply.setAdd_id(getSessionMemberId(request));
				}
				
				applyService.addRelayLectureApply(relayLectureApply);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}

		return res;
	}
	
}
