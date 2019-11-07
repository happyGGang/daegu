package kr.co.whalesoft.app.cms.projectManage;

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

@Controller
@RequestMapping(value = {"/cms/projectManage"})
public class ProjectManageController extends BaseController {

	private final String basePath = "/cms/projectManage/";

	@Autowired
	private ProjectManageService service;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, ProjectManage projectManage, HttpServletRequest request) {
		projectManage.setHomepage_id(getAsideHomepageId(request));
		int count = service.getProjectManageListCount(projectManage);
		service.setPaging(model, count, projectManage);
		model.addAttribute("projectManage", projectManage);
		model.addAttribute("projectManageListCount", count);
		model.addAttribute("projectManageList", service.getProjectManageList(projectManage));
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, ProjectManage projectManage) {
		if(projectManage.getEditMode().equals("MODIFY")) {
			model.addAttribute("projectManage", service.copyObjectPaging(projectManage, service.getProjectManageOne(projectManage)));
		} else {
			model.addAttribute("projectManage", projectManage);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, ProjectManage projectManage, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = projectManage.getEditMode();
	/*	if(!teach.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "homepage_name", "홈페이지명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "homepage_type", "홈페이지 유형을 선택하세요.");
			ValidationUtils.rejectIfEmpty(result, "domain", "도메인명을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "folder", "폴더명을 입력하세요.");
		}*/
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				service.addProjectManage(projectManage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				service.modifyProjectManage(projectManage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteProjectManage(projectManage);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
}