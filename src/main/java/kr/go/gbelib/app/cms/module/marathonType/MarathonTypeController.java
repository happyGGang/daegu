package kr.go.gbelib.app.cms.module.marathonType;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.co.whalesoft.framework.utils.ValidationUtils;
import kr.go.gbelib.app.cms.module.marathon.Marathon;

@Controller
@RequestMapping(value = {"/cms/module/marathonType"})
public class MarathonTypeController extends BaseController{

	private final String basePath = "/cms/module/marathonType/";
	
	@Autowired
	private MarathonTypeService service;
	
	@RequestMapping(value = {"/index.*"}, method = RequestMethod.GET)
	public String index(Model model, MarathonType marathonType, HttpServletRequest request) throws AuthException{
		checkAuth("R", model, request);
		marathonType.setHomepage_id(getAsideHomepageId(request));
		
		List<Marathon> marathonList = service.getMarathonList(marathonType);
		
		service.setPaging(model, service.getMarathonTypeCount(marathonType), marathonType);
		model.addAttribute("marathonList", marathonList);
		model.addAttribute("marathonType", marathonType);
		model.addAttribute("marathonTypeList", service.getMarathonTypeList(marathonType));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"}, method = RequestMethod.GET)
	public String edit(Model model, MarathonType marathonType, HttpServletRequest request) throws AuthException{
		marathonType.setHomepage_id(getAsideHomepageId(request));
		
		if(marathonType.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			List<Marathon> marathonList = service.getMarathonList(marathonType);
			model.addAttribute("marathonList", marathonList);
			model.addAttribute("marathonType", service.copyObjectPaging(marathonType, service.getMarathonTypeOne(marathonType)));
		}else {
			checkAuth("C", model, request);
			List<Marathon> marathonList = service.getMarathonList(marathonType);
			model.addAttribute("marathonList", marathonList);
			model.addAttribute("marathonType", marathonType);
		}
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(MarathonType marathonType, BindingResult result, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);
		marathonType.setHomepage_id(getAsideHomepageId(request));
		
		JsonResponse res = new JsonResponse(request);
		if(marathonType.getEditMode().equals("ADD")) {
    		if(marathonType.getTypeList() != null) {
        		List<MarathonType> list = marathonType.getTypeList();
        		for(int i = 0; i < marathonType.getTypeList().size(); i++) {
        			list.get(i).setHomepage_id(getAsideHomepageId(request));
        			list.get(i).setAdd_id(member.getMember_id());
        			list.get(i).setContest_idx(marathonType.getContest_idx());
        		}
        		/*유효성 검증 >>>>>>>>>>*/
        		for (int i = 0; i < marathonType.getTypeList().size(); i++) {
        			ValidationUtils.rejectIfEmpty(result, "typeList[" + i + "].contest_type", "종목" + (i+1) + "의 종목명을 입력해 주세요.");
        			ValidationUtils.rejectIfEmpty(result, "typeList[" + i + "].page_count", "종목" + (i+1) + "의 쪽수를 입력해 주세요.");
        			ValidationUtils.rejectIfEmpty(result, "typeList[" + i + "].application_subject", "종목" + (i+1) + "의 대상을 입력해 주세요.");
        		}
        		/*<<<<<<<<<<<<<< 유효성 검증 */
    		}
		}
		/*유효성 검증 >>>>>>>>>>*/
		else if(marathonType.getEditMode().equals("MODIFY")) {
			ValidationUtils.rejectIfEmpty(result, "contest_type", "종목명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "page_count", "쪽수를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "application_subject", "대상을 입력하세요.");
		}
		/*<<<<<<<<<<<<<< 유효성 검증 */
		if(!result.hasErrors()) {
			if(marathonType.getEditMode().equals("ADD")) {
				service.addMarathonType(marathonType);
				res.setValid(true);
				res.setMessage("등록되었습니다.");
			}else if (marathonType.getEditMode().equals("MODIFY")) {
				marathonType.setModify_id(member.getMember_id());
				service.modifyMarathonType(marathonType);
				res.setValid(true);
				res.setMessage("수정되었습니다.");
			}else if(marathonType.getEditMode().equals("DELETE")) {
				service.deleteMarathonType(marathonType);
				res.setValid(true);
				res.setMessage("삭제되었습니다.");
			}
		}else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}
