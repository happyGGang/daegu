package kr.co.whalesoft.app.cms.taskManage;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.menu.Menu;
import kr.co.whalesoft.app.cms.menu.MenuService;
import kr.co.whalesoft.framework.base.BaseController;
import kr.co.whalesoft.framework.exception.AuthException;
import kr.co.whalesoft.framework.utils.JsonResponse;
import kr.co.whalesoft.framework.utils.ValidationUtils;

@Controller
@RequestMapping(value = {"/cms/taskManage"})
public class TaskManageController extends BaseController {

	private final String basePath = "/cms/taskManage/";

	@Autowired
	private TaskManageService service;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value = {"/index.*"})
	public String index(Model model, TaskManage taskManage, HttpServletRequest request) throws AuthException {
		checkAuth("R", model, request);
		taskManage.setHomepage_id(getAsideHomepageId(request));	
		int count = service.getTaskListCount(taskManage);
		service.setPaging(model, count, taskManage);
		
		List<TaskManage> taskList = service.getTaskList(taskManage);
		for ( TaskManage one : taskList ) {
			one.setTask_desc(one.getTask_desc().replaceAll("\n", "<br/>"));
		}
		int moduleMenuIdx = menuService.getMenuIdxByProgramIdx(new Menu(taskManage.getHomepage_id(), 31));
		model.addAttribute("moduleMenuIdx", moduleMenuIdx);
		
		model.addAttribute("taskManage", taskManage);
		model.addAttribute("taskManageListCount", count);
		model.addAttribute("taskList", taskList);
		
		return basePath + "index";
	}
	
	@RequestMapping(value = {"/edit.*"})
	public String edit(Model model, TaskManage taskManage, HttpServletRequest request) throws AuthException {
		if(taskManage.getEditMode().equals("MODIFY")) {
			checkAuth("U", model, request);
			model.addAttribute("taskManage", service.copyObjectPaging(taskManage, service.getTaskOne(taskManage)));
		} else {
			checkAuth("C", model, request);
			taskManage.setPrint_seq(service.getMaxPrintSeq(taskManage));
			model.addAttribute("taskManage", taskManage);
		}
		
		return basePath + "edit_ajax";
	}
	
	@RequestMapping(value = {"/manager.*"})
	public String manager(Model model, TaskManage taskManage) {
		Member member = new Member();
		member.setHomepage_id(taskManage.getHomepage_id());
		model.addAttribute("memberList", service.getMemberListNotInTaskManage(taskManage));
		
		return basePath + "manager_ajax";
	}
	
	@RequestMapping(value = {"/save.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse save(Model model, TaskManage taskManage, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = taskManage.getEditMode();
		if(!taskManage.getEditMode().equals("DELETE")) {
			ValidationUtils.rejectIfEmpty(result, "dept_name", "부서를 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "rank_name", "직급을 입력하세요.");
			ValidationUtils.rejectIfEmpty(result, "task_desc", "업무를 입력하세요.");
		}
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				taskManage.setAdd_id(getSessionMemberId(request));
				service.addTask(taskManage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			} else if(editMode.equals("MODIFY")) {
				taskManage.setMod_id(getSessionMemberId(request));
				service.modifyTask(taskManage);
				res.setValid(true);
				res.setMessage("수정 되었습니다.");
			} else if(editMode.equals("DELETE")) {
				service.deleteTask(taskManage);
				res.setValid(true);
				res.setMessage("삭제 되었습니다.");
			}
		} else {
			res.setValid(false);
			res.setResult(result.getAllErrors());
		}
		
		return res;
	}
	
	@RequestMapping(value = {"/saveManager.*"}, method = RequestMethod.POST)
	public @ResponseBody JsonResponse saveManager(Model model, TaskManage taskManage, BindingResult result, HttpServletRequest request) {
		JsonResponse res = new JsonResponse(request);
		String editMode = taskManage.getEditMode();
	
		if(!result.hasErrors()) {
			if(editMode.equals("ADD")) {
				service.addTaskManager(taskManage);
				res.setValid(true);
				res.setMessage("등록 되었습니다.");
			}
			else if(editMode.equals("DELETE")) {
				service.deleteTaskManager(taskManage);
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